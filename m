Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FFAC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CFE206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBSTkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:40:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35329 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:40:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id v23so617684pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xk3FQWFLEA9Ivw7eQtk1E45ebBr0l+OsXJaKdMkwewM=;
        b=BNI586195ZP8T82iJbf2C4Sl/o1HqxAbd92AUN1QIWxx/EXBfK0Kx5AAqhzBsK5w6G
         vW4oKRzRhSyJALzQHRUNoG4KPFMuwBitA9QxGC0C7gjDbvRsegbsENC53K+RBZjhF5Pc
         5UHu0dkbmzl5MzdUfqhL+bjD8jdPGZupUj+NtjSveDhBwAKYi9pYOuztaIYPCZrYYPrn
         IPiSd9cRyXY9GIlA3kfHVJKkW4hsvOkBAXzTSIKmr47j7f9VPte8C22mxpAfKwr7fk5d
         Zf1mFi3cbLU4loFzzgW0XOz7SHn3VKeX18i22iwJxgyjeOAeJPBpKvuHMSltnAyh8QZG
         R0sA==
X-Gm-Message-State: APjAAAUdpn/KP1FkNSF45ZrC24Xyyf5bztHWvM9CdV6bXegO8+q9Lg4z
        CmydayL7zQND9/9EnMtsuAw=
X-Google-Smtp-Source: APXvYqw2c5Lr90FnrKjZBh1E37nvLIczFX0XDP5GUvh7AyvJ4X/KbXpJ3bdQxra43uC9r6BfB0duVQ==
X-Received: by 2002:a62:486:: with SMTP id 128mr28636963pfe.236.1582141208801;
        Wed, 19 Feb 2020 11:40:08 -0800 (PST)
Received: from sultan-book.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id c8sm510530pgq.30.2020.02.19.11.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:40:08 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:40:06 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200219194006.GA3075@sultan-book.localdomain>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:13:21AM -0800, Dave Hansen wrote:
> On 2/19/20 10:25 AM, Sultan Alsawaf wrote:
> > Keeping kswapd running when all the failed allocations that invoked it
> > are satisfied incurs a high overhead due to unnecessary page eviction
> > and writeback, as well as spurious VM pressure events to various
> > registered shrinkers. When kswapd doesn't need to work to make an
> > allocation succeed anymore, stop it prematurely to save resources.
> 
> But kswapd isn't just to provide memory to waiters.  It also serves to
> get free memory back up to the high watermark.  This seems like it might
> result in more frequent allocation stalls and kswapd wakeups, which
> consumes extra resources.
> 
> I guess I'd wonder what positive effects you have observed as a result
> of this patch and whether you've gone looking for any negative effects.

This patch essentially stops kswapd from going overboard when a failed
allocation fires up kswapd. Otherwise, when memory pressure is really high,
kswapd just chomps through CPU time freeing pages nonstop when it isn't needed.
On a constrained system I tested (mem=2G), this patch had the positive effect of
improving overall responsiveness at high memory pressure.

On systems with more memory I tested (>=4G), kswapd becomes more expensive to
run at its higher scan depths, so stopping kswapd prematurely when there aren't
any memory allocations waiting for it prevents it from reaching the *really*
expensive scan depths and burning through even more resources.

Combine a large amount of memory with a slow CPU and the current problematic
behavior of kswapd at high memory pressure shows. My personal test scenario for
this was an arm64 CPU with a variable amount of memory (up to 4G RAM + 2G swap).

Sultan
