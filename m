Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB4FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F95206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DwodH1gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgFDPGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgFDPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:06:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADAC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mG7D+jRYpSS5Y4OVIdfZqG69AgF0Bh19MVMpT/Ilvms=; b=DwodH1gGIjv40L+PhfWicphFbx
        L5Z7b3GpAuWb46yYc5ODv3xP+8dgv15FmsYeJFocfnSI7z+I4gPK9mheD3eUZt6qcUTA3vG+E7ztE
        2AW5EznqM9mp1JesX5GoV7c1VvYvJkk2mz516slHkUVfO+DHtGJS4xZkBq4YiM9vW2uD8ZVjFCDK4
        JZogr9lWJ74maHopDVAhQp0uKdnPVBrZUQenuz/5mHQ1ZkKDvh43e5oCFL9NPq5AKozm4d269Vipk
        ctlqUTa3Bq68LHEsMO6yea9qAjPF3yP4s1rZmRV5v9mY3eZzGi5R/RVpxQor/Y4XugO5QlyuT2/Pe
        SQO0YF9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgrS7-0008Be-4R; Thu, 04 Jun 2020 15:06:43 +0000
Date:   Thu, 4 Jun 2020 08:06:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Miles Chen <miles.chen@mediatek.com>, wsd_upstream@mediatek.com,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Chao Hao <chao.hao@mediatek.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/mediatek: Use totalram_pages to setup enable_4GB
Message-ID: <20200604150643.GA29193@infradead.org>
References: <20200604080120.2628-1-miles.chen@mediatek.com>
 <55820901-430b-14c4-9426-7a4991ca0eed@redhat.com>
 <1591264174.12661.17.camel@mtkswgap22>
 <f02c8c9d-ed75-6513-f8a9-a2fdbb11b750@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02c8c9d-ed75-6513-f8a9-a2fdbb11b750@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:32:40PM +0200, David Hildenbrand wrote:
> Just a thought: If memory hotplug is applicable as well, you might
> either want to always assume data->enable_4GB, or handle memory hotplug
> events from the memory notifier, when new memory gets onlined (not sure
> how tricky that is).

We probably want a highest_pfn_possible() or similar API instead of
having drivers poking into random VM internals.
