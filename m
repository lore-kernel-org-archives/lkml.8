Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC17C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694BC2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hhab7Toa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHVUuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgHVUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:50:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECBC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:50:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so5011753wrh.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=awS83gVg339WvkVehjyxkJ0tva7kYJAQiAAlkyDZdCY=;
        b=Hhab7Toa7JqQg6Fs3xCaGrLLkK7u5Ls3HVTVp62/yPtGHAdmEI+CGJqcQx+Zsr5uRs
         LRusOTPsSwoHzk5sO6LFtSmubjbUWgXURg4s1njMDIWMXOSBWtYjhv09oxEi7rt0zIXY
         7RAQ6GQsDp2PGMoc2o20aAl7QqTa+UhprHOak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=awS83gVg339WvkVehjyxkJ0tva7kYJAQiAAlkyDZdCY=;
        b=qnr/da8W8w/+jAnkogR6OcDDnjhEvyMYbujiV5wcXV6TULkHlCiAajgFwI7T8At0Wo
         Codut64dWzj0hTo25c8o0jUrp76qgRye6uafTA9aSRQlVU90SGtGYGTUe9nh/MI8un58
         DBN1XbQVBjgJ957vFNCcXfMP68h3tHwpJgnNkDPFRRBK59tAbTdSQ44v5u60mAYVNvEe
         JplUJc2CsNytwmaymIvCsHFbdj9vscqgDL7prj+4gEpuNTrExu+RMWEcyLr1ylxUdlmE
         o7mWG4mLaMKUIpDBqcpURIIKxOx263TaogBAdD0YtHiysGhzyzbXGnXR/LR7VMY4poxe
         /0Ow==
X-Gm-Message-State: AOAM530POdA6Bb8VtTRjedIOM4o781k6pmndKtOOP5n++1QJgycOacSp
        wzWVHAzyOHltAXUwmTYMZKt/Fw==
X-Google-Smtp-Source: ABdhPJxynv1Nm0KoX+Ru6/XDn803cx9lbNeDxDE59Kp8xjg81nYzHC9GGVXUlo/Af2VHftP5h/3wtg==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr8363433wrv.208.1598129416035;
        Sat, 22 Aug 2020 13:50:16 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id n18sm13041935wrp.58.2020.08.22.13.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 13:50:15 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id E4FF6212A928; Sat, 22 Aug 2020 13:50:12 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] memory: brcmstb_dpfe: fix array index out of bounds
Date:   Sat, 22 Aug 2020 13:50:00 -0700
Message-Id: <20200822205000.15841-1-mmayer@broadcom.com>
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
Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
Reported-by: Colin Ian King <colin.king@canonical.com>
---

Changes since v2:
    - Added "Fixes:" and "Reported-by:"
    - Fixed "From" address
    - No changes to the code

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

