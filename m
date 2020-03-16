Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B41C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D994120409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1EbTPZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgCPSUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:20:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44780 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732236AbgCPSUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:20:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id h16so15073452qtr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKFZzAhZQvtZ0ajIaQdWvUFb/RVZsTqaSdNCIFm2bao=;
        b=Z1EbTPZvjSbUTzInKlQ3ySCYhajxIyyyUeRxcNt/UtHDB8fhtPVLH3HbFPcxj9lmRr
         aQAMksOrY2R+WNj9Y2wMs9jz819yimoo9vv0FOyHAr3u8up3NmVVjeKO1b13yxLu4HbP
         cIQoAmzVi2BVZOb0YlM1XMAIb9AXU2uz6tuE+T1mfdGjOZPp3IVvOGASm+INvZjMX1o7
         QFu3d6E/Zta85NL0yLj4DlCMiRtnoPMnylDAM0v3de6Syk8xeyjkmoMyZF1NZp7rvQuN
         eb1pTYjEzPMHDrWvr6aItwgPasKTcJUQXvCD7FetJ+z30O6uNIhaVYum/NDmunfN5r+u
         SSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKFZzAhZQvtZ0ajIaQdWvUFb/RVZsTqaSdNCIFm2bao=;
        b=rniBERISoQR/lf/qVfO9FPwkKvNSVL1/tzXRoAYUFnFbj8SyBqGUQFt/OM+a26sT7X
         R7+wtxZjqwbcf/8oJMw5ESC4t0n2abUPKxJZAMwl5cM6UGJCODWxIRlLsFl+3tlpqgc/
         Bpj6pjcihoiYsyYRtfQjH5uDuUq+xXJi6sx1cVALqvFa9ogLN581CLnGrZDLTrOLISKF
         FO8O70luVkPNxc/Dw+/WUDgNBJM4vpFwM+tScqU/ZCpAFqYsbeorLOjNtfoKd0L1UL2e
         GbDHaV4sxZ2u5PVdHkVijAdRnbNH2BGzhFrRQqc2dYlp/TZflInH5orYvO8rpeiSaWrY
         7a1g==
X-Gm-Message-State: ANhLgQ07kAdM3hJZXUpryEwn0GTCtbIwkzSswr+FUV+RE4U0cXNiKD9j
        fhI3oVKkBpsqkZcO2Qg8BKo=
X-Google-Smtp-Source: ADFU+vut8+lk8h6DghsGF9vXWwJyd0Q9FTHyY9s/hrhAU/14scaEcUy0d31RwT+XbbfJ4twZkjo9Jg==
X-Received: by 2002:aed:36a5:: with SMTP id f34mr1369065qtb.57.1584382802448;
        Mon, 16 Mar 2020 11:20:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z18sm365473qtz.77.2020.03.16.11.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 11:20:01 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 16 Mar 2020 14:20:00 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316181957.GA348193@rani.riverdale.lan>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316175450.GO26126@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:54:50PM +0100, Borislav Petkov wrote:
> On Mon, Mar 16, 2020 at 02:42:34PM +0100, Peter Zijlstra wrote:
> > Right I know, I looked for it recently :/ But since this is new in 10
> > and 10 isn't released yet, I figured someone can add the attribute
> > before it does get released.
> 
> Yes, that would be a good solution.
> 
> I looked at what happens briefly after building gcc10 from git and IINM,
> the function in question - start_secondary() - already gets the stack
> canary asm glue added so it checks for a stack canary.
> 
> However, the stack canary value itself gets set later in that same
> function:
> 
>         /* to prevent fake stack check failure in clock setup */
>         boot_init_stack_canary();
> 
> so the asm glue which checks for it would need to reload the newly
> computed canary value (it is 0 before we compute it and thus the
> mismatch).
> 
> So having a way to state "do not add stack canary checking to this
> particular function" would be optimal. And since you already have the
> "stack_protect" function attribute I figure adding a "no_stack_protect"
> one should be easy...
> 
> > > Or of course you could add noinline attribute to whatever got inlined
> > > and contains some array or addressable variable that whatever
> > > -fstack-protector* mode kernel uses triggers it.  With -fstack-protector-all
> > > it would never work even in the past I believe.
> > 
> > I don't think the kernel supports -fstack-protector-all, but I could be
> > mistaken.
> 
> The other thing I was thinking was to carve out only that function into
> a separate compilation unit and disable stack protector only for it.
> 
> All IMHO of course.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

With STACKPROTECTOR_STRONG, gcc9 (at least gentoo's version, not sure if
they have some patches that affect it) already adds stack canary into
start_secondary. Not sure why it doesn't panic already with gcc9?

00000000000008f0 <start_secondary>:
     8f0:       53                      push   %rbx
     8f1:       48 83 ec 10             sub    $0x10,%rsp
     8f5:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
     8fc:       00 00
     8fe:       48 89 44 24 08          mov    %rax,0x8(%rsp)
     903:       31 c0                   xor    %eax,%eax
...
     a2e:       e8 00 00 00 00          callq  a33 <start_secondary+0x143>
                        a2f: R_X86_64_PLT32     cpu_startup_entry-0x4
     a33:       48 8b 44 24 08          mov    0x8(%rsp),%rax
     a38:       65 48 33 04 25 28 00    xor    %gs:0x28,%rax
     a3f:       00 00 
     a41:       75 12                   jne    a55 <start_secondary+0x165>
     a43:       48 83 c4 10             add    $0x10,%rsp
     a47:       5b                      pop    %rbx
     a48:       c3                      retq   
     a49:       0f 01 1d 00 00 00 00    lidt   0x0(%rip)        # a50 <start_secondary+0x160>
                        a4c: R_X86_64_PC32      debug_idt_descr-0x4
     a50:       e9 cb fe ff ff          jmpq   920 <start_secondary+0x30>
     a55:       e8 00 00 00 00          callq  a5a <start_secondary+0x16a>
                        a56: R_X86_64_PLT32     __stack_chk_fail-0x4
