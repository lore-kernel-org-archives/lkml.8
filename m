Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE65CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E2420663
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFcDYd0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgEZPk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgEZPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:40:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B05C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:40:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so1494141pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjnl/JxEGriKorXrTPs6RAu94HRZLs85s5QetpCKq1Q=;
        b=qFcDYd0iBnzGrt/TK7N0lwbAK6KbDETo97IeZd0WVVyBA+aJoUp4jzuPFO8ypMc/Gb
         L7Rqn9kLpHYSHEuuUHDRpPNWXmcnhoSRFQjlBFEUwhxfO22bW9twODIuQad+Y80bvEpv
         lrjug32IiXaSGIopv6PKagvIJpdH/CqiY2+Pnj/Fv1fD1k4IgUiOALE7G113xZAJGbQW
         fFSTKNTEYvpG2/5PMP8CkjAnwhhDiqBMHvW0pzdPaIg7bX/0Pzj7ppU34ipPTNcrjeL9
         OBzYWILVYCRBQaNaU7bUS5GZufm9vccOIjcJsKArMM+nOnz2ee4qt7h50anJgJuBDpPj
         CqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjnl/JxEGriKorXrTPs6RAu94HRZLs85s5QetpCKq1Q=;
        b=htJl0sBb7tHhLy6JPC50ZBJO0OOaG6Kb6NAJwSWsejgiI+qlTzIb+DNL5j8hyHA/A1
         bmTqHJjzjAGPqsH5WHaHF4wTdcP3+D6hJ2GHg4rW9xEBfGNcbR3OFw/Ywb97NwKOJnWV
         HeoPlQYtYkvd0vurSm/KIavZ/1ACbaYGlPFFtnh2C5xKwcTcrnMacqCK2KaR7p6gQ/Ck
         /zJCF086QqiG6YPuu/5+OhLZZ7HikhaChFnXLON/OGKzW6DBMVK5ORCMTob8W63zLwjf
         9zTIhhTQm/5+aROqWl0vI/quicTpQ1YSphXZkoEIuybgTrhaDmZz6iSN/LNjPbKt8v+d
         Vj1g==
X-Gm-Message-State: AOAM532dfa3brpqG5b0UhuTxXw+/N0iWl+PGHJbNNNaEisHMisxinbJo
        w0Rwn/xk6ZjqgxEKFUQaM5EygU5U0OuGrYOjMutztA==
X-Google-Smtp-Source: ABdhPJxfpkQUxfSc6ou5v2IxmRJgcqi1Vr3ymUZE6sf+XL1RdUwRbloUHEHRLK7kfH+MWGd6ubn/wPOf+1IFDoA5SX0=
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr1595124pll.223.1590507625356;
 Tue, 26 May 2020 08:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200526153004.GA74229@roeck-us.net>
In-Reply-To: <20200526153004.GA74229@roeck-us.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 May 2020 08:40:14 -0700
Message-ID: <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
Subject: Re: [PATCH] compiler/gcc: Raise minimum GCC version for kernel builds
 to 4.8
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Will Deacon <will@kernel.org>, Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 8:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
> > It is very rare to see versions of GCC prior to 4.8 being used to build
> > the mainline kernel. These old compilers are also known to have codegen
> > issues which can lead to silent miscompilation:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >
> > Raise the minimum GCC version to 4.8 for building the kernel and remove
> > some tautological Kconfig dependencies as a consequence.
>
> My hexagon compiler is v4.6.1, and I have been unable to find a more
> recent version. Does anyone happen to have a pointer to a hexagon toolchain
> with gcc 4.8 or later ?

IIUC, hexagon moved to LLVM, though that target still has issues
building the kernel.
https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+hexagon%22
-- 
Thanks,
~Nick Desaulniers
