Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A9AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066F12074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9SC3o9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgFJLhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgFJLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1116C08C5C1;
        Wed, 10 Jun 2020 04:36:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l17so1596753qki.9;
        Wed, 10 Jun 2020 04:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=qsT1gCj+s7CWFymn08xxmx3dZhMjbbtFSYSlDs2tyjU=;
        b=J9SC3o9rHNx+zrdx7P9kKBj3FQVrZPPAwcoa3ww06QBvTPqfJB0syEKqDJXidEF0dk
         8PfhPYo1aJj4M/juRqlunLnFxwSsIUUktl/9Bg5EfLGKi9cUz8KcjNn9WQQdWrLj+zQK
         ztn2N83cy+MQpNM5VPzcrdWw+QGYrQtId8OtIdp1gJQVcsanoyT2g6aKcgowDF9YaYT7
         B6N1mswsU54+RIgJbA47mY5b3gzLLesjf/8TSxLnx6EoiGLiGH820dTXQqmkcVmFl3t9
         DHhB468PiotNcLW/cX/Wx1KNh+W2zgw0nU50t8hdm8bwvuENfFbA+eFs20tm1UWurNSS
         G4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=qsT1gCj+s7CWFymn08xxmx3dZhMjbbtFSYSlDs2tyjU=;
        b=nf3vhuIJBOhd4siZMFH0HPirhZgxdfnFu9YlHwD2G8HWdpQ049Mv4FhM4lYVopB1nm
         jusDitBJ0JquI+wT/SxZ688Dv39KgsEiMJtBfPzAgtHSrzvHJomUuLSdNsI6KO8vwoZE
         wiDkf3Nn6wSqv/fGPubG91XizLulqnFR5rB8E7Hby/hDwhCR/o0yPduFiEIbgkAfW7Z2
         BdcC/2FNpBmJ8mzOQ2tiz0XFpERL/41DOBCLd4QLHbMi5eZ3iV2ZIRwbOpuP9G0s0YtP
         y4N1b8QbzoBV+BBf717/j643Y/gn73zGk15W5hy17snhwk5g+yKUHV8/Fg8Big1i4bkF
         zjdg==
X-Gm-Message-State: AOAM531ZwzBu5NfXmhpRrc4BZNGqbP9DlWwAkky/5IR8YAupnIEUmfKd
        EdkPvlFKPet+f1/5p7y1mNIJQ/AupIxeNQ==
X-Google-Smtp-Source: ABdhPJzS4TJF54SMTHZZ2BGFB3nQMx4xCmsYgjEoDDXttE+7WhVD/Ctg4jF3Vdwm+u6jjPK5tW5SqQ==
X-Received: by 2002:a37:707:: with SMTP id 7mr2327325qkh.15.1591788998224;
        Wed, 10 Jun 2020 04:36:38 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:61ac:316c:1207:3fa6])
        by smtp.googlemail.com with ESMTPSA id g5sm13809059qta.46.2020.06.10.04.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:36:37 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] max732x_probe: remove redundant check
Date:   Wed, 10 Jun 2020 07:36:30 -0400
Message-Id: <20200610113630.11922-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>

The pdata is already checked for its validity. Remove
this redundant check.

---
 drivers/gpio/gpio-max732x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 5fb0bcf31142..63472f308857 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -703,7 +703,7 @@ static int max732x_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	if (pdata && pdata->setup) {
+	if (pdata->setup) {
 		ret = pdata->setup(client, chip->gpio_chip.base,
 				chip->gpio_chip.ngpio, pdata->context);
 		if (ret < 0)
-- 
2.17.1

