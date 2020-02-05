Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6401FC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C82214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XLUoY2KT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBETEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:04:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44568 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBETEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:04:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so1247233plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=am6fR46L40jLnJSE/2XocB+n60+MBKESAuM1CJxf9pA=;
        b=XLUoY2KT5ZdfwTtuUfRq9CQssvHL5pDUTYQsMdMM21EHQ/GJCGkU+JPz2Xms0HSmCy
         SmDCP2wFbE9g2QihcQLNI+nR3E+cxHylfQvkVHRmIrUoXOwEO12AVwM3cYcccfDmSMZ+
         C+J1lbCnUbgOtMLL7L7x9ZKBS9VbzzkbuZ734=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=am6fR46L40jLnJSE/2XocB+n60+MBKESAuM1CJxf9pA=;
        b=Soc66Lsm4rxBkSNDRc5Z7iTLF3f38NKUNZXv0obZeDsTMOP1IGXHBaXlVxuLSbj4bM
         YBdOCO4dpiquyggnIQrkF/WjQoALhrf21Y9QgWQDjBgfwPtw3Z50m+Hpaf39zz8xrGxz
         iW+1vzER7Q4zfYrjL6IU46aX1A5oGV2LuU8WSwwuXR/RLrsvWC3iJPVLWRE1vCFxdbC7
         4XeGS9QgegqMM72UCV7Fcl+YYnudT4M4vKQu68TIlwkSa9iclSu6xD1btVTCW9vqOc9n
         6gF2UndcsCPrGo8wMmO2j3rXU6Qez1gBvn4fciFeaQ9CTxIY4AlcTIzA5rmFjlLoVvxe
         wM/g==
X-Gm-Message-State: APjAAAUIH3qU/59eb4QdyXy9xNgBTbnPu2wh0yKqybfV2FYC9J/YdrzD
        x5pXFOSVAw6mBbenh6jXZEI7eD3K3l8=
X-Google-Smtp-Source: APXvYqwNoNSH2IAfwK6qqXpB77hQZdQMZQ4Usbc1WcGx2vILbMTceCVmsnGs7VMg833JoAFeMc/Zdg==
X-Received: by 2002:a17:90a:bd89:: with SMTP id z9mr7064549pjr.13.1580929470211;
        Wed, 05 Feb 2020 11:04:30 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:04:29 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 02/17] platform/chrome: chardev: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 10:59:57 -0800
Message-Id: <20200205190028.183069-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Chrome OS character device driver to use the newly introduced
cros_ec_cmd() function instead of cros_ec_cmd_xfer_status(), thus
avoiding message buffer set up work which is already done by the new
function.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use newer function name and parameter list.

 drivers/platform/chrome/cros_ec_chardev.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index c65e70bc168d8c..f92fe4139c4367 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -57,25 +57,20 @@ static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
 		"unknown", "read-only", "read-write", "invalid",
 	};
 	struct ec_response_get_version *resp;
-	struct cros_ec_command *msg;
 	int ret;
 
-	msg = kzalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
-	if (!msg)
+	resp = kzalloc(sizeof(*resp), GFP_KERNEL);
+	if (!resp)
 		return -ENOMEM;
 
-	msg->command = EC_CMD_GET_VERSION + ec->cmd_offset;
-	msg->insize = sizeof(*resp);
-
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	ret = cros_ec_cmd(ec->ec_dev, 0, ec->cmd_offset + EC_CMD_GET_VERSION,
+			  NULL, 0, resp, sizeof(*resp), NULL);
 	if (ret < 0) {
 		snprintf(str, maxlen,
-			 "Unknown EC version, returned error: %d\n",
-			 msg->result);
+			 "Unknown EC version, returned error: %d\n", ret);
 		goto exit;
 	}
 
-	resp = (struct ec_response_get_version *)msg->data;
 	if (resp->current_image >= ARRAY_SIZE(current_image_name))
 		resp->current_image = 3; /* invalid */
 
@@ -85,7 +80,7 @@ static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
 
 	ret = 0;
 exit:
-	kfree(msg);
+	kfree(resp);
 	return ret;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

