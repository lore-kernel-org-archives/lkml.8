Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E02C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1315208A9
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="O4LFdDLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgHaUiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:38:09 -0400
Received: from st43p00im-ztfb10063301.me.com ([17.58.63.179]:36528 "EHLO
        st43p00im-ztfb10063301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgHaUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598906286; bh=XxL3oI7OiD9bAadRpAo7Tb0keHieFRkDTCWwJZ6GaXk=;
        h=From:To:Subject:Date:Message-Id;
        b=O4LFdDLKXb3JAY1a1/RMuFGJ+jU08k95AsR8Mj3CxnUzA9oFzBLgt7eMt5bA2RuyJ
         U2dh/4KNT4ZWCwVNV27GfChZmrkOS9kQGwD8ThYIdxDk/F/t8wJ/RMH7szYZ0A4b2I
         58sWtm4BVEkapTCFJrn0QKfFdGWPAVdGQZuVbBa7sHMNW2HjmaCtdXT9DynNZo+il8
         acEHIRl+r8y5HXBvbxjb3I2VMX/vvA+LK3+bAi+K4G6cGtWLbWSAFm8GwTQPdw9Zq6
         6pR7uAAq0j8/ZiaOYMiF4+Aczjw2BTe1OIDcB+qJKPAHKNj18mtCRRzqJgNo2crrVR
         EU4I16AiibBtw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id 78BFCA4040C;
        Mon, 31 Aug 2020 20:38:06 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH] reset: sti: reset-syscfg: fix struct description warnings
Date:   Mon, 31 Aug 2020 22:38:04 +0200
Message-Id: <20200831203804.6568-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_09:2020-08-31,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008310120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix formating of struct description to avoid warning highlighted
by W=1 compilation.

Fixes: e5d76075d930 ("drivers: reset: STi SoC system configuration reset controller support")
Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/reset/sti/reset-syscfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
index 91215bb88f62..99b63035fe72 100644
--- a/drivers/reset/sti/reset-syscfg.c
+++ b/drivers/reset/sti/reset-syscfg.c
@@ -17,7 +17,7 @@
 #include "reset-syscfg.h"
 
 /**
- * Reset channel regmap configuration
+ * struct syscfg_reset_channel - Reset channel regmap configuration
  *
  * @reset: regmap field for the channel's reset bit.
  * @ack: regmap field for the channel's ack bit (optional).
@@ -28,8 +28,9 @@ struct syscfg_reset_channel {
 };
 
 /**
- * A reset controller which groups together a set of related reset bits, which
- * may be located in different system configuration registers.
+ * struct syscfg_reset_controller - A reset controller which groups together
+ * a set of related reset bits, which may be located in different system
+ * configuration registers.
  *
  * @rst: base reset controller structure.
  * @active_low: are the resets in this controller active low, i.e. clearing
-- 
2.17.1

