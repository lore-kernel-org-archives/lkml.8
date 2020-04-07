Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F13C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBCE20857
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="IgLldp2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDGRjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:39:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46891 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:39:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id k191so2039639pgc.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=3XwUwp3pgBvnG5QKAIgM6nYkdjDyX8ty4EUjxeeITl0=;
        b=IgLldp2IUD3AdT94teIH7R1Kzox4JrBZHD772J7XFCfK6waEJ3JFkTil1KpzxcOlWQ
         gfcfeoc5pCwTiRNzpfINnp1UadH5RtYVkEgcSGRPHlRPKCvhWUi/a0Xiqdh0aezldxJV
         Nx33uTzY7sXmwbChwCEmNc3xWhFzi0e6Ql2RPdMHpHBWfZh2x1/kOG1zPXW4xVexqCkC
         uEmNzdfsbLptTo3hhxrcxf/clfAk1JcVQBjmHzhcpgd5APZzu/sEl2sAMA67Cd1a1OkH
         wqtAzm2kcYdLN7fD7XkqFD5kLmo3dUR5nXqe+4SwilYTX/uQlPkGVSOoTFSf8rtNwD3W
         +LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=3XwUwp3pgBvnG5QKAIgM6nYkdjDyX8ty4EUjxeeITl0=;
        b=XpVzg2f9y2jHiWvelqyBRGFjdW2VJ04ChB+pBYesGUqvhyRHBt4jfwIGfDFEk3eGnN
         s+qYWm+xyjrZvfIHVhg2w2z1KrerXcHw9vKXgtFWLMVkj3W+uH4w5cuwty2Q+hOv3qxi
         QaKmFKJLAG4ajPeSUPXoKLvu3MMRbCpfrNlJUw83zcMF7IkKwkPP0sbxkFBVZdxQxTUW
         8WmFm+mEk03lp0cFwNLLv6rbMnE0C8aNv7RgbL3jvCIUlTRmIiXl92OjjRhbA/fm94KE
         8JouVZKJa/bST0stJxDkBS8OaUjO6ly7LCJVkilb6kS0mUvtIniaf33Vz5vfKl1tXMzr
         iJxw==
X-Gm-Message-State: AGi0PuZiWjZugZfAxiHAR2cClSuI8fqMRGNskzamziUtg6HFgyR6QZW5
        IOiMP76LJ1O1KnE7XwkXT5HyVQ==
X-Google-Smtp-Source: APiQypLDYPRvMovGL1rJQVdThBVbfZDDoVoxcUf0z+PonCSH/EJgmmJmJq91Pm2pjpHoY26oOZd1LA==
X-Received: by 2002:a62:1a03:: with SMTP id a3mr3590436pfa.171.1586281138748;
        Tue, 07 Apr 2020 10:38:58 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:648b:efdd:7224:327? ([2601:646:c200:1ef2:648b:efdd:7224:327])
        by smtp.gmail.com with ESMTPSA id nu13sm2329780pjb.22.2020.04.07.10.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 10:38:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
Date:   Tue, 7 Apr 2020 10:38:56 -0700
Message-Id: <772A564B-3268-49F4-9AEA-CDA648F6131F@amacapital.net>
References: <20200407172140.GB64635@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
In-Reply-To: <20200407172140.GB64635@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 7, 2020, at 10:21 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
>=20
> =EF=BB=BFOn Mon, Apr 06, 2020 at 01:42:28PM -0700, Andy Lutomirski wrote:
>>=20
>>>> On Apr 6, 2020, at 1:32 PM, Andy Lutomirski <luto@amacapital.net> wrote=
:
>>>=20
>>> =EF=BB=BF
>>>> On Apr 6, 2020, at 1:25 PM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>>>=20
>>>> =EF=BB=BFOn Mon, Apr 06, 2020 at 03:09:51PM -0400, Vivek Goyal wrote:
>>>>>> On Mon, Mar 09, 2020 at 09:22:15PM +0100, Peter Zijlstra wrote:
>>>>>>> On Mon, Mar 09, 2020 at 08:05:18PM +0100, Thomas Gleixner wrote:
>>>>>>>> Andy Lutomirski <luto@kernel.org> writes:
>>>>>>>=20
>>>>>>>>> I'm okay with the save/restore dance, I guess.  It's just yet more=

