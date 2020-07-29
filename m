Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90066C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6219520656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQp6rQ8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgG2WXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:23:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79672C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:23:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b79so23845426qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6YCAc5J78Gb3CL6JITqJCex4PtmMFXj1bpF2ImMkMxc=;
        b=oQp6rQ8YviAsRtGckYtsG48sNBe/wTftTbVYJ++XKEpZ/4ANT22UkOxvyuexNi14eN
         HVXZiVIVvVPo61hUObdNnmSfMfwsqCRnGvoht5YFMBqHEeH1QFAWwo+KBa9fkIuacnO2
         0mROGgZQLIJQ1RtGix8nHS5OSFvAndcXHiHOTtLwnzlqdhBkC92QUDMdU9o6dp5FP/5x
         JgPFrvpeRYBIgICtpjgnVyBkkE1M1lDeR7h/azl6KyPhdzFN0oY3pkVghcBKXFXlhRwg
         tLLuXODVmRb3pBQYnuvv9ZttkCe8ZZN1FA+8bBo7PL70m10t+JJeuBExJxpvShbNTZD3
         7K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6YCAc5J78Gb3CL6JITqJCex4PtmMFXj1bpF2ImMkMxc=;
        b=pvPIKAQNRzN5qZWJri0pBbwmMBCoI5ImHA+aoCaZzu+2FaCbvy/SN7HnydiCUcQIAj
         VnN4TRtN70v+92flH6eCAWL29KI6+0RCbR+lorTBeObZfOwPXbzSTcA2hwEaYPCIRV9s
         oAsmpv18kRDIxt9X+ewn3n+MuxBDBsIdJ9ghu9uByNaLpq/PLdRXPPm/bgfDVj4BI9nz
         ok6cFGgJunoplciPIg+PoUUWeDmafhRH+ey1GgMIpbC0Kb+xKnJRHmwSTqssfXRXCNis
         0qiYxDA+ycu93+Tqv1e5V5PFdXHGvL1gV110P4zcpwaBTIiouqNScmFuj6co2hqS11pR
         v79g==
X-Gm-Message-State: AOAM533hS3rG2mukOrxoVw4yd6Tnt0DOdu1ZNQjloRhWTE1fxsgmbahR
        arbjqJaD/kxIeAwtaUCOC3s=
X-Google-Smtp-Source: ABdhPJyPO4gpLkvIa7v8JU9LISyoc9Q5v3ji5XzcrmAttwSDnq+Irld9YbTj1Z0P0WrCLdLo8KrMvg==
X-Received: by 2002:a37:74c:: with SMTP id 73mr33611992qkh.468.1596061423588;
        Wed, 29 Jul 2020 15:23:43 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g61sm2865166qtd.65.2020.07.29.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:23:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 29 Jul 2020 18:23:41 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
Message-ID: <20200729222341.GA684483@rani.riverdale.lan>
References: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
 <20200717201801.3661843-1-nivedita@alum.mit.edu>
 <202007291502.18DC4C0F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007291502.18DC4C0F@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:04:43PM -0700, Kees Cook wrote:
> On Fri, Jul 17, 2020 at 04:17:54PM -0400, Arvind Sankar wrote:
> > Same as v5 previously posted, but rebased onto next-20200717.
> > 
> > v5: https://lore.kernel.org/lkml/20200715004133.1430068-1-nivedita@alum.mit.edu/
> 
> BTW, some bits of feedback on process:
> 
> - please don't re-use version numbers, this is confusing :)

This was a special case as there were no actual changes in this version.

> - please fix whatever is happening with the "In-Reply-To:" headers, the
>   threading is extremely hard to understand (each patch isn't a reply to
>   the cover letter, and everything is a reply to a single earlier email)
> 
> -- 
> Kees Cook

I think this is because I'm passing --in-reply-to to format-patch.
Seems like I should specify that in send-email instead, hopefully that
will fix the threading.

Thanks.
