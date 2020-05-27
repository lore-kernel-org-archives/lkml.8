Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AB2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CB9207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgE0NlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:41:12 -0400
Received: from foss.arm.com ([217.140.110.172]:38676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387627AbgE0NlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:41:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 163A755D;
        Wed, 27 May 2020 06:41:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECA433F305;
        Wed, 27 May 2020 06:41:09 -0700 (PDT)
Date:   Wed, 27 May 2020 14:41:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, ndesaulniers@google.com
Subject: Re: arm64/acpi: NULL dereference reports from UBSAN at boot
Message-ID: <20200527134104.GA16115@e121166-lin.cambridge.arm.com>
References: <20200521100952.GA5360@willie-the-truck>
 <20200521173738.GA29590@e121166-lin.cambridge.arm.com>
 <20200526202157.GE2206@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526202157.GE2206@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:21:57PM +0100, Will Deacon wrote:
> Hi Lorenzo, Hanjun, [+Nick]
> 
> On Thu, May 21, 2020 at 06:37:38PM +0100, Lorenzo Pieralisi wrote:
> > On Thu, May 21, 2020 at 11:09:53AM +0100, Will Deacon wrote:
> > > Hi folks,
> > > 
> > > I just tried booting the arm64 for-kernelci branch under QEMU (version
> > > 4.2.50 (v4.2.0-779-g4354edb6dcc7)) with UBSAN enabled, and I see a
> > > couple of NULL pointer dereferences reported at boot. I think they're
> > > both GIC related (log below). I don't see a panic with UBSAN disabled,
> > > so something's fishy here.
> > 
> > May I ask you the QEMU command line please - just to make sure I can
> > replicate it.
> 
> As it turns out, I'm only able to reproduce this when building with Clang,
> but I don't know whether that's because GCC is missing something of Clang
> is signalling a false positive. You also don't need all of those whacky
> fuzzing options enabled.
> 
> Anyway, to reproduce:
> 
>  $ git checkout for-next/kernelci
>  $ make ARCH=arm64  CC=clang CROSS_COMPILE=aarch64-linux-gnu- defconfig
>  <then do a menuconfig and enable UBSAN>
>  $ make ARCH=arm64  CC=clang CROSS_COMPILE=aarch64-linux-gnu- Image
> 
> I throw that at QEMU using:
> 
> qemu-system-aarch64 -M virt -machine virtualization=true \
> 	-machine virt,gic-version=3 \
> 	-cpu max,sve=off -smp 2 -m 4096 \
> 	-drive if=pflash,format=raw,file=efi.img,readonly \
> 	-drive if=pflash,format=raw,file=varstore.img \
> 	-drive if=virtio,format=raw,file=disk.img \
> 	-device virtio-scsi-pci,id=scsi0 \
> 	-device virtio-rng-pci \
> 	-device virtio-net-pci,netdev=net0 \
> 	-netdev user,id=net0,hostfwd=tcp::8222-:22 \
> 	-nographic \
> 	-kernel ~/work/linux/arch/arm64/boot/Image \
> 	-append "earlycon root=/dev/vda2"
> 
> I built QEMU a while ago according to:
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/docs/qemu/qemu-arm64-howto.html
> 
> and its version 4.2.50 (v4.2.0-779-g4354edb6dcc7).
> 
> My clang is version 11.0.1.

Thanks a lot Will.

I *think* I was right - it is the ACPI_OFFSET() macro:

#define ACPI_OFFSET(d, f)  ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)

that triggers the warnings (I suspected it because at least in one of
the warnings I could not see any dereference of any dynamically
allocated data).

Now on what to do with it - thoughts welcome.

Lorenzo
