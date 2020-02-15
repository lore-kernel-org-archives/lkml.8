Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9EEC35242
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6B0206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHxib7TD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBOAeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:34:05 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38830 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgBOAeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:34:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id z19so10981258qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 16:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmgYhweJhl89e4ilF9ZJJWJKYHyCp9Ogu+nrxQ6cXtA=;
        b=CHxib7TDnzFLxDBvZ9ve8Fbrhu0Z8MIsjbMBJhrKzxeQvOjYN2LyeVS/SKolbt9HtK
         jXUrN27cc2r97xOivSLeABDb40V9o+0/XSnU7hdoMGc1F7E98VwP1DnF9tBSWbQPvn0w
         TOAFiC+mLMc8CQQtyRDLx3eE3mWxXZFZWUmsjCvMer7fregi4q+oAgR5gpzAGEXDOvdg
         agvX48Hkni1XoKoXPHWjJRExonD5c/YVatu4N61zHnlX41N2wW4LtRPdomDlf/UJ3e72
         q2YqPASZOY7HgYFQiee07x6UCGRYEfjvlpkkdQVCugzGHf4kAGIx19CNw0i0g+4CBqn9
         Ca7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmgYhweJhl89e4ilF9ZJJWJKYHyCp9Ogu+nrxQ6cXtA=;
        b=DaT1GvYNeBj7F/w6zA/M1IRx3cWviVYYD3dKpdLb5coZ1u9jEQvAohtci7ChQltrkx
         QtpzPhiXwS08+I/hM4ybU1yHdmDDYb2Nvij4HSNeQinhwTChHirwxacWbFJNcTgv6Lwo
         4OjV6VJ6zgbu7FTeoPx6QOIi9/g7k1rr7WVsQEH/8TUCrtpSgu0XggtSOMMG4nQ2U+6K
         3Z4+A40nsoln5/BDjD4XXZsUqeLxyDBT9W10GyxKdE1LuALXRAP2EIMhlT8M2UO/rDkf
         AP/EsOoRNlGuTiEEhT798bbZC+ISjYnctyZ5xwG4joSWLGSokf+zHHijhFkqZ837nVeS
         /AVA==
X-Gm-Message-State: APjAAAUIslv4r27Af0TKjdNx6mrrcXTjC4jd1R/aIl1jjBFT7tTAcQNH
        x+KiVjmH8Kn91y/ar5lWits=
X-Google-Smtp-Source: APXvYqzg2LwD6m15ztqdXwqrIzR8jRG6Nlct/2lCqoMJ5xd5U+xRXz31rrX+3OE7vb9a3EdCTPyaYw==
X-Received: by 2002:a37:4f54:: with SMTP id d81mr5221995qkb.408.1581726842986;
        Fri, 14 Feb 2020 16:34:02 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w9sm4303610qka.71.2020.02.14.16.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:34:02 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 14 Feb 2020 19:34:01 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        jpoimboe@redhat.com, peterz@infradead.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200215003400.GA3908513@rani.riverdale.lan>
References: <20200213184708.205083-1-ndesaulniers@google.com>
 <20200213192055.23kn5pp3s6gwxamq@google.com>
 <20200214061654.GA3136404@rani.riverdale.lan>
 <20200214180527.z44b4bmzn336mff2@google.com>
 <20200214204249.GA3624438@rani.riverdale.lan>
 <20200214222046.bkafub6dbtapgter@google.com>
 <20200215000556.GA3876732@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200215000556.GA3876732@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 07:05:57PM -0500, Arvind Sankar wrote:
> On Fri, Feb 14, 2020 at 02:20:46PM -0800, Fangrui Song wrote:
> > On 2020-02-14, Arvind Sankar wrote:
> > >
> > >I was testing with hidden/protected visibility, I see you want this for
> > >the no-semantic-interposition case. Actually a bit more testing shows
> > >some peculiarities even with hidden visibility. With the below, the call
> > >and lea create relocations in the object file, but the jmp doesn't. ld
> > >does avoid creating a plt for this though.
> > >
> > >	.text
> > >	.globl foo, bar
> > >	.hidden foo
> > >	bar:
> > >		call	foo
> > >		leaq	foo(%rip), %rax
> > >		jmp	foo
> > >
> > >	foo:	ret
> > 
> > Yes, GNU as is inconsistent here.  While fixing
> > https://sourceware.org/ml/binutils/2020-02/msg00243.html , I noticed
> > that the rule is quite complex. There are definitely lots of places to
> > improve.  clang 10 emits relocations consistently.
> > 
> >    call	foo              # R_X86_64_PLT32
> >    leaq	foo(%rip), %rax  # R_X86_64_PC32
> >    jmp	foo              # R_X86_64_PLT32
> > 
> 
> I guess the reason why is that jmp instructions can be optimized to use
> 8-bit signed offset if the destination is close enough, so the assembler
> wants to go through them anyway to check, while such optimization is not
> possible for the call and lea.
> 
> clang 9 emits no relocations for me, unless @PLT/@GOTPCREL is explicitly
> used. Has that changed? (Just using clang -o test.o test.s on that
> assembler, not too familiar with invokation syntax)

Actually, wait, it does that even with default visibility. The only way
to make it allow for symbol interposition is to explicitly use @PLT etc.
Is the only reason you're adding these local symbols then is to work
around GNU as adding PLT relocations automatically for call foo?
