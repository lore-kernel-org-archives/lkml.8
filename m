Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB9DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903382088E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtNMIWpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgFSDON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgFSDOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:14:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB29EC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:14:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so3854159pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=07k7/aElZ8IDLCRU1K4WL2sU+mJSMesA92lX9Cgm4xc=;
        b=jtNMIWpCdbUvuwaeyg40ayk1MkX3OBzqXRCdE2UYXvjV9o8dIAvuVO2NSvYqEi5t0F
         4tqrZ8VeiUZOScf6O7CzKyIWPP7XWwOy+fswvSqLV7vuZvoxwgrzGIuw+4PyiIt1rDOU
         yYyZvXsrq5g8glNsjNH8wMcUQ3CYIw7tioOhjtGC9CYyiv0HyIK0kgfKw87izG6+7g0r
         F/BUxjjzcEHBNtqGczqVrOvqUGj0NSv0cE+IBU2V8SFdXs43jV23phebv4Ulr22UdneX
         pXmV1JHmu5zgaA3rkzNmoO7aplf7u0kYlZh6EOKVfg9ET48WARQxgaWrcLYJYp+182zk
         bGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=07k7/aElZ8IDLCRU1K4WL2sU+mJSMesA92lX9Cgm4xc=;
        b=HQSoohhbHOyy8kJXFBXy8yr7wBkj43ISSHjPLqEdEaK2clYRNrhmOfC4xb0j3A5CGC
         E1xIffxkjdBy3cmvBIaAsTRgal5AhiPP/ka9FethqYXWXtt0qUGk1oHffXbjEQtMnqGt
         N7AGgsMUuDylCWSXSofv63qokyZQDsg2TbVk2eyjTcMGIDNsDbFr35y+H5jk+U7MmlbZ
         fCdI4L+IfmBvDrS7SfWj5zmcGRu3BZHtcwpWIxKeFWA9jOeLQEdtqm7t6LEr0/ARR8SD
         1oR7r8FbzYEDaqoDY7IcFDBu6SJgxQouvJUUKyfLJ6mp3ehUWXaDo9V1q0NsVW2eXQMz
         vQzA==
X-Gm-Message-State: AOAM530BjbBzvtvFXrr6OPA0n5z22bnTsZLIMEQ93eEd8XEu42il7dB5
        dawFSVpFPX6MOMk7Wuh75MQ7B51y7NY=
X-Google-Smtp-Source: ABdhPJwGwCVcBLgClj3L2vTEWGSoJjxxWLP+tqv/lhVv4JWDOx2UhrGvfsXrcTPDwl8DUTPlqWO5Wg==
X-Received: by 2002:a63:fa4d:: with SMTP id g13mr1374296pgk.26.1592536450109;
        Thu, 18 Jun 2020 20:14:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id u61sm3842579pjb.7.2020.06.18.20.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 20:14:09 -0700 (PDT)
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
Subject: [PATCH v3] ASoC: qcom: Kconfig: Tweak dependencies on SND_SOC_SDM845
Date:   Fri, 19 Jun 2020 03:14:07 +0000
Message-Id: <20200619031407.116140-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CROS_EC isn't strictly required for audio to work
on other SDM845 platforms (like the Dragonboard 845c).

So lets remove the dependency and select the related
CROS_EC options via imply.

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
v2: Switch to using imply as suggested by Srinivas
---
 sound/soc/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index f51b28d1b94d..0ea4cde9f4f0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -99,12 +99,12 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && CROS_EC && I2C && SOUNDWIRE
+	depends on QCOM_APR && I2C && SOUNDWIRE
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
-	select SND_SOC_CROS_EC_CODEC
+	imply SND_SOC_CROS_EC_CODEC
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.17.1

