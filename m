Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44EB02076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1Ko7NJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHLKSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLKSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:18:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8003C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 03:18:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so1402086wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5qhRi6Ox3xbNvhyYFyZsql4fq6abhJftdxIw5uDwWI4=;
        b=q1Ko7NJ4418WiyeFsOI7FRGkohua0ug4zGBElZayGr8uChRBlNYt5BGxQRWTz7Khdi
         fXBL77j7mCTTTq5ml7tqZH0Yx3yn3WpA1A/FbdVTN87+XjRQVD1Y2ua1IhicQIr7SQyf
         qWdQKjikI45nnTGv9ZtvMabibKHs0D/mAhj1wHLVQNabEVlp9YXInKxnhHxDzruD0/Zc
         nV5tXaJBEUtEcbnUTDHbCBjBuAPMHJZl9bN7nuGDxBJpoVZJIDAowZr8/4e9HGtLN74a
         9E+2wP6RO4JBPmAcgS2Oi1GdesqcABXcaEGo+mWgtlVRuMGOcUx5kgQt4O/iXQtw3iH1
         fV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5qhRi6Ox3xbNvhyYFyZsql4fq6abhJftdxIw5uDwWI4=;
        b=PbivU8yM/M5kv6WbqfB/lLQHb94HIA4VUWIbDdxufxidPLgtW2Kehmz5qyQ4SxCUY4
         2wYeXvDqFAZlU539fPHlDgJ2kSxhWnvpbMeLcj/nGw9l1WBARbRK+iIUZ+cDtVvIjJFI
         tV4awcZA43jPMLrUcoJL3z8IwynNIkktcYaf8ruHRihQ1ZcrH8wBdeTaseXgbZMRNe7D
         IkMBM023HPHYlbGP0RTotuZLLhLRcRjvYmJm44ad+j19PmG9crjlg21dlt7F4rC6Dg6Z
         sR5xPQdy04UCNESXUGJvN2eyHRLJZ36+7gUifvR4YexE9S4wTqOh023MpFtqBPqvXAjg
         ag+w==
X-Gm-Message-State: AOAM530wFzHvy6Rchw/biBlOEMR3UJdBwxOSgssrG7Hs+eO884PDjk3t
        cJZe7rqiDiErEHHbOKb5rmaTdHJW
X-Google-Smtp-Source: ABdhPJyxR+0HUH1wvYeFkl24KVzTCz+wVMuOhIpvfaR8hqq4LqGCCisJYmZW1sBU0R50cHJ29aPlFw==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr7793239wmc.109.1597227523709;
        Wed, 12 Aug 2020 03:18:43 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id w64sm3429714wmb.26.2020.08.12.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 03:18:42 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/3] habanalabs: validate FW file size
Date:   Wed, 12 Aug 2020 13:18:37 +0300
Message-Id: <20200812101839.31233-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We must validate FW size in order not to corrupt memory in case
a malicious FW file will be present in system.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/firmware_if.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index f70302cdab1b..419e9c33dd5e 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -13,6 +13,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/slab.h>
 
+#define FW_FILE_MAX_SIZE	0x1400000 /* maximum size of 20MB */
 /**
  * hl_fw_load_fw_to_device() - Load F/W code to device's memory.
  *
@@ -48,6 +49,14 @@ int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 
 	dev_dbg(hdev->dev, "%s firmware size == %zu\n", fw_name, fw_size);
 
+	if (fw_size > FW_FILE_MAX_SIZE) {
+		dev_err(hdev->dev,
+			"FW file size %lu exceeds maximum of %u bytes\n",
+			fw_size, FW_FILE_MAX_SIZE);
+		rc = -EINVAL;
+		goto out;
+	}
+
 	fw_data = (const u64 *) fw->data;
 
 	memcpy_toio(dst, fw_data, fw_size);
-- 
2.17.1

