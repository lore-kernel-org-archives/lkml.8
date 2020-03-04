Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F4820866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Yz3sfhkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgCDICw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:02:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37981 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:02:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so928101ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJwXQHOGfBvRfP8VBWg2bX3dJRR6Y/FuTLO1IQfTw1A=;
        b=Yz3sfhkQCsVRs2839qs1BfeyedHx2siPjrgeKySlIDpScCfojGKQCbXYvL39Fq3EYM
         HHQGJyPEuUTpxzf4IuJCTMQa8C2Gn3y1ANBqWZ4zlVXkkyoLFVlRGvWQ4LTj6mBNrHZU
         xOeDs9VQ4NyQhxwcungr9jQGvvJVT8rKEv72BnR3jOkYDQ9WzJY+wTzkBVKqf/lOyb/s
         lgZxU6z9GXgYBYPL5KJ2XcjhqcSfqSiyHtUFMLmLiCexiiZWysJzBYl6FpHvkJsQ1Z7r
         RQMUwPw8LxBzH/6ihsNX+3J1/vHGjtrOmbgn19h1VGvkNQrp+VNCRy1vb1zxbUV4G283
         XUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJwXQHOGfBvRfP8VBWg2bX3dJRR6Y/FuTLO1IQfTw1A=;
        b=Pw3sfp1x7gXHWxK0yXa2CiAhZ5uBhmsekyOmTbz8i5/c26THZUNMD2PBrPc8jNFh6V
         a4V2ZPZRpsjgrQR4THKa2LanHCJOzDzpzvv6KFUFE//Ws6IsiQob4tnD1e0KIMDm14sC
         KG/7gZ024gSLhyRGFuWOQk5LYn0fT1jyN7IPCi7O4Ijn3g2cE9TVrGuvAIXBV9nqVy0O
         eWby9QaebG7x3w78Rz+jfweQu1B/xmpAefP2jPJ3arwGt3vrKd030NvkFf7PQClOGF3M
         wMrvFfoW4aVck4zoCwemOEC3FSSCcw+4rTX6s0WIS5Rf0CblEc6kZtLe8RyWNunt9/vk
         or6Q==
X-Gm-Message-State: ANhLgQ18cu6YWJ99TIVzRlyADILNvREKUm9RLdD+0MwqqBYvi4IM5eyg
        2P3M4CJON5gz9KE74kmxBAfuLA==
X-Google-Smtp-Source: ADFU+vvkwU/GzcL4pLeLhMMhkTpWZOVBAFzfm69VarafgvEVC8sWssS6tTWvQlMWM188Qc550cKVCQ==
X-Received: by 2002:a2e:8015:: with SMTP id j21mr1215994ljg.194.1583308970222;
        Wed, 04 Mar 2020 00:02:50 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s21sm15487953lfb.27.2020.03.04.00.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 00:02:49 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7F01F100FE1; Wed,  4 Mar 2020 11:02:48 +0300 (+03)
Date:   Wed, 4 Mar 2020 11:02:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/20] mm/thp: narrow lru locking
Message-ID: <20200304080248.wuj3vqlz46ehhptg@box>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-7-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583146830-169516-7-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 07:00:16PM +0800, Alex Shi wrote:
> @@ -2564,6 +2565,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		xa_lock(&swap_cache->i_pages);
>  	}
>  
> +	/* Lru list would be changed, don't care head's LRU bit. */
> +	spin_lock_irqsave(&pgdat->lru_lock, flags);
> +
>  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>  		__split_huge_page_tail(head, i, lruvec, list);
>  		/* Some pages can be beyond i_size: drop them from page cache */

You change locking order WRT i_pages lock. Is it safe?

-- 
 Kirill A. Shutemov
