Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD2C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F46020724
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B4NK76HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgCOHPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 03:15:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgCOHPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b7DGAf57srs3jYFqQmuOCHu9lYGsD/cv05l7QbqgK20=; b=B4NK76HAx9yniZ9gTFqMsrZzzg
        qSww3XhWBTz5HYdPoTen/fg7eZ3Epy1QeTexpEnhBIbGm8KQ3j66RMJrRlTgsg3LsWYyjUi9JRZ8y
        CERcx1rS+88HpUzF7NCb4U+LQcDTtgHRoqb5yAsJia7YBiXG23J0mgoJGVf7QDmf2N7M6qm46Y0HD
        3OIBYGXWSr8ATn2Y/xP5206WFxdpSnEKOZBB5sHyDA5zxqSu1fkSEwzqG2BcrlfLvBdgbNkO/pOtk
        uNzURLM/U5TcNimNOCtlnMD56T+YBAc1NU7r3GaeOG28gB3kVs66jL9WtMDMOJwqjhMY5OgPNEnBJ
        +XkLmaoQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDH1Z-0001O7-6m; Sun, 15 Mar 2020 00:21:01 +0000
Date:   Sat, 14 Mar 2020 17:21:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap_state.c: use the same way to count page in
 [add_to|delete_from]_swap_cache
Message-ID: <20200315002101.GT22433@bombadil.infradead.org>
References: <20200314215912.1554-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314215912.1554-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 09:59:12PM +0000, Wei Yang wrote:
> Function add_to_swap_cache() and delete_from_swap_cache() are counter
> parts, while currently they use different way to count page.
> 
> It doesn't break any thing because we only have two size for PageAnon,
> but this is confusing and not a good practice.
> 
> This patch corrects it by both using compound_nr().

You're converting in the wrong direction.  hpage_nr_pages() is optimised
away when CONFIG_TRANSPARENT_HUGEPAGE is undefined, whereas compound_nr()
is not.

I also have this patch pending:
http://git.infradead.org/users/willy/linux-dax.git/commitdiff/192b635b428ae74f680574cdcc3d5e9d213fcb64
