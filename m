Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC38C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0420732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seiBEgEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgC2JWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:22:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37254 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgC2JWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:22:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id h72so7021665pfe.4;
        Sun, 29 Mar 2020 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1hCX0Eu5BSFoHJWyRefAvnMuTN8T0slwSrNK+D8BVUE=;
        b=seiBEgEWo89G0cm4eLCRBhoG4Ilds9sW/UkUVahSr62V/bc68xt4FSrpnMVkw8BfJn
         SO8C+hWFr7MqBP927XPkgd1v5y+scKb3sdMF15SV9rB60OKms3nLkpWT/7LpeBYmTx8T
         5MZ2mRL/6P8rvgoMzla/a+Wl1XOW4dHDbn0pXPmU/uibNDN+JK2J1blSPVOMMEyPC+py
         NLawegDjyJ203XfGz6tILqTQPOzGBBFiy9IiaXDbsJQFs2cI81MQw9gW6l4zRcpzMFPQ
         K5jmOkIUmQrD0ABHxXfFEG6P+rX2v6oke5jSor4qvAI1G3hOQZ09GYU377NQXRtPDM/e
         a/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1hCX0Eu5BSFoHJWyRefAvnMuTN8T0slwSrNK+D8BVUE=;
        b=hI9Vb/eNTK0LCsNVvriupsby62+XLxDhaYR5fUIC9Yyg4B97WGEhwQYBfZ4nSEz3TI
         4oZbYTbFubR8H6avy4Fy+5mfeQ/Ur2zMh31BmVWViH3+pzG0TwcRiW3MbUvMC0oe8XsD
         c+Hm1DVnunLD8RciWW3yAQHZABCEPfgrljDpsVBxzMnNa5CcnS1eOg1GH/FkH2YnchYt
         ny2xYlEtRaFQqWz53Auncz4Qx2L+lN6ILXVZECFhtL+6ws3FLU+oMQPN1je/vHp04sE2
         tr7xE2Y3uU9xx5uSh/IeKE2WEq1rqy4lT39azQcm37VfcSmyW+fFRNawMLHyUlpZSD3J
         5lrg==
X-Gm-Message-State: ANhLgQ3pr+J7IVhnKhfOAj5qbruR5bsJD9zBveLafq38rrPZfrH2G3CG
        JTak3F3HNuo8au/p5HJPPqE=
X-Google-Smtp-Source: ADFU+vs2xioDwndYreFjtqUiqCO2dHroI6mYZCs+EpeXHdChdsMV8FKCH9+T0VoQFeFpcNj8WaZt5A==
X-Received: by 2002:a65:5a87:: with SMTP id c7mr7664384pgt.237.1585473758132;
        Sun, 29 Mar 2020 02:22:38 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id b3sm7366962pgs.69.2020.03.29.02.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 02:22:37 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH] staging: fbtft: Replace udelay with preferred usleep_range
Date:   Sun, 29 Mar 2020 02:22:04 -0700
Message-Id: <20200329092204.770405-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix style issue with usleep_range being reported as preferred over
udelay.

Issue reported by checkpatch.

Please review.

As written in Documentation/timers/timers-howto.rst udelay is the
generally preferred API. hrtimers, as noted in the docs, may be too
expensive for this short timer.

Are the docs out of date, or, is this a checkpatch issue?

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index eeeeec97ad27..019c8cce6bab 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
 	gpiod_set_value(par->gpio.reset, 0);
-	udelay(20);
+	usleep_range(20, 20);
 	gpiod_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
-- 
2.25.1

