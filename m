Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0319C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4678218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HUffOfge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgBDXX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:23:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38729 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgBDXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:23:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so268513wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 15:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yzs8TJvyQFCvJyaNWKZJmpZR9rIBxqg0DMsRTVYEQE4=;
        b=HUffOfgeXHgJpzF4ELf8SsmlNMmo0Np0N/0pdLSdlCZDOks9I3Eteh3c3+PUOrJJTy
         5EVAk+gDMmN4NRsP/DFau1Vog+7aUbNIyeq6hBa3Q6i3AMpkg3xNKR1QfY8qXVaZHR8t
         /5QYfvI1RtAjZCNwPmmOufRXW7dHtPEWJ9O6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yzs8TJvyQFCvJyaNWKZJmpZR9rIBxqg0DMsRTVYEQE4=;
        b=gRqqwbPBNCPFxMf38A3wxO37uO2wFfmm4jvdNvVGzxk1S0TckupTtAz47ZWOEcopya
         KNnJPLEx9GwsYO1tAcYhofRXim7LMUzXPr6VtHK2J/cOgSw081jA5YKJk77PqRmtbYfW
         vWETBquLTS8XtQOIgPFJa1g9kbj9BYACzFwVJN8piMzbNxal2EdftIVWumHi6rg3jjQL
         uo5GWsN304FQ9tdILhgOIAbIyj/3dUQZqiqg3mRU0aBYj48rumxkeCktX9LpDG+23ewo
         UWc8szLSjvQq0JgQho+nwdspeEa+n7lHlkUfOqikb+Q5hdXGOPxxLNPYhM23RUPpee47
         xLyw==
X-Gm-Message-State: APjAAAWuyQQp+cclfQsMCM2kGQKXfRu25lF0pXqAZY1NBtKen3wzO1aD
        Si/DjKYuSmpSjLOyh4LKRx2LsQ==
X-Google-Smtp-Source: APXvYqwMP5NIXjFkdCf079RGzAmaxgCfMWYTCUaG0AzZt3rH27Km67NGJTwecUgz0UkRuPRJhohHEg==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr22932545wrq.98.1580858635051;
        Tue, 04 Feb 2020 15:23:55 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id a13sm32643924wrp.93.2020.02.04.15.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 15:23:54 -0800 (PST)
Subject: Re: [PATCH v2 1/2] kernel.h: Split out min()/max() et al helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Trond@black.fi.intel.com,
        Myklebust@black.fi.intel.com, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200204170412.30106-1-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c02c86a1-5df3-1b94-78a7-3948bd9e64cb@rasmusvillemoes.dk>
Date:   Wed, 5 Feb 2020 00:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170412.30106-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2020 18.04, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out min()/max()
> et al helpers.
> 
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.

This is definitely long overdue, so thanks for taking this on. I think
minmax.h is fine as a header on its own, but for the other one, I think
you should go even further - and perhaps all these should go in a
include/math/ dir (include/linux/ has ~1200 files), so we'd have
math/minmax.h, math/round.h, math/ilog2.h, math/gcd.h etc., each
containing just enough #includes to be self-contained (so if there's a
declaration of something taking a u32, there's no way around having it
include types.h (or wherever that's defined).

Rasmus
