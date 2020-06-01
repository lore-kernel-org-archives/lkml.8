Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101FA2076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590995106;
	bh=B3QD6jug+ogOzxUlyPb4F6UTjlIKD4f4RQZhFem4HJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GoChZ5MKM0Qiu1FtSFr/HvJcNndcOoAZZPOBMtqxhxY5l5BpczA6a0L8VdwV8BlRn
	 oRobR4HJRULWPh3HvgjwVziYsBuNdWgrLb2X6XEL71bsJuky3QeghrDigajz0evFx1
	 0UJFXyS1PZgt01wieIX6YQdiKw15/nL/H64U7VM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFAHFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFAHFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:05:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF902074B;
        Mon,  1 Jun 2020 07:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590995104;
        bh=B3QD6jug+ogOzxUlyPb4F6UTjlIKD4f4RQZhFem4HJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIyZxKIpBbX7KMO6KiPQO8iHUlmr2rCiXeSPsi/nsD/csVbFUjQ511WD0pco/4587
         4sxuBII1LQxSbg7P7vjRRQTfbTTV7rGT4RWxO6CPi6Jsn8WiSZ0wC+Qvf6/sERpgRJ
         4NTHny9OIWYq+pWEtJihbcpITPmOXeAVlOC4FgxA=
Date:   Mon, 1 Jun 2020 08:05:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, ndesaulniers@google.com
Subject: Re: arm64/acpi: NULL dereference reports from UBSAN at boot
Message-ID: <20200601070459.GB8601@willie-the-truck>
References: <20200521100952.GA5360@willie-the-truck>
 <20200521173738.GA29590@e121166-lin.cambridge.arm.com>
 <20200526202157.GE2206@willie-the-truck>
 <20200527134104.GA16115@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527134104.GA16115@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 02:41:04PM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 26, 2020 at 09:21:57PM +0100, Will Deacon wrote:
> > Hi Lorenzo, Hanjun, [+Nick]
> > 
> > On Thu, May 21, 2020 at 06:37:38PM +0100, Lorenzo Pieralisi wrote:
> > > On Thu, May 21, 2020 at 11:09:53AM +0100, Will Deacon wrote:
> > > > Hi folks,
> > > > 
> > > > I just tried booting the arm64 for-kernelci branch under QEMU (version
> > > > 4.2.50 (v4.2.0-779-g4354edb6dcc7)) with UBSAN enabled, and I see a
> > > > couple of NULL pointer dereferences reported at boot. I think they're
> > > > both GIC related (log below). I don't see a panic with UBSAN disabled,
> > > > so something's fishy here.
> > > 
> > > May I ask you the QEMU command line please - just to make sure I can
> > > replicate it.
> > 
> > As it turns out, I'm only able to reproduce this when building with Clang,
> > but I don't know whether that's because GCC is missing something of Clang
> > is signalling a false positive. You also don't need all of those whacky
> > fuzzing options enabled.
> > 
> > Anyway, to reproduce:
> > 
> >  $ git checkout for-next/kernelci
> >  $ make ARCH=arm64  CC=clang CROSS_COMPILE=aarch64-linux-gnu- defconfig
> >  <then do a menuconfig and enable UBSAN>
> >  $ make ARCH=arm64  CC=clang CROSS_COMPILE=aarch64-linux-gnu- Image
> > 
> > I throw that at QEMU using:
> > 
> > qemu-system-aarch64 -M virt -machine virtualization=true \
> > 	-machine virt,gic-version=3 \
> > 	-cpu max,sve=off -smp 2 -m 4096 \
> > 	-drive if=pflash,format=raw,file=efi.img,readonly \
> > 	-drive if=pflash,format=raw,file=varstore.img \
> > 	-drive if=virtio,format=raw,file=disk.img \
> > 	-device virtio-scsi-pci,id=scsi0 \
> > 	-device virtio-rng-pci \
> > 	-device virtio-net-pci,netdev=net0 \
> > 	-netdev user,id=net0,hostfwd=tcp::8222-:22 \
> > 	-nographic \
> > 	-kernel ~/work/linux/arch/arm64/boot/Image \
> > 	-append "earlycon root=/dev/vda2"
> > 
> > I built QEMU a while ago according to:
> > 
> > https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/docs/qemu/qemu-arm64-howto.html
> > 
> > and its version 4.2.50 (v4.2.0-779-g4354edb6dcc7).
> > 
> > My clang is version 11.0.1.
> 
> Thanks a lot Will.
> 
> I *think* I was right - it is the ACPI_OFFSET() macro:
> 
> #define ACPI_OFFSET(d, f)  ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> 
> that triggers the warnings (I suspected it because at least in one of
> the warnings I could not see any dereference of any dynamically
> allocated data).

Cheers, Lorenzo.

> Now on what to do with it - thoughts welcome.

Nick -- any idea what to do about the above? The '#define' pasted by
Lorenzo is causing a couple of spurious UBSAN splats when compiling with
clang 11.

Cheers,

Will
