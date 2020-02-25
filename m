Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AA2C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8922124682
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu6ZP2ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgBYFIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:08:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45650 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBYFIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:08:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id r77so2890818pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UKu1DiH1aE4gWTyQt4rVDR13BTjgcFDoUNycgrJmwbg=;
        b=Cu6ZP2ZIv35GFagdY+/LcLqaOOw+CLP2oG+i36khDGnV8jZqR9+fcfjmtSi8rmir7L
         Jx1LaoZjn8k7/5orzjhIAxTgMTS++qpZ/WATeHeqfZ4jMF2TstYXaTiMIt63Hf5rFPkU
         HLBZsZV3viwEcdZFWD4uZ3ZgmCzB54Q6z++Xu2LdT8HN4JDEUwYeMU+o2G6oG5cftukM
         y7ej0sQ3QrmZg8WvRtkxYZ4OdyjLUJTBxEIivl+4yyyqBrytgZceKBvx4/TkxTvlIbFa
         dfRZhnCHnKcjjZePiKQqRzKAcc0sYa7DHxrLEP68JvuQDo+Me44fthyCMhq4WUVHAtib
         OSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UKu1DiH1aE4gWTyQt4rVDR13BTjgcFDoUNycgrJmwbg=;
        b=qxyQNUreXmdhtzGUElum+4iLtcRJh46DvK2+RIZjJBwCcgBHvDgG8oHScezNd5dl7F
         UZbrxyL+49zrExPjhfMajWexI31qKtMNxSbdh3pnvSZMVog71lbf+XVioCRzJkcwU+HN
         zs6+Y6YQsGIC2BudN6NpmF6TRxlDYQk994Pt78M+H/OVQGOUO9xg+XpNlrfoHqzOutp8
         WkIOGpqH2dnYOcRXeA514kWJjxndSHQQpT9WbpYPZBWTin/x/gQT7HElbF9iPiaBUcVc
         r+mnRv8Xr5xEay5/C/N97iHCd6Y0uQIXlIAGhd8BEVG2w4ad+SPB9lIbl6LmKQ4yCAXC
         I+MQ==
X-Gm-Message-State: APjAAAUtmrEDz17LUr4lyCXRAp7vX2QSrd/s3c0OW0wp2Riys5P2gzcH
        3afnLgC72SKK0qwAXozeUYxZ+JHEWhk=
X-Google-Smtp-Source: APXvYqzJ+fEVi/wIlI9WBB1N7Ce1uB1pgPc8Gi+KC1Np/LBZigKmj6Z4U+C8cgQ72ykCwoffntxxsw==
X-Received: by 2002:a62:5bc7:: with SMTP id p190mr53865844pfb.16.1582607325037;
        Mon, 24 Feb 2020 21:08:45 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:44 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
Date:   Tue, 25 Feb 2020 05:08:25 +0000
Message-Id: <20200225050828.56458-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
References: <20200225050828.56458-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the earlier sanity fixes to
driver_deferred_probe_check_state() it should be usable for the
pinctrl logic here.

So tweak the logic to use driver_deferred_probe_check_state()
instead of driver_deferred_probe_check_state_continue()

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/pinctrl/devicetree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 9357f7c46cf3..1ed20ac2243f 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -127,11 +127,12 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
 			of_node_put(np_pctldev);
+			ret = driver_deferred_probe_check_state(p->dev);
 			/* keep deferring if modules are enabled unless we've timed out */
-			if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
-				return driver_deferred_probe_check_state_continue(p->dev);
-
-			return driver_deferred_probe_check_state(p->dev);
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
+			    (ret == -ENODEV))
+				ret = -EPROBE_DEFER;
+			return ret;
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
-- 
2.17.1

