Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34FDC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A447208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589231485;
	bh=UTbTm++8n1i5+8gpoyrj8bjLx9n97J0BhZSZ+eXg4SM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sxiHRJSlwx+qgIF5G03A26xsrRVuFnD3xJVFqzLXKqahzZ5pxCNIixTbNm/XdiNkv
	 sVnfmnFHGnYR+PtPhKSQssvou1Dw25WNjwyCnJgnU0aAKRp+gLPm9Byehr7a5Mb9mB
	 ePE591E9NINv2Mh1cD6Yq6+4Dkd0dfy4dgyby/i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgEKVLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgEKVLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:11:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A0720836;
        Mon, 11 May 2020 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589231483;
        bh=UTbTm++8n1i5+8gpoyrj8bjLx9n97J0BhZSZ+eXg4SM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IiLcHFYcraLjJV+Jzc7qEmx+NomfJ1/WNEHXIAbI+dvzxN9fKuHJW9K5G/xidO805
         yRDXie7P68uvY0/eLWqwriQp0s5iaWqj2m2xgqggx63FqK1UZegLOkEgSqG/6+rwCu
         WCMU4TRu46XTINcJTUDHls7QegV9BBOQTMzEzugQ=
Date:   Mon, 11 May 2020 14:11:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix LRU balancing effect of new transparent huge
 pages
Message-Id: <20200511141122.9b03e2f0852b57b224eab066@linux-foundation.org>
In-Reply-To: <20200509141946.158892-1-shakeelb@google.com>
References: <20200509141946.158892-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 May 2020 07:19:46 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> Currently, THP are counted as single pages until they are split right
> before being swapped out. However, at that point the VM is already in
> the middle of reclaim, and adjusting the LRU balance then is useless.
> 
> Always account THP by the number of basepages, and remove the fixup
> from the splitting path.

Confused.  What kernel is this applicable to?
