Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AECAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F13920BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgGCMux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:50:53 -0400
Received: from smtp.asem.it ([151.1.184.197]:60540 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCMuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:50:52 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000359509.MSG 
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 14:50:49 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 3 Jul
 2020 14:50:47 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 3 Jul 2020 14:50:47 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] drm/i915: Fix spelling mistake in i915_reg.h
Date:   Fri, 3 Jul 2020 14:50:46 +0200
Message-ID: <20200703125046.8395-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090201.5EFF29A8.003D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo: "TRIGER" --> "TRIGGER"

The two misplelled macros:

1) OAREPORTTRIG1_EDGE_LEVEL_TRIGER_SELECT_MASK
2) OAREPORTTRIG5_EDGE_LEVEL_TRIGER_SELECT_MASK

are not used in any other sources of the kernel,
so this change can be consider only a local change
for the i915_reg.h file.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/gpu/drm/i915/i915_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 9d6536afc94b..c2153364724a 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -868,7 +868,7 @@ static inline bool i915_mmio_reg_valid(i915_reg_t reg)
 
 #define OAREPORTTRIG1 _MMIO(0x2740)
 #define OAREPORTTRIG1_THRESHOLD_MASK 0xffff
-#define OAREPORTTRIG1_EDGE_LEVEL_TRIGER_SELECT_MASK 0xffff0000 /* 0=level */
+#define OAREPORTTRIG1_EDGE_LEVEL_TRIGGER_SELECT_MASK 0xffff0000 /* 0=level */
 
 #define OAREPORTTRIG2 _MMIO(0x2744)
 #define OAREPORTTRIG2_INVERT_A_0  (1 << 0)
@@ -921,7 +921,7 @@ static inline bool i915_mmio_reg_valid(i915_reg_t reg)
 
 #define OAREPORTTRIG5 _MMIO(0x2750)
 #define OAREPORTTRIG5_THRESHOLD_MASK 0xffff
-#define OAREPORTTRIG5_EDGE_LEVEL_TRIGER_SELECT_MASK 0xffff0000 /* 0=level */
+#define OAREPORTTRIG5_EDGE_LEVEL_TRIGGER_SELECT_MASK 0xffff0000 /* 0=level */
 
 #define OAREPORTTRIG6 _MMIO(0x2754)
 #define OAREPORTTRIG6_INVERT_A_0  (1 << 0)
-- 
2.17.1

