Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29015C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A93E222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCBQIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:08:19 -0500
Received: from 8bytes.org ([81.169.241.247]:49604 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgCBQIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:08:18 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 013665BC; Mon,  2 Mar 2020 17:08:16 +0100 (CET)
Date:   Mon, 2 Mar 2020 17:08:14 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yonghyun Hwang <yonghyun@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <mdf@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys()
 for huge page
Message-ID: <20200302160813.GB7829@8bytes.org>
References: <20200226203006.51567-1-yonghyun@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226203006.51567-1-yonghyun@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:30:06PM -0800, Yonghyun Hwang wrote:
> intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
> page onto its corresponding physical address. This commit fixes the bug by
> accomodating the level of page entry for the IOVA and adds IOVA's lower
> address to the physical address.
> 
> Cc: <stable@vger.kernel.org>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Yonghyun Hwang <yonghyun@google.com>

Applied with Fixes tag:

Fixes: 3871794642579 ("VT-d: Changes to support KVM")
