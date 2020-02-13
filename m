Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D4C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D15D246B3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581625223;
	bh=/QOiQiXXiovtGHxYG5aVdZh+2JuQfzTgjoE0CRPON4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RzE1FHf5zj9Wqr5kjizomrplMt2JNMaR2WWizjefxOaAcG/2LpAX9dTjnAyhbNMo2
	 YepiV/Ev8HQtuNN1k05yXYZiAbEqyPN5xWa5k0kAGtwMYxfSf5JOvRDiDjgUgrv4zh
	 a+9bFIj/799MWRW4Gq6dh+z4kEtRtCmzIh2gDLRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgBMUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:20:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387421AbgBMUUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:20:19 -0500
Received: from ziggy.cz (unknown [37.223.145.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D480246F1;
        Thu, 13 Feb 2020 20:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581625218;
        bh=/QOiQiXXiovtGHxYG5aVdZh+2JuQfzTgjoE0CRPON4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oj/JxisvI2iF45VxuWmSj0gIDnGzoN20SXGXL5b4Iavh1MZDL5qvCBf8pGTJgqidr
         op5+zeRMC4N2jkRM36S6bUvB/BkbVWh/NTXqWBJdl6d1YXwv3E41o5aakUEastTFHQ
         S1jjRigwkT8BXSjgDej7kTb3cfiNtGrEd5FOlt+g=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@kernel.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, enric.balletbo@collabora.com
Cc:     devicetree@vger.kernel.org, drinkcat@chromium.org,
        frank-w@public-files.de, sean.wang@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wens@csie.org, linux-mediatek@lists.infradead.org,
        rdunlap@infradead.org, matthias.bgg@kernel.org,
        hsinyi@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v7 03/13] dt-bindings: mediatek: Add compatible for mt7623
Date:   Thu, 13 Feb 2020 21:19:43 +0100
Message-Id: <20200213201953.15268-4-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213201953.15268-1-matthias.bgg@kernel.org>
References: <20200213201953.15268-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

MediaTek mt7623 uses the mt2701 bindings as fallback.
Document this in the binding description.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v7:
- fix typo in commit message
- add Rob's ack

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/display/mediatek/mediatek,disp.txt      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 8e453026ef78..456e502f538c 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -46,6 +46,8 @@ Required properties (all function blocks):
 	"mediatek,<chip>-disp-od"    		- overdrive
 	"mediatek,<chip>-mmsys", "syscon"	- provide clocks and components management
   the supported chips are mt2701, mt2712 and mt8173.
+  For mt7623, compatible must be:
+        "mediatek,mt7623-<component>" , "mediatek,mt2701-<component>"
 
 - reg: Physical base address and length of the function block register space
 - interrupts: The interrupt signal from the function block (required, except for
-- 
2.24.1

