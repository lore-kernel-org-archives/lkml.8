Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15350C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9DC20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405499AbgFYOwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405385AbgFYOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:52:31 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CFFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:52:31 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5C7CE4D6; Thu, 25 Jun 2020 16:52:28 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Qian Cai <cai@lca.pw>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 0/2] iommu/amd: Don't use atomic64_t for domain->pt_root
Date:   Thu, 25 Jun 2020 16:52:25 +0200
Message-Id: <20200625145227.4159-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

a previous discussion pointed out that using atomic64_t for that
purpose is a bit of overkill. This patch-set replaces it with unsigned
long and introduces some helpers first to make the change more easy.

Qian, can you please test these patches in your environment? You can
trigger any race-condition there pretty reliably :)

Other than that, please review and test.

Regards,

	Joerg

Joerg Roedel (2):
  iommu/amd: Add helper functions to update domain->pt_root
  iommu/amd: Use 'unsigned long' for domain->pt_root

 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 39 ++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.27.0

