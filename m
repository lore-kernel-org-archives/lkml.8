Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574DFC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237C5206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="k+B4qS+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDURLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDURK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:10:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA53C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:10:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so4582215wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRF8mhv6ReO1PDrOI+WCZVSt0+yq+v9H72EfJ68K0w0=;
        b=k+B4qS+9lJ0ExW055A2cabAgqkmJmyyDNvDFOhs5xwLnRsZgvtShLUbS6yLoCmiIzH
         4Byg3rtggeH+8DGgVL9GAU5Fkn3X8Yy1LzoXf9j4cbA1R92XYxzpZUp6B3Cx0JnF/Srm
         q7p57ILIUosjMyLqHNL3dUFqMgws0TqQWLRHy+tbdqqTNqyfK/zs8R8RQr6onciodr2B
         Yc4jiNykFbZIVoFj1wZIfxt7ztyYYT21d7WOL9fZQ3t6P6Z1sX1ku5KODRyFAnKzkCXh
         +DfhOealMK6qvWWGvUMcjXoty4rg4DDIoBr76zBW+ZYQJTCMNxnoNzutlIzHa330a2fT
         oB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRF8mhv6ReO1PDrOI+WCZVSt0+yq+v9H72EfJ68K0w0=;
        b=bQ7wgbisvJsA2VHoJrC7TC8FKD6tLfuftsVZiK7wF7KALGSnnA7D9teycDR0j+bMgr
         vI84jBCCogKIy2IrMs54lGahgXUEXCgTqFpN6EcUdBQDfgkeIO73oVfvRneb/KBbQLoM
         LG6eyGN6XOweXbkHdoVz5Fpl1dTeHfAX6jhLQWAvQ1DyzwRQRJGkbmR02JrDYLtpfvsy
         ofsYAqsNC6QEG5TBEOVqDUl8nJB7ylasSwGh7pJhyNDSD2+dDAo2r0QGy/dme3hsxvh2
         e2wfhc4fKbp2UV0QX4ZnzS7oi8ekZmrTjBQpgRVEMiOCL5qax9FU8Xj5LhmKhbTwpr3b
         lisQ==
X-Gm-Message-State: AGi0PubX5DWahIul8ATzz6P1FmfxTZGhbAmSMvh9IVznmp950BINB3+D
        ruayDnuCrh3LmELaUc2RZ2WhuGpfnrf7J2o9Cnm0WQ==
X-Google-Smtp-Source: APiQypLmJQEyzLsjaey4mJhzOTlmlm+KQEGznl7g0Kon5uiVzuUYQwtbez8EfkeIsC4A324npRTXz4lZaNuyB3p/dR4=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr5676517wmk.36.1587489058116;
 Tue, 21 Apr 2020 10:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200419203137.214111265@linutronix.de>
In-Reply-To: <20200419203137.214111265@linutronix.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 21 Apr 2020 10:10:46 -0700
Message-ID: <CALCETrWubcrju+j4ck65scs7gwHC44gkvryzwJZ=x_9B26=Fhw@mail.gmail.com>
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 1:36 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The per-CPU tlbstate contains sensitive information which should be really
> only accessible in core code. It is exported to modules because some inline
> functions which are required by KVM need access to it.
>
> The following series creates regular exported functions for the few things
> which are needed by KVM and hides the struct definition and some low level
> helpers from modules.
>
> The series is also available from git:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel x86/tlb
>
> Thanks,

The whole series is Acked-by: Andy Lutomirski <luto@kernel.org>
