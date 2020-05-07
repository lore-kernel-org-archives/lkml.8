Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1FAC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A22B24985
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Nwem4RCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGUly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEGUlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:41:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E3C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:41:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z90so6006393qtd.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2sEB/hg7nI765KO+sGVWwlpeLWhkT2BGkQB6agKb2hg=;
        b=Nwem4RCafQxZA33I/DLrM69yNQA3krWl4ud0UnNMG9VzRbX1rvD+mOYuD9jq8gQtVM
         hm1F/6YeZSVOG/YCsce0dv+dEffsc/eU+lVTscpPG7eP2PfZa10dW6MWDhglGxaucNyC
         Wig6bmpO7u4wivFDSS1LpFdCu6EGCsWQ8CXryFVeqGh/giUrPy0jD2CcXqQFWaPesihT
         l16e2vDapQh6mqjA9/QHI48HmABDeBlYiZ3UHtY4IVulYJcM1AfSvd/2cZ1rCQgAVN2y
         Pcz/cuf2p0U1WGJW0UUJB0S57uDbXVgrLIthO6cBbGMzFmvwWDbfWD0qPuvo4NNor1WX
         5hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2sEB/hg7nI765KO+sGVWwlpeLWhkT2BGkQB6agKb2hg=;
        b=RrCoY0DVWB2ypKIKqsKhU+Xv87E1MjXDJmlB9upYUkje6ckrXf45Teq5UFgbPoZikz
         IPxX+VcBHBEM7vpFD/dm/7IAjwKQI1pF9T6a6XkB48SChW2b/TSS0UxhcoqzaFEHbg5i
         EKjZR4PnJ2S9RWQU+fllFFhaxr6H/eMfo4aBnEGv1hQS/oLrGF58rsf6tyCsZ8Ll3eve
         nHaWdp+Y/XaxHbWKRsu+QkWna5OzLVNxuUo968muksawoQ/gRSSrQZP63T2zuqI/Xx1+
         JFpn8Pbzywoix99LemPHFWUYKnJi83pXDZvKt6XdjaPnnyzxgl83GJSO7/TeS7SUu5Bt
         BcgA==
X-Gm-Message-State: AGi0PuYkr9NT7C3iT8jAd+VImLUUoYO7HYKAmi3FX+jAslFJJe5qGFOP
        OF9FZkkCcKguFpoljUb4NxRmM/JGxQY=
X-Google-Smtp-Source: APiQypKszgJEMRP8Wa0a+vGtxubxhiQ2T7LYaAqJ2CJ4vo+zNuL6wJK0NFwLDuRPylFmT2sYsTlGYg==
X-Received: by 2002:ac8:120a:: with SMTP id x10mr16458805qti.127.1588884113745;
        Thu, 07 May 2020 13:41:53 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id v130sm5056159qkb.39.2020.05.07.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:41:53 -0700 (PDT)
Date:   Thu, 7 May 2020 16:41:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/19] mm: memcg: convert vmstat slab counters to bytes
Message-ID: <20200507204137.GC161043@cmpxchg.org>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422204708.2176080-4-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:46:52PM -0700, Roman Gushchin wrote:
> In order to prepare for per-object slab memory accounting, convert
> NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat items to bytes.
> 
> To make it obvious, rename them to NR_SLAB_RECLAIMABLE_B and
> NR_SLAB_UNRECLAIMABLE_B (similar to NR_KERNEL_STACK_KB).
> 
> Internally global and per-node counters are stored in pages,
> however memcg and lruvec counters are stored in bytes.
> This scheme may look weird, but only for now. As soon as slab
> pages will be shared between multiple cgroups, global and
> node counters will reflect the total number of slab pages.
> However memcg and lruvec counters will be used for per-memcg
> slab memory tracking, which will take separate kernel objects
> in the account. Keeping global and node counters in pages helps
> to avoid additional overhead.
> 
> The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
> so it will fit into atomic_long_t we use for vmstats.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for splitting this out, it makes both this and the previous
patch easier to read.
