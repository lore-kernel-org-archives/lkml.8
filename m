Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F5020730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QR9hOFh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgBDLMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:12:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45252 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgBDLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:12:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so22438137wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=euRgUOHMwfJN66fku2jYxRm29ftSwRr6fu8SbqY0eAc=;
        b=QR9hOFh8+DQ+Wvt/lNZuDlLWHuHNVU2IaRasepwiUHsedECyFbyY48yqEPWM46xj2j
         s8MB5JYLY6Q60MBOot/ORXhodw2GJm/Ox/iyFC68DjNH/LpQhF6OUWUQJj9EEcZMU2q1
         /4bBog0EPt0RpSrgYJtvESydtn3pYJhLHVOd+2Cuw9PatT8UMB3jEd4pPUEbzA7wwHWt
         mIOQLUGGL/hIULvoI7fl9eW0jSpDoVgoaUphCna44YwSA91qE5XxSRTjyZ7rZN0VM4Ud
         V0ghFEnNcZFYzVPsNQCN8LWBp6RQNHomFMKolXW61dReQbALB/w7HuQMJztKGg8UxxiN
         ToaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=euRgUOHMwfJN66fku2jYxRm29ftSwRr6fu8SbqY0eAc=;
        b=FbCUjzdxw2+WstPgIuzN0+LzV1+ZO1M0t9hvgKPMjPX36bvYVb+w3doGvC86KrBOly
         UDjKR9AU2CSNZPzr+CCoDv2/L75DXTKBWv9ne5mWONGJ8twhy76H8TN8WmHlDrFxWRC0
         LvW+yiYo1BA/0WbeRpMCKOjqzDWLDLaNxrz74CRPKFr2YqIuxHE+ylFfzT22MiF33Y5D
         ngkUbzSlCSloZwll5SX8yHuxnoq3Q9SS/0jldRLeqoOUkKy87I2SeW4Ii8qaof+/XaWn
         1lpgIOb6tuB/vmBZ8notSmgqUFuq77vJ7Y16zd361k+X6roqiIF+dnFgvl4BK0QBrEUl
         6ZYg==
X-Gm-Message-State: APjAAAXhSfvn78euVKJX+SsvkT4i8l40Lf/CeXLW8yVrgj4xLREvRsvq
        4IM47jDkFl2nrA8FXB/UG5WCqA==
X-Google-Smtp-Source: APXvYqxJ3p0f3NqaYyzd6dHvDo+rS6RPnTDwxFF8uIb22oszcbFEPq5OjqcdifqgHTlmhog/UyIEhw==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr4772043wrn.327.1580814766507;
        Tue, 04 Feb 2020 03:12:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v12sm3239378wru.23.2020.02.04.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 03:12:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, sfr@canb.auug.org.au,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] ASoC: wcd934x: Add missing COMMON_CLK dependency
Date:   Tue,  4 Feb 2020 11:12:41 +0000
Message-Id: <20200204111241.6927-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like some platforms are not yet using COMMON CLK.

PowerPC allyesconfig failed with below error in next

ld: sound/soc/codecs/wcd934x.o:(.toc+0x0):
	 undefined reference to `of_clk_src_simple_get'
ld: sound/soc/codecs/wcd934x.o: in function `.wcd934x_codec_probe':
wcd934x.c:(.text.wcd934x_codec_probe+0x3d4):
	 undefined reference to `.__clk_get_name'
ld: wcd934x.c:(.text.wcd934x_codec_probe+0x438):
	 undefined reference to `.clk_hw_register'
ld: wcd934x.c:(.text.wcd934x_codec_probe+0x474):
	 undefined reference to `.of_clk_add_provider'

Add the missing COMMON_CLK dependency to fix this errors.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- Rebased on top of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git next branch

 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c9eb683bd1b0..286514865960 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1334,6 +1334,7 @@ config SND_SOC_WCD9335
 
 config SND_SOC_WCD934X
 	tristate "WCD9340/WCD9341 Codec"
+	depends on COMMON_CLK
 	depends on MFD_WCD934X
 	help
 	  The WCD9340/9341 is a audio codec IC Integrated in
-- 
2.21.0

