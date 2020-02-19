Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A6C3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244FD21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XA+8LmMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSHaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:30:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38574 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgBSHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:30:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so16566215lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 23:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7FnCiq4hA96VAHvbFXLDbnkoYqJvhn7/q9GEFSkjLz8=;
        b=XA+8LmMoQ+0bciAXjXuKHio/Ma3CwfuhLLlbTK4oJqgiKU4zD/hF4yy1tFqQ9LVleM
         j0p862IU1tdCS4eE3aRlheE2DIKO2Ey0K0Dq/pN1EijBGsLuuNk0++i73XjdEMBShwpL
         qQ9eAj5wFQ4RyOV2TDnGOfSeS5NcqKlGoZ9fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7FnCiq4hA96VAHvbFXLDbnkoYqJvhn7/q9GEFSkjLz8=;
        b=LYuU41y0VKsMwvunfQ8Jxo6h3S+a0f62acNDm7LHW2Hz38Gbn94l21zIWVbGgYvmP9
         eYkepJWJC0nkbbaueFN/t9nXokgAsK74oC9BGsvQmaqeF4lUWhHfFcm3d/wJDPYbPcki
         ZePRttqoORctzD70IMPPUEi4bF75huCLQ3ll/1dHvSqGTUXNsBBKgX+SsRLvRGWitmGW
         mX46UBLcyHb4zNy/Fw0CUdk7bY5Xbu7SQZhpf7a5WPeLcPDMM4CYpoA4FbhsOnZz6yTY
         JHIMKA4+4pOzXWBupS527EZc2Oif0heEdMzhhQTJlYYjMoaGu1eA924Zkzk2jze2jcu0
         pniA==
X-Gm-Message-State: APjAAAVUuROhGZLyMZwX1kVwUwLZb2sA2WmxiN12AVpQx35frwxfU3qa
        aHfCwvJWA5Qm0JmTaavx170Gbg==
X-Google-Smtp-Source: APXvYqx8vCjrG9iQLoAlDqFbCik4pZOKiSELxoACc0IuQGQVH3YTUjiTKzZe/ZVgMyzDsvD1E9omhw==
X-Received: by 2002:a19:c1c9:: with SMTP id r192mr12743260lff.28.1582097407281;
        Tue, 18 Feb 2020 23:30:07 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z22sm539555lfd.87.2020.02.18.23.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 23:30:06 -0800 (PST)
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
To:     Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
References: <20200217222803.6723-1-idryomov@gmail.com>
 <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
 <CAHk-=whj0vMcdVPC0=9aAsN2-tsCyFKF4beb2gohFeFK_Z-Y9g@mail.gmail.com>
 <20200218193136.GA22499@angband.pl>
 <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <CAOi1vP_Ned9QG32+o9KT-Bh3qMTb6h0SaP8W74Am_gkVX3mcSQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <178fd91a-5171-d269-2e8f-bf58e5d98fbe@rasmusvillemoes.dk>
Date:   Wed, 19 Feb 2020 08:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOi1vP_Ned9QG32+o9KT-Bh3qMTb6h0SaP8W74Am_gkVX3mcSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 21.19, Ilya Dryomov wrote:

> Looks sensible to me.  Without this patch NULL is obfuscated for
> both %p and %pe though.  Do you want this patch amended or prefer
> a follow-up for %pe "0000000000000000" -> "NULL" so that it can be
> discussed separately?

Please cc me on all vsprintf.c patches (scripts/get_maintainer.pl should
list me as reviewer), and especially ones that touch the recently added %pe.

Thanks,
Rasmus
