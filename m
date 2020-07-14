Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D2FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890B821D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGNKVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:21:00 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:20465 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbgGNKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:21:00 -0400
X-IronPort-AV: E=Sophos;i="5.75,351,1589209200"; 
   d="scan'208";a="52086649"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2020 19:20:58 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 12180421EC6C;
        Tue, 14 Jul 2020 19:20:56 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] iommu/ipmmu-vmsa: Add entry for R8A774E1 and r8a77961
Date:   Tue, 14 Jul 2020 11:20:53 +0100
Message-Id: <1594722055-9298-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Patch 1/2 was posted as part of series [1] as pointed out by Geert we need to
have an entry in both the lists soc_rcar_gen3 and soc_rcar_gen3_whitelist to
enable iommu unconditionally, this is now fixed in patch 1/2, also note the DT
binding documentation for R8A774E1 is part of [1]. Where as patch 2/2 is a
similar FIX for r8a77961.

Cheers,
Prabhakar

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=317627

Lad Prabhakar (1):
  iommu/ipmmu-vmsa: Add an entry for r8a77961 in soc_rcar_gen3[]

Marian-Cristian Rotariu (1):
  iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code

 drivers/iommu/ipmmu-vmsa.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.17.1

