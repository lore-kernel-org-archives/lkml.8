Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F33207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgGBQzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGBQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:54:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA366C08C5C1;
        Thu,  2 Jul 2020 09:54:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id F1AF12A603F
From:   Helen Koike <helen.koike@collabora.com>
To:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        robh+dt@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        kernel@collabora.com, dafna.hirschfeld@collabora.com,
        ezequiel@collabora.com, mark.rutland@arm.com,
        karthik.poduval@gmail.com, jbx6244@gmail.com, kishon@ti.com,
        tfiga@chromium.org, eddie.cai.linux@gmail.com,
        zhengsq@rock-chips.com
Subject: [PATCH v3 7/9] media: MAINTAINERS: rkisp1: add path to dt-bindings
Date:   Thu,  2 Jul 2020 13:54:08 -0300
Message-Id: <20200702165410.2583375-8-helen.koike@collabora.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200702165410.2583375-1-helen.koike@collabora.com>
References: <20200702165410.2583375-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip ISP bindings was moved out of staging.
Update MAINTAINERS file with the new path.

Fields sorted according to output of
./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS
--order

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---

V3:
- Add line:
L:     linux-rockchip@lists.infradead.org
- Re-order:
F:     drivers/staging/media/rkisp1/

V2:
- This is a new patch in the series
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 634d2c3d621aa..d7141cf17072f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14679,7 +14679,9 @@ F:	include/linux/hid-roccat*
 ROCKCHIP ISP V1 DRIVER
 M:	Helen Koike <helen.koike@collabora.com>
 L:	linux-media@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/media/rockchip-isp1.yaml
 F:	drivers/staging/media/rkisp1/
 
 ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
-- 
2.26.0

