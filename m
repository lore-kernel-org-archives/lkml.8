Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDF1C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2F320732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tl6H29o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCWHHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:07:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36269 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgCWHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:07:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so13426528wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 00:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6+H3L1N6B9JwGgT4kGhTvyXOoPuS69y5RAhMF6/3IAY=;
        b=Tl6H29o84KzodraSj/8Lu6j8G6gU1mywLmC42YDgg7lakLlWht51bOWK5K+Bxjuj1E
         /hTufsQ9PX041U6vgoUdezqK+vKU26qDC3PYidkJBfxoCQt8PgmTyrqMS2us6BLLRr12
         QP4D03g3s1ajzwNoPYVwIlW1x3fApRy4/4aDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6+H3L1N6B9JwGgT4kGhTvyXOoPuS69y5RAhMF6/3IAY=;
        b=Pgxw170mn1NvHQuTMQsULewWNH8zQsv7SUTyySbVT4doSlYrhBlhTDWBHInTGBfnJx
         idA5jN23xT+Da7wx8uOkw27nk6LafJzd3K/NioPJcmO7pJ6PpPF67S84ykT/K9dg/GzR
         t69peWHMn+Tb+JiXlH3NV10zzmqa0SYOZSQK8DNa92ulN3ApiA2rR0rgOYUlNa3kzN/+
         0QUmH3ABwjObIbuy7rk7SGxD0w26c3lTSiuKVSpD6DVitkssZKtI9jqlTc93+ed7pKOR
         ERwxXvdRQWcloJrMCl7H0wkzj2Z3T1TINccKqaO0bvxfYRCPZh+mBwQBAcJTRt1OgXvk
         sU+w==
X-Gm-Message-State: ANhLgQ2nwg7+f+zSKrbuCN2fGzqxC8qXVk7LhQeyOp5VWzuY8GPwvgvy
        o8yWiLdQvNEWP/kZL56FX2dYUA==
X-Google-Smtp-Source: ADFU+vsSfC3Hj17Pt53rFgFvGSwfbnAEXfthhJMgt21/X54FlXdpmHewhUklckSBnoNd8YyT/0vtvA==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr11287399wmi.169.1584947233631;
        Mon, 23 Mar 2020 00:07:13 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n1sm22144380wrj.77.2020.03.23.00.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 00:07:13 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 1/1] firmware: tee_bnxt: remove unused variable assignment
Date:   Mon, 23 Mar 2020 12:37:01 +0530
Message-Id: <20200323070701.17078-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable assignment.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
Changes from v1:
-Address code review comments from Sergei Shtylyov,
 correct the commit message and subject line.

 drivers/firmware/broadcom/tee_bnxt_fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index ed10da5313e8..6fd62657e35f 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -143,8 +143,6 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
 	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
 
 	while (rbytes)  {
-		nbytes = rbytes;
-
 		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
 
 		/* Fill additional invoke cmd params */
-- 
2.17.1

