Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF499C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E61220842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QvD20COf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgBKTVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:21:33 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53425 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbgBKTVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:21:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so1763425pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 11:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LWdO903JlL7mrIroJ1DR4H0Lf0OnGW3IvW4RvhYAFg0=;
        b=QvD20COfVzxuay6xGJSzAAWXcjptzM8MyBsKCfYGfkNUpP3ZsfpRCnB1a9xLwfnTHB
         wKNeAxR0CVstaTCqWBMgJCLOT41JKo13HUck+vjHHNU6vzraPrnd3cDFUvgFWIPAtFMt
         nAsJb50vycy90MUlcKEG44K3kaE7ytB6v2oE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LWdO903JlL7mrIroJ1DR4H0Lf0OnGW3IvW4RvhYAFg0=;
        b=VyJTZodQZ3eEjfmmMEvY0yXYwO6B85KjITY4ml4GGXTt8Hn/j80tA8NHP04HvPOWqv
         n5x6toHK5PFiUsluI1jsyHhRtSvJaqRMJ9f0PRbG1pRf54R5Y78ZYxoylQNbEujxSFNJ
         jQdtBwaJSfF2IBZRvyL4WfZpv9L8bw8bAd15o4WSz0IEnVXlm4erJlyUXZEmIx9ewGSi
         vGq1TV+7W5xL0FV/22IMfUXY/MWKL9WDfIYMj/1qMjhSsBCWiuNC3ehtLYhHBGkkEJXi
         hKQnojBLonjgkJoxl9iHhA1bfXiSoJuHFEJZRfQ/FcvCgopNpMStIWaQrkgFL+AyesMU
         gdSw==
X-Gm-Message-State: APjAAAU5F9uhe5YgdV6npHz/h7e9kerbbDvPA94h5y5sa+oCMeQqyxnQ
        SvH7vWn7JyR4IbGXY37fxuQ9LQ==
X-Google-Smtp-Source: APXvYqw1YwEZ93PZj55gFovRIY7+WfkCv4LbdL59T6UWNYBnl5teLRUx7UPTsrLJB/UZSKSu0YhImQ==
X-Received: by 2002:a17:90a:9311:: with SMTP id p17mr5315663pjo.140.1581448892021;
        Tue, 11 Feb 2020 11:21:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f43sm4267444pje.23.2020.02.11.11.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 11:21:31 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:21:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] lib/test_lockup: test module to generate lockups
Message-ID: <202002111120.91782E0686@keescook>
References: <158132859146.2797.525923171323227836.stgit@buzz>
 <202002101725.EE6D5A6@keescook>
 <5e5ee6b7-68a9-1bcc-66c5-814e40a627be@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5ee6b7-68a9-1bcc-66c5-814e40a627be@yandex-team.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 03:57:42PM +0300, Konstantin Khlebnikov wrote:
> On 11/02/2020 04.26, Kees Cook wrote:
> > On Mon, Feb 10, 2020 at 12:56:31PM +0300, Konstantin Khlebnikov wrote:
> > > CONFIG_TEST_LOCKUP=m adds module "test_lockup" that helps to make sure
> > > that watchdogs and lockup detectors are working properly.
> > 
> > Isn't this all already possible with CONFIG_LKDTM ?
> 
> Yep, LKDTM covers some cases. But they are unrecoverable.
> 
> It seems LKDTM is more like a fixed set of unit tests while
> test_lockup is a flexible tool for stress load.

Okay, cool. I just wanted to make sure you'd seen LKDTM and there wasn't
too much wheel-reinvention happening. :) Thanks for checking!

-Kees

-- 
Kees Cook
