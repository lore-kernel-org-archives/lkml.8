Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AC7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5680E207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgFIJPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:15:50 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52799 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgFIJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:15:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U.3kARo_1591694145;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.3kARo_1591694145)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Jun 2020 17:15:45 +0800
Subject: Re: [patch 113/131] mm: balance LRU lists based on relative thrashing
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        mhocko@suse.com, minchan@kernel.org, mm-commits@vger.kernel.org,
        riel@surriel.com, torvalds@linux-foundation.org
References: <20200603230303.kSkT62Lb5%akpm@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a60f7866-3b32-7a0e-5d0a-a48d77f845a8@linux.alibaba.com>
Date:   Tue, 9 Jun 2020 17:15:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200603230303.kSkT62Lb5%akpm@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/6/4 ÉÏÎç7:03, Andrew Morton Ð´µÀ:
>  
> +	/* XXX: Move to lru_cache_add() when it supports new vs putback */

Hi Hannes,

Sorry for a bit lost, would you like to explain a bit more of your idea here?

> +	spin_lock_irq(&page_pgdat(page)->lru_lock);
> +	lru_note_cost(page);
> +	spin_unlock_irq(&page_pgdat(page)->lru_lock);
> +


What could we see here w/o the lru_lock?

Thanks
Alex
