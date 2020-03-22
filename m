Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE5C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC3720722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="PxZksnGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgCVPKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:10:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46183 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:10:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id r3so4747227pls.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=vNrHv5MU5i37N5R1LqzO2eNJ+gJR0AhuDRT5HbNSdYI=;
        b=PxZksnGoOqFjksaqQgo37ZEPfKNQvvro7H3lqZdDWmqd+HsWmCcoH7I91t3qV82yMN
         KTHSgbNXdsoX1n3miwFkC4Uro78wvrZT1nHph6Ayh0ndF1WZ1BR5OrakYTwFxtoSYow9
         T60hXFKiq0f6Aoako2NuWe0EUDbEwin+SV+Xin4LY17SqoKsmdGbXozLP/gtelVP0Yw/
         UmjwE/EZBCHJzpGHx0NoJEh/ixB+0noV/5Bj04sWmKdd4ApR9Nx2t3e8gk5/+R+2axut
         cDtE4E86GvZ6XQQzBJT5c8UbGF4djnY9czMKZXhFzCEhaz9Ufp+Gobc3Btn3MGdRgYx0
         xxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vNrHv5MU5i37N5R1LqzO2eNJ+gJR0AhuDRT5HbNSdYI=;
        b=dOy/zXuOmwCc/y5U5aRSDMmHNSrMD45tDdik9ZKInmXMg9Bub8IOB3cIzxcgPwjfPn
         5lEwrypIRltGhZ7dWPy0EJGEBeGHDdnI54FGUV/gcndI5LR7vPZFQrDhNzzHdmA5aQO6
         yC/cuE5aMk20haMT/65sLpar/InjY6NvBp1IXOg3TYPGslKFMTmn4n7phn50V98EOlk4
         g29ZjlTPdMw0U0CWyC9mA8lgavXDgY2muvKlyCY7l7bZ4miHkV4Qn93llsMM93x8679H
         WitdW2AVxf8lD9JztgUVy4H+KiQID9WilvvF8lLDBdpZFTjWmB5t+c9p9Xa58s3BR7KZ
         YzLQ==
X-Gm-Message-State: ANhLgQ2ovbvyAngjrtGZyW6TfXexoz2H5tNCbSkEop34V+iLze78n9ZC
        MtkzLZ03TBfJeLRICDxZl5kVig==
X-Google-Smtp-Source: ADFU+vtI5uhetij9RLJkj+3AkhajnPNS4gR1VAbceNcLt2YdcSN3ul3WZX/TwKMfysSuuE9IPSQ6mw==
X-Received: by 2002:a17:902:a502:: with SMTP id s2mr17474359plq.204.1584889832230;
        Sun, 22 Mar 2020 08:10:32 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e53e:ff0:f752:748a? ([2601:646:c200:1ef2:e53e:ff0:f752:748a])
        by smtp.gmail.com with ESMTPSA id b16sm3073210pfb.71.2020.03.22.08.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 08:10:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Date:   Sun, 22 Mar 2020 08:10:29 -0700
Message-Id: <A38682A4-62B2-4849-ADEA-196DFF4D36C9@amacapital.net>
References: <99ef5eec8502a7b53eee362063b9b2252a5a47da.camel@amazon.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>
In-Reply-To: <99ef5eec8502a7b53eee362063b9b2252a5a47da.camel@amazon.com>
To:     "Herrenschmidt, Benjamin" <benh@amazon.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 21, 2020, at 10:08 PM, Herrenschmidt, Benjamin <benh@amazon.com> wr=
ote:
>=20
> =EF=BB=BFOn Fri, 2020-03-20 at 12:49 +0100, Thomas Gleixner wrote:
>> Balbir,
>>=20
>> "Singh, Balbir" <sblbir@amazon.com> writes:
>>>> On Thu, 2020-03-19 at 01:38 +0100, Thomas Gleixner wrote:
>>>>> What's the point? The attack surface is the L1D content of the schedul=
ed
>>>>> out task. If the malicious task schedules out, then why would you care=
?
>>>>>=20
>>>>> I might be missing something, but AFAICT this is beyond paranoia.
>>>>>=20
>>>=20
>>> I think there are two cases
>>>=20
>>> 1. Task with important data schedules out
>>> 2. Malicious task schedules in
>>>=20
>>> These patches address 1, but call out case #2
>>=20
>> The point is if the victim task schedules out, then there is no reason
>> to flush L1D immediately in context switch. If that just schedules a
>> kernel thread and then goes back to the task, then there is no point
>> unless you do not even trust the kernel thread.
>=20
> A switch to a kernel thread will not call switch_mm, will it ? At least it=
 used not to...
