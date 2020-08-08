Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B843C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 04:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7587D2073E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 04:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxsmsVrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgHHEfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 00:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgHHEfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 00:35:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EDC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 21:35:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 74so2200274pfx.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FLH00sdB350zJ9xfj23oogVpb2S3tQu3JW6EcRNgLew=;
        b=jxsmsVrPMXk3ia55RuurLWnSF4l/zKLQ3vl9KAAZyocpecHvuHBmvqNZ3/XplYR3Gu
         n64wEa8PfUTVNoNBErV1lJqro5vuj1nM156YV6puxX0VwIGA00GjYcltZ/n0CHtTmuzl
         K2dCPiCPxd74wNDhXQLkKGBo2IVHvYaeYFNG01vgjfXIz8zc4ApEPfoR14VwkWPo/3jX
         gsEkm2oobSufzAL5Borf0uY3W1ZJuoPEjN+7yEoaVyebCPQbU6AoPggfRtKb3JqQ42/A
         JwqVVpbzfnkJNscvxEW48HhBsrwYsNzeGeVgzqGq0KhbSns0HdL3r9jTSBsMGRJ+8XlJ
         8GKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FLH00sdB350zJ9xfj23oogVpb2S3tQu3JW6EcRNgLew=;
        b=S3WcMve6iOruyNuglF4mF9rSX2APaodbfrvoznbUgOs4v04wunmXXvsa4+BxulHv3o
         v12QypdnrQv9wRrMr8E3pm/HwV/oxhfxBXRl8YyckDeB/Wojoa3De3ZM1bv8wZEV5OzQ
         7iSNlI1KBuaEAR4jHU60TFZlsOmc4rT/Nsjz9eiu7xLh1U3w5fRIPXJdx89xokb3G9KW
         vFw2YSn8DAOZhDY7afqfua9fl1vwI15qUl92QC8YkLeFw6Pl9FxWQWjUviG1rNL2K3eP
         kDBA3WStDhGxgtAWH97J/GJTR7piIO8M7su0X3Tfn7Mrir0BORlOUM1G00pigXwLt5DC
         WvLg==
X-Gm-Message-State: AOAM530G+ykW/Yl+Qo771psK1MFjw9spKmOVKgjLuoAo7D7kenLveYzy
        sBZCHMO/gVKi+m8qgoRa1BNYD4wTlOk=
X-Google-Smtp-Source: ABdhPJwNTHQJhOGti3fSdIgHT3N5Ze4RXdBPrXTV4+YSlALH9wv8HLqMwbWjlTEZZ6jWzuIuQz6l9Q==
X-Received: by 2002:a63:485f:: with SMTP id x31mr14308176pgk.49.1596861315980;
        Fri, 07 Aug 2020 21:35:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id u24sm14607963pfm.211.2020.08.07.21.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 21:35:15 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Subject: [RFC][PATCH] pinctrl: Rework driver_deferred_probe_check_state() evaluation since default timeout has changed
Date:   Sat,  8 Aug 2020 04:35:12 +0000
Message-Id: <20200808043512.106865-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit bec6c0ecb243 ("pinctrl: Remove use of
driver_deferred_probe_check_state_continue()"), we removed the
use of driver_deferred_probe_check_state_continue() which
effectively never returned -ETIMED_OUT, with the
driver_deferred_probe_check_state() function that had been
reworked to properly return ETIMED_OUT when the deferred probe
timeout expired. Along with that change, we set the default
timeout to 30 seconds.

However, since moving the timeout to 30 seconds caused some
issues for some users with optional dt links, we set the
default timeout back to zero - see commit ce68929f07de ("driver
core: Revert default driver_deferred_probe_timeout value to 0")

This in essence changed the behavior of the pinctrl's usage
of driver_deferred_probe_check_state(), as it now would return
ETIMED_OUT by default. Thierry reported this caused problems with
resume on tegra platforms.

Thus this patch tweaks the pinctrl logic so that it behaves as
before. If modules are enabled, we'll only return EPROBE_DEFERRED
while we're missing drivers linked in the DT.

Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_state_continue()")
Fixes: ce68929f07de ("driver core: Revert default driver_deferred_probe_timeout value to 0")
Reported-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/pinctrl/devicetree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index c6fe7d64c913..09ddf567ccb4 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -129,9 +129,8 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
 			of_node_put(np_pctldev);
 			ret = driver_deferred_probe_check_state(p->dev);
-			/* keep deferring if modules are enabled unless we've timed out */
-			if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
-			    (ret == -ENODEV))
+			/* keep deferring if modules are enabled */
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
 				ret = -EPROBE_DEFER;
 			return ret;
 		}
-- 
2.17.1

