Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5365C206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkdMkc7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHSMhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:37:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55681 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726752AbgHSMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597840650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyJv9f30kmkUETLE2cVJf3IGYOx0OtHQLaHP3thyrbY=;
        b=MkdMkc7rzdHcLQrU1vT2Z49lMRXmTWaYDsKUoNSZbMLzYqflxHddhu4wyOQpLDmk2a/cDA
        LGAVky5jbh5otjTmYT6Dg0IXicULOCzl91QLIuFSzKvQYo/a8ce0IdzGdIKr5NwyA6/lno
        R+WU4/xCgkqHG9p7qJCki+BC2L9CFFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-txA31vqLOcWwQTsEob-CMw-1; Wed, 19 Aug 2020 08:37:24 -0400
X-MC-Unique: txA31vqLOcWwQTsEob-CMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB4D31015DCF;
        Wed, 19 Aug 2020 12:37:22 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA3495D9F1;
        Wed, 19 Aug 2020 12:37:16 +0000 (UTC)
Date:   Wed, 19 Aug 2020 20:37:13 +0800
From:   Dave Young <dyoung@redhat.com>
To:     James Morse <james.morse@arm.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Sang Yan <sangyan@huawei.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, xiexiuqi@huawei.com,
        guohanjun@huawei.com, luanjianhai@huawei.com, zhuling8@huawei.com,
        luchunhua@huawei.com
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
Message-ID: <20200819123713.GB13727@dhcp-128-65.nay.redhat.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
 <20200814065845.GA18234@dhcp-128-65.nay.redhat.com>
 <ad098e21-d689-f655-1e32-c93adcf0cb2d@huawei.com>
 <20200814112413.GA8097@dhcp-128-65.nay.redhat.com>
 <CA+CK2bDG9mzzpLhyQS=MiyNNcYsUdV=VQt9LufL7VrqKH8cK_g@mail.gmail.com>
 <a6e8de9c-06fa-75c4-b975-457877226f49@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e8de9c-06fa-75c4-b975-457877226f49@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/20 at 01:14pm, James Morse wrote:
