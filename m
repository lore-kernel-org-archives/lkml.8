Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E085C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D62F20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JfhHhfwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIJVky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgIJNGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:06:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E71BC0617A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so5711495wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nrHj9I7O9lphgMpg3nYt8s6m+DhlUlMF3Q2xQwYP4o=;
        b=JfhHhfwgFyod/Q11QsB20PWg+IXp0MwbLVKEVJL8Xc96YCyL4xey0pP2SGU5uojuTs
         DuUjgoLnOJnE2X03XlZelu56WjbjShlK8YJIoPLTPFIv048vx5ZHsjchrG0l0/qXf6zv
         zJcPOkKfIPzxM1OGvHyaxnmgcFvu7TFEfr+Ghl9yJIWUlUSGUnv7XQCAfhHRgWL0v5bP
         IWAxunEPLeefjeEALzZY1jnkyGBQDjazW9O3bcDClAhuUkxOi8l8Yfj5POLh0grL1t22
         aMdMbvtXZO0Oa7SvxlredWytF7nuav3rLEDUoUAVuLhC9xJb7DYBWfpbZ9CO5MOu5TTF
         f0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nrHj9I7O9lphgMpg3nYt8s6m+DhlUlMF3Q2xQwYP4o=;
        b=Lw1kIOT7+o4+qwEmCy2D2cw5lMQZrxAKzByFv4rW4XOcwcg9mbIvpi79L4r+os7iOj
         kws44sLm5DyjchOc3ITiuyQbCNTv2cmzOynq1X7EPbtON1IM+2qRimAU3UfyO54u/K0w
         MVm12xDSMXdzieiYqfoB4Gb4zuDMpULTtt6BLjyYIn7vYR3h0t/+BXylC6nh9zFd9La8
         xGRUT7NDzZIpSFQ44qvNSIpLc8KabXtyhPn3aEDyTjaxn91Y+5kLyvTrOZUkew8P+fqx
         wz0ObOry+yi6PKF2W3i7ljdP4H4gbITNpNnpax6401gi/l01pcoI9XF9s5wQmzMF1WT2
         178A==
X-Gm-Message-State: AOAM531qBmwPBHTMZPsXTsXG25QEfoIASWUEZLyrzrjWqoN6zHvQUIQq
        51oPexegUQ0B6R3nhqheCFPVVA==
X-Google-Smtp-Source: ABdhPJyQlwnTdOQN8O42Q8fGi8/D7oqfz4eeL8TeUHl2gPGc3qd3UR/PR3mSgO2NeUBm2nMrBpNovA==
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr8796864wmf.111.1599743106742;
        Thu, 10 Sep 2020 06:05:06 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id p16sm9321988wro.71.2020.09.10.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:05:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 08/11] rtc: rx8010: prefer sizeof(*val) over sizeof(struct type_of_val)
Date:   Thu, 10 Sep 2020 15:04:43 +0200
Message-Id: <20200910130446.5689-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200910130446.5689-1-brgl@bgdev.pl>
References: <20200910130446.5689-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Using the size of the variable is preferred over using the size of its
type when allocating memory. Convert the call to devm_kzalloc() in
probe().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index e401d8ed0e19..0665878e8843 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -419,7 +419,7 @@ static int rx8010_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	rx8010 = devm_kzalloc(dev, sizeof(struct rx8010_data), GFP_KERNEL);
+	rx8010 = devm_kzalloc(dev, sizeof(*rx8010), GFP_KERNEL);
 	if (!rx8010)
 		return -ENOMEM;
 
-- 
2.26.1

