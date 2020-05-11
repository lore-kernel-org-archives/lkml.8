Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D0BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D429420720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tMMXsDjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgEKS1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:27:11 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:22994 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729673AbgEKS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:27:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589221630; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4tojzUk0+KKF9I2AVQ6mA8PuzXqs6EPae9bRmzGTpvM=; b=tMMXsDjtJPf1qw9W/X9X31rzdIfbDfCBGcfk66jaZuhiGKJgg4Zq2O746+tFXAH6wlRTZZFq
 7VIQTtQBKI49IztMsHJS1Q5HfFbUjHEJjR2fUx8V4fiaqrlxm/yZCYF42QEgtxjkx7cXuWRf
 Scc40x6HgHnpZIq/F5DrMosEEo4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb998fb.7f3f934a2458-smtp-out-n01;
 Mon, 11 May 2020 18:27:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D76E2C432C2; Mon, 11 May 2020 18:27:06 +0000 (UTC)
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B77DC433F2;
        Mon, 11 May 2020 18:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B77DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Jason Baron <jbaron@akamai.com>, Joe Perches <joe@perches.com>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "dynamic_debug: Remove unnecessary __used"
Date:   Mon, 11 May 2020 11:26:58 -0700
Message-Id: <1589221618-21808-1-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c0d2af637863940b1a4fb208224ca7acb905c39f.

Some compilers[1] may break dynamic_hex_dump by optimizing the
DYNAMIC_DEBUG_BRANCH check inside __dynamic_func_call_no_desc and completely
removing the dynamic debug metadata. Thus, there is no dynamic_debug control
site to enable or disable. The if condition is optimized away based on the
initial value of flags (i.e. if DEBUG macro is present).

[1]: This behavior is present on [aarch64-gnu-linux-gcc (Ubuntu/Linaro
5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609] and [Android Common Kernel
toolchain: "Android (6051079 based on r370808) clang version
10.0.1"] using arm64 default defconfig + DYNAMIC_DEBUG enabled.

Change-Id: I28e9b86088eee5d5ed2384fbcea2ac2e7337a559
Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 include/linux/dynamic_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index abcd5fd..7518db4f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -79,7 +79,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
-	static struct _ddebug  __aligned(8)			\
+	static struct _ddebug __used __aligned(8)		\
 	__attribute__((section("__verbose"))) name = {		\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
