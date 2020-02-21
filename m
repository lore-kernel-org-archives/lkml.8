Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5399C11D28
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6888208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgBUEWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:22:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39076 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgBUEWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:22:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so312158plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 20:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ju/zaBpvWAo0tPrtMvrLc+tZUkDMjmmyyQeZUswt94Q=;
        b=rZxNS5XJBI0Pj02HTyzBQrCNXXMfYNSE6DqEQ8ba7WCOJEkITPxUcrjbshEP9McVK0
         S8utzMZ7Es0kIJ+/34sZlWhol1vZ9F/pSQO7mUR9BC7YZFN6Imxgf1/QlC5nILnVKCcw
         C/Pjv/vfs0wXIr2X3DwAYRNJv4HNGQ5zORj6YGw2FlX8r6opGOOQ63+fnOoBaqQLYcwk
         V7/wYmkrq088CrHZJPgoczwRPaD6Wej3B1U8JGbqvPqiN58IzyMA2cKA0DSH0XDGIamH
         MwKo5rTehMmLurdsZBO3r8VHFNJCQAtVycL96neJp6TvUnHkd2UUSnivFc79/t4ljYWB
         xXpA==
X-Gm-Message-State: APjAAAWNVJXn2OzjcJV7kydtTwliGjZmUJsZ8/doB0ivUVk84AoDo5hg
        jIfiqnMEgfp2Dr7+r13bFI0=
X-Google-Smtp-Source: APXvYqzNG1mdGIKbi/T9kQ5qmyRVwaYky9rxueeBZ5HuMfH5DWnDyqjC4hVrR9bCSq4M+kVynFzoaA==
X-Received: by 2002:a17:90a:c20d:: with SMTP id e13mr701306pjt.95.1582258955584;
        Thu, 20 Feb 2020 20:22:35 -0800 (PST)
Received: from sultan-book.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id w18sm812318pge.4.2020.02.20.20.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 20:22:34 -0800 (PST)
Date:   Thu, 20 Feb 2020 20:22:32 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200221042232.GA2197@sultan-book.localdomain>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220101945.GN3420@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:19:45AM +0000, Mel Gorman wrote:
> I'm not entirely convinced. The reason the high watermark exists is to have
> kswapd work long enough to make progress without a process having to direct
> reclaim. The most straight-forward example would be a streaming reader of
> a large file. It'll keep pushing the zone towards the low watermark and
> kswapd has to keep ahead of the reader. If we cut kswapd off too quickly,
> the min watermark is hit and stalls occur. While kswapd could stop at the
> min watermark, it leaves a very short window for kswapd to make enough
> progress before the min watermark is hit.
> 
> At minimum, any change in this area would need to include the /proc/vmstats
> on allocstat and pg*direct* to ensure that direct reclaim stalls are
> not worse.
> 
> I'm not a fan of the patch in question because kswapd can be woken between
> the low and min watermark without stalling but we really do expect kswapd
> to make progress and continue to make progress to avoid future stalls. The
> changelog had no information on the before/after impact of the patch and
> this is an area where intuition can disagree with real behaviour.
> 
> -- 
> Mel Gorman
> SUSE Labs

Okay, then let's test real behavior.

I fired up my i5-8265U laptop with vanilla linux-next and passed mem=2G on the
command line. After boot up, I opened up chromium and played a video on YouTube.
Immediately after the video started, my laptop completely froze for a few
seconds; then, a few seconds later, my cursor began to respond again, but moving
it around was very laggy. The audio from the video playing was choppy during
this time. About 15-20 seconds after I had started the YouTube video, my system
finally stopped lagging.

Then I tried again with my patch applied (albeit a correct version that doesn't
use the refcount API). Upon starting the same YouTube video in chromium, my
laptop didn't freeze or stutter at all. The cursor was responsive and there was
no stuttering, or choppy audio.

I tested this multiple times with reproducible results each time.

I will attach a functional v2 of the patch that I used.

Sultan
