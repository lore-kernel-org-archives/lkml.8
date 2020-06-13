Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A0CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7902620789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Ardg8aLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgFMUwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:52:11 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44878 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:52:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49kqXR11gHz9vZTv
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V-LTL5QAY37K for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 15:52:07 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49kqXQ6JvXz9vZTh
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:52:06 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49kqXQ6JvXz9vZTh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49kqXQ6JvXz9vZTh
Received: by mail-io1-f69.google.com with SMTP id x2so3177452iof.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UkcroixAl0qAjD6GgNgyzou/IsN1STk9p+xVVDcmeP0=;
        b=Ardg8aLxFj2jA4QjL4csIbDmbF7Qv6ioBUq9BFwPAzpqdsP+ivgI2B8v6vEDSmF5Kq
         T+VI+cMiJyrltzxL2KJ+S2WHTXIUF/tzDx+Hy6iiCbHiebDtommqrsorIxWsJtD5Xxfl
         rSzCIoMmPWNRk35WVAw7LbUcN+FwnWoL2ov7l39z+On9rB0EWpXx0pMhwvIoyqrXUaxN
         SVjXxR5F+7oT+/CflVUIQ8BF6ijShRJTLfKceESF3Hx+zZ8lX0oXaFdA9bCViMHOZw8e
         x1Ek4ACuuHNQSXcdq2kYUQsZrqkPdIsjq0SIXmIxXnf4IToCmyoJ83/4UJ3PDAddESUD
         Xw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UkcroixAl0qAjD6GgNgyzou/IsN1STk9p+xVVDcmeP0=;
        b=hI/JvNJzO/U1faBCyzUO4I18vMWdCQaduhz7w+pTznFvNTdpKv/wS8j5rivllEUtpV
         NN/uNejSN0Wfvv/yVWrRDJqTSbt7kNZYGxXijMSiLzNzFx7wH8nEJkxF+BoSjTis7N9r
         fO9yRqjswxGB9qHr3hyWDdLrpqdjx4h+rk3bF5pRYyqMuLUNCGPMli6vD21pP6jVM+w7
         g+2Es2K+0jP8+OTJYC5d7WC56Rb4lYygVVfP/MQxh5j7LggQjO6Wyn86/6t3fjrzkCc8
         tlPvnWYg5IN/GjgIHnSaFRdnuI8V8tp6MlGxvLqjrqQqWS3Ut2K9Ia72nx9lotvdr4Mc
         RxCQ==
X-Gm-Message-State: AOAM532auQ5JLyqWOzZaYKndkLFZBoReMTxnO8lRsLDYnQ77Jsvki0qA
        bJWTt8egIQtMu0ohCX6i+Oo4jqaEfkW2ABqpvcTn1PT+CDsG9PG1eS/il5RIgphOc80BacyO6Wn
        MaftXlNbmqYBolW4irlzq+dL420o5
X-Received: by 2002:a05:6e02:542:: with SMTP id i2mr19700878ils.203.1592081526450;
        Sat, 13 Jun 2020 13:52:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWlEJFk6HoO+GE9Acy8SKo/fFC/orEpAve7+rluozITdaEPrSwu9DbTGUy6wx6oKsMcR3TDA==
X-Received: by 2002:a05:6e02:542:: with SMTP id i2mr19700858ils.203.1592081526162;
        Sat, 13 Jun 2020 13:52:06 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id c1sm5138369ilh.35.2020.06.13.13.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 13:52:05 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 15:51:58 -0500
Message-Id: <20200613205158.27296-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count if pm_runtime_put is not called in
error handling paths. Call pm_runtime_put if pm_runtime_get_sync fails.

Fixes: fc05a5b22253 ("ASoC: rockchip: add support for pdm controller")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 sound/soc/rockchip/rockchip_pdm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 7cd42fcfcf38..1707414cfa92 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -590,8 +590,10 @@ static int rockchip_pdm_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	ret = regcache_sync(pdm->regmap);
 
-- 
2.17.1

