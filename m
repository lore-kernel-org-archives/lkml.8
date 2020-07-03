Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F86B2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LuBmQALB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGCHTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCHTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:19:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17909C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:19:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so10439187pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JylBBIg6s0EqS8bdMWdfMXLZabsAcyVLV5Ia1GF24jE=;
        b=LuBmQALByFHpbapAUDv6bqBgiD40v2S3cpXHTBd494VfOxmTeAfoOVxc3X7KJq6rYf
         mf3j3YomUb9B9FUv07321mneQR8s1v3xe+VZhtu4Ez8Gx6bEpl7muNosjsBi7YNyqExw
         PvJH23Kq03SPfX55KZjdgzDNJufwLz/TYl3Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JylBBIg6s0EqS8bdMWdfMXLZabsAcyVLV5Ia1GF24jE=;
        b=FI0CzYCMtk2Mk/44WG+dlV2xCkftLyIDaZxeo8PtLQQ3tnZ1E3PYf6w6cSffuhsk+n
         I8xTqckJR7paD3eyxKbe8UoZfUlRv0xx4MXn1LwBBAxaBCOve9LWNiIJSo2cGkwzk96B
         o/EXovnKHSNAOLVz3/VceWqKwLsaHbysSYsdboszHyGLELd1uIMWH2N3l6dwQ1agiK45
         Wi+BNlJfi2sXdAehhHnIT9QsN8ywWvd3iFrC8tEu4ycP6TmVWNNmwqZGi9uG119s7Mo1
         UgGx6DoSrwPsmkhf2FCewaZApSesmzSJJLONBq9ENDZsHdDywGHbxxecMoo5/bc8CQLl
         vibg==
X-Gm-Message-State: AOAM531NP6QoiBdSojvWtQ7Ak+xrrfSf5voUkELlIQutTpFBqHMi953f
        KwGzBi0QApjMVIF1G0lZbhlC6NqpKxj4lw==
X-Google-Smtp-Source: ABdhPJwc5DFMU7lUMcC9pIOl141dJmNWbcK3lxZkVUgks8KYeFld2VbYBWEOy49NWxeoXdxhvCf0ig==
X-Received: by 2002:a17:902:c391:: with SMTP id g17mr30067388plg.330.1593760760320;
        Fri, 03 Jul 2020 00:19:20 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id f3sm9603746pju.54.2020.07.03.00.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 00:19:18 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
Date:   Fri,  3 Jul 2020 15:19:13 +0800
Message-Id: <20200703071913.2358882-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Log results of failed EC commands to identify a problem more easily.

Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the result
has already been checked in this function. The wrapper is not needed.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 8d45c628e988e..a4ab62f59efa6 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
 	if (outsize)
 		memcpy(msg->data, out, outsize);
 
-	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0)
 		goto error;
 
+	if (msg->result != EC_RES_SUCCESS) {
+		dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
+			msg->result);
+		ret = -EPROTO;
+		goto error;
+	}
+
 	if (insize)
 		memcpy(in, msg->data, insize);
 
-- 
2.27.0.212.ge8ba1cc988-goog

