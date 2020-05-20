Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E981C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FA52070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCz+sHF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgETDVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgETDVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:21:35 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB4C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:21:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id a23so1546520qto.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H3LD04AQwmxN/W6G9Hm1qR+vU06ilPmJsdKj04uNnA4=;
        b=DCz+sHF4It2JSWZejzc2SvNTbmx85dJISq+sgdg0dUWXllA4lOVq2msJAtSdiv1wRm
         xEZazLGCamFvnKTJ5idqqsJyTT6NDYBVwliNcWXQ2qVhK3po4rHxUqT6VBeOm/xJgvE4
         qibpNpqidLiKMhhBLw0Lz1UrwfMgGIx3hmMmyKCxMpC94i5wyetynGDJhH6KRRlhM45k
         vSxZjQcBRf+2plI1M5uEv3zDZp+ltkOQiESSW7CYH0FQqvpebhjxTfhg+fmvXx1g/DPw
         O28tGqbziISe3XYzPOMYGigcZnI39Re+nU8POnnvr+QheqGcxrPYKi1Ur7ef977G1gJJ
         QQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H3LD04AQwmxN/W6G9Hm1qR+vU06ilPmJsdKj04uNnA4=;
        b=SpyrjLksn3eZvmFNLZlrMP9v4SekLyi44nXYDh9yWyU2JfFRvPOIQZNxCKhaA9qYzT
         0qRw8tpNCEqLlehxKxG8JeHbW8zkJJaFjsll8HRdMolyGXk/tqeSfNZxIgfqWQ3KQiB7
         3YYPU5MIfvQ+owPnlTGz93t9hPS3a2o+Xsr9ugkGQigt6tkagfzrXfZo+xbhFyheN/Ee
         1AgGYuq7sftEPEUZc/e6MOFDWhU7cNXR4ZdSrkZDRIwCm45FOfuVzmZ/uK+r2xu7P9dE
         DOLomSytIfBqDCs4iKQkg0FmfCgH27rEyGhXz0q62WfegkqjEZw5zud30mMX2Ek5CZ+A
         gcAg==
X-Gm-Message-State: AOAM532I1dYMWoLtwpobVZm1BaRTnBUPoMT7udckEF0Aj4OS71a97n7S
        U0giVUEWR/Jfe6MN6b10gnw=
X-Google-Smtp-Source: ABdhPJwkNV6xh7GZP+CGFpCwAKH9XVqPYyKAWJgVcQ54oj4PyYOJxs7jmCc0CrKwg6XeaT9VYHT8EQ==
X-Received: by 2002:ac8:5142:: with SMTP id h2mr3306395qtn.37.1589944893849;
        Tue, 19 May 2020 20:21:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919:d4cb:2d07:fb81:cec4])
        by smtp.gmail.com with ESMTPSA id g20sm1210274qki.75.2020.05.19.20.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 20:21:32 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jassisinghbrar@gmail.com
Cc:     kernel@pengutronix.de, o.rempel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mailbox: imx: Disable the clock on devm_mbox_controller_register() failure
Date:   Wed, 20 May 2020 00:22:46 -0300
Message-Id: <20200520032246.12482-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_mbox_controller_register() may fail, and in the case of failure the
priv->clk clock that was previously enabled, should be disabled.

Fixes: 2bb7005696e2 ("mailbox: Add support for i.MX messaging unit")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mailbox/imx-mailbox.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 7906624a731c..3f7c4548c18f 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -508,7 +508,13 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	return devm_mbox_controller_register(dev, &priv->mbox);
+	ret = devm_mbox_controller_register(dev, &priv->mbox);
+	if (ret) {
+		clk_disable_unprepare(priv->clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int imx_mu_remove(struct platform_device *pdev)
-- 
2.17.1

