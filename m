Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7297BC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EC82070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="asnUUpYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCZUvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:51:23 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21164 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:51:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585255846; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=goDa1uetFfJ/Wyf+q+JO9pKMxOsRxrD6LZ/iHPrzmwpd/EgpmR+JgqKXH3LccSKPqq5Zz0wEhQeFKrb47Cm5P9GUL4mbar/sx9Vjnxc/mYBY5vufmk6ql6IsM6WMmRdXnKimekJqqgN24rXRV4WozULkciWAVJ67MBFRpQy0Ws4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585255846; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=aa4K/ZRFPJeoEuPOg/NZttGCne1mt+XFCAyeIhYYMt4=; 
        b=SuEwoErdmvWfQpOFaNn0vRkKfdo2l2rca21Ielq7RyVwDGTJ0Iu9VZbxuByRMCQ5PE+cf4qth/jc1ZHTWepi8Tp913Ah70Zgxg1dHaYJCI1TDrLSMms82DewR+bDgaF6YhClGYJLXLXSr81+viyDTgEI8tFvReOp+4x1baO5OqU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585255846;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=aa4K/ZRFPJeoEuPOg/NZttGCne1mt+XFCAyeIhYYMt4=;
        b=asnUUpYHkDeALYCSzwdZFlnSzF8ikd3wUpiGeebw/2TnzDKDPi9WoliJRN6DebXV
        p/rnVo28DcxyuU22ZRWxV+34kAmk70P13/KF/z6ZpqhIFZ/DAbTCox1brRnYq4x85TU
        DqD07h22L/3GtZcbCRyvaIbfRz5utf1xHvTiqitA=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1585255844877600.7985414883151; Thu, 26 Mar 2020 13:50:44 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel
 support
To:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
 <CALCETrUshiLMHyf4DShgDRtCvnzUVyRQgmgCiudvhuhw05cDxg@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <6bb09673-292e-b056-3755-ffc51a1d6b59@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Thu, 26 Mar 2020 16:50:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUshiLMHyf4DShgDRtCvnzUVyRQgmgCiudvhuhw05cDxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 6:51 PM, Andy Lutomirski wrote:
> On Wed, Mar 25, 2020 at 1:29 PM Matthew Garrett <mjg59@google.com> wrote:
>>
>> On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
>> <ross.philipson@oracle.com> wrote:
>>> To enable the kernel to be launched by GETSEC or SKINIT, a stub must be
>>> built into the setup section of the compressed kernel to handle the
>>> specific state that the late launch process leaves the BSP. This is a
>>> lot like the EFI stub that is found in the same area. Also this stub
>>> must measure everything that is going to be used as early as possible.
>>> This stub code and subsequent code must also deal with the specific
>>> state that the late launch leaves the APs in.
>>
>> How does this integrate with the EFI entry point? That's the expected
>> entry point on most modern x86. What's calling ExitBootServices() in
>> this flow, and does the secure launch have to occur after it? It'd be
>> a lot easier if you could still use the firmware's TPM code rather
>> than carrying yet another copy.
>=20
> I was wondering why the bootloader was involved at all.  In other
> words, could you instead hand off control to the kernel just like
> normal and have the kernel itself (in normal code, the EFI stub, or
> wherever it makes sense) do the DRTM launch all by itself?  This would
> avoid needing to patch bootloaders, to implement this specially for
> QEMU -kernel, to get the exact right buy-in from all the cloud
> vendors, etc.  It would also give you more flexibility to evolve
> exactly what configuration maps to exactly what PCRs in the future.
>=20

Partly this is driven by the fact that one of the goals for the
TrenchBoot project is about more universal/unified, cross open source
project adoption of Dynamic Launch. Another aspect is that initiating a
Dynamic Launch requires additional file(s) to be loaded, the platform to
be put into a quiescent state, and the invocation of the SENTER/SKINIT
instruction can be thought of as a soft reset of the CPU that on Intel
even results in the CPU being in a different mode (SMX) which has a
subtle change to its behavior. In the TCG Dynamic Launch design, the
component responsible for this loading, preparing, and Dynamic Launch
Instruction invocation is referred to as the Preamble and IMHO the best
time for dealing with such a disruptive behavior caused by invoking the
instruction is at the boot boundary. It also makes for a good transition
point to enable switching between kernels in control of the system
whereby the integrity will be establish by the hardware instead of the
kernel (UEFI, GRUB, Linux, etc.) that loaded it. I think what helps
address your concern is that one of the next items on the roadmap is to
extend kexec to be able to perform the Preamble. As I just mentioned,
this provides a clean way to transition for one Linux kernel that may or
may not have been started via a Dynamic Launch could relaunch itself,
launch a new Linux kernel, or even launch a non-Linux kernel that is
Dynamic Launch aware.

As for controlling which PCRs are used, the ability to control that is
actually quite limited. The CPU will always put its first measurement
into PCR 17 and then next set of measurement will differ depending on
whether you are on Intel or AMD. With Intel, the Intel provided binary
blob called the ACM has a fixed measurement policy it uses to place
measurements into PCRs 17 and 18. On AMD they left their ACM equivalent
as an exercise for the implementer (for which we have one in
development) which give us control over the measurements that it takes.
Then you have to consider the properties of the DRTM PCRs, 17-22, where
PCRs 17, 18, and 19 are the only ones that cannot be reset after the
DRTM event. Where as PCRs 20, 21, 22 can be reset by Locality 2, the
highest locality for which the kernel will be able to request/access.

I hope this helps and if you have any other questions concerns I would
be glad to answer them.

V/r,
Daniel P. Smith