>>>>>>>>> entry crud to deal with architecture nastiness, except that this
>>>>>>>>> nastiness is 100% software and isn't Intel/AMD's fault.
>>>>>>>>=20
>>>>>>>> And we can do it in C and don't have to fiddle with it in the ASM
>>>>>>>> maze.
>>>>>>>=20
>>>>>>> Right; I'd still love to kill KVM_ASYNC_PF_SEND_ALWAYS though, even i=
f
>>>>>>> we do the save/restore in do_nmi(). That is some wild brain melt. Al=
so,
>>>>>>> AFAIK none of the distros are actually shipping a PREEMPT=3Dy kernel=

>>>>>>> anyway, so killing it shouldn't matter much.
>>>>>=20
>>>>> It will be nice if we can retain KVM_ASYNC_PF_SEND_ALWAYS. I have anot=
her
>>>>> use case outside CONFIG_PREEMPT.
>>>>>=20
>>>>> I am trying to extend async pf interface to also report page fault err=
ors
>>>>> to the guest.
>>>>=20
>>>> Then please start over and design a sane ParaVirt Fault interface. The
>>>> current one is utter crap.
>>>=20
>>> Agreed. Don=E2=80=99t extend the current mechanism. Replace it.
>>>=20
>>> I would be happy to review a replacement. I=E2=80=99m not really excited=
 to review an extension of the current mess.  The current thing is barely, i=
f at all, correct.
>>=20
>> I read your patch. It cannot possibly be correct.  You need to decide wha=
t happens if you get a memory failure when guest interrupts are off. If this=
 happens, you can=E2=80=99t send #PF, but you also can=E2=80=99t just swallo=
w the error. The existing APF code is so messy that it=E2=80=99s not at all o=
bvious what your code ends up doing, but I=E2=80=99m pretty sure it doesn=E2=
=80=99t do anything sensible, especially since the ABI doesn=E2=80=99t have a=
 sensible option.
>=20
> Hi Andy,
>=20
> I am not familiar with this KVM code and trying to understand it. I think
> error exception gets queued and gets delivered at some point of time, even=

> if interrupts are disabled at the time of exception. Most likely at the ti=
me
> of next VM entry.

I=E2=80=99ve read the code three or four times and I barely understand it. I=
=E2=80=99m not convinced the author understood it.  It=E2=80=99s spaghetti.

>=20
> Whether interrupts are enabled or not check only happens before we decide
> if async pf protocol should be followed or not. Once we decide to
> send PAGE_NOT_PRESENT, later notification PAGE_READY does not check
> if interrupts are enabled or not. And it kind of makes sense otherwise
> guest process will wait infinitely to receive PAGE_READY.
>=20
> I modified the code a bit to disable interrupt and wait 10 seconds (after
> getting PAGE_NOT_PRESENT message). And I noticed that error async pf
> got delivered after 10 seconds after enabling interrupts. So error
> async pf was not lost because interrupts were disabled.
>=20
> Havind said that, I thought disabling interrupts does not mask exceptions.=

> So page fault exception should have been delivered even with interrupts
> disabled. Is that correct? May be there was no vm exit/entry during
> those 10 seconds and that's why.

My point is that the entire async pf is nonsense. There are two types of eve=
nts right now:

=E2=80=9CPage not ready=E2=80=9D:  normally this isn=E2=80=99t even visible t=
o the guest =E2=80=94 the guest just waits. With async pf, the idea is to tr=
y to tell the guest that a particular instruction would block and the guest s=
hould do something else instead. Sending a normal exception is a poor design=
, though: the guest may not expect this instruction to cause an exception. I=
 think KVM should try to deliver an *interrupt* and, if it can=E2=80=99t, th=
en just block the guest.

=E2=80=9CPage ready=E2=80=9D: this is a regular asynchronous notification ju=
st like, say, a virtio completion. It should be an ordinary interrupt.  Some=
 in memory data structure should indicate which pages are ready.

=E2=80=9CPage is malfunctioning=E2=80=9D is tricky because you *must* delive=
r the event. x86=E2=80=99s #MC is not exactly a masterpiece, but it does kin=
d of work.

>=20
> Thanks
> Vivek
>=20
