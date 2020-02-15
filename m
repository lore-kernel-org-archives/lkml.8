Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ABAC35242
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176622187F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsN5lIG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgBOAGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:06:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40632 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgBOAGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:06:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id b7so10947156qkl.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 16:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BPOdHtMy10jXLLqWHQ04CL+6fzbfR9FVbgkT55IQYqA=;
        b=hsN5lIG12+mhYE03VkiHZkluLmUE+FtBkH3B3q9sqbEy63o5kdNdvdplSEOwt5VtFl
         /3HBu3GZPYlmgymUKkOGiBVI9BhOz3WLz+pny/WbMtL3UXtaVMj7KAA+3i0Qz+h1VPAK
         TWdA6Kw11qbVrdngCCnSwhwNGQ3QErtldGpH8jTaQr60N2XShTBxD3W6lahKrpLqkfhT
         VOONB0TYIX0A31aEUG4B1waEAcoZ0nA3MQDfd6Q5CLPkT7NL6zjGnxjmrT0j1enbntFt
         NlL83fLrfLIuWXVp5zbPdDPW+vz/K/kBgwwJWPaUqRQ5SWVGc0dh5skZk0mSRp2CiWyU
         UFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BPOdHtMy10jXLLqWHQ04CL+6fzbfR9FVbgkT55IQYqA=;
        b=pecSOARK5WU1NnAJsOw6zdrGubp8mdrvwBPmOwnsPWNqMe+XRYUUYI/ZluAMIueKWH
         pUyRhX1EE0BlLpbwqtz6SoH2hmkIssr6l0SsXTNlDSf3xroiuTaXz6cR1VusKAju5OEA
         ET/sJok3BphPE1XoN1Pj/fql/DIGWAm1JCRLa5X+31ZGU+WBwRFI5MXx4fkVZGLU8T1H
         wxMna2bXqdh7K4ZYtnZdanaH498mEao+WkZyfHOxIX0xBnikcL+KL5ho3VDVmmYIf5Tg
         i3JsX7eGb9D8a0EuqMmd14bclzScwDnWet6v+TAWcDUa93UOfsOK0mrdbf2lJRENiQc3
         YToQ==
X-Gm-Message-State: APjAAAV66++6nW7jkyAVFglYZmnhNMj45uUt915i1/PxpZyCngzEDZWs
        9peTTs9Xn50ViQa0btdqYa8=
X-Google-Smtp-Source: APXvYqxkFO1PO4pGAzGNfZj1+Hgqs0kpTJ7IoxtEHoKtksplfJegJqKRl0NC5IE34uq9Uf7ka3ntyw==
X-Received: by 2002:ae9:c014:: with SMTP id u20mr4967709qkk.53.1581725159728;
        Fri, 14 Feb 2020 16:05:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t3sm4312931qtc.8.2020.02.14.16.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:05:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 14 Feb 2020 19:05:57 -0500
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        jpoimboe@redhat.com, peterz@infradead.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200215000556.GA3876732@rani.riverdale.lan>
References: <20200213184708.205083-1-ndesaulniers@google.com>
 <20200213192055.23kn5pp3s6gwxamq@google.com>
 <20200214061654.GA3136404@rani.riverdale.lan>
 <20200214180527.z44b4bmzn336mff2@google.com>
 <20200214204249.GA3624438@rani.riverdale.lan>
 <20200214222046.bkafub6dbtapgter@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214222046.bkafub6dbtapgter@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:20:46PM -0800, Fangrui Song wrote:
> On 2020-02-14, Arvind Sankar wrote:
> >
> >I was testing with hidden/protected visibility, I see you want this for
> >the no-semantic-interposition case. Actually a bit more testing shows
> >some peculiarities even with hidden visibility. With the below, the call
> >and lea create relocations in the object file, but the jmp doesn't. ld
> >does avoid creating a plt for this though.
> >
> >	.text
> >	.globl foo, bar
> >	.hidden foo
> >	bar:
> >		call	foo
> >		leaq	foo(%rip), %rax
> >		jmp	foo
> >
> >	foo:	ret
> 
> Yes, GNU as is inconsistent here.  While fixing
> https://sourceware.org/ml/binutils/2020-02/msg00243.html , I noticed
> that the rule is quite complex. There are definitely lots of places to
> improve.  clang 10 emits relocations consistently.
> 
>    call	foo              # R_X86_64_PLT32
>    leaq	foo(%rip), %rax  # R_X86_64_PC32
>    jmp	foo              # R_X86_64_PLT32
> 

I guess the reason why is that jmp instructions can be optimized to use
8-bit signed offset if the destination is close enough, so the assembler
wants to go through them anyway to check, while such optimization is not
possible for the call and lea.

clang 9 emits no relocations for me, unless @PLT/@GOTPCREL is explicitly
used. Has that changed? (Just using clang -o test.o test.s on that
assembler, not too familiar with invokation syntax)
