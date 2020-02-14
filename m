Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D7AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666820873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T435wpmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgBNI07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:26:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36209 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:26:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so3467042plm.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3bmgmETZeBo0EFsBeEB+TZ0Z824p4H/W8k7nEd9ZXs=;
        b=T435wpmqpKgEEgCx+n7GAU+TvalD+G4SMWspDq7b/zaFvbaJ4EEEf84Gy8W7tlU6dl
         P+vN2AJGX+WeV9DaXg7M7z5nMOjCN1qGwQA4AWd/ymOT++fwNS73IDXyMBSqvHeG0ci/
         CKZDxPT+pRzVeFR5Ffx/WTVORhvpOKPnzYAB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3bmgmETZeBo0EFsBeEB+TZ0Z824p4H/W8k7nEd9ZXs=;
        b=Rbj70fd8GV6mx52JeIA0dF55oCuuETPQIJltCq9GyYG4O8EoqDEto5bNxgFtOD8eny
         IwhUkKttfbX4h+Es0zLXERM1PJrRXznuFdjtJ5BCnSeL7mFUOEjD3LINgM/ajh34CxPl
         cVZTQB9Arg5fi9doHwT87yMsSfzslbeTeUj7EVMgxfLhdeMJ5gskPi8DYe1VeBUVQU/j
         fm5aa3Yze28sZeWEEcWRDg1IxQpVUR8btJnFprE0FqH1PgftaCY/AWuo4IMuslw2IkF5
         pJTzPJIPp+Klbe3NHo3w6PV5JKp3kJzMmwX+FPk5n0ERZ99+GUggmyC0vF4WzyLGfUNc
         t61A==
X-Gm-Message-State: APjAAAUow+RAV9mMR4P/Pfmw/fXcA/qhakxRBv6fu/M6LZ7Iki79XR5R
        iUQw66lZ682i96RnzSGrpbH+KQ==
X-Google-Smtp-Source: APXvYqxtDnbwml1lyXGkAcwF6Scgzl+O7vHDyP1TEI1ielXLKvIJVi2YaPyG7IHpF3qFQskNsH1ygg==
X-Received: by 2002:a17:90a:5801:: with SMTP id h1mr2164293pji.121.1581668817956;
        Fri, 14 Feb 2020 00:26:57 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id m12sm5125622pjf.25.2020.02.14.00.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:26:57 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] platform/chrome: cros_ec_rpmsg: Fix race with host event.
Date:   Fri, 14 Feb 2020 16:26:38 +0800
Message-Id: <20200214082638.92070-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host event can be sent by remoteproc by any time, and
cros_ec_rpmsg_callback would be called after cros_ec_rpmsg_create_ept.
But the cros_ec_device is initialized after that, which cause host event
handler to use cros_ec_device that are not initialized properly yet.

Fix this by don't schedule host event handler before cros_ec_register
returns. Instead, remember that we have a pending host event, and
schedule host event handler after cros_ec_register.

Fixes: 71cddb7097e2 ("platform/chrome: cros_ec_rpmsg: Fix race with host command when probe failed.")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/platform/chrome/cros_ec_rpmsg.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index dbc3f5523b83..7e8629e3db74 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -44,6 +44,8 @@ struct cros_ec_rpmsg {
 	struct completion xfer_ack;
 	struct work_struct host_event_work;
 	struct rpmsg_endpoint *ept;
+	bool has_pending_host_event;
+	bool probe_done;
 };
 
 /**
@@ -177,7 +179,14 @@ static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 		memcpy(ec_dev->din, resp->data, len);
 		complete(&ec_rpmsg->xfer_ack);
 	} else if (resp->type == HOST_EVENT_MARK) {
-		schedule_work(&ec_rpmsg->host_event_work);
+		/*
+		 * If the host event is sent before cros_ec_register is
+		 * finished, queue the host event.
+		 */
+		if (ec_rpmsg->probe_done)
+			schedule_work(&ec_rpmsg->host_event_work);
+		else
+			ec_rpmsg->has_pending_host_event = true;
 	} else {
 		dev_warn(ec_dev->dev, "rpmsg received invalid type = %d",
 			 resp->type);
@@ -240,6 +249,11 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
 		return ret;
 	}
 
+	ec_rpmsg->probe_done = true;
+
+	if (ec_rpmsg->has_pending_host_event)
+		schedule_work(&ec_rpmsg->host_event_work);
+
 	return 0;
 }
 

base-commit: b19e8c68470385dd2c5440876591fddb02c8c402
-- 
2.25.0.265.gbab2e86ba0-goog

