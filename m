Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D530E206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MFfhw4Ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgGHHL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgGHHL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:11:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1CCC061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:11:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so14706536pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+a5Yprqxr4YrC8ddRW3zptpr1c8vgN9ZuXvWQPKlFVg=;
        b=MFfhw4CakjJVB9f0UmWu8pC0qAsbx035oeNJnZ8AZNdtg7Ji/ZCHbJVR3yXwhItAPs
         F0QRtUCO6DB/ikQWHkEDO36hf7A63FNsqRaDtQPm3wBHQpkrORRfGYteBm9LFZNjOtFN
         IT+sXoF6yYRCFgT+8Y9qMWQMJ4r1ku5nRbo+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+a5Yprqxr4YrC8ddRW3zptpr1c8vgN9ZuXvWQPKlFVg=;
        b=dzezYTZiGQC1iaZjoib14+C4KcnWLz4zPXxFnjSWXzV7zTWibIrFBPLbA5Ad3jpced
         EFbexlqNx8oLam1vapO9IJBor7jc32fSRiY3WIoFupAGYCuUhdEBglN6Fw/AiI89VHmc
         udYVIcw6wZfDNMJmo8MFqCV+vRXSlVqSQ1xSnT0N80vjTA2Xx7+JnkFEQl5/jWEqul3Y
         bnnYPkQewtzeTImVi+Z/aKbf16Q7+74SHDSs/KMSTVqUjAKmcxd1pVsi/cr4avQ5aRNl
         i0GcDPmFJAsXy68bpBegA1vKCICSRzk54r/PzTg96fUiENwwCZokAcpsw8zNO/ZyxAkk
         g3FA==
X-Gm-Message-State: AOAM533MvUeGHFw+LZ++reWINBe/TwXiRXXiEkdEHs9oxzcBP6SVK0XO
        ByMdY/+gQ07P3J394cFqazzAzDglmM4z/g==
X-Google-Smtp-Source: ABdhPJxPe+FrQXu/yLvuqwBRWqt2yTo1MAuvXoVYQVlzKsLdn7kZhMgTOxEwJgHQeWcJeGRJFQd3jg==
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr27241417pfi.145.1594192287030;
        Wed, 08 Jul 2020 00:11:27 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id q13sm4694320pjc.21.2020.07.08.00.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:11:25 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Yicheng Li <yichengli@chromium.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: cros_ec_codec: Reset I2S RX when probing
Date:   Wed,  8 Jul 2020 15:11:17 +0800
Message-Id: <20200708071117.3070707-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
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
 include/linux/platform_data/cros_ec_commands.h | 1 +
 sound/soc/codecs/cros_ec_codec.c               | 7 +++++++
 2 files changed, 8 insertions(+)

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
index 8d45c628e988e..5495214e73e68 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -1034,6 +1034,13 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
 	}
 	priv->ec_capabilities = r.capabilities;
 
+	/* Reset EC codec I2S RX. */
+	p.cmd = EC_CODEC_I2S_RX_RESET;
+	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
+				   (uint8_t *)&p, sizeof(p), NULL, 0);
+	if (ret)
+		dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
-- 
2.27.0.383.g050319c2ae-goog

