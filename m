Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6697BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FD0208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZbIN+JQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbgF2V1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgF2Smo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47258C030F07
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:13:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so3240859pfq.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxKoXEPuBlTQyUvZurMXJpDKgGIiS8L+c8IX0bHvw0I=;
        b=ZbIN+JQ//n3EjgqTOkxX8ekliUEAwjrDiPxXO8sdYMv3PjsHgAP1nHlnBoXEVQUQo+
         6yx/lX1lGZmAt5N4ds9sj0kru9/aQaEzthHpzQWl7eAn49ZkUvpOItVzAIn954A1VV9b
         BpATBvCE9AahTLjS0sYbh7C3vxW2VdR8SCeOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxKoXEPuBlTQyUvZurMXJpDKgGIiS8L+c8IX0bHvw0I=;
        b=JxKyGgV/EBD8hCIBPjA+RzF8V3/1IsU+fJZLN4HqCB7Q0LGZBaZlwJIruiDkXdlSZN
         zf5tvi/i3MmlAXQWphzNGJ9ra4N/JA2Xkn49qaqcZKFDDD3Go7IUu9ApNgrByB/WR8CL
         Z2VJxUhyGHNYWcsLp9+5VXjy88CL1ZL7LWr1bGgg6FxGRG5WMd3iEmr4FxnI84IyDXQA
         A6p3MXHY5BxRNE0wxqHUToDENK0IS8ZR/V7Ti92V/10dwJwoSQabOAF+rChOSL8SEKYF
         boBwBmL5rZ+UxhQ3cVvPWiRUxyW6wRQ7Pue5/GW9ke4qP1d36oK9xER7ztSz7L+wrJ8u
         BFWg==
X-Gm-Message-State: AOAM531XdqrMpJjv2dV9HbH0R/T53ynifUqiauLH4YBnN0fhCotGoZUA
        0HdTX1bDJE3uQ4FQQPxHVnM4IQwAb/U=
X-Google-Smtp-Source: ABdhPJywueBWqoLIhuqMQ7cBJU/+OGOIL8B8/25cx6FoSvyPEwkSCIAK1vwBSUZrloSGjTfbYI58gw==
X-Received: by 2002:a63:bf04:: with SMTP id v4mr11418563pgf.212.1593447232551;
        Mon, 29 Jun 2020 09:13:52 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id d5sm188462pfa.71.2020.06.29.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:13:52 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add PM support
Date:   Mon, 29 Jun 2020 09:13:34 -0700
Message-Id: <20200629161333.2110327-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200629161333.2110327-1-pmalani@chromium.org>
References: <20200629161333.2110327-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define basic suspend resume functions for cros-ec-typec. On suspend, we
simply ensure that any pending port update work is completed, and on
resume, we re-poll the port state to account for any
changes/disconnections that might have occurred during suspend.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Remove #ifdef-ery, add __maybe_unused tag to functions.

 drivers/platform/chrome/cros_ec_typec.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 630170fb2cbe..b2e7e928e788 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -725,11 +725,37 @@ static int cros_typec_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused cros_typec_suspend(struct device *dev)
+{
+	struct cros_typec_data *typec = dev_get_drvdata(dev);
+
+	cancel_work_sync(&typec->port_work);
+
+	return 0;
+}
+
+static int __maybe_unused cros_typec_resume(struct device *dev)
+{
+	struct cros_typec_data *typec = dev_get_drvdata(dev);
+
+	/* Refresh port state. */
+	schedule_work(&typec->port_work);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cros_typec_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
+};
+
+#define DEV_PM_OPS	(&cros_typec_pm_ops)
+
 static struct platform_driver cros_typec_driver = {
 	.driver	= {
 		.name = DRV_NAME,
 		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
 		.of_match_table = of_match_ptr(cros_typec_of_match),
+		.pm = DEV_PM_OPS,
 	},
 	.probe = cros_typec_probe,
 };
-- 
2.27.0.212.ge8ba1cc988-goog

