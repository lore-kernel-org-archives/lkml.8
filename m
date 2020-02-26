Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F19C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 06:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EFC222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 06:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="iAunlpGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBZGHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 01:07:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43833 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBZGHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:07:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so758784pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 22:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wHnRWSkI/KPKw6tQwkKo0dZto1+RLrsK9CfP2hBdd44=;
        b=iAunlpGumDfMTCDwa2qDpliEwWgJJRKO4KOJHWiktC2X4lt65wcUnHSGHs3l6UP66Q
         d4Ocycbdkd/amh/DmSUexBB8vr8aDXUlPM5nn55YLs9ozjynb0f/G6A0DRUqp4fDNKUq
         72517XtJWuA4U0Cd0PsZA7s2vZe51bPW/k6s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wHnRWSkI/KPKw6tQwkKo0dZto1+RLrsK9CfP2hBdd44=;
        b=hibdObsjuBmBQtgBB9c9kXeHxQYDVnCmobdXEgQ1vajJ5D1TNaTcT/QESzvhao8i1O
         q3rGLsOOuYYBZfwkesczwFq68M4BeoPrKfh7BGw6HCcHZaq+v5BuH6rdLz0dCWL0SNxD
         K6WMjAU1INTqrRxwT87eXqklkhjBeWOETtT/2tpF9Y1TjQ9OFO3XQQReW5wGgR7DsfE+
         UW/wl299I82nxcKQTS4gCJ9t2LhVCCgOqIAUMixDG/9x7eMneJrmszk/W5QntapHgPTI
         dsFSbFZBf8IUCbIb6oR3GbdkFqn7jC3DAR0S0t/qh/JWqqHd1aW0G2Uwu/6DIX8+6S3b
         ukqA==
X-Gm-Message-State: APjAAAUEpill9HyjsRbKXNURwnFwR0kpUBamtp9cl3AlhYoPjAbaslrm
        7mzeaJICB/xHYvYqp6ffHfc54w==
X-Google-Smtp-Source: APXvYqy/xqWhxm0yEB7fap02Q6GRzScFy9XqEbLyCX3qDDPYVkQGakX1z25WIIR7ekand399s53kfA==
X-Received: by 2002:a63:4707:: with SMTP id u7mr2226588pga.221.1582697242816;
        Tue, 25 Feb 2020 22:07:22 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-5952-947b-051c-ea5f.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:5952:947b:51c:ea5f])
        by smtp.gmail.com with ESMTPSA id o14sm1008351pgm.67.2020.02.25.22.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 22:07:21 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] [RFC] mm: annotate memory allocation functions with their sizes
In-Reply-To: <202002251035.AD29F84@keescook>
References: <20200120074344.504-1-dja@axtens.net> <20200120074344.504-6-dja@axtens.net> <CA+DvKQJ6jRHZeZteqY7q-9sU8v3xacSPj65uac3PQfst4cKiMA@mail.gmail.com> <202002251035.AD29F84@keescook>
Date:   Wed, 26 Feb 2020 17:07:18 +1100
Message-ID: <87wo89rieh.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, Feb 07, 2020 at 03:38:22PM -0500, Daniel Micay wrote:
>> There are some uses of ksize in the kernel making use of the real
>> usable size of memory allocations rather than only the requested
>> amount. It's incorrect when mixed with alloc_size markers, since if a
>> number like 14 is passed that's used as the upper bound, rather than a
>> rounded size like 16 returned by ksize. It's unlikely to trigger any
>> issues with only CONFIG_FORTIFY_SOURCE, but it becomes more likely
>> with -fsanitize=object-size or other library-based usage of
>> __builtin_object_size.
>
> I think the solution here is to use a macro that does the per-bucket
> rounding and applies them to the attributes. Keep the bucket size lists
> in sync will likely need some BUILD_BUG_ON()s or similar.

I can have a go at this but with various other work projects it has
unfortunately slipped way down the to-do list. So I've very happy for
anyone else to take this and run with it.

Regards,
Daniel

>
> -- 
> Kees Cook