> Hi guys,
> 
> On 14/08/2020 20:22, Pavel Tatashin wrote:
> > On Fri, Aug 14, 2020 at 7:24 AM Dave Young <dyoung@redhat.com> wrote:
> >> On 08/14/20 at 04:21pm, Sang Yan wrote:
> >>> On 08/14/20 14:58, Dave Young wrote:
> >>>> On 08/14/20 at 01:52am, Sang Yan wrote:
> >>> Yes, it's particularly obvious on arm64. I will add it to the patch log,
> >>> and test how long it takes on x86 and other arch.
> 
> Earlier versions of kexec-tools had the in-purgatory checksum enabled unconditionally.
> More recent versions let you disable it, I think the parameter is called no-checks. This
> saves some time, but the relocations still have to be done.
> 
> 
> >>>> About the arm64 problem, I know Pavel Tatashin is working on a patchset
> >>>> to improve the performance with enabling mmu.
> >>>>
> >>>> I added Pavel in cc, can you try his patches?
> >>>>
> >>> Thanks for your tips, I will try these patches. @Pavel.
> >>> Disable mmu after finishing copying pages?
> 
> >>>>> We introduce quick kexec to save time of copying memory as above,
> >>>>> just like kdump(kexec on crash), by using reserved memory
> >>>>> "Quick Kexec".
> >>>>
> >>>> This approach may have gain, but it also introduce extra requirements to
> >>>> pre-reserve a memory region.  I wonder how Eric thinks about the idea.
> >>>>
> >>>> Anyway the "quick" name sounds not very good, I would suggest do not
> >>>> introduce a new param, and the code can check if pre-reserved region
> >>>> exist then use it, if not then fallback to old way.
> >>>>
> >>> aha. I agree with it, but I thought it may change the old behaviors of
> >>> kexec_load.
> >>>
> >>> I will update a new patch without introducing new flags and new params.
> >>
> >> Frankly I'm still not sure it is worth to introduce a new interface if the
> >> improvement can be done in arch code like Pavel is doing.  Can you try
> >> that first?
> 
> > My patches will fix this issue. This is an ARM64 specific problem and
> > I did not see this to be performance problem on x86 during kexec
> > relocation. This happens because on ARM64 relocation is performed with
> > MMU disabled, and when MMU is disabled the caching is disabled as
> > well.
> 
> > I have a patch series that fixes this entirely, but James Morse
> > (+CCed) and I still have not agreed on the final approach. We had an
> > off-list conversation about it, and we need to continue it in public
> > ML.
> > 
> > Here is some history:
> > 
> > This is the original series that I sent a year ago. It basically
> > proposes the same thing as this series from Sang Yan:
> > https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com/
> > 
> > Once, I realized that with enabling MMU the relocation is issue is
> > gone completely, I sent a new series, and this is the latest version
> > of that series:
> > https://lore.kernel.org/lkml/20200326032420.27220-1-pasha.tatashin@soleen.com/
> > 
> > It has been tested in production, and several people from different
> > companies commented to me that they are using it as well.
> > 
> > After my patch series was sent out, James created a new branch in his
> > tree with his approach of enabling MMU without having a new VA space,
> > but instead re-use what the kernel  has now. I have not tested that
> > branch yet.
> 
> For context, that is here:
> http://www.linux-arm.org/git?p=linux-jm.git;a=shortlog;h=refs/heads/kexec%2Bmmu/v0
> 
> I think we can maintain this approach, but it doesn't work for Pavel, as he has extra
> requirements. I stopped looking at it because it became a solution no-one needed.
> 
> 
> > Here are some comments from James Morse and the off-list discussion we had:
> > -------
> > It sounds like you are depending on write streaming mode to meet your
> > target performance.
> > This isn't even CPU specific, its cache and firmware configuration specific!
> > I don't think we should optimise a general purpose operating system
> > based on things like this.
> > ..
> > I think the best approach is going to be to eliminate the relocations entirely.> ...
> > I'm afraid I view this kexec-map thing as high-risk duct-tape over the
> > kexec core code
> > deliberately scattering the kexec payload.
> > I'd prefer any approach that causes the payload to be stored in-place
> > from the beginning
> > as that benefits other architectures too.
> > -------
> 
> The 'eliminate relocations' comment goes with some of the context you removed.
> 
> 
> > It appears James is leaning to the approach of not performing
> > relocation at all and use what is proposed by Sang Yan and me during
> > my first approach for this problem.
> 
> The background to that is Pavel's timing requirements: Enabling the MMU isn't enough, from
> his description he also depends on re-arranging the memory so the CPU only sees increasing
> virtual addresses. This is what my 'write streaming' comment refers to.
> Doing this requires rewriting the relocation assembly code.
> 
> If we enable the MMU during kexec relocation, I expect someone on a memory constrained
> system to come out of the woodwork screaming 'regression'. Systems with insufficient
> memory to allocate the page tables will no longer be able to kexec.
> 
> If we keep the relocation assembly code as it is, its possible for it to handle MMU-on and
> MMU-off relocations with a very small adjustment. It just won't work for Pavel, as
> enabling the MMU is not enough.
> 
> I'm confident we won't get a second copy of the relocation code, that only runs on some
> platforms, past the arch code maintainer.
> 
> 
> > However, I have several issues
> > with this take, which if addressed would be OK for me.
> > 1. The newer, more secure kexec syscall kexec_file_load(), which
> > allows to check the IMA integrity of the loaded file does not have a
> > way to specify the area in memory where to place the kernel. We are
> > using this syscall in production, and cannot go back to kexec_load()
> > for security reasons.
> > 2. Reserving memory means wasting memory during run-time. Our machine
> > has only 8G of RAM, and reserving even 128M 
> 
> You're loading a 128M kernel!?
> 
> 
> > for the next kernel is an
> > expensive proposition. Now we start loading the next kernel after some
> > non essential processes are stopped, but before essential processes
> > are stopped for the lowest downtime possible.
> 
> > 3. Disabling relocation means changes in the common code, which I am
> > not sure actually helps any other platform beside ARM64, so I am
> > worried it won't be accepted into upstream.
> 
> I'm happy to post the MMU-enabled series, it needs to be maintainable and solve someone's
> problem.
> 
> To chip away at the rest of Pavel's problem, my suggestions were:
>  * Allocate things in place. If we can allocate any 2MB hugepage, we can place the DTB
>   there and not need to relocate it.
> 
>  * use huge pages more generally in the core code. With the MMU enabled, this might keep
>    the core in write-streaming-mode for longer. (might, because this is very platform
>    specific).
> 
>  * Store the kexec payload in the crashkernel carveout, to eliminate the relocations
>    completely. This is the bit Pavel quoted.
> 
> To expand on the carveout:
> The crashkernel carveout is sized to load the payload, and memory to run the kdump kernel
> entirely from within the carveout. Its obviously bigger than the payload it contains.
> 
> If you load your kexec kernel into the 'memory' part of the carveout, it won't overwrite
> the kdump payload, and it wont require relocation, as its already stored in place. arm64's
> arch code will spot these in-place buffers, and skip the relocation.
> 
> If you kdump even after doing this, the kdump kernel sees the kexec payload as
> uninitialised memory, and will overwrite it.
> 
> If we did this, we wouldn't need to enable the MMU, and it should skip most of the
> relocation code on all architectures without any changes to the arch code.

I'm not very confident about this approach.  

Kdump usually goes with a minimum initramfs, but for kexec reboot the
normal initramfs generated by distribution could be larger, and there
could be some other cases which can cause troubles.

Another way, maybe one can copy the kernel, dtb, initrd etc with the
very early boot code. And the later kernel code just use the kexec_file_load
function to load them, since they are already in kernel buffers so the
relocations are not necessary.

Current kexec_file_load use 'fd' to load file content, we can have some
interface to load from memory buffers.

Anyway this is just a wild idea.

> 
> On arm64 the kernel and initramfs only need relocating because their physical addresses
> are baked into the DTB. The DTB's physical address is then passed to the new kernel.
> From memory: 'relocatable kernel' is detectable from the image header, and the support
> predates arm64's kexec support.
> 
> 
> James
> 

Thanks
Dave

