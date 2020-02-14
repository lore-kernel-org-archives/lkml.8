Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA684C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FEF222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXgSlpqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgBNGQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:16:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33555 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgBNGQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:16:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so8234695qkm.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 22:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VFRjTGQ9Dnl+MZIVnGVwqakySwAmYVzRmQfE7Q96rnY=;
        b=LXgSlpqpq0R+xzD02e4Ag0j/EdQGAAj7sPbolCPILlWp+g6JFUBTq+oG+Bs8kpHGqb
         z3uhLR8bi0PF1MuqNe67GlyPNd+M+vPhUzTnBcc0jFbSIlpqTZ1z0auMB8G4oLDtkLuB
         WIMfbnIck8bLJtcAELfK5njZ7ujZbEgq0562VNoRI1YGoEOmnXQ5cwvnY9iwweaqp1lf
         U3X/omOEPqit1LBzKjECZTNYdhUUfLeF3rbee3gqZ7LQ3k/4dwthbbjvciXzEWxIvEkl
         CiPv9Vkyy/VOfvfnWWt3B3lBVRdysBeg9FDQytRM3oF6D6kdg9cadUkgQdYlz9pWZatU
         jFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VFRjTGQ9Dnl+MZIVnGVwqakySwAmYVzRmQfE7Q96rnY=;
        b=crqj/5C/hfpWDT2ASHQpM0DlCBooCYzSxwpOt3BFlx2MfikzBBwyGig6tu74egYtMU
         Ur2S+ZUNUgCrL0zeXPD97Cgjp/SQ05VNAvQvADIKI0jLBZcoWGuZd5uB/m5tuehe80cm
         0HBHQxJ3470hiy9U3VTJ/DSjVBd4ThZ2rK4hxsbrFXS8/fOcu2u3UHyA2KS6zDdJxC2/
         0YKbdqOgylIxkEoyFRxayKAiJNuqeGDwM+bOk8XJUDeQIoMLWByooHnfyqg9nsblv3TT
         IU4jwuJsm4/fYMBC2YxOBSPGtQaxylbtqROR0cGg+3vP4MiZ5O2YGYP/H8MORLn66wQH
         alAA==
X-Gm-Message-State: APjAAAU8nkJk9C7RPoy7JWNjsZgKBr9Mvnkyq2NxlddEkEo0urkxJSHn
        JXZK47nk5IG50kN7tAXpe6o=
X-Google-Smtp-Source: APXvYqy1SihlRM49c3nNKNjHBa/+RX7vRTUr5+t3qxUb9zr4CtSUukK9h7ZpV4bWEtWnoy2/hAxnig==
X-Received: by 2002:ae9:dc82:: with SMTP id q124mr1119706qkf.20.1581661018030;
        Thu, 13 Feb 2020 22:16:58 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b84sm2652163qkc.73.2020.02.13.22.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 22:16:57 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 14 Feb 2020 01:16:56 -0500
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, jpoimboe@redhat.com,
        peterz@infradead.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200214061654.GA3136404@rani.riverdale.lan>
References: <20200213184708.205083-1-ndesaulniers@google.com>
 <20200213192055.23kn5pp3s6gwxamq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213192055.23kn5pp3s6gwxamq@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:20:55AM -0800, Fangrui Song wrote:
> On 2020-02-13, Nick Desaulniers wrote:
> >Top of tree LLVM has optimizations related to
> >-fno-semantic-interposition to avoid emitting PLT relocations for
> >references to symbols located in the same translation unit, where it
> >will emit "local symbol" references.
> >
> >Clang builds fall back on GNU as for assembling, currently. It appears a
> >bug in GNU as introduced around 2.31 is keeping around local labels in
> >the symbol table, despite the documentation saying:
> >
> >"Local symbols are defined and used within the assembler, but they are
> >normally not saved in object files."
> 
> If you can reword the paragraph above mentioning the fact below without being
> more verbose, please do that.
> 
> If the reference is within the same section which defines the .L symbol,
> there is no outstanding relocation. If the reference is outside the
> section, there will be an R_X86_64_PLT32 referencing .L
> 

Can you describe what case the clang change is supposed to optimize?
AFAICT, it kicks in when the symbol is known by the compiler to be local
to the DSO and defined in the same translation unit.

But then there are two cases:
(a) we have call foo, where foo is defined in the same section as the
call instruction. In this case the assembler should be able to fully
resolve foo and not generate any relocation, regardless of whether foo
is global or local.
(b) we have call foo, where foo is defined in a different section from
the call instruction. In this case the assembler must generate a
relocation regardless of whether foo is global or local, and the linker
should eliminate it.

In what case does does replacing call foo with call .Lfoo$local help?
