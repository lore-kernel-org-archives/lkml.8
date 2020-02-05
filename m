Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCD7C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6152B22527
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oMayZTRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBETF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:05:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39220 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBETF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:05:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so1400327pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/+l2VZUrV5Qwvr/mwaqtpe39jAW0eY4hdEX/zwn5x4=;
        b=oMayZTRwuvAF18x8VHGU+FkRVVQazEiVz6138R6ecuoN8gke/bAE5rYO/3eG3FNmMV
         xCSvx17yStvz2wwTicSszIEiW6plnIlT2HdvzVRxtPRpg/PWxmvOX9TXDxosk3cC+dTu
         8nURu6GYq4jhb/XwnHiq7Wq94uUWKb6xJrn6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/+l2VZUrV5Qwvr/mwaqtpe39jAW0eY4hdEX/zwn5x4=;
        b=IW8cpJknTXGGdXiGxVOgd/k7O3lJY1gtqJdttPy04cBeEsI5K1T3oWiAaKfrHXI+2F
         TwbiQLVItMOnNzNvdmWoBrP5O0Gyc5jBOLCQu44wwrThr5ms1rBHbyjEIcNKKO56M1rN
         DelRelsxhItFy6x2F4od60eB7TfpmgKSAmidmlqNIqmu+lPXPRQaQa5v/FwVYJ/YJVa3
         eT4cDi/ADO0kWsy4PQq4M7574MH1QMDqT7rI6b3iUDC7hJYD3ObVLmT8RY3t4bE3fhDI
         dqXSSaKUIaI3NV4Mq0AN+doQ7K73Nxzbmg2S/GckFuNyWmcM5U1Cr1oJA+GSJ2qjmwKO
         hkDw==
X-Gm-Message-State: APjAAAVZ5k1SQV7EczicSNKZoFMAby9vEILhtXQ3mRxgocGxnE+ippU8
        w55T19Vr+ypROD4+W9lEGZPi0yP2Fxc=
X-Google-Smtp-Source: APXvYqzIVWhhSDFGWOfKT8zIo1ZEPcDB7Tx4NHxSoFZAlaV4ccxqX9uwKM9bA3mNxUnSTiXoyoRfww==
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr35514102pln.178.1580929556983;
        Wed, 05 Feb 2020 11:05:56 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:05:56 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 04/17] platform/chrome: usbpd_logger: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:01 -0800
Message-Id: <20200205190028.183069-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the earlier call of cros_ec_cmd_xfer_status() to
cros_ec_cmd() which does the buffer setup and message allocation.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/platform/chrome/cros_usbpd_logger.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 7de3ea75ef46eb..084b6d4b692128 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -61,19 +61,15 @@ static int append_str(char *buf, int pos, const char *fmt, ...)
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
+	ret = cros_ec_cmd(ec_dev->ec_dev, 0,
+			  ec_dev->cmd_offset + EC_CMD_PD_GET_LOG_ENTRY, NULL, 0,
+			  logger->ec_buffer, CROS_USBPD_LOG_RESP_SIZE, NULL);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	return (struct ec_response_pd_log *)msg->data;
+	return (struct ec_response_pd_log *)logger->ec_buffer;
 }
 
 static void cros_usbpd_print_log_entry(struct ec_response_pd_log *r,
-- 
2.25.0.341.g760bfbb309-goog

