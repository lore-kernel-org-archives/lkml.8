Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F86C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698282073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgBUXLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:11:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgBUXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:11:54 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j5HSR-0004zi-UK; Fri, 21 Feb 2020 23:11:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Roy Pledge <Roy.Pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] soc: fsl: dpio: fix dereference of pointer p before null check
Date:   Fri, 21 Feb 2020 23:11:43 +0000
Message-Id: <20200221231143.30131-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer p is currently being dereferenced before it is null
checked on a memory allocation failure check. Fix this by
checking if p is null before dereferencing it.

Addresses-Coverity: ("Dereference before null check")
Fixes: 3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array mode with ring mode enqueue")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 740ee0d19582..d1f49caa5b13 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -249,10 +249,11 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
 	u32 mask_size;
 	u32 eqcr_pi;
 
-	spin_lock_init(&p->access_spinlock);
-
 	if (!p)
 		return NULL;
+
+	spin_lock_init(&p->access_spinlock);
+
 	p->desc = d;
 	p->mc.valid_bit = QB_VALID_BIT;
 	p->sdq = 0;
-- 
2.25.0

