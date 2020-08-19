Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E233C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574232078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgHSFJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:09:26 -0400
Received: from verein.lst.de ([213.95.11.211]:36104 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSFJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:09:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 865C468AFE; Wed, 19 Aug 2020 07:09:22 +0200 (CEST)
Date:   Wed, 19 Aug 2020 07:09:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dma-mapping: set default segment_boundary_mask to
 ULONG_MAX
Message-ID: <20200819050922.GA19697@lst.de>
References: <20200815064726.20459-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815064726.20459-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to the dma-mapping tree.  This should give us the whole merge
window to root out any obvious problems with drivers.
