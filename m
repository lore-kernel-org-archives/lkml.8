Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CB6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC10820708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T6qJhWJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgA3UdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34338 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgA3UdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so2094488pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJYisW8YElxmBY5tsNphXNjlMMt9yY3f6zbpMQ9CmDc=;
        b=T6qJhWJNCqsdMfChbJhoNcYa3S09Q11hX7v8A2q+4sdC2uGD3W70LMhz6qoD2y9jGT
         dkJG0VVA/Eab5KsEzZhrFwimaR/bULoIOfWv9xueMPQe4nbsfq9sLop9RJ3t35RooHrD
         JHYkIfgDGKKZphrUdY71INQCfru1VOxnKdfK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJYisW8YElxmBY5tsNphXNjlMMt9yY3f6zbpMQ9CmDc=;
        b=Or/YlBP+hVnThcip3HUFh9RCqmFjj/71sL8sq5XrLT+knSEp5RnNOSd16OD7mCtE+W
         RVKaoQCuHbfV9FmsUMhBPMjB/zP0YVCsQn080lH//lkI6BMOuu5om5pqLanjZdu76RxK
         Maym3aMiKJ9C8aNY8ILbBM5yfAExke8IQVB7RhoizmMbu8NWQGFuhRWfmfnUwFDFhBSe
         E1klvBZqRiTMSxr75iV0gP05wcxVeZdl4wGikGi6c++T4EsukYmJoF1IoLSaOIPvoWwg
         rBEGjB4SXcQ0hABEDPLIXoeFk/IheEkixqZdsf4mtOLQZ745IwxwxWzuytVsJjpZfxh0
         azdw==
X-Gm-Message-State: APjAAAUZAGYtM9uz9eDRn8EL5AX0nPc9c8DmO7S6k5qfzovhu/f7wrNR
        YwFlgNQxJPYj/eVYvnHJn6B0ROe/z30=
X-Google-Smtp-Source: APXvYqzT9tZQCkCIfPPVJ2fb2z2kJfUdUtEnnpsmHD2u6hFyrX2HidqDLFTJFVRg1b4/KtdyKeJisw==
X-Received: by 2002:a62:5547:: with SMTP id j68mr7024038pfb.6.1580416393069;
        Thu, 30 Jan 2020 12:33:13 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:12 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 04/17] platform/chrome: usbpd_logger: Use cmd_send_msg()
Date:   Thu, 30 Jan 2020 12:30:40 -0800
Message-Id: <20200130203106.201894-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the earlier call of cros_ec_cmd_xfer_status() to
cros_ec_send_cmd_msg() which does the buffer setup and message
allocation.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_usbpd_logger.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 374cdd1e868ac1..356bc2fe068466 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -62,19 +62,16 @@ static int append_str(char *buf, int pos, const char *fmt, ...)
 static struct ec_response_pd_log *ec_get_log_entry(struct logger_data *logger)
 {
 	struct cros_ec_dev *ec_dev = logger->ec_dev;
-	struct cros_ec_command *msg;
 	int ret;
 
-	msg = (struct cros_ec_command *)logger->ec_buffer;
-
-	msg->command = ec_dev->cmd_offset + EC_CMD_PD_GET_LOG_ENTRY;
-	msg->insize = CROS_USBPD_LOG_RESP_SIZE;
-
-	ret = cros_ec_cmd_xfer_status(ec_dev->ec_dev, msg);
+	ret = cros_ec_send_cmd_msg(ec_dev->ec_dev, 0,
+				   ec_dev->cmd_offset + EC_CMD_PD_GET_LOG_ENTRY,
+				   NULL, 0,
+				   logger->ec_buffer, CROS_USBPD_LOG_RESP_SIZE);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	return (struct ec_response_pd_log *)msg->data;
+	return (struct ec_response_pd_log *)logger->ec_buffer;
 }
 
 static void cros_usbpd_print_log_entry(struct ec_response_pd_log *r,
-- 
2.25.0.341.g760bfbb309-goog

