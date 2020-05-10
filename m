Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F3DC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A112495C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moB/WcAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgEJQz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729230AbgEJQzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so7934876wrb.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGtRSx0M1H2sciVoOm/cuTNsMxGSi9E0CIv7gSphJdg=;
        b=moB/WcApqXpplDXdnr9T7REGok5c63lnlOe5MLGjckrRBKnIWwEiMeEqNq/Ku2Ixgl
         a5aUidJAP1BSgquxga6sidNtyZ00U5NR7JLvdS7UoPuhDqQliDguzuxc3BZGJmuVExqE
         JgSYBt7oDjmW88qF4l+dKQOaswcczrNLYT37B9AU+xFEftA4Rhr1FmCmBPOgfj9fN9wZ
         WEvROQktO7JyOqpEtW83RPd54M3mn1roeo8boJgOrG0Bik7OTKB0QsWU0Nn9s57rdlqw
         KeH2TaiHbx1LmzzDyWoyeEy7Bkj66NcNiwwjRg9XUXY3lufrrYj0LV7V3QqXB5ZSOBCL
         XQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGtRSx0M1H2sciVoOm/cuTNsMxGSi9E0CIv7gSphJdg=;
        b=Yv4x0adTfS1RIdpoClqAUnzxIidB2e/11J3nfApIzjcBJzLg4krU75ggHk/GLvhsya
         16Eau2+O+1YZRf1P0i6GzxKYcQHYIZEur9o9dnycIo2OESELNkR/qntrcQYAa67KUDsu
         4opSyIGza6LTfM1XOCR/+QNI3bmm9nAHcybW9b+Qt2p7Gs74ZFU3h3Fm946Cd0uA8604
         2btaWdHnBn1AUjdk2P9ETDqudYI8zCMFedJbNju7XADkZe/S1+aBxbG74n3SUSdGS8cT
         a0akSsVmTqcgIx5YQBL+4wiVUK+nkbnbNhQRUk5y76olIfABqOACQSq+ghmkaemqvU4T
         yqXQ==
X-Gm-Message-State: AGi0Pua8DuCSH3H/w9O6ZBujwIdDHtjci7wQQFRJEoSuNbP50r0cjcVR
        srnm3CbBoMExPSpoOl3wVYo=
X-Google-Smtp-Source: APiQypJb2TSWzqq6njqmcEA/TOqYHZSFpZoZ7VDbi6n/FR3lppFw2NBiQ/cKffersHlcaOfO6TPUTg==
X-Received: by 2002:adf:a118:: with SMTP id o24mr13650480wro.330.1589129753836;
        Sun, 10 May 2020 09:55:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:53 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 11/15] drm/panfrost: set devfreq clock name
Date:   Sun, 10 May 2020 18:55:34 +0200
Message-Id: <20200510165538.19720-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs have  several clocks defined and the OPP core
needs to know the exact name of the clk to use.

Set the clock name to "core".

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 13 +++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 9ffea0d4a087..6bf3541b4d53 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -103,6 +103,14 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 
 	spin_lock_init(&pfdevfreq->lock);
 
+	opp_table = dev_pm_opp_set_clkname(dev, "core");
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto err_fini;
+	}
+
+	pfdevfreq->clkname_opp_table = opp_table;
+
 	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
 					      pfdev->comp->num_supplies);
 	if (IS_ERR(opp_table)) {
@@ -176,6 +184,11 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 		dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
 		pfdevfreq->regulators_opp_table = NULL;
 	}
+
+	if (pfdevfreq->clkname_opp_table) {
+		dev_pm_opp_put_clkname(pfdevfreq->clkname_opp_table);
+		pfdevfreq->clkname_opp_table = NULL;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 347cde4786cf..1f2475e1d034 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -16,6 +16,7 @@ struct panfrost_device;
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
 	struct opp_table *regulators_opp_table;
+	struct opp_table *clkname_opp_table;
 	struct thermal_cooling_device *cooling;
 	bool opp_of_table_added;
 
-- 
2.20.1

