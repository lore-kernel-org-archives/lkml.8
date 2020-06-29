Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA2CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98902083E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bO3ONsX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgF2THu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgF2THm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:07:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E56DC030F2A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:39:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d6so8256526pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQm9k3QD0fOYn01ydGN/ugkrIz4gUsIQA2Gtlz9ae7I=;
        b=bO3ONsX+3iGctW2inZ47Wqs9ZZv05POvU+r5G58J2J9LTLymRmNXHznvKTUP2GMQan
         Rfr3P4nrWcmum4eD1X7htUPtPI8DRP30iJI9z/4k5X02qKxhZUY00uzvkjqs187NT162
         mvUZE3WWSoq+BN80zlmKoJeeTgtLzA368MTFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQm9k3QD0fOYn01ydGN/ugkrIz4gUsIQA2Gtlz9ae7I=;
        b=OcTPWAPBp47x/C6+ld2Pac1wbeGt7olhMES6C12kf2bjKZvcdhsRZK65rc2G5fGPV/
         sQc/6NExflK2FcOV9G5uicG2P18/MPNOkgWsJXCEjcYxSdqY8MubZBrP2iCzw6wrUsWo
         VDqeqEfFjG+rGA3h5kXqpFZOTfWKksETQ8NZ+1W5nrrtHfS77nO73i+hpEqQocr2vd2L
         5dv2zaD+Vw4PHtOKFG+fcSFKsEac96KQBOSN6ELfgwEEjmFYHp55RwjT+f4bvlFVVSXx
         ePSoejPs0HKDCxXrn0jjL3WqeIIA+0Hgak3Ho5FwUgPcmz+HEVfoVViBd+Rv418gc724
         ntSA==
X-Gm-Message-State: AOAM530ZaIbOazanMKYRZHMoNmW/wq3Nj6pvZ3r+pEe37bO5o28R31lu
        49P5MVfcH4P3ety2heMnx19gEq6jLdg=
X-Google-Smtp-Source: ABdhPJylRt8boVH4iQcwk+v7TEPvKAJKV/4fgP9gbOjcDa4aaign8K0BU9D5DsISGrDpRvkqIEDj+A==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr90418pjy.175.1593448759530;
        Mon, 29 Jun 2020 09:39:19 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s6sm79060pfd.20.2020.06.29.09.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:39:19 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 2/2] platform/chrome: cros_ec_typec: Add PM support
Date:   Mon, 29 Jun 2020 09:38:52 -0700
Message-Id: <20200629163851.2130450-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200629163851.2130450-1-pmalani@chromium.org>
References: <20200629163851.2130450-1-pmalani@chromium.org>
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

Changes in v3:
- Remove superfluous DEV_PM_OPS #define.

Changes in v2:
- Remove #ifdef-ery, add __maybe_unused tag to functions.

 drivers/platform/chrome/cros_ec_typec.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0beb62bf5adf..d5ac691de68b 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -722,11 +722,35 @@ static int cros_typec_probe(struct platform_device *pdev)
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
 static struct platform_driver cros_typec_driver = {
 	.driver	= {
 		.name = DRV_NAME,
 		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
 		.of_match_table = of_match_ptr(cros_typec_of_match),
+		.pm = &cros_typec_pm_ops,
 	},
 	.probe = cros_typec_probe,
 };
-- 
2.27.0.212.ge8ba1cc988-goog

