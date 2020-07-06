Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104BAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E325020739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYBdtG0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgGFIxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGFIxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:53:15 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ADCC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 01:53:14 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q192so15698394qka.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nn1O+W5EF/DppeDjb/j++wKQhD1vgt5fSJyldwn+gr0=;
        b=KYBdtG0lzBfVvrUkrfz0r108HsyZcZi/XmN0umNhNVvTlM8fpVEjbJi4SPx9oneLiM
         M/8fMNWhiR3NWpli+VYKaJb+41nmadZixzlqEtOcI3qlgwcOVpNbsaYN1CR+NxJ6ahb9
         tl/elsz1PQ1HtSXJRnyBvVduGH7Fnf5l5lJsNKenGYNnpEWBB8bQBPaIqms56clYlvxm
         4jkNvY3ATegxSVNYuaNUbhUY2ZhcrKN5J/clF6nFeiz2AYYE3LCM8/6FqACCevrRy2Mx
         9gLstIU0qSZz3YvbJymzIiTTKZapgKLyUA96aeuFV7wrYaG2xTdj34QN8KzWTwizXfhy
         wxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nn1O+W5EF/DppeDjb/j++wKQhD1vgt5fSJyldwn+gr0=;
        b=j/VQ7JrhxR3t2etmt3WDfKI7Cu8RoVP3rWVn82pCccoC6Jo6lVGgACzswWVjbj2/MA
         pcNrTgCuEnHZgBggr6fpot3goCVqS6J8XMWtK1UeK2jDRl8xrCoX/8LSaPI1RZgqh+bE
         GA+JYQ0CGu3p9jDcSQm+5D5xpVvsMWAn0I0FfA/nx6Dxw7DIS2Phs2OxQHaZz7OrVekl
         3boxZ6SYvf8DSkzDEbQemEcc9qUegr2Kdxblhj+hoUzyAWl6UldhS+q5hvf8Mpx4oscq
         6oTeYmQ7ttupM60GSCjzfbvn058hKCqArb2fh2u29kPCaHTvyABKOzXPOYwOcXtlcwdl
         307Q==
X-Gm-Message-State: AOAM530A4R5u1yWDzBTsS8DNSiGFUv0ET73/2IYHei9IRPgbDQZmwmmI
        3tvqRqx/RzrcZ0ShK4mC8+gLNwvPX8I=
X-Google-Smtp-Source: ABdhPJwG1fHRy4VggT3+PmM+BVlmrAXKXA76Zr3GApVvJaKpT8zYZUmtqmAOf+97SJeq844FjtnlNSsNxEk=
X-Received: by 2002:a0c:ab55:: with SMTP id i21mr46962478qvb.139.1594025593948;
 Mon, 06 Jul 2020 01:53:13 -0700 (PDT)
Date:   Mon,  6 Jul 2020 10:52:38 +0200
Message-Id: <20200706085240.1979622-1-darekm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] media: cros-ec-cec: disable the device wakeup on remove
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Cc:     Dariusz Marcinkiewicz <darekm@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dariusz Marcinkiewicz <darekm@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device is enabled for wake up while the driver is loaded.
For symmetry, disable wakeup when it is removed.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 2d95e16cd248..3881ed7bc3d9 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -277,8 +277,6 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, cros_ec_cec);
 	cros_ec_cec->cros_ec = cros_ec;
 
-	device_init_wakeup(&pdev->dev, 1);
-
 	cros_ec_cec->adap = cec_allocate_adapter(&cros_ec_cec_ops, cros_ec_cec,
 						 DRV_NAME,
 						 CEC_CAP_DEFAULTS |
@@ -306,6 +304,8 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_probe_notify;
 
+	device_init_wakeup(&pdev->dev, 1);
+
 	return 0;
 
 out_probe_notify:
@@ -335,6 +335,8 @@ static int cros_ec_cec_remove(struct platform_device *pdev)
 					 cros_ec_cec->adap);
 	cec_unregister_adapter(cros_ec_cec->adap);
 
+	device_init_wakeup(&pdev->dev, 0);
+
 	return 0;
 }
 
-- 
2.27.0.212.ge8ba1cc988-goog

