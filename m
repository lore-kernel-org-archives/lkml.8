Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770AAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404602082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkwjJFwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407428AbgFYV6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405083AbgFYV6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:58:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C58C08C5C1;
        Thu, 25 Jun 2020 14:58:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ne5so3729326pjb.5;
        Thu, 25 Jun 2020 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvZtbrDBRF/tkY1XUgsUhw4qRWkNkbAOPkZ951cjMrY=;
        b=BkwjJFwyPkRmc45qqofzWlP9K8Xikjkm4IBfVGW1yaCij7b/CyzWOm7Zx9JCA0npIr
         iAN6V7Hw2BNH6G2PojQN0W+X2QvLctkrbU5GollJjoqSe0lCdGOccF+fgUx3851D4cji
         YRCRkUX85Oo/Ixf+N93NGSyoMKVAluxIEuAM6Z0Jg3t2uGu2BKb5TquTvvvvL+/ZZsHh
         f96PW9heA/zHSxjiIKWV1PWJSmK4vTCFoBoEzIzfRuFiA/VXWIKThkCEYBowwTGSfV1+
         Tz/k4eEw755/YjLhFpPJmyy0wJTtu/rEgF3x5LKX5pGHyJrMFac1aZGsmwTOsOIELZ3p
         UlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvZtbrDBRF/tkY1XUgsUhw4qRWkNkbAOPkZ951cjMrY=;
        b=W6YvRyCAE3joQ9y4MrsWnsyPFMDUxIX99gzFHaBVVmjq13iOXiTfYHHJ86IpC99IP5
         MMd8izgq1kqmSJ95s89s7m4x06npE+uZMdIfqvttLVue0hhjGyAYEFM+tSXGjfCfNhmz
         xdQPd3rClQGgy+SvmDxBl1k+IYf7SzjyV1+2o/6iuJIhXvXfS6ma/bb2YJkI3dCXfr/r
         Hx0URate7z4kdVtAni1t2ITvKWrroUKg9bZCL0VLPgv0fx+XSSBKo4BZyn+/kecNqn6B
         /GUwvqSwZgKIThbB6/2EMDUScD5+GSHGNEk6qBpOG5tq7Z8nfH+UYTLhX/mQaQ1depjp
         vSgg==
X-Gm-Message-State: AOAM530uyH+toNioKvEl1nqewQlnzYGkTyaDg6ndUwWaBKOieC85ubDn
        2e3Gi6fTYc0o7vX/kMgUYyg=
X-Google-Smtp-Source: ABdhPJyFz12WBHR1O1mbxNk9OexI3FzHpN1/Wva0TcWoy3grLRSNmrwdSXWjYu1nP9rU1wWZ8a0Cqg==
X-Received: by 2002:a17:90a:d998:: with SMTP id d24mr46854pjv.43.1593122287530;
        Thu, 25 Jun 2020 14:58:07 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id u25sm23564827pfm.115.2020.06.25.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:58:07 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com (supporter:QLOGIC QLGE 10Gb ETHERNET
        DRIVER), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org (open list:QLOGIC QLGE 10Gb ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] staging: qlge: fix trailing */ in block comment
Date:   Fri, 26 Jun 2020 05:57:54 +0800
Message-Id: <20200625215755.70329-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625215755.70329-1-coiby.xu@gmail.com>
References: <20200625215755.70329-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trailing "*/" in block comments.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/staging/qlge/qlge_main.c |  3 ++-
 drivers/staging/qlge/qlge_mpi.c  | 10 ++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 1650de13842f..aaecf2b0f9a1 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -3244,7 +3244,8 @@ static void ql_set_irq_mask(struct ql_adapter *qdev, struct intr_context *ctx)
 		 */
 		ctx->irq_mask = (1 << qdev->rx_ring[vect].cq_id);
 		/* Add the TX ring(s) serviced by this vector
-		 * to the mask. */
+		 * to the mask.
+		 */
 		for (j = 0; j < tx_rings_per_vector; j++) {
 			ctx->irq_mask |=
 			(1 << qdev->rx_ring[qdev->rss_ring_count +
diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
index 60c08d9cc034..3bb08d290525 100644
--- a/drivers/staging/qlge/qlge_mpi.c
+++ b/drivers/staging/qlge/qlge_mpi.c
@@ -389,7 +389,8 @@ static void ql_init_fw_done(struct ql_adapter *qdev, struct mbox_params *mbcp)
  *  This can get called iteratively from the mpi_work thread
  *  when events arrive via an interrupt.
  *  It also gets called when a mailbox command is polling for
- *  it's completion. */
+ *  it's completion.
+ */
 static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
 {
 	int status;
@@ -520,7 +521,7 @@ static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	 * changed when a mailbox command is waiting
 	 * for a response and an AEN arrives and
 	 * is handled.
-	 * */
+	 */
 	mbcp->out_count = orig_count;
 	return status;
 }
@@ -555,7 +556,8 @@ static int ql_mailbox_command(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	 * here because some AEN might arrive while
 	 * we're waiting for the mailbox command to
 	 * complete. If more than 5 seconds expire we can
-	 * assume something is wrong. */
+	 * assume something is wrong.
+	 */
 	count = jiffies + HZ * MAILBOX_TIMEOUT;
 	do {
 		/* Wait for the interrupt to come in. */
@@ -1178,7 +1180,7 @@ void ql_mpi_idc_work(struct work_struct *work)
 		/* Signal the resulting link up AEN
 		 * that the frame routing and mac addr
 		 * needs to be set.
-		 * */
+		 */
 		set_bit(QL_CAM_RT_SET, &qdev->flags);
 		/* Do ACK if required */
 		if (timeout) {
--
2.27.0

