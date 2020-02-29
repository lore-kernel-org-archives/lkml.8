Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D603624688
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P/Nsf2a2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgB2Xvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:51:48 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55250 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2Xvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:51:48 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so2819977pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 15:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=JCx5kM2FMe+phgvKiMpcu0iiorhySMfHXJQpD4PHwa8=;
        b=P/Nsf2a2wOYy7D1u146YWjS1s0ujxd2TAgYMb/LLAdf9b3eCgjLNdXrDZV2mViHn+a
         WmdqTo54POm0wJbKOda2WLgKO23AX8ZVC56n86ceOp/d7nQqrv40YovrJ9GeywHUeIDu
         muZunWBfnMGLQSnTUszHU82kX6t5xpQt2TdhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=JCx5kM2FMe+phgvKiMpcu0iiorhySMfHXJQpD4PHwa8=;
        b=L7YrawCw1Q+r9ub9fEVqTgJWOy5KngFxwvP4vpO+RUzXmC6w5Ps0vgTeZDGHb3PVuA
         fgz/8VjRPKj0DQDJR1jrppW+kNzrEumfVP+k4TuXq3ZQO95/0Fys+LakbSPNpVndQY5X
         qIFXP889PKZYmx6MYV1IHGkQFPaVgz5g14BvjvoZjrJAb/UtY4sycon0o6myjIZ9yWsk
         Gk1DmRHbHdefDx3nTQ0Y0fmVOezsGZbjPmICja109S0krGIgPsv4pp96+wpFzjx9jKIO
         KAZcTv6ZJOP6jYDnZ+6MKTc+sxebCDItUqq04sEA97TA6tEC9QVEXE3wOU4Xrn9XGsSC
         yg9A==
X-Gm-Message-State: APjAAAUv9cxHyI8cFtC9jsOcrTn54I/oR2ccuE0kTIlltTKcz213M5tI
        C9cJ6rPtil/Q+4Uf+an4Nf7T016IYZ4=
X-Google-Smtp-Source: APXvYqxsx1i0sHqA2KvbaHmgfpHOZ+FRmZ9YIX/ymQrfriesl+tjije02HUpoRd4OXIwmBiGs6tUyQ==
X-Received: by 2002:a17:90b:11d0:: with SMTP id gv16mr12761318pjb.109.1583020307505;
        Sat, 29 Feb 2020 15:51:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w17sm10706874pfg.33.2020.02.29.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 15:51:46 -0800 (PST)
Date:   Sat, 29 Feb 2020 15:51:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     dave.hansen@linux.intel.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, me@tobin.cc,
        peterz@infradead.org, tycho@tycho.ws, x86@kernel.org
Subject: Re: [PATCH] x86/mm/init_32: Don't print out kernel memory layout if
 KASLR
Message-ID: <202002291534.ED372CC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226215039.2842351-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Sankar said:
> For security, only show the virtual kernel memory layout if KASLR is
> disabled.

These have been entirely removed on other architectures, so let's
just do the same for ia32 and remove it unconditionally.

071929dbdd86 ("arm64: Stop printing the virtual memory layout")
1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")

-Kees

-- 
Kees Cook