>=20
>>>>> 3. There is a fallback software L1D load, similar to what L1TF does, b=
ut
>>>>>    we don't prefetch the TLB, is that sufficient?
>>>>=20
>>>> If we go there, then the KVM L1D flush code wants to move into general
>>>> x86 code.
>>>=20
>>> OK.. we can definitely consider reusing code, but I think the KVM bits r=
equire
>>> tlb prefetching, IIUC before cache flush to negate any bad translations
>>> associated with an L1TF fault, but the code/comments are not clear on th=
e need
>>> to do so.
>>=20
>> I forgot the gory details by now, but having two entry points or a
>> conditional and share the rest (page allocation etc.) is definitely
>> better than two slightly different implementation which basically do the s=
ame thing.
>>=20
>>>>> +void enable_l1d_flush_for_task(struct task_struct *tsk)
>>>>> +{
>>>>> +     struct page *page;
>>>>> +
>>>>> +     if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
>>>>> +             goto done;
>>>>> +
>>>>> +     mutex_lock(&l1d_flush_mutex);
>>>>> +     if (l1d_flush_pages)
>>>>> +             goto done;
>>>>> +     /*
>>>>> +      * These pages are never freed, we use the same
>>>>> +      * set of pages across multiple processes/contexts
>>>>> +      */
>>>>> +     page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, L1D_CACHE_ORDER);
>>>>> +     if (!page)
>>>>> +             return;
>>>>> +
>>>>> +     l1d_flush_pages =3D page_address(page);
>>>>> +     /* I don't think we need to worry about KSM */
>>>>=20
>>>> Why not? Even if it wouldn't be necessary why would we care as this is a=

>>>> once per boot operation in fully preemptible code.
>>>=20
>>> Not sure I understand your question, I was stating that even if KSM was
>>> running, it would not impact us (with dedup), as we'd still be writing o=
ut 0s
>>> to the cache line in the fallback case.
>>=20
>> I probably confused myself vs. the comment in the VMX code, but that
>> mentions nested virt. Needs at least some consideration when we reuse
>> that code.
>>=20
>>>>>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>>>>              struct task_struct *tsk)
>>>>>  {
>>>>> @@ -433,6 +519,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, st=
ruct
>>>>> mm_struct *next,
>>>>>               trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
>>>>>       }
>>>>>=20
>>>>> +     l1d_flush(next, tsk);
>>>>=20
>>>> This is really the wrong place. You want to do that:
>>>>=20
>>>>   1) Just before return to user space
>>>>   2) When entering a guest
>>>>=20
>>>> and only when the previously running user space task was the one which
>>>> requested this massive protection.
>>>>=20
>>>=20
>>> Cases 1 and 2 are handled via
>>>=20
>>> 1. SWAPGS fixes/work arounds (unless I misunderstood your suggestion)
>>=20
>> How so? SWAPGS mitigation does not flush L1D. It merily serializes SWAPGS=
.
>=20
>>> 2. L1TF fault handling
>>>=20
>>> This mechanism allows for flushing not restricted to 1 or 2, the idea is=
 to
>>> immediately flush L1D for paranoid processes on mm switch.
>>=20
>> Why? To protect the victim task against the malicious kernel?
>=20
> Mostly malicious other tasks for us. As I said, I don't think switch_mm
> is called on switching to a kernel thread and is definitely a colder
> path than the return to userspace, so it felt like the right place to
> put this, but I don't mind if you prefer it elsewhere as long as it
> does the job which is to prevent task B to snoop task A data.
>=20
>> The L1D content of the victim is endangered in the following case:
>>=20
>>    victim out -> attacker in
>>=20
>> The attacker can either run in user space or in guest mode. So the flush
>> is only interesting when the attacker actually goes back to user space
>> or reenters the guest.
>>=20
>> The following is completely uninteresting:
>>=20
>>    victim out -> kernel thread in/out -> victim in
>=20
> Sure but will that call switch_mm to be called ?
>=20
>> Even this is uninteresting:
>>=20
>>    victim in -> attacker in (stays in kernel, e.g. waits for data) ->
>>    attacker out -> victim in
>=20
> I don't get this ... how do you get attacker_in without victim_out
> first ? In which case you have a victim_out -> attacker_in transition
> which is what we are trying to protect.
>=20
> I still think flushing the "high value" process L1D on switch_mm out is
> the way to go here...

Let me try to understand the issue. There is some high-value data, and that d=
ata is owned by a high-value process. At some point, the data ends up in L1D=
.  Later in, evil code runs and may attempt to exfiltrate  that data from L1=
D using a side channel. (The evil code is not necessarily in a malicious pro=
cess context. It could be kernel code targeted by LVI or similar. It could b=
e ordinary code that happens to contain a side channel gadget by accident.)

So the idea is to flush L1D after manipulating high-value data and before ru=
nning evil code.

The nasty part here is that we don=E2=80=99t have a good handle on when L1D i=
s filled and when the evil code runs. If the evil code is untrusted process u=
serspace and the fill is an interrupt, then switch_mm is useless and we want=
 to flush on kernel exit instead. If the fill and evil code are both userspa=
ce, then switch_mm is probably the right choice, but prepare_exit_from_userm=
ode works too. If SMT is on, we lose no matter what.  If the evil code is in=
 kernel context, then it=E2=80=99s not clear what to do. If the fill and the=
 evil code are both in kernel threads (hi, io_uring), then I=E2=80=99m not a=
t all sure what to do.

In summary, kernel exit seems stronger, but the right answer isn=E2=80=99t s=
o clear.

We could do an optimized variant where we flush at kernel exit but we *decid=
e* to flush in switch_mm.
