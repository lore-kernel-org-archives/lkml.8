Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D78C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782E2206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbgF3Im5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:42:57 -0400
Received: from 8bytes.org ([81.169.241.247]:50572 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgF3Imz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:42:55 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E504F26B; Tue, 30 Jun 2020 10:42:52 +0200 (CEST)
Date:   Tue, 30 Jun 2020 10:42:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Prakash Gupta <guptap@codeaurora.org>
Subject: Re: [PATCH] iommu/iova: Don't BUG on invalid PFNs
Message-ID: <20200630084251.GA28824@8bytes.org>
References: <acbd2d092b42738a03a21b417ce64e27f8c91c86.1591103298.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acbd2d092b42738a03a21b417ce64e27f8c91c86.1591103298.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:08:18PM +0100, Robin Murphy wrote:
> Unlike the other instances which represent a complete loss of
> consistency within the rcache mechanism itself, or a fundamental
> and obvious misconfiguration by an IOMMU driver, the BUG_ON() in
> iova_magazine_free_pfns() can be provoked at more or less any time
> in a "spooky action-at-a-distance" manner by any old device driver
> passing nonsense to dma_unmap_*() which then propagates through to
> queue_iova().
> 
> Not only is this well outside the IOVA layer's control, it's also
> nowhere near fatal enough to justify panicking anyway - all that
> really achieves is to make debugging the offending driver more
> difficult. Let's simply WARN and otherwise ignore bogus PFNs.
> 
> Reported-by: Prakash Gupta <guptap@codeaurora.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied without stable tag, thanks.

