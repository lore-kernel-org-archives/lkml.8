Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BD5C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45B920731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588276725;
	bh=8UGlkfS3b0Qfi+GqXTADnCgpEzDxYSx5dvkPteuNa1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j+LfFL74nVKFfeuuAGpc+MjFIJjdpG3as4WM8Fx2T3isLNeuK5+NMtPj1lP04w3EH
	 06DUx5swbpDQuKOpCMdTr2j63A1t/HpCSxwNo4wwe6nAxpWHL1jA4CWkhwAmUJyQvz
	 bOOAKlm/QLncbSDmVC7v7MpXTcUvT07oW1SMwVDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgD3T6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgD3T6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:58:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9FC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:58:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so5566381edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buJprfejQSl5yOput5ZzEt1+jJW0SdBoSZ4YNZtieEY=;
        b=VUySWc9/2/N9fwGhjHudR0NYsyMdMYZXogyCdl4rAuef6cbEQbsUZSSi0oWuzE4z5h
         oCVQ61Pc7cnFxML60ozbbHuETGxsnqdWrMhn5WWKV0YPtGOtTP7g+li2MpWKMXtZQPIL
         fURRW8u5/c5rMyeSpaud7CEBjaUNeWdlVUYJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buJprfejQSl5yOput5ZzEt1+jJW0SdBoSZ4YNZtieEY=;
        b=afdf0n64CoL0LK4l3ALQ0XfP22DoajcKyVP2XcdyCDR/qjW0dtxTQ04zUfPpMvzb3m
         RVrKkz/G1O6YEx2+VLOVDCKjTuNoegUdnynl2s1sdsPlrW0+caBBKxLYAK0IVL6CyV0J
         fcPhVNBicE8j46UORWrE90hzmq6UWIj2MFkXs9FdRV19SP6rP7Gk4Zb79MSMJolHccr0
         rEDu9ZavCXaxR7u80KHFAeoImguqyL2rzmU3ztB161J6DP7gR7k1e9IawkAVkq14AmYm
         RLwZmWaM7yYphFdDKywLCWO1GKXz8T8LtZM/fs3EW9AEcCwy2lLTc/m1KARWzsaQgJqn
         gFAA==
X-Gm-Message-State: AGi0PuY7LhQ9Z6zmgtyLntGKFOhBIhfDb54aUpldxejY0iCWAi3khJ1I
        GRjEuRJ2H8LlIAsLVFxcBrgxZtcT0rw=
X-Google-Smtp-Source: APiQypLZAdBovXkh9CFMEKa127psAgREaMTk4jcHambMnTuzWRiPxj8FHgAYNKT7Cldsg8rqRvDNLg==
X-Received: by 2002:aa7:cd06:: with SMTP id b6mr605283edw.67.1588276721219;
        Thu, 30 Apr 2020 12:58:41 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id co22sm51823edb.30.2020.04.30.12.58.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 12:58:41 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id a8so5585447edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:58:40 -0700 (PDT)
X-Received: by 2002:a05:6512:1114:: with SMTP id l20mr178100lfg.31.1588276256935;
 Thu, 30 Apr 2020 12:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com> <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 12:50:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
Message-ID: <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:23 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> How about
>
>         try_copy_catch(void *dst, void *src, size_t count, int *fault)
>
> returns number of bytes not-copied (like copy_to_user etc).
>
> if return is not zero, "fault" tells you what type of fault
> cause the early stop (#PF, #MC).

That just makes things worse.

The problem isn't "what fault did I get?".

The problem is "what is the point of this function?".

In other words, I want the code to explain _why_ it uses a particular function.

So the question the function should answer is not "Why did it take a
fault?", but "Why isn't this just a 'memcpy()'"?

When somebody writes

    x = copy_to_user(a,b,c);

the "why is it not a memcpy" question never comes up, because the code
is obvious. It's not a memory copy, because it's copying to user
space, and user space is different!

In contrast, if you write

    x = copy_safe(a,b,c);

then what is going on? There is no rhyme or reason to the call. Is the
source unsafe? Wny? Is the destination faulting? Why? Both? How?

So "copy_to_user()" _answers_ a question. But "copy_safe()" just
results in more questions. See the difference?

And notice that the "why did it fault" question is NOT about your
"what kind of fault did it take" question. That question is generally
pretty much uninteresting.

The question I want answered is "why is this function being called AT ALL".

Again, "copy_to_user()" can fail, and we know to check failure cases.
But more importantly, the _reason_ it can fail is obvious from the
name and from the use. There's no confusion about "why".

"copy_safe()"? or "try_copy_catch()"? No such thing. It doesn't answer
that fundamental "why" question.

And yes, this also has practical consequences. If you know that the
failure is due to the source being some special memory (and if we care
about the MC case with unaligned accesses), then the function in
question should probably strive to make those _source_ accesses be the
aligned ones.  But if it's the destination that is special memory,
then it's the writes to the destination that should be aligned. If you
need both, you may need to be either mutually aligned, or do byte
accesses, or do special shifting copies. So it matters for any initial
alignment code (if the thing has alignment issues to begin with).

I haven't even gotten an answer to the "why would the write fail".
When I asked, Dan said

 "writes can mmu-fault now that memcpy_mcsafe() is also used by
_copy_to_iter_mcsafe()"

but as mentioned, the only reason I can find for _that_ is that the
destination is user space.

In which case a "copy_safe()" absolutely could never work.

If I can't figure out the "why is this function used" or even figure
out why it needs the semantics it claims it needs, then there's a
problem.

Personally, I suspect that the *easiest* way to support the broken
nvdimm semantics is to not have a "copy" function at all as the basic
accessor model.

Why? Exactly because "copy" is not a fundamental well-defined action.
You get nasty combinatorial explosions of different things, where you
have three different kinds of sources (user, RAM, nvdimm) and three
different kinds of destinations.

And that's ignoring the whole "maybe you don't want to do a plain
copy, maybe you want to calculate a RAID checksum, or do a 'strcpy()'
or whatever". If those are ever issues, you get another explosion of
combinations.

The only *fundamental* access would likely be a single read/write
operation, not a copy operation. Think "get_user()" instead of
"copy_from_user()".  Even there you get combinatorial explosions with
access sizes, but you can often generate those automatically or with
simple patterns, and then you can build up the copy functions from
that if you really need to.

                   Linus
