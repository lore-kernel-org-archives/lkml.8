Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F73C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5ECA20758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597861366;
	bh=ZKweGUWJvFq2Vs0jkZI11165VYu6b7gVCDPwPSQOouc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cH91JeNz6gY+1TkSO7ekD1nFG8Qt+dnOqQ/n0BiVuvF0rWsAvR+I6H+8XnDtq+qEk
	 mq3rxkE0WAqNLL+f9BlOm+GD1eNAu0hMPNmKiDvl1JNtK/OoCx2DUFn6RdovixkkyL
	 XFrFEjimQhlaBVoaDCPdSGyik6lICUzqCRTmQk5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHSSWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgHSSWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:22:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC09C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:22:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so26499047ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79ev9ikbUTXiBlx8BAwL5pB8K3ajpVCqOFOleujXdPo=;
        b=IDQGdL/5id8GNxENSsHI2wxK4/GZ5xngsW+Eha1nuNKPmJGlqmvPbb8du9ZPBCBRRn
         gcwhHklx3dYgYVG5/IFLJAyq1IPOCPogblQ93UEr+8YMf1+mOELzQ2caUs5F4LoUFBf2
         VLUHHA3n+6lCCXPn0GEIie4bewzMlUNpn7IrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79ev9ikbUTXiBlx8BAwL5pB8K3ajpVCqOFOleujXdPo=;
        b=dVAfmqetchPQGxwH8vbYFtFjZFko8ncKrgLe+HO9iWQOMoIMZeQcr0pQmHHzoi6E3d
         FyL4OLbJdLDjY4B7vlyHg2+0GCaf4rbsHIvCG7tnhFtfxClvu0h7J3zyQpdPb82eynlj
         3/BNbD76BFkWGuWzspOAQElewTrHB9/U/7eiqGDAoCUwyaYm9yBdJvnTjl3XUOhbkQ0G
         u0ae/gHj4HRFenh8F3vbxoW1EGo79Zlv4k3kG2ajCdj5iP7OHjZfBUuuwHLaXiVpW8il
         hsBgOt6s8m7jvzoaKv4k3FsiQ3RvXvMcnKz8YabOX3IhvksZkzDR0u73P+MOqq73X4Uy
         fLDQ==
X-Gm-Message-State: AOAM530fDXVR8UftefoVQwUncghrRsAH3/s+KP7bNJeitYbd77yXKkU5
        nL9m897jbEreqcADFnCpyOSgs+gN9k9/SA==
X-Google-Smtp-Source: ABdhPJzq9kxpzO+Hi27Q0pCcavAcHLlHRa7QpPW5Y8OTgj3G/LaNY8KnFoeDSrQG5e+TKxuuTXrR1w==
X-Received: by 2002:a2e:7006:: with SMTP id l6mr11088897ljc.107.1597861359648;
        Wed, 19 Aug 2020 11:22:39 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id g21sm6796298ljh.103.2020.08.19.11.22.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 11:22:38 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id b11so12580988lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:22:38 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr12977840lfl.30.1597861357867;
 Wed, 19 Aug 2020 11:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <9753118F-84DD-44C4-8B8C-F45B8EE0FC14@fb.com> <20200804234817.3922187-1-nivedita@alum.mit.edu>
 <20200804234817.3922187-2-nivedita@alum.mit.edu> <202008191111.4244B09D26@keescook>
In-Reply-To: <202008191111.4244B09D26@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Aug 2020 11:22:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC4jj3j9TViftsS97cdTKaM_7=e98WgaqojPk+EVTMxw@mail.gmail.com>
Message-ID: <CAHk-=wiC4jj3j9TViftsS97cdTKaM_7=e98WgaqojPk+EVTMxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/boot/compressed: Use builtin mem functions for decompressor
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <xiang@kernel.org>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:14 AM Kees Cook <keescook@chromium.org> wrote:
>
> Did anyone pick this up? (Ingo can you snag it, or maybe akpm who took
> the LZ4-specific patch already?) This looks sane to me and provides some
> surprising performance benefits. :)

I'll take this and Arvind's freestanding patch too.

             Linus
