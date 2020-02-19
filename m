Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E246C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67952207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgBSKQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:16:16 -0500
Received: from 8bytes.org ([81.169.241.247]:54864 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSKQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:16:15 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1661936A; Wed, 19 Feb 2020 11:16:14 +0100 (CET)
Date:   Wed, 19 Feb 2020 11:16:12 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Use C99 flexible array in fwspec
Message-ID: <20200219101612.GC1961@8bytes.org>
References: <7364595699c37d2ef53636c8af6dcefa6602529b.1581601149.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7364595699c37d2ef53636c8af6dcefa6602529b.1581601149.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:00:21PM +0000, Robin Murphy wrote:
> Although the 1-element array was a typical pre-C99 way to implement
> variable-length structures, and indeed is a fundamental construct in the
> APIs of certain other popular platforms, there's no good reason for it
> here (and in particular the sizeof() trick is far too "clever" for its
> own good). We can just as easily implement iommu_fwspec's preallocation
> behaviour using a standard flexible array member, so let's make it look
> the way most readers would expect.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Before the Coccinelle police catch up with me... :)

Applied, thanks. You should be safe now :)
