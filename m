Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2DDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7FD20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FAkcrvKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbgE0QDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389345AbgE0QDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:03:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC7BC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:03:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dh1so11350845qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S4XAF2qs5g4AY/r0EWrS8+9mLHbgcJOtXMG15PYfY1M=;
        b=FAkcrvKPhwXHPzhdsTR4NIhbFqwfLMvAV5bGTRBFGbczDHZC/aQDPVNA9PY7cGrlvI
         OAU7sMfEHvFrbqT7CvtkuJGTkLTQG5KPLvLc06tbn9wyvDUbjiyyqowgDNO9WndwvoJj
         X2dl1qZDNUOZqVESipiKNZd2Z60Nw52ZyxG0kUa5w+Kb9fsoxQn99KBAnvXQXuidqHXF
         g8B5P2fMOTarggI1cwoQW6OJquoa9Iej9VuFDR2ehmtvCwzE99l5fAoHQpqyCpeiAEEr
         Af1ivrgSbwVp3LHhcKFdtzo1qHJKVNeAaLsKpBMc9QZNWJkGiTDvSPU22BKqJthweSfF
         Xblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4XAF2qs5g4AY/r0EWrS8+9mLHbgcJOtXMG15PYfY1M=;
        b=EJBpPP9nNQ/MgRmZ/gWBPTs335D8ed3KzhiwKFQpdGvU1hODIKM0ijghO4sMigzPqR
         d9Y7F3vOxOnRfoRL/r0QOOFNx1OSHrxBSre3FB0uUTrTz5y1Lf2UkQdTQ6THNAoO6RRd
         QXW9JBlVa+P4DZEwLEjPTbggf3Mb5rKItNu9k8G2vsLqcLBF/SB6gz/3DjdAqn2C0gCK
         lH36eTGMkVpf7jRAYYycj1m5Ey10v9KMZaX0Nfxv0/Nj/7oOTjP47xCjKwwS4ltomj5x
         tUlpyUNBnJz1JSqI8fJvJtpkmKUvvKHS5HpUen5WUK0ECl58F1YaOeLMo2w1DQp11EiS
         IiBw==
X-Gm-Message-State: AOAM5301w2yvTTzM34HAzZ1NN3EVdBzeafR0og+Z1XVH+9eAdLleTYHJ
        yWI7C3cYVnyfK5hSbQWEQfUbbQ==
X-Google-Smtp-Source: ABdhPJyGGNRt6GbiZDvAAJR7JhnDFJNuzQwWePJEhdbGDeVQFHSsv2y//UkvfCBcqxVwmEGqiS8tHA==
X-Received: by 2002:a0c:f486:: with SMTP id i6mr24701658qvm.190.1590595402656;
        Wed, 27 May 2020 09:03:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id g66sm2485148qkb.122.2020.05.27.09.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:03:22 -0700 (PDT)
Date:   Wed, 27 May 2020 12:02:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 04/12] mm: add support for async page locking
Message-ID: <20200527160257.GB42293@cmpxchg.org>
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-5-axboe@kernel.dk>
 <20200526215925.GC6781@cmpxchg.org>
 <152529a5-adb4-fd7b-52ac-967500c011c9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152529a5-adb4-fd7b-52ac-967500c011c9@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 04:01:07PM -0600, Jens Axboe wrote:
> On 5/26/20 3:59 PM, Johannes Weiner wrote:
> > On Tue, May 26, 2020 at 01:51:15PM -0600, Jens Axboe wrote:
> >> Normally waiting for a page to become unlocked, or locking the page,
> >> requires waiting for IO to complete. Add support for lock_page_async()
> >> and wait_on_page_locked_async(), which are callback based instead. This
> > 
> > wait_on_page_locked_async() is actually in the next patch, requiring
> > some back and forth to review. I wonder if this and the next patch
> > could be merged to have the new API and callers introduced together?
> 
> I'm fine with that, if that is preferable. Don't feel strongly about
> that at all, just tried to do it as piecemeal as possible to make
> it easier to review.

Not worth sending a new iteration over, IMO.
