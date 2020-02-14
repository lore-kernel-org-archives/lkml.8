Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88030C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2A7222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TSTqqQMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgBNNOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:14:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgBNNN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:13:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so10830656wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuwuzpsX5RzClpZoSCXE8jPlP14S0+i5Nh9kd/OQAlU=;
        b=TSTqqQMFRXUb+avCLPyEtyy/SXMFgBkz3pOzmJbAzGCp49zkBAxH+R1F/rhbnNxTFD
         Lk+85ejQ9VGaB7p/I4fQH7B7SdZAVt7MLVbNYuC7JYW+x61DQrc2AWz8LSevDK05D5eM
         HcrXJxXWzTXuLSNhEvuWHScbTYgK6y1xzaKe5Lcg9UBtw6PwP9hs115Own9COoQ83NFd
         Ywc8T0gKKEGTgQ/6RHwKCvpXT0LlDeHmBbnWaLQQ+hrEcvsTBE7pSSdiTIZhk4an+wBg
         3pSd5O99tNdGusYKMLiX2H6bckHhb5Oj10pHRP/mJwt2i895/6nWHO18IV24BQyvxVdJ
         /THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuwuzpsX5RzClpZoSCXE8jPlP14S0+i5Nh9kd/OQAlU=;
        b=i2KVLLHU8wk/4hw837/MfcsLPjW6qkRLsB+fEoukUIBQcdwMqid0j9iZrG9vQkIx21
         XM3J0Z8a2VNgqHhA84ghzqgoTqGvzoWj2sxAltsL4oSkrLwebmuNG9/L/9mnBEUAuZXB
         zNMdVmJQKmw4iY7rCoa687Evn+7AJeuTdqZznIS8+z7FbvVSnOUOjYYGg9amzIfySXw/
         Jfr7utZGhgJqklKtaMsUpRGmdbOtr7ckIlMI59MVL3j09aba9aZNBoVz6u7tszyuJjjZ
         kRSTP0EH9i9eiC6AK4SdICR9xOFuBuX8HQ5Ap9WkdZ55MpSnP/11hQkJA3FJIa9M0tY7
         91Og==
X-Gm-Message-State: APjAAAUxgr3uDBRtAhin4A2dod0Mflz87zhHaTwnja0RybOHBbLmkhzk
        Kv9u3iAsDmf3or09HoMaUaupug==
X-Google-Smtp-Source: APXvYqxMHOnNCwLIWDmiOvwhVwAWtwAZf5cc+Xtor4Tr9qkozMweqEkbj+d370UvqeuQ9mcLgqpjyA==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr3985658wrt.162.1581686037685;
        Fri, 14 Feb 2020 05:13:57 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm6760792wmi.9.2020.02.14.05.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:13:57 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 3/5] ASoC: meson: aiu: fix irq registration
Date:   Fri, 14 Feb 2020 14:13:48 +0100
Message-Id: <20200214131350.337968-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214131350.337968-1-jbrunet@baylibre.com>
References: <20200214131350.337968-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aiu stored the irq in an unsigned integer which may have discarded an
error returned by platform_get_irq_byname(). This is incorrect and should
have been a signed integer.

Also drop the irq error traces from the probe function as this is already
done by platform_get_irq_byname().

Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/aiu.c | 8 ++------
 sound/soc/meson/aiu.h | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index de678a9d5cab..34b40b8b8299 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -314,16 +314,12 @@ static int aiu_probe(struct platform_device *pdev)
 	}
 
 	aiu->i2s.irq = platform_get_irq_byname(pdev, "i2s");
-	if (aiu->i2s.irq < 0) {
-		dev_err(dev, "Can't get i2s irq\n");
+	if (aiu->i2s.irq < 0)
 		return aiu->i2s.irq;
-	}
 
 	aiu->spdif.irq = platform_get_irq_byname(pdev, "spdif");
-	if (aiu->spdif.irq < 0) {
-		dev_err(dev, "Can't get spdif irq\n");
+	if (aiu->spdif.irq < 0)
 		return aiu->spdif.irq;
-	}
 
 	ret = aiu_clk_get(dev);
 	if (ret)
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index a65a576e3400..097c26de7b7c 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -26,7 +26,7 @@ enum aiu_clk_ids {
 struct aiu_interface {
 	struct clk_bulk_data *clks;
 	unsigned int clk_num;
-	unsigned int irq;
+	int irq;
 };
 
 struct aiu {
-- 
2.24.1

