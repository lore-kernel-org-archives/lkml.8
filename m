Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF0C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD3021744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582683073;
	bh=ZEaedp/t+OQSF3UOsAPhZYZgIEc+LWUwL3y+/EEtQhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rxBOJk1LIR1NJWxc6lMlBLrSKBMbb+DBEYrQvo/ySeqJyQguQq/+Gtiumze1NHTji
	 vLK5Frr7zOcp3x2RyD74nios7UBXaGQNS5uE4JIdtQbEeperL3DQPO0iYTF08uXa/c
	 qfHrRUnSnTO6QfYWaLp8WC2ibd2SCC9wp2kR1W74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgBZCLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgBZCLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:11:03 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4CE21744;
        Wed, 26 Feb 2020 02:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582683061;
        bh=ZEaedp/t+OQSF3UOsAPhZYZgIEc+LWUwL3y+/EEtQhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KMWf8lCx4d8eRF5v4CGpKVE8EnPQo0CFGrnGVlu8kncXipEwtwpCsQIpjm3SDeyfh
         Ah2b+mGlHmB6PKYzocKhQKhMaQh4tpOOlYNqsoGPseZs6xOMpS40LCsUSuhfVIziRi
         3asgSyZdZbKMPwQoczZ0RDkU9rp/VUe/B27qFS/w=
Date:   Tue, 25 Feb 2020 18:11:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: fix data races at kswapd_classzone_idx
Message-Id: <20200225181101.eca053d3201a6ac68e543572@linux-foundation.org>
In-Reply-To: <1582649726-15474-1-git-send-email-cai@lca.pw>
References: <1582649726-15474-1-git-send-email-cai@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 11:55:26 -0500 Qian Cai <cai@lca.pw> wrote:

> pgdat->kswapd_classzone_idx could be accessed concurrently in
> wakeup_kswapd(). Plain writes and reads without any lock protection
> result in data races. Fix them by adding a pair of READ|WRITE_ONCE() as
> well as saving a branch (compilers might well optimize the original code
> in an unintentional way anyway). The data races were reported by KCSAN,
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3961,11 +3961,10 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
>  		return;
>  	pgdat = zone->zone_pgdat;
>  
> -	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
> -		pgdat->kswapd_classzone_idx = classzone_idx;
> -	else
> -		pgdat->kswapd_classzone_idx = max(pgdat->kswapd_classzone_idx,
> -						  classzone_idx);
> +	if (READ_ONCE(pgdat->kswapd_classzone_idx) == MAX_NR_ZONES ||
> +	    READ_ONCE(pgdat->kswapd_classzone_idx) < classzone_idx)
> +		WRITE_ONCE(pgdat->kswapd_classzone_idx, classzone_idx);
> +
>  	pgdat->kswapd_order = max(pgdat->kswapd_order, order);
>  	if (!waitqueue_active(&pgdat->kswapd_wait))
>  		return;

This is very partial, isn't it?  The above code itself is racy against
other code which manipulates ->kswapd_classzone_idx and the
manipulation in allow_direct_reclaim() is performed by threads other
than kswapd and so need the READ_ONCE treatment and is still racy with
that?

I guess occasional races here don't really matter, but a grossly wrong
read from load tearing might matter.  In which case shouldn't we be
defending against them in all cases where non-kswapd threads read this
field?
