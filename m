Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26114C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB0120692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4jNigDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbgDMRdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732821AbgDMRdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:33:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23544C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:33:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a81so10748363wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+Q3sQHWHz/4UUWb+fTY+Lp+S0KWob6RkIjERN3PrL0=;
        b=N4jNigDmVKSbuGJIYErgx2wKkgof51DDTFYeJrbPeiBoXHbVSgm1rvyddooJwQ9/F7
         dBKI4oGUrbpftuKwatusTGfwjFk9ZMDVM8mmcyvVGZZ+oknZ6o5isIBIXgMH/FwLyzIw
         UiMu0w0GxAf3NaFN6o4WKc+XH6Hwn3pYIc8SHDrinUGFbMtAOeX1FcynrjpjzZcLZxbV
         fSEl+EmvEwWkGHwBv13UwsrlXU53gllxB1D4d1cQpHLbppZOsu5MIVVdvUaQNXeRmthF
         4kl7jdSgOss7MRRe5PJMbqi6UBW2A04Dm5wjyUambqsaaar2P3usG2vYH4Z/C6ktLgxo
         nWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+Q3sQHWHz/4UUWb+fTY+Lp+S0KWob6RkIjERN3PrL0=;
        b=YCwAsnlsXrZgxx+eJKWnkZ6Yp02Auh03/2eSAf8c+4x4TGaJgaD47uN7J9aJWBhHNv
         CZ9plFfy4ienxs7KUAA66y3rswZv9LedvI+H85GG1KqZlQMIkCempFO/wKfRlvwIHo4U
         5RaEF3IOqJF1gZ00QfQ07McQ0NN1yKn8cmLCgL7pJuwgblYj328aRp+fiMjS3+7V+4pK
         QvBZJwIMAiCONNP8OSKPJPJ1WAZBL71kxmVDhxYPdJvMWHlTfgB9IU6Q78m9UHnx8E7I
         a7StktzAClGoa7QwR9xuTuGEuEpNMyK5DSVMeWfYtkyGRpxwsKMLoK4tU5iVVWjDqA3v
         KLFg==
X-Gm-Message-State: AGi0PuZKUd4rlhP/Wu1h0kSULJB4mc1TXStq9ErStk6vhidhHpNSx3Ri
        bXJRYMjjoymDqQcetJjbG6o=
X-Google-Smtp-Source: APiQypIzdPLyjmPzkX2e19Qkf1kNYWx+TJed6CleG8uZX09mZoberRJIHXFRzVApcauMNo3V2XOI0g==
X-Received: by 2002:a1c:6:: with SMTP id 6mr11592040wma.12.1586799225707;
        Mon, 13 Apr 2020 10:33:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::42f0:c285])
        by smtp.gmail.com with ESMTPSA id v7sm17025219wmg.3.2020.04.13.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:33:44 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/2] drm/panfrost: missing remove opp table in case of failure
Date:   Mon, 13 Apr 2020 19:33:37 +0200
Message-Id: <20200413173338.8294-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of failure we need to remove OPP table.

Use Linux classic error handling with goto usage.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbf..62541f4edd81 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -90,8 +90,11 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	cur_freq = clk_get_rate(pfdev->clock);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp))
-		return PTR_ERR(opp);
+	if (IS_ERR(opp)) {
+		DRM_DEV_ERROR(dev, "Failed to set recommended OPP\n");
+		ret = PTR_ERR(opp);
+		goto err_opp;
+	}
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
@@ -100,8 +103,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
 	if (IS_ERR(devfreq)) {
 		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
-		dev_pm_opp_of_remove_table(dev);
-		return PTR_ERR(devfreq);
+		ret = PTR_ERR(devfreq);
+		goto err_opp;
 	}
 	pfdev->devfreq.devfreq = devfreq;
 
@@ -112,6 +115,11 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		pfdev->devfreq.cooling = cooling;
 
 	return 0;
+
+err_opp:
+	dev_pm_opp_of_remove_table(dev);
+
+	return ret;
 }
 
 void panfrost_devfreq_fini(struct panfrost_device *pfdev)
-- 
2.20.1

