Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5926AC433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332902086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595539822;
	bh=LjPYQXYCMq01OkWf8ZVQxeTp9Qz+blIk2hR6fIzeLNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ldhl7HAP9C26rspS5ai2HpXVE7YDh8lYR8FkArPbhatCBScR7BviM5LmzwuWJZnGY
	 /f9rf9QyEUUrcbSdFkk6S61tXoL5ce+soB/gGZYDS1QI1YRcEJBit7qVAE0rxfZX17
	 /Rbgeqty06lVj2B69/5uYibCCj9jCcBzcVocdKTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgGWVaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGWVaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:30:21 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A2C22CF7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595539820;
        bh=LjPYQXYCMq01OkWf8ZVQxeTp9Qz+blIk2hR6fIzeLNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QinynW2K93EXrPR6DHoUgxUGXaHWzMH146Nrrve6MhpMPCFwGDoURTCwZW01w2nig
         yjJRiHvrDGxPpz7uOlli64G8+T1vxQUU9Hzaz9+hUdIyI0JcVCYuSGY1wFgfAPnSa/
         Qz1ISBhK19OBZO0AlIkHeM5E1hrKxyuX0nsm1UII=
Received: by mail-wr1-f47.google.com with SMTP id b6so6474929wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 14:30:19 -0700 (PDT)
X-Gm-Message-State: AOAM533pQzHigWhIg4TKPZQmbpU6z1pZfqkjn5H2J3/xw0dD8QsfFnNB
        XBK/Q4xtkiEexgoFEC/HLASDcbiWppJHwaA9iGpNcQ==
X-Google-Smtp-Source: ABdhPJxkIDtPFawZcWsduLG2ySWexVRWYEyTMNYsD2OEQFrKOENShjDryhjYBkc7VXix4cqL0MKNzSQ5LIQb5iHR31E=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr5578852wrc.257.1595539818063;
 Thu, 23 Jul 2020 14:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
 <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net> <87imeevv6b.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87imeevv6b.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 23 Jul 2020 14:30:06 -0700
X-Gmail-Original-Message-ID: <CALCETrUdxpVP3dZgsZBpCODxW8yaiHguxTu=aHg_AkRbs91dWg@mail.gmail.com>
Message-ID: <CALCETrUdxpVP3dZgsZBpCODxW8yaiHguxTu=aHg_AkRbs91dWg@mail.gmail.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Weiny Ira <ira.weiny@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 23, 2020, at 1:22 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> =EF=BB=BFAndy Lutomirski <luto@amacapital.net> writes:
>
>> Suppose some kernel code (a syscall or kernel thread) changes PKRS
>> then takes a page fault. The page fault handler needs a fresh
>> PKRS. Then the page fault handler (say a VMA=E2=80=99s .fault handler) c=
hanges
>> PKRS.  The we get an interrupt. The interrupt *also* needs a fresh
>> PKRS and the page fault value needs to be saved somewhere.
>>
>> So we have more than one saved value per thread, and thread_struct
>> isn=E2=80=99t going to solve this problem.
>
> A stack of 7 entries and an index needs 32bytes total which is a
> reasonable amount and solves the problem including scheduling from #PF
> nicely. Make it 15 and it's still only 64 bytes.
>
>> But idtentry_state is also not great for a couple reasons.  Not all
>> entries have idtentry_state, and the unwinder can=E2=80=99t find it for
>> debugging. For that matter, the page fault logic probably wants to
>> know the previous PKRS, so it should either be stashed somewhere
>> findable or it should be explicitly passed around.
>>
>> My suggestion is to enlarge pt_regs.  The save and restore logic can
>> probably be in C, but pt_regs is the logical place to put a register
>> that is saved and restored across all entries.
>
> Kinda, but that still sucks because schedule from #PF will get it wrong
> unless you do extra nasties.

This seems like we=E2=80=99re reinventing the wheel.  PKRS is not
fundamentally different from, say, RSP.  If we want to save it across
exceptions, we save it on entry and context-switch-out and restore it
on exit and context-switch-in.


>
>> Whoever does this work will have the delightful job of figuring out
>> whether BPF thinks that the layout of pt_regs is ABI and, if so,
>> fixing the resulting mess.
>>
>> The fact the new fields will go at the beginning of pt_regs will make
>> this an entertaining prospect.
>
> Good luck with all of that.

We can always cheat like this:

struct real_pt_regs {
  unsigned long pkrs;
  struct pt_regs regs;
};

and pass a pointer to regs around.  What BPF doesn't know about can't hurt =
it.
