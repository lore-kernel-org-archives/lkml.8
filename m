Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68599C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A5420708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MHQx52ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgA3Ucj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:32:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39372 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgA3Uci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:32:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id 84so2076183pfy.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJ+DRNvHZTTPVkJjzrZHokarbI9A0YTamLP4Fwgv7d0=;
        b=MHQx52fflYvXgTMEO0JWgOd3LgLWCtCbvdorGKIx8SkW8VpAlsVEO1aFiCSrlU6icA
         g+poDvXo9nFKW5XtLOyFe4ncL1B5RngOrb+A8Q7ExNekRE6v1CdjONN6S8L+5HZ3fYVb
         vMY3kV7H1poBYJCzetRKNrocb79goQjh3JO/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJ+DRNvHZTTPVkJjzrZHokarbI9A0YTamLP4Fwgv7d0=;
        b=Q2Owa7Xl8tP33jTT62rIKLoC73Fxcng2vyri3yyHcjDrTGqffTuM1UU04YxHf0/ATh
         E8bXa49tC1/FlQz9eNxrtlnkIJfJ0pb8DfRaSM/SzMj0dSfCmvO1ZAsM5DbcP+CuUxUn
         wVAZ3p9k3tXeokj13uoFAs8eSxKYol7adKldE/NGQJ/R4vumfPz4g4awpEvxksWjDbBw
         8NQYv9DErx24LomJz3UJ1/yH4DtUEwpGgSEDhRw62OCC/Fa/8GJpGNFtd+BiP2yQ73nj
         GevRvgVWFMfV99/m2AMuVDZKhyH6CJqVj/lrnkD0LhRnQbjWWVSrHpsR7a6FnZY+gljm
         wUtg==
X-Gm-Message-State: APjAAAVW6N1NJ1be/iWIvbqjp42Ph7oNGzfLiFH3qMG2RvFJsXqE3vl4
        j267no3FcPuqVlJBRulzsz+LbHaZLqEPaA==
X-Google-Smtp-Source: APXvYqy3J/RjqUiINGjx6E9bPIqW1OaS2zMZYVASzwA3489PtFs6E+HKjTT6r9WW+UJalp2I/FpLyA==
X-Received: by 2002:a62:cd8f:: with SMTP id o137mr7107906pfg.254.1580416357905;
        Thu, 30 Jan 2020 12:32:37 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:32:37 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 02/17] platform/chrome: chardev: Use send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:30:35 -0800
Message-Id: <20200130203106.201894-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Chrome OS character device driver to use the newly introduced
cros_ec_send_cmd_msg() function instead of cros_ec_cmd_xfer_status(),
thus avoiding message buffer set up work which is already done by the
new function.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_chardev.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index 74ded441bb5006..f8136addb8b3f7 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -58,25 +58,21 @@ static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
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
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 0,
+				   ec->cmd_offset + EC_CMD_GET_VERSION, NULL, 0,
+				   resp, sizeof(*resp));
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
 
@@ -86,7 +82,7 @@ static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
 
 	ret = 0;
 exit:
-	kfree(msg);
+	kfree(resp);
 	return ret;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

