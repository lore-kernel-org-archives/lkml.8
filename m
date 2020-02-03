Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9249C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A043920674
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bp8+Uco/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgBCNVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:21:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgBCNVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:21:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so18113040wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wi18qa0MrlL/7K66WwSCllXqfZXEgraYZcR91lSYDNE=;
        b=bp8+Uco/w5cV6S55A/YKo5bqO7+Pr/oxNg0Z6oluQH68KFgb2DyxJH1EwAdG4K/oCA
         RgZ8wCPi+pDA22I3GDZ+m/tglWqftq6a2mbvb0dmPxDZIl6MlarANf/SciK/eh01HGNg
         zH7H9/rPxFUMrbqchrYmegcJnZL0vNEEiNesSql4aYUXj1ljvecw397nIZH3qASJWysu
         NXQvoUfF9qP9WQYbBDslrIyaU0HYyFNfUUoReu2ao0QXNWUrFGMOZCSRMEg09zjRiJLw
         3AxNeaITML3GClFIA311nFdYiGnKiC2ehyUigKDabL9y7VQ+GrENKIYocO2ZosgQRBZ3
         Yd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wi18qa0MrlL/7K66WwSCllXqfZXEgraYZcR91lSYDNE=;
        b=tyrgOTHrGGkUmKG/3XLrhDV1PzrICCiDVUWalc9S2NDuDCYgYMO1veDEpRIn/0TgjP
         skFZspvb1cjPS0/ANkv4NsoFNE8DHIdUkgq6duENEQd9UMwJ4WPfpqZ593PFsKx9pm7d
         Vn2hmjEmtRInSbvd0yrTQPxdkpJzcPnsnL4cCoa2boJiK/0rkg6R4O8GZbQmaFKs6dPf
         5ihDEhtA8tza4ppfTUI2XC3Bvagko4+sfyFd+c+xyoXFB0JB2vPLL6F6iwpvl8O6wtLP
         lHcD/3LzQwwJNTEN7dnZQG7GH1PrsqQ7E3k1v6Y+9sAWcHOsFjOKBrjfIMw1RUhIp5nj
         KSww==
X-Gm-Message-State: APjAAAVcWXKX2tP/l0P5Fo0Ywi14KAvtZRBvN6w7nCwAZj8K5OiQSITc
        AXizpBy9lXDsEGJSrJ1daANwl3G/Zec=
X-Google-Smtp-Source: APXvYqzSJpvUoeMx6zIu+JC/mHzWGsTSVjVo4y40fmiz9jSCiVrpzfukntQzLAl4MzTE3YGEZljuuA==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr15054437wro.375.1580736075590;
        Mon, 03 Feb 2020 05:21:15 -0800 (PST)
Received: from localhost.localdomain ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id z133sm24623094wmb.7.2020.02.03.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:21:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] media: si470x-i2c: Move free() past last use of 'radio'
Date:   Mon,  3 Feb 2020 13:21:30 +0000
Message-Id: <20200203132130.12748-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pointer to 'struct si470x_device' is currently used after free:

  drivers/media/radio/si470x/radio-si470x-i2c.c:462:25-30: ERROR: reference
    preceded by free on line 460

Shift the call to free() down past its final use.

NB: Not sending to Mainline, since the problem does not exist there.

Cc: <stable@vger.kernel.org> # v3.18+
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/media/radio/si470x/radio-si470x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
index ae7540b765e1d..aa12fd2663895 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -483,10 +483,10 @@ static int si470x_i2c_remove(struct i2c_client *client)
 
 	free_irq(client->irq, radio);
 	video_unregister_device(&radio->videodev);
-	kfree(radio);
 
 	v4l2_ctrl_handler_free(&radio->hdl);
 	v4l2_device_unregister(&radio->v4l2_dev);
+	kfree(radio);
 	return 0;
 }
 
-- 
2.24.0

