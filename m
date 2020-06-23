Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1504DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A6B2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWZ+7Xai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbgFWBFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbgFWBFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:05:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A7AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:05:00 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l63so181157oih.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CfJ8Pc9YLqJXskuETsP85RAipKzoJPI0qElzgwT8aM=;
        b=FWZ+7XaiqHMa4Q12NfmF5NoZFKlDHLyGxKbp5PLgnia7yxslU3AmjT/Tub3twO9gDe
         JZNIHOvfwVBuymSj7SQheE1ekHMULPH3JEiw9Ug/zM2w+hA/V1+smCSPt3iUx4e27jgm
         W6voYhCLJ38pJlnBoXJbyp+GYfWPxp3CTvliqZnHN4p+V5MyB2lTqlaArT+SxQXtIuLu
         OwJpyBwxTt91GO3Q4WFHfjc3lkUliqPfhidG0B829V+rvohOyDbPReA0oFBFYOpZ9x6c
         2NhQ6douaqGT2X7jkIEmK+d17RXs8fJEsFAr5f6DHJcMyusVryYdb4jRONe51aciTr7u
         TrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CfJ8Pc9YLqJXskuETsP85RAipKzoJPI0qElzgwT8aM=;
        b=rLny2s1YCFPmqkEgv9QnNXDymxpP4wb+5+ELOyLsVBd87sO7z+BWnVUSnDaU+6JJ0V
         qSa1txFCB90Z0P7f4OEmus72ZGGLkiqcjm+MTjj1tBkO0xL1rLVJ2A6Gl1mrh+VX/JiT
         lQBvJ90tniKobaqozqJbhW5krUGOjC7KxYGOIXZPPJFQ33tXj8V8ucdCNOIHy3s+6OJg
         3fHDzYYKEX4FmYGTDs5JibVNnmC/wpfGUPXlMg2SRAU261kFZqsCN3Hs+sG3BTVkF34Z
         eyaNw44OoB4l6xIAdwNdZ3PrvjqZaWiLEJoRR8JfvCpAwP4C0bqr2xvpprTPXq495LdW
         wytQ==
X-Gm-Message-State: AOAM53384qIwsVoz/yVURfE6jxyiRDmFOl4sHR4cpk8+dX5pqv8p0y7O
        gHXJPmEc+hgpmeKhC5M2Vi0=
X-Google-Smtp-Source: ABdhPJxXvXTYx0mxK9chxigSTiPWbhvGp8FLj5viZTi+p3AexRVBzIeK0hcCSQhjfng7kJbQZuiP2w==
X-Received: by 2002:aca:aa4b:: with SMTP id t72mr13734421oie.99.1592874299402;
        Mon, 22 Jun 2020 18:04:59 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id e17sm3614276oiy.21.2020.06.22.18.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 18:04:58 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mailbox: imx: Mark PM functions as __maybe_unused
Date:   Mon, 22 Jun 2020 18:04:03 -0700
Message-Id: <20200623010403.517691-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM and CONFIG_PM_SLEEP are unset, the following warnings
occur:

drivers/mailbox/imx-mailbox.c:638:12: warning: 'imx_mu_runtime_resume'
defined but not used [-Wunused-function]
  638 | static int imx_mu_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~
drivers/mailbox/imx-mailbox.c:629:12: warning: 'imx_mu_runtime_suspend'
defined but not used [-Wunused-function]
  629 | static int imx_mu_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/mailbox/imx-mailbox.c:611:12: warning: 'imx_mu_resume_noirq'
defined but not used [-Wunused-function]
  611 | static int imx_mu_resume_noirq(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~
drivers/mailbox/imx-mailbox.c:601:12: warning: 'imx_mu_suspend_noirq'
defined but not used [-Wunused-function]
  601 | static int imx_mu_suspend_noirq(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~

Mark these functions as __maybe_unused, which is the standard procedure
for PM functions.

Fixes: bb2b2624dbe2 ("mailbox: imx: Add runtime PM callback to handle MU clocks")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/mailbox/imx-mailbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 7205b825c8b5..2543c7b6948b 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -598,7 +598,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
 
-static int imx_mu_suspend_noirq(struct device *dev)
+static int __maybe_unused imx_mu_suspend_noirq(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
 
@@ -608,7 +608,7 @@ static int imx_mu_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int imx_mu_resume_noirq(struct device *dev)
+static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
 
@@ -626,7 +626,7 @@ static int imx_mu_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static int imx_mu_runtime_suspend(struct device *dev)
+static int __maybe_unused imx_mu_runtime_suspend(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
 
@@ -635,7 +635,7 @@ static int imx_mu_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int imx_mu_runtime_resume(struct device *dev)
+static int __maybe_unused imx_mu_runtime_resume(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
 	int ret;

base-commit: 27f11fea33608cbd321a97cbecfa2ef97dcc1821
-- 
2.27.0

