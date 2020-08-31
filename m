Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F17BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4479C20936
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nufgvQyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgHaTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:53:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14842 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgHaTwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:52:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d55040000>; Mon, 31 Aug 2020 12:52:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 12:52:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 31 Aug 2020 12:52:50 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 19:52:50 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 19:52:50 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.173.243]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4d55110003>; Mon, 31 Aug 2020 12:52:49 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <sakari.ailus@iki.fi>,
        <hverkuil@xs4all.nl>, <luca@lucaceresoli.net>,
        <leonl@leopardimaging.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: media: imx274: Use lower case for supply names
Date:   Mon, 31 Aug 2020 12:52:36 -0700
Message-ID: <1598903558-9691-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598903558-9691-1-git-send-email-skomatineni@nvidia.com>
References: <1598903558-9691-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598903556; bh=ySzum52tCISvSDqWynIx+cn7v/qn33wbCu7y8hGm7XQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nufgvQyutBdVMTJl7UiqVZMgPSKYIX84fX3enTtbUqHBbB+QllvIEqNKdRSamy7T5
         IgKD0soBJQikeZdTcQnE67/tBxHZh/5I/C+g4UIsbOwuJVjoMdzhNf0GKx0zCwxEsq
         Pirjy85sHv933LyJlWY/8lDi/Ey7Cm4yz46zPHv6JBBHJuyYzqM17GX5+XsKunA0QY
         7/NWGOozeLB/YxukFaTf9azyYUg9S3YsCxa1mTOkee1iqOwn/gKyJExi7HB7nnSqkQ
         XlFy572kq8M6i4AiFRQJXKNcG5pzXFou0rzexV1BXIYoHclCkr0tpzGYUdXUm9KsTc
         7WhUTDsCAwkQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates dt-binding to use lower case for supply names.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/media/i2c/imx274.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/imx274.txt b/Documentation/devicetree/bindings/media/i2c/imx274.txt
index 0727079..d0a5c899 100644
--- a/Documentation/devicetree/bindings/media/i2c/imx274.txt
+++ b/Documentation/devicetree/bindings/media/i2c/imx274.txt
@@ -15,9 +15,9 @@ Optional Properties:
 - reset-gpios: Sensor reset GPIO
 - clocks: Reference to the input clock.
 - clock-names: Should be "inck".
-- VANA-supply: Sensor 2.8v analog supply.
-- VDIG-supply: Sensor 1.8v digital core supply.
-- VDDL-supply: Sensor digital IO 1.2v supply.
+- vana-supply: Sensor 2.8v analog supply.
+- vdig-supply: Sensor 1.8v digital core supply.
+- vddl-supply: Sensor digital IO 1.2v supply.
 
 The imx274 device node should contain one 'port' child node with
 an 'endpoint' subnode. For further reading on port node refer to
-- 
2.7.4

