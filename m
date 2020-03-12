Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C476C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F98520724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="nNate0u0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCLOrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:47:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39635 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbgCLOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:47:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id f17so3239737qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bkEMbn273mdTI0AXhfsCYlRybd34rXTvQOuBweyXdAI=;
        b=nNate0u0S3aVT6rUhoHi/gCeLVVgF1Ym72tleDd+1mq2bhxXMk+lsBEU6d/v8IGA+b
         zsy0SRB0aYjUpDfxZ7fLcV6y+UvgmFZ0v/5vPLQbYmx78/I3InPTXPh5fOen3gfwj4jV
         o+0PXJ/uH5PwNAlAsiIbI470nbSRicBtc04BPl44plQcSedwSSztXOutjQ9XS5uyHqdi
         jsufNn8/4b1dAAvEjn6V0uUAWlUz2+CFYeGAPnzOQ0JS3QrXajrbh73O4xGyEUVIsWwg
         yU/A1563fUjzs8Nc5f6hPayD9gnnr3nu5GISVBR8NoGuRIJCJV5wkxc/38aZzEbiwEDn
         KWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bkEMbn273mdTI0AXhfsCYlRybd34rXTvQOuBweyXdAI=;
        b=spZlEJU7n7Lf6+nWf9BYXpycbcWmPCtIyXSvmPN/6sG4asmmBDBCuVAyYPdUAKyTPC
         qKNT9/qIjPxk08oESYAMCAgBW9dpuWzzpjoCu6bjsHLdjxnSlTuF2MZEoh4sCbwMsDEz
         s3gLF3uyPPZuyKmA9TAIrjpnF4Ui0L9l1cGbPNBJ4fmy/rInNcahYPNEULrO0UHxEvhN
         WQ+dJ3OQjJhbWS2Hj5kdgoVkMT8C7tSKNvpKLYJRzBvT7stwpquoImYNQnIVon4t8vDB
         CxLqCMI7EybqCSPvFUxDtATiwMmPiXgQfYWrzjeqhX/rWYXcQJS0flBcn4ywsfhoV+ru
         qLrQ==
X-Gm-Message-State: ANhLgQ2LHYKjo8341lCXn1iy4YId/BUuOGFDWUrcSn3Fpr8U4GVghbYp
        4f4BOD1IMHcfEFvIQDBphYjnzw==
X-Google-Smtp-Source: ADFU+vtez/OYPIOGbQ3kCqqnHLmKDJ5OQvSq2g62kT+6Tr+O2gVjdB1Bhf9T9GX+6Ir1rjbjtE8Ndg==
X-Received: by 2002:ac8:e45:: with SMTP id j5mr7465910qti.215.1584024471583;
        Thu, 12 Mar 2020 07:47:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ef6a])
        by smtp.gmail.com with ESMTPSA id f13sm13651077qte.53.2020.03.12.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:47:50 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:47:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 1/9] mm/vmscan: make active/inactive ratio as 1:1 for
 anon lru
Message-ID: <20200312144749.GG29835@cmpxchg.org>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1582175513-22601-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582175513-22601-2-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 02:11:45PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Current implementation of LRU management for anonymous page has some
> problems. Most important one is that it doesn't protect the workingset,
> that is, pages on the active LRU list. Although, this problem will be
> fixed in the following patchset, the preparation is required and
> this patch does it.
> 
> What following patchset does is to restore workingset protection. In this
> case, newly created or swap-in pages are started their lifetime on the
> inactive list. If inactive list is too small, there is not enough chance
> to be referenced and the page cannot become the workingset.
> 
> In order to provide enough chance to the newly anonymous pages, this patch
> makes active/inactive LRU ratio as 1:1.

Patch 8/9 is a revert of this patch. I assume you did this for the
series to be bisectable and partially revertable, but I'm not sure
keeping only the first and second patch would be safe: they reduce
workingset protection quite dramatically on their own (on a 10G system
from 90% of RAM to 50% e.g.) and likely cause regressions.

So while patch 2 is probably a lot better with patch 1 than without,
it seems a bit unnecessary since we cannot keep patch 2 on its own. We
need the rest of the series to make these changes.

On the other hand, the patch is small and obviously correct. So no
strong feelings either way.

> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
