Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E078C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC8420735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEEMk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:40:28 -0400
Received: from 8bytes.org ([81.169.241.247]:41258 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgEEMk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:40:27 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B6CCF39A; Tue,  5 May 2020 14:40:26 +0200 (CEST)
Date:   Tue, 5 May 2020 14:40:25 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Qian Cai <cai@lca.pw>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iommu/amd: Fix race conditions around
 increase_address_space()
Message-ID: <20200505124025.GC18353@8bytes.org>
References: <20200504125413.16798-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504125413.16798-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 02:54:08PM +0200, Joerg Roedel wrote:
> Joerg Roedel (5):
>   iommu/amd: Fix race in increase_address_space()/fetch_pte()
>   iommu/amd: Do not loop forever when trying to increase address space
>   iommu/amd: Call domain_flush_complete() in update_domain()
>   iommu/amd: Update Device Table in increase_address_space()
>   iommu/amd: Do not flush Device Table in iommu_map_page()
> 
>  drivers/iommu/amd_iommu.c       | 198 +++++++++++++++++++++++++-------
>  drivers/iommu/amd_iommu_types.h |   9 +-
>  2 files changed, 161 insertions(+), 46 deletions(-)

Applied for v5.7.
