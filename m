Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B0EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B3120771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="gpganJ9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDGVms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:42:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34193 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGVms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:42:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id l14so2364427pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Lc03lxpmmTygABgX8OgiVj7a3XBF6ipkL+GRsRV1zvg=;
        b=gpganJ9Tu0hdI8gQe0b847IZvIq/PSx5Xs1039Kwbsifl55q3o1Gko+2cnLRqChYEH
         0WvXdJeHbcRz7d7/0wgi87isotznI9sDGaSMGdbMfYtxxPJCydAN29E7UUikB7QK6hAT
         85vnZAoVb6fUh6SuAB8SftLSTVTRdqfRU5i+OwLULeWtCU+UOtMZ/Zsph8XyeKaZMnPM
         xOvNJe/8dIiz7J1UoL2o6OVkCVlVc0Uug/etFpeCnof+m6b3ICuAr6aoUYVzjT3np49B
         LL5CPCU6VW2HTMHIBRGg0jv5uBP8YxkHuYpfXQmM8fVjNOnCyessmhZaLDm59vn4VlYI
         p7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Lc03lxpmmTygABgX8OgiVj7a3XBF6ipkL+GRsRV1zvg=;
        b=lr2YpFdSjGll2nm8pteiifA3zmn20olwCL9VGh0dz7TrVfdAFSx+R6nVRtJHxy9r9A
         CsGQnD6TKKY4WyFRouFoPo5PTgRDmAL1O3Lcbj++byJ3GYsEv4OXbim9+G6grrJVVfPB
         GUwIK4E8WlqQO2tWITidEvhZyKix30mqKgeKgE428MIUdh/KVrOb/3gdTs6kB0x/6Ni/
         W4++jj9rGO5gxCx5pUKxLsCPWMRFARyr3YxDU3mYLD1KKQGdJlN+58DbpspZbWfX66HT
         fm/xfqy3oW5ZjYkW81Z6AMbYeeD+7Y9+Pnq3l3jRTJSdxPL0/rjoHdu10srKZnOZcQQ7
         W6RA==
X-Gm-Message-State: AGi0Pua0VNCEsjB1CY9JSYFocTlxgqWWZ0B2PMLlJ3s401yQz6Lv97px
        KpHFN6L0XWv2XAlle1flcwSfeg==
X-Google-Smtp-Source: APiQypLKLZ5ZuY/7SKFspeCaOY0/NcQ//AWn65fwf5V38fiYhRELoMqVxzUPrTS8qSrs6FmsS8B7gQ==
X-Received: by 2002:a63:7e5e:: with SMTP id o30mr3986846pgn.57.1586295766919;
        Tue, 07 Apr 2020 14:42:46 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:a143:7d95:91a:a0ae? ([2601:646:c200:1ef2:a143:7d95:91a:a0ae])
        by smtp.gmail.com with ESMTPSA id s62sm14059371pgb.94.2020.04.07.14.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 14:42:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
Date:   Tue, 7 Apr 2020 14:42:44 -0700
Message-Id: <32206246-48F6-4C03-B2C7-FC766B1254EB@amacapital.net>
References: <9921cb2e-a7cb-c1d0-b120-c08f06be7c7f@intel.com>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
In-Reply-To: <9921cb2e-a7cb-c1d0-b120-c08f06be7c7f@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 7, 2020, at 1:21 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 4/7/20 10:55 AM, Keno Fischer wrote:
>>> On Tue, Apr 7, 2020 at 12:27 PM Dave Hansen <dave.hansen@intel.com> wrot=
e:
>>>=20
>>>>> How does this work with things like xstateregs_[gs]et() where the form=
at
>>>>> of the kernel buffer and thus the kernel XCR0 is exposed as part of ou=
r
>>>>> ABI?  With this patch, wouldn't a debugger app see a state buffer that=

>>>>> looks invalid?
>>>>=20
>>>> Since those operate on the in-kernel buffer of these, which
>>>> in this patch always uses the unmodified XCR0, ptracers
>>>> should not observe a difference.
>>>=20
>>> Those operate on *BOTH* kernel and userspace buffers.  They copy between=

>>> them.  That's kinda the point. :)
>>=20
>> Right, what I meant was that in this patch the kernel level
>> xsaves that populates the struct fpu always runs with
>> an unmodified XCR0, so the contents of the xsave area
>> in struct fpu does not change layout (this is the major
>> change in this patch over v1).
>=20
> The userspace buffer is... a userspace buffer.  It is not and should not
> be tied to the format of the kernel buffer.
>=20
>> Are you referring to a ptracer which runs with a modified XCR0, and
>> assumes that the value it gets back from ptrace will have an
>> XSTATE_BV equal to its own observed XCR0 and thus get confused about
>> the layout of the buffer (or potentially have not copied all of the
>> relevant xstate because it calculated a wrong buffer size)?
>=20
> I don't think it's insane for a process to assume that it can XRSTOR a
> buffer that it gets back from ptrace.  That seems like something that
> could clearly be an ABI that apps depend on.
>=20
> Also, let's look at the comment about where XCR0 shows up in the ABI
> (arch/x86/include/asm/user.h):
>=20
>> * For now, only the first 8 bytes of the software usable bytes[464..471] w=
ill
>> * be used and will be set to OS enabled xstate mask (which is same as the=

>> * 64bit mask returned by the xgetbv's xCR0).
>=20
> That also makes it sound like we expect there to be a *SINGLE* value
> across the entire system.  It also makes me wonder *which* xgetbv is
> expected to match USER_XSTATE_XCR0_WORD.  It can't be the ptracee since
> we expect them to change XCR0.  It can't be the ptracer because they can
> use this new prctl too.  So does it refer to the kernel?  Or, should the
> new prctl() *disable* future ptrace()s?
>=20
>> If so, I think that's just a buggy ptracer. The kernel's xfeature
>> mask is available via ptrace and a well-behaved ptracer should use
>> that (e.g. gdb does, though it looks like it then also assumes that
>> the xstate has no holes, so it potentially gets the layout wrong
>> anyway).
>=20
> I'm trying to figure out what the semantics are of this whole thing.  It
> can't be "don't let userspace observe the real XCR0" because ptrace
> exposes that.  Is it, "make memory images portable, unless it's a memory
> image from ptrace"?
>=20
>> In general, I don't really want the modified XCR0 to affect
>> anything other than the particular instructions that depend
>> on it and maybe the signal frame (though as I said before,
>> I'm open to either here).
>=20
> Just remember that, in the end, we don't get to say what a good ptracer
> or bad ptracer is.  If they're expecting semantics that we've kept
> constant for 10 years, we change the semantics, and the app breaks, the
> kernel is in the wrong.
>=20
> I also don't feel like I have a good handle on what ptracers *do* with
> their XSAVE buffers that they get/set.  How many apps in a distro do
> something with this interface?

Most of them treat it as bytes to be blindly stuck back into the tracee.  So=
me of them will display some registers for the user=E2=80=99s benefit.  Mayb=
e a couple that I don=E2=80=99t know about do something odd.=
