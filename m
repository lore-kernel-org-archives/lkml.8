Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68ADC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D872465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k58MSEu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBTTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:06:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34157 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBTTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:06:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so1924278plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrzKXFViI3ntiY1ouWD28JK1QkMX/IzmV91XBOK+RwY=;
        b=k58MSEu7IhRpAdwC3WeOLMftb9iCW1F4o8Y/3EKVap3e+YDOYE3dWfPEp5w9Uf3FJf
         EocRn5yXKCSaU1jAeIuSWDSK1lbozF2/QKb1xFA/uGbs2wlGkH52nNUsaILPuuv2i8AX
         gnM0w10GCSAdqhOYVoecJaBm1SXqPrtawFINOwaZXE1eVbFfKnf3wfebrSHVUlXQki3+
         hrT3B9dNL/DNEQycWQwIcF2xID+L0zlJv65bmw7mmDAEpf8aY4N2njy4uHHCDfSpio7k
         L4ahmnqcfRnlbb6toyjtuVbrvHpdYXHOqehxcCWeXRFxYdlTfIweKAqvOdpXoA032MoX
         rrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrzKXFViI3ntiY1ouWD28JK1QkMX/IzmV91XBOK+RwY=;
        b=s3zKj3HRPu/Whrn8JX3mO7qWNwId0gPlc3Y9FxYIugiW6yhanbbeV8y0lf0ROTUwlg
         vS7uUvZnZD+mYtPddp+K3QwNQLew82G2czXXP6YoTaS6lKwZSksaR9iuCrj7Df0DBQPG
         HYGqbhesyHUdi4cVUBj0/2QTz/WtGdt+k9d3ePuJx0cvZ2xFT27m21IbCinHA2BCOHg7
         Eaj4ArM8xir0PZgWxabzxgf3itn/9SvVEIEAVYsIWqSyycUEhkfbTArmcKGBUr47SkKy
         RPKtJmvaaZwC/7oqd2Udn6h62EqCwCJl2sRO/AHwOriAt1W0jW0XYvfFUdw90eX6L/J0
         ENMg==
X-Gm-Message-State: APjAAAXx9Pe+UMph936hg9dHN62amKLKnQpsQPv/Mb9XOoQiGdSRxqdb
        ce4zSVEfHbUix+5586a9qnmBjWX6vDIiuhWAaiVGMg==
X-Google-Smtp-Source: APXvYqxmsaYcZYgWhhNoXU79Wiq+Q7wZt8g0RDpisGINc3IAG0DnYEYe1mjBzhwLil781+PJ+lq+DojOtNLmVRj1QKQ=
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr30835316pll.119.1582225600944;
 Thu, 20 Feb 2020 11:06:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581997059.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1581997059.git.jpoimboe@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Feb 2020 11:06:30 -0800
Message-ID: <CAKwvOdnOrezCVzRSFfrXxXXgfPCNxeyi8=2-k9Fz=Y4xAe8fAw@mail.gmail.com>
Subject: Re: [PATCH 0/2] objtool: clang-related fixes
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, can one of the x86 maintainers please pick up this series? Our
CI has been red *for days* now without it.

On Mon, Feb 17, 2020 at 7:42 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Fix a couple of issues which were discovered after clang CI was broken
> by 644592d32837 ("objtool: Fail the kernel build on fatal errors").
>
> Josh Poimboeuf (2):
>   objtool: Fix clang switch table edge case
>   objtool: Improve call destination function detection
>
>  tools/objtool/check.c | 38 +++++++++++++++++++++++++++-----------
>  tools/objtool/elf.c   | 14 ++++++++++++--
>  tools/objtool/elf.h   |  1 +
>  3 files changed, 40 insertions(+), 13 deletions(-)
>
> --
> 2.21.1
>


-- 
Thanks,
~Nick Desaulniers
