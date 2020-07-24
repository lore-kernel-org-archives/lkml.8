Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F08C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE1E206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGXO7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:59:19 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:18194 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgGXO7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:59:19 -0400
X-IronPort-AV: E=Sophos;i="5.75,391,1589209200"; 
   d="scan'208";a="52751506"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Jul 2020 23:59:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E0DD3425F874;
        Fri, 24 Jul 2020 23:59:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Niklas <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] media: rcar-vin: Add support to select data pins
Date:   Fri, 24 Jul 2020 15:58:50 +0100
Message-Id: <1595602732-25582-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds support to enable selecting data
lines via DT.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: media: renesas,vin: Document renesas-vin-ycbcr-8b-g
    property
  media: rcar-vin: Add support to read renesas-vin-ycbcr-8b-g property

 Documentation/devicetree/bindings/media/renesas,vin.yaml | 13 +++++++++++++
 drivers/media/platform/rcar-vin/rcar-core.c              |  4 +++-
 drivers/media/platform/rcar-vin/rcar-dma.c               |  7 +++++++
 drivers/media/platform/rcar-vin/rcar-vin.h               |  2 ++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.7.4

