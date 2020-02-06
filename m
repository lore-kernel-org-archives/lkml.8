Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7533AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C26217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX4kb+AM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBFNuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:50:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38163 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:50:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6so2381108plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q0BdBCYUrqfjFVvkubnw3NGbt6uVGwl1GZxSoEc+RNI=;
        b=rX4kb+AMG78lYebzHJRfVvcxmA3l00utGJ/IQp5BSZdVR/x4OMKnpqV7sWo7ak+Ga9
         MNFQI/d8MyqLIwL9ouHjSHS7Qw9MRKK+MGYK5ih7QBEtFs/fab0H+A41zxD1sEJL11km
         3nq/A1NiO8ugrN74Qbt2Eow6Z1oWNIaBX/Ctf9l5VdOmXtNSEnciU76WCAed9mux4wUc
         QxeDzHfZ+jgXkFnmQ9aRmla/nDVCX6GxaqJ9kluPqLN+uRdxTbqm177sv7Esy3u9CCVs
         9ZgKWOEq+WphVA4ax9o2JBZcE3jiA4841NCfuIXT53GRBmBjESQ1vu67YH4lDm984qs6
         E+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q0BdBCYUrqfjFVvkubnw3NGbt6uVGwl1GZxSoEc+RNI=;
        b=aJbYNdQ+Nf0iJrlYjM9KTl1vL6Kjdox+9N0lvs4EYD5WyZIkzqZuiWQAC49tw5coOB
         +uRw7LXHU1CbUbh7F1DIefZt9/JyiIsYQ0bNtTcQHzkNA77QgduP5elXmcoWf6iKAPwn
         pt5yN7MgGVboV5SF5VZKFC9fozQ9xhGKukPFZEjDED5j+6HGezRWxcL32hgIsjvHsTcv
         5S7DLENYO/qgEeUMZcXk+X0iwRgx7bBtwwno31jBZVGNLcdcZYI74BSzfVfwSMdb17Oy
         lbwPCUHueli8pclghPFPbu9gRfT2jZntGNCszd6i5mC7DtrgLxma/Svxv0u6hAEIs65v
         qdEw==
X-Gm-Message-State: APjAAAXN4/NuMaQ5y1o/+rnTriEIedD7D7UkAcdG7YfUZByVvJiiVHh3
        EG79ViH2XToz3pmZ0d21b7I=
X-Google-Smtp-Source: APXvYqxh0nu36Pb3x629QJnjPf4bdZYxMDEikt+yBm2PTf2zhnL7dcueTERFEmGVe0rmuy89raLMcQ==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr4245600pjv.140.1580997015260;
        Thu, 06 Feb 2020 05:50:15 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.20])
        by smtp.gmail.com with ESMTPSA id y3sm3581126pff.52.2020.02.06.05.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Feb 2020 05:50:14 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     support.opensource@diasemi.com, Adam.Thomson.Opensource@diasemi.com
Cc:     axel.lin@ingics.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] regulator: da9063: remove redundant return statement
Date:   Thu,  6 Feb 2020 19:19:56 +0530
Message-Id: <1580996996-28798-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_request_threaded_irq() already returns 0 on success
and negative error code on failure. So return from this itself
can be used while preserving error log in case of failure.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/regulator/da9063-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2aceb3b..70554b0 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -867,12 +867,10 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 				NULL, da9063_ldo_lim_event,
 				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				"LDO_LIM", regulators);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "Failed to request LDO_LIM IRQ.\n");
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static struct platform_driver da9063_regulator_driver = {
-- 
2.7.4

