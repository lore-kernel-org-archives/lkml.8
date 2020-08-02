Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB01C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 03:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B1220722
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 03:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0tGr6Iys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHBDZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 23:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBDZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 23:25:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7666C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 20:25:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so18095494pgf.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 20:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TU0jVDkAi+TrfLwagAtvk/o+NPXU3FvHA83O5gmgbI=;
        b=0tGr6IysV+eD9opoEGIr6mkegepTqnjGOL8YRmg0O7yoTPq2OW3noILiXRlqROwKMe
         y5XvRVcaCNhbZ3la/jk1ZTiRg7hUtUYRtWKqQBzmRjJ9XFnAydqcUErnDwUnWYYClQIL
         lndUK0Jpdl1+XhpLVu6Wpsl+n4Vl6pbeLF13s/Sh//2hpN5mAwJbjxBOLLwdIJHnhxDL
         MRQUBBFotciWnOfqGVVn1uXuchDNo3OmkGiTjk7pD6ArG9Oh+dIMkTlfig5E1eb/RXpV
         PPp0qfwtbL990UjpbSTzqu5ppvq2l6LjY9fTaDk8sll/VhgDM9g26/mt+yery33w4ysw
         /QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TU0jVDkAi+TrfLwagAtvk/o+NPXU3FvHA83O5gmgbI=;
        b=cVUdkbU6q52TaFz8wulWuZYRQEpo21AJrXt+61+Mkiv4xiqMwn9St9nrx+LVAV0JCy
         SWOgCh067QDUm4LbjwC7YRFganaXuCrafu+tjVr020P/2c9IKxr070eBusZDRxuQYuHm
         J1N3in8iNh5uZJUZ37D/VqA8zA6lsEQ27JOhr90ogp+MNeTOcfLCm1gYRRY8f/WSKFWh
         Eb2LETtjyT7Vdv88q2tUit7vJcY+jiuv1u5rDTNQq8zxX21KCucTN6xHvTBu4iXUHhAk
         3WzN2HtmwjiiFuCTHGmoDjzYxL1+UxCVAIfxBUEMQe6rVqz8ky/VBXnR5D111B5Ufddn
         SHZw==
X-Gm-Message-State: AOAM532d0HEQf2i63/Bev2opy64kKmlu4VIw+ODzHfJvi4pXmCyUAR/8
        9ObehbUunJizOTLBBILIuHoeeQ==
X-Google-Smtp-Source: ABdhPJzCDvfKN4o4egxZWxHYrsT51nnaZpcJciej09GUhdkbrV74KESCD/rwpuL1HN0aUfm8Hf0iew==
X-Received: by 2002:aa7:8a4d:: with SMTP id n13mr8130420pfa.143.1596338735295;
        Sat, 01 Aug 2020 20:25:35 -0700 (PDT)
Received: from localhost.localdomain (36-239-219-92.dynamic-ip.hinet.net. [36.239.219.92])
        by smtp.gmail.com with ESMTPSA id k21sm12059565pgl.0.2020.08.01.20.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 20:25:34 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: cros-ec-regulator: Add NULL test for devm_kmemdup call
Date:   Sun,  2 Aug 2020 11:25:09 +0800
Message-Id: <20200802032509.305425-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix possible NULL pointer dereference.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/cros-ec-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index 3117bbd2826b..eb3fc1db4edc 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -170,6 +170,9 @@ static int cros_ec_regulator_init_info(struct device *dev,
 	data->voltages_mV =
 		devm_kmemdup(dev, resp.voltages_mv,
 			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
+	if (!data->voltages_mV)
+		return -ENOMEM;
+
 	data->desc.n_voltages = data->num_voltages;
 
 	/* Make sure the returned name is always a valid string */
-- 
2.25.1

