Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A413C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0359B20702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Na8jhfRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHUQz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:55:58 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:39806 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728644AbgHUQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:52:39 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 3386A30C193;
        Fri, 21 Aug 2020 09:49:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 3386A30C193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1598028596;
        bh=1N277qLlwPe3wO79G1bB+4oXclXO8d32DbZS3HyRadQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Na8jhfRpR8y7lbNjf/dOMgpbj+FQLlA1dRc4fIZ+D0+31C9SQvuEbj1prGbmHy/qx
         sTfb5MFF9KTPXm9U58ayVkcd0V4rkHJfkmgPOUJE8uZ/RbcngSR/H8FMG+XZODwRuW
         7M9RXa5z4lFxHhdCsw1O2iAOXrcVFhOvWY52B85U=
Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id E31A214008D;
        Fri, 21 Aug 2020 09:52:32 -0700 (PDT)
From:   Markus Mayer <markus.mayer@broadcom.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Markus Mayer <markus.mayer@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
Date:   Fri, 21 Aug 2020 09:52:21 -0700
Message-Id: <20200821165221.32267-1-mmayer@broadcom.com>
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

This patch was prepared in response to
    https://lkml.org/lkml/2020/8/18/505.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---

Changes since v1:
    - Added link of the coverity report to the commit message.
    - Added Florian's ack.
    - Removed second "const" from get_error_text() return type
      (thanks to the kernel test robot).

 drivers/memory/brcmstb_dpfe.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index e08528b12cbd..dcf50bb8dd69 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -188,11 +188,6 @@ struct brcmstb_dpfe_priv {
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
 
+static const char *get_error_text(unsigned int i)
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
@@ -445,7 +454,7 @@ static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
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

