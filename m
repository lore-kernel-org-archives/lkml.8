Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F9CC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F44246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4XH4Tzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgARRRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:17:15 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46244 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgARRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:17:14 -0500
Received: by mail-lf1-f46.google.com with SMTP id z26so100186lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/TfM+yjsSV6EWSEIB9bivQEZTFqDC0eQ4tARU7du8Iw=;
        b=S4XH4TztfDlx0PcgUb9TVFLr47mdXeBEIFQuA1I4OaCWP564rhGaqk75ccIRgwXvFZ
         bVcVuLpwUjJvGAzQKLi+tGcaTED7OVeiHQ7fwzsmjxufW1OnUb8K4x8vu1F/nnD9essp
         GoJ0mYol94JZY+1g0c7xl5ydn4gEgWXLzlhKger7eLbMqr/hDr2ymbYXat7XTAx5ZedG
         yBQOMFB/xBxvaUfV8vmGUz6LoG91/aEQ0+ABQXx7Ox9FL3/fB4WLRBAGkQQSOZqUDQtj
         BGZACQzkHj0dWWon3cCXRhkd795BFG1zKvThMmk1SH6PrPbQS/2VQW4ePwieNEiVzqcS
         XfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/TfM+yjsSV6EWSEIB9bivQEZTFqDC0eQ4tARU7du8Iw=;
        b=JFtNokK18Ze6nVsPRt3NqI537i15qq1F55y2LWdF8rX23tIQCxHAVJhnXDa2JGxeAN
         y9BNC8jHx3i9rXLIC5j4X6ANInr+gkeF1mbi+YgE4NDFB4/Jaextvd5NpuYgpuLdDKrX
         j1NuZff1y80E1teilkaScOFTOgzPxKt7H6G/R4EfFC0fnoDObl3hLeUWxjtuFwX/12TO
         0EEG4cRZG53WQuavnVzY+k0vnXj/7E6hLnl3EaT7fp89GGWrGnCpVVZC+m0MEuBgX8M0
         mbyPFyQme1PqkimDH9/9D2v36WiAQyU5/4IEDe5E7GCvBvw1GJTGtMBSpRK2As5CRSdT
         CTLg==
X-Gm-Message-State: APjAAAW+xZ8GaGLWozHJXZmIGZ63LWW1O0EeEd3hZZ/9YgMtrtntUDXt
        PQC7cfJ+cCUQdGgqWulOpK8=
X-Google-Smtp-Source: APXvYqxDnIq4CCujiAo2Wx1/I3okHK3AXG2vjysGcu6Pq0RY7shBizwZius7MDgymGciHzFw24IY5w==
X-Received: by 2002:ac2:50da:: with SMTP id h26mr8738520lfm.80.1579367832422;
        Sat, 18 Jan 2020 09:17:12 -0800 (PST)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id r21sm14278729ljn.64.2020.01.18.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:17:11 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 00643461790; Sat, 18 Jan 2020 20:17:10 +0300 (MSK)
Date:   Sat, 18 Jan 2020 20:17:10 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: getrusage(RUSAGE_BOTH)
Message-ID: <20200118171710.GA2437@uranus>
References: <ca7a02ad-2408-0cd8-e54e-d7dbecf9f0ba@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7a02ad-2408-0cd8-e54e-d7dbecf9f0ba@rasmusvillemoes.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 05:48:20PM +0100, Rasmus Villemoes wrote:
...
> 
> If RUSAGE_BOTH is not supposed to be used, perhaps it should be removed
> from the uapi header?

Hi Rasmus! I don't remember from scratch the RUSAGE_BOTH context
(out of sources right now), but dropping it from uapi is definitely
a wrong way -- since it is used inside kernel we should consider
it as reserved value thus it should better live in uapi.
