Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4CFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA750204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ScABqrn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgGPRJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPRJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:09:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:09:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so5158293pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YUV7baZS3QMy6H9iHTF1vq422tSxwwdhocsQIIKpJ8=;
        b=ScABqrn1IiApBTOd3uwWZ9zcKyBA/0MYgYViGsTpujPuZnW3GdtFtgxyBI5AFAzYl3
         fUrxQg8yGnew+6F9JimmYfj2uOabAogHKPhV3U7stmqIjUvfIAn3FmaffVO5I3+Cc4Bc
         vhXwlBO1ze/qqLGqmg/EgekmFJZAfA2nMSGkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YUV7baZS3QMy6H9iHTF1vq422tSxwwdhocsQIIKpJ8=;
        b=JHZWFN3V/2OWidMSCTsbFNvkcw37T+LHK9HfSunz4T07yxOKChTEdBYCW7EETH7wqA
         gS3EWeu9WFhTNjnAeGtQ3KI9MA63/GKZ3j/lORzuAjblswsJZvGHLMQNBXaUhUQyYqW5
         ip5h75b8m1E+CuV4dqE6SQAvLaT5iX659hTxzyf7TkSV6Jww74XmibtXEqiunVG30fb3
         B//j5/xIwuec6VEiP4rvPR4abAhp74HBYwbImz2GHqeot66x2h/YyOF618gEhqqGo586
         NFqYWuvBDGC3X/uylTf6DtVn05E1pyNTmDAVQo8Xx8MFyqE5V595FfofTrhla7BmlXUR
         NfRA==
X-Gm-Message-State: AOAM530erqVNQ+h/ppThRzFt/VUDIyGoaNPkJHW577TrwKkvc0YeOYGe
        XGFSHKvL/qkSfdBh7qnVbVkWop2XP0XupQ==
X-Google-Smtp-Source: ABdhPJwER+Qj87J/ACr8CCYXvpcmu4jIfvu9bYRFuYv8jUqPfgcWzZLmxBY+kzYo551VD6jFfDqMQQ==
X-Received: by 2002:a63:cb03:: with SMTP id p3mr5023403pgg.444.1594919364719;
        Thu, 16 Jul 2020 10:09:24 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id c71sm651622pje.32.2020.07.16.10.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 10:09:22 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: cros_ec_codec: Reset I2S RX when probing
Date:   Fri, 17 Jul 2020 01:09:14 +0800
Message-Id: <20200716170914.3623060-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not guaranteed that I2S RX is disabled when the kernel booting.
For example, if the kernel crashes while it is enabled, it will keep
enabled until the next time EC reboots. Reset I2S RX when probing to
fix this issue.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c        | 7 ++++++-
 include/linux/platform_data/cros_ec_commands.h | 1 +
 sound/soc/codecs/cros_ec_codec.c               | 9 +++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3e745e0fe092c..2c60690d7147c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -572,7 +572,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 		return -ENOTSUPP;
 	} else if (msg->result != EC_RES_SUCCESS) {
 		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
-		return -EPROTO;
+		switch (msg->result) {
+		case EC_RES_INVALID_PARAM:
+			return -EINVAL;
+		default:
+			return -EPROTO;
+		}
 	}
 
 	return ret;
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 69210881ebac8..11ce917ca924c 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
 	EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH = 0x2,
 	EC_CODEC_I2S_RX_SET_DAIFMT = 0x3,
 	EC_CODEC_I2S_RX_SET_BCLK = 0x4,
+	EC_CODEC_I2S_RX_RESET = 0x5,
 	EC_CODEC_I2S_RX_SUBCMD_COUNT,
 };
 
diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index f23956cf4ed84..b5ff30b7f1aa8 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -1034,6 +1034,15 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
 	}
 	priv->ec_capabilities = r.capabilities;
 
+	/* Reset EC codec I2S RX. */
+	p.cmd = EC_CODEC_I2S_RX_RESET;
+	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
+				   (uint8_t *)&p, sizeof(p), NULL, 0);
+	if (ret == -EINVAL)
+		dev_info(dev, "Missing reset command. Please update your EC firmware.\n");
+	else if (ret)
+		dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
-- 
2.27.0.389.gc38d7665816-goog

