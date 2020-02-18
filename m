Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F3BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D89522B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgBRQWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:22:32 -0500
Received: from 8bytes.org ([81.169.241.247]:54706 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgBRQWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:22:32 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E7F66B0; Tue, 18 Feb 2020 17:22:30 +0100 (CET)
Date:   Tue, 18 Feb 2020 17:22:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5 v2] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()
Message-ID: <20200218162228.GH22063@8bytes.org>
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-4-joro@8bytes.org>
 <83b21e50-9097-06db-d404-8fe400134bac@linux.intel.com>
 <20200218092827.tp3pq67adzr56k7e@8bytes.org>
 <a83ec6c4-2995-3219-c28a-72d2e56a0557@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a83ec6c4-2995-3219-c28a-72d2e56a0557@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:54:52PM +0800, Lu Baolu wrote:
> Looks good to me now. For all patches in this series,
> 
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks, queued the fixes for v5.6.
