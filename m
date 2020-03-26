Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC38C2D0F1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEFB20848
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLPuirHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgCZU2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:28:35 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34937 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgCZU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:28:31 -0400
Received: by mail-pj1-f65.google.com with SMTP id g9so2897172pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Xte6JTYhfOTcgtkbBUqBG8iaUvqvtXol2sJNIPpD2qg=;
        b=MLPuirHGxydXDBDRZ/xS5K6PiE7OSPGqDuv1UUixk/NsNG4Ms77hhxCR1N5IgaN+VZ
         Uzk4cKJmgTNuS9TWCy8yHKM3yq8mkwR9mjDjNfaBHz4qjmU1tUABlldm9arG+HGnpfVQ
         CwgIs1L8aV4hlb4nve2gu76drB5ebHn2GNqqJ2P8CVMdb7hho7tXSYlTnwcoGNO/Gge6
         0V69tqDwVk0mr31mszkfpb2xsleKtpCXA4Rcv/hqq6nl2C3kYwZ69OWx/Cqwv09d9Q7E
         w3jFhjx/V9eOXuaCdSKdK9DDOJiI21QW1ceJfqo6PALNdD7aD7ebxv2vxyVWCPFRx7U3
         weoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xte6JTYhfOTcgtkbBUqBG8iaUvqvtXol2sJNIPpD2qg=;
        b=aHklTD2SEFT/A0TXuwrtaKuVmIvQEY14RMBvDCWf6DY6nb534zcBpTuSry08+6Y1df
         0BTfeOPfeqnwvDKFEdEmwLeNUTDThNyhjlSQyVEYAk4X+GQa44OMjM5vN81wTUzCkuiv
         dCgNXY6BzH+vi5MVAD+jJL3qZC1YJRtqy/4oaovdAAGkOkBtTqz2zsjcvufjK3aJKZAw
         xblSBx8Yul5Fw+d46iKLjwSRmClbFcI7sWmyULt2HzIPUQvtoP1zHldcid/OZcVZkuwA
         uVb74qSrX+dOYlid9i2k4OOw7XHp+gWXoNqiB6i5EDiu++0AJ4ac1BzwC6fUW7XEsfRx
         +wpg==
X-Gm-Message-State: ANhLgQ0jgoa7A96OVrcPkuB+auKZLJkIR+bdIpCDXYmXpmgY2jHNVFgF
        iasPBOF/3u6N3GvFEO3o1a1sYqlQvFc=
X-Google-Smtp-Source: ADFU+vv8mMJ10BJLLfBfuu/iGF6cLP8/TyK5cqm4Nq49tE0IEbuHt6E21hY4YyuZiM/BTEDTCXZFNA==
X-Received: by 2002:a17:90a:eb0f:: with SMTP id j15mr1891679pjz.139.1585254509470;
        Thu, 26 Mar 2020 13:28:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r186sm2428879pfc.181.2020.03.26.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:28:28 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [RFC][PATCH] sound: qcom: Kconfig: Tweak dependencies on SND_SOC_SDM845
Date:   Thu, 26 Mar 2020 20:28:25 +0000
Message-Id: <20200326202825.80627-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CROS_EC isn't strictly required for audio to work
on other SDM845 platforms (like the Dragonboard 845c).

So lets remove the dependency and select the related
CROS_EC options if CROS_EC is already enabled.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rohit kumar <rohitkr@codeaurora.org>
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 sound/soc/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 6530d2462a9e..6f1bc6ea130e 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -99,12 +99,12 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && CROS_EC && I2C
+	depends on QCOM_APR && I2C
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
-	select SND_SOC_CROS_EC_CODEC
+	select SND_SOC_CROS_EC_CODEC if CROS_EC
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.17.1

