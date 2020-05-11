Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F66C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5236F20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCpoN1tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgEKLck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728776AbgEKLck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:32:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85B3C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f134so5509874wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=GEgujft/FvfB+35pBFaRy4JR8B5RPGb8OIs/5dvvq4Y=;
        b=mCpoN1tk/k+WFmtPHxYJ0HTmD8D0i4czRUMCFow6BNk6RPBQ1XylvcgE6e12xIgZ8L
         oxfzYvW467H/0K00nvrlkWuYXHtyCnYMusq5CR6h5ywnmIjFmFgCX8AnDCfQvyodIO2D
         /Fqzj8GRzVrU5kubJwclFh3+vnsO0mIwcpzs5iry8f7i0pQKgylxNH4t3kn6v61FjOq8
         vRCFCZmkUMYcxQGvV6+eBG2QIMJpW7ZCJCeVFKPcdfLBXLRyDuMTTlTqITD1PFs0O9sH
         fYAbfUbuPmA6uQFRbAZLPgo0hTV5DWmfvnEm2UC1RlJw42oFzgAWYqH2pRlehW80sIRu
         1dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=GEgujft/FvfB+35pBFaRy4JR8B5RPGb8OIs/5dvvq4Y=;
        b=n5KoXMSEwE7X+ZF6Lo48QlvMPVa74NNULodvB9pEDcL2MBXvMfrUmH/f/DNnkAo/Yc
         VkJX10l3M4jCsUI95YAk/H+pepiY+y8O9CyV49rgaKoqTEGxkMvueaiWvvu4faR3IjYq
         8v1nOdF2rJQKJUsJeVaSz7bZbVo3i0lDsq7iYQ2HG8wCGDEM1pbNNlsT90c1SAQ3XZwQ
         rzL981wJ8vWvay2Flk5P55FubOvBBTCs+iYSyA93D5lOi1fwcyRhTyzMWARydbI75LhL
         73HnJ5xmQSkNbu1P/QOMJ5WwajHWNFaYvqt4CfRwZYa8DlIAaFpCO+pYVkYKqY07WbyK
         ZwzA==
X-Gm-Message-State: AGi0PubRlqnTEf35kKDYfipSmUuSfxqbrHt66xFTW/U6E95bgZOswRoi
        3UFvcDn+iO1WV+Y3Wyzt4XL0ymJl
X-Google-Smtp-Source: APiQypL91Sn+3bIIst8YoHXZH9Z6LmymrZS8dwy0ouRx4xzYv6Y7sxPgdRGLhJx6uUyioJeQxmjQvA==
X-Received: by 2002:a1c:2888:: with SMTP id o130mr10859547wmo.138.1589196757799;
        Mon, 11 May 2020 04:32:37 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:36 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 01/11] habanalabs: add dedicated define for hard reset
Date:   Mon, 11 May 2020 14:32:22 +0300
Message-Id: <20200511113232.5771-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Gaudi requires longer waiting during reset due to closing of network ports.
Add this explanation to the relevant comment in the code and add a
dedicated define for this reset timeout period, instead of multiplying
another define.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c     | 5 +++--
 drivers/misc/habanalabs/habanalabs.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index c89157dafa33..f618cff9a167 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -1326,11 +1326,12 @@ void hl_device_fini(struct hl_device *hdev)
 	 * This function is competing with the reset function, so try to
 	 * take the reset atomic and if we are already in middle of reset,
 	 * wait until reset function is finished. Reset function is designed
-	 * to always finish (could take up to a few seconds in worst case).
+	 * to always finish. However, in Gaudi, because of all the network
+	 * ports, the hard reset could take between 10-30 seconds
 	 */
 
 	timeout = ktime_add_us(ktime_get(),
-				HL_PENDING_RESET_PER_SEC * 1000 * 1000 * 4);
+				HL_HARD_RESET_MAX_TIMEOUT * 1000 * 1000);
 	rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
 	while (rc) {
 		usleep_range(50, 200);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index cfb306daa8d4..d77410886a67 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -25,6 +25,8 @@
 
 #define HL_PENDING_RESET_PER_SEC	30
 
+#define HL_HARD_RESET_MAX_TIMEOUT	120
+
 #define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
 
 #define HL_HEARTBEAT_PER_USEC		5000000 /* 5 s */
-- 
2.17.1

