Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1208AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37E0207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HazYeEzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgHUBDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:03:41 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:55920 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgHUBDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:03:41 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 9C2BE30C016;
        Thu, 20 Aug 2020 18:01:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 9C2BE30C016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1597971664;
        bh=gfV9uR728yHTYUxg7H5ULAzW8rEUVFV045F+OHaYPqQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HazYeEzKIGHdcBMStV0QAJpJ20cR1oqFarwW88uBZ3id4PtnGXyXZvPmW/LWkaddu
         TPIzdRAx9W0Db4XCVEUFJH5SXrhH38bfDK+IJdOPr46EfJLrAbU/UsEAjAMnjIsnkM
         rtvGP7HrXL92HHD2EOXPxEYsMerocf4crc9/r/S4=
Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id BA7B214008B;
        Thu, 20 Aug 2020 18:03:38 -0700 (PDT)
From:   Markus Mayer <markus.mayer@broadcom.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Markus Mayer <markus.mayer@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] memory: brcmstb_dpfe: fix array index out of bounds
Date:   Thu, 20 Aug 2020 18:03:33 -0700
Message-Id: <20200821010333.20436-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would overrun the error_text array if we hit a TIMEOUT condition,
because we were using the error code "ETIMEDOUT" (which is 110) as an
array index.

We fix the problem by correcting the array index and by providing a
function to retrieve error messages rather than accessing the array
directly. The function includes a bounds check that prevents the array
from being overrun.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

This patch was prepared in response to https://lkml.org/lkml/2020/8/18/505.

 drivers/memory/brcmstb_dpfe.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 81abc4a98a27..a986a849f58e 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -190,11 +190,6 @@ struct brcmstb_dpfe_priv {
 	struct mutex lock;
 };
 
-static const char * const error_text[] = {
-	"Success", "Header code incorrect", "Unknown command or argument",
-	"Incorrect checksum", "Malformed command", "Timed out",
-};
-
 /*
  * Forward declaration of our sysfs attribute functions, so we can declare the
  * attribute data structures early.
@@ -307,6 +302,20 @@ static const struct dpfe_api dpfe_api_v3 = {
 	},
 };
 
+static const char * const get_error_text(unsigned int i)
+{
+	static const char * const error_text[] = {
+		"Success", "Header code incorrect",
+		"Unknown command or argument", "Incorrect checksum",
+		"Malformed command", "Timed out", "Unknown error",
+	};
+
+	if (unlikely(i >= ARRAY_SIZE(error_text)))
+		i = ARRAY_SIZE(error_text) - 1;
+
+	return error_text[i];
+}
+
 static bool is_dcpu_enabled(struct brcmstb_dpfe_priv *priv)
 {
 	u32 val;
@@ -446,7 +455,7 @@ static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
 	}
 	if (resp != 0) {
 		mutex_unlock(&priv->lock);
-		return -ETIMEDOUT;
+		return -ffs(DCPU_RET_ERR_TIMEDOUT);
 	}
 
 	/* Compute checksum over the message */
@@ -695,7 +704,7 @@ static ssize_t generic_show(unsigned int command, u32 response[],
 
 	ret = __send_command(priv, command, response);
 	if (ret < 0)
-		return sprintf(buf, "ERROR: %s\n", error_text[-ret]);
+		return sprintf(buf, "ERROR: %s\n", get_error_text(-ret));
 
 	return 0;
 }
-- 
2.17.1

