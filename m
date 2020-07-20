Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4632FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C662065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgGTDn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:43:59 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:33994 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgGTDn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:43:59 -0400
X-QQ-mid: bizesmtp9t1595216603t3onmsz3u
Received: from xr-hulk-k8s-node1933.gh.sankuai (unknown [101.236.11.3])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Jul 2020 11:43:19 +0800 (CST)
X-QQ-SSF: 01100000002000E0ZJ10000A0000000
X-QQ-FEAT: 4yulX1Vb0J3hDzZoCD6i6EfQxAGUUkZSS/SmHM2vIOrZ6/kG7/90xoT067wrk
        UjRBng8c5DbhMFXeyLcNxk/+TykLA5L7cBepqoW1O1lBiZTyO8T8ZM9Gk6LMNtU1SMGG1P5
        rWUSynvZPSEUvS1j3yC/EXJKHUhF2uORFrPNW2miyDrIpTgvYl1rTf1KaOtFWH6c7CL4ta6
        z8xxeDoOZfJR1ZdhfTjAoCsXlt5/B6BUSPAt3ZnYCffWe1O3uxo/tLM8RAB9aiDR2sC+2bA
        S1FWx5v8eJUpZYs7mfwhnpeOS/P8Ukpvk2dwXu3yzR25/98k0j25ZeNYA=
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] xarray: update document for error space returned by xarray normal API
Date:   Mon, 20 Jul 2020 11:43:19 +0800
Message-Id: <1595216599-45197-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current xarray code, the negative value -1 and -4095 represented
as an error.

xa_is_error(xa_mk_internal(-4095)) and xa_is_error(xa_mk_internal(-1))
are all return true.

This patch update the document.

Signed-off-by: Wang Long <w@laoqinren.net>
---
 include/linux/xarray.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index b4d70e7..0588fb9 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -36,7 +36,7 @@
  * 257: Zero entry
  *
  * Errors are also represented as internal entries, but use the negative
- * space (-4094 to -2).  They're never stored in the slots array; only
+ * space (-4095 to -1).  They're never stored in the slots array; only
  * returned by the normal API.
  */
 
-- 
1.8.3.1




