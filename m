Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EEC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933F220866
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCHQcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:32:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:44810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 624BAAEF6;
        Sun,  8 Mar 2020 16:32:45 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC 01/11] dt-bindings: vendor-prefixes: Add Sunplus
Date:   Sun,  8 Mar 2020 17:32:19 +0100
Message-Id: <20200308163230.4002-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunplus Technology Co., Ltd. is a Taiwanese IC vendor.
Assign vendor prefix "sunplus".

Cc: Wells Lu 呂芳騰 <wells.lu@sunplus.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6e09fc7362d5..2c764b0941b4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -955,6 +955,8 @@ patternProperties:
     description: Summit microelectronics
   "^sunchip,.*":
     description: Shenzhen Sunchip Technology Co., Ltd
+  "^sunplus,.*":
+    description: Sunplus Technology Co., Ltd.
   "^SUNW,.*":
     description: Sun Microsystems, Inc
   "^swir,.*":
-- 
2.16.4

