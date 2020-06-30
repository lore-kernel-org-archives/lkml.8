Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B10EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C5220722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a52p8zpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbgF3NeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388164AbgF3Ndy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB66C03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so18130349wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxMqnKZ6/vF3Sz1VG4ZmVbGw0fGc694S11E5HGVbx6s=;
        b=a52p8zpDtHp2BZaKl7cLaCsGbQRImiqq+vdYMe+DEp24dRvPaj0y8e3Kju7zD0XhYx
         CLwU8KT53+rUeG44oD/jA/JijDdkch9F3RMzyJ1ppCeX6KBs/ucps8SozbJzpjtw6mOt
         jBoBo02vlcgoUfsxeIazznL9FhHExCEjjRFK8stugey1p6cx+rMZ1SxHayD+46hcaVCM
         8V8ZwOXV3CqPMIqYBokS0zQGkEJG0UQuUU44tgL2m9+EtAqzEEXvqj+MCGmqaek2aBnk
         AuLUNAngsZhaTMBEpLkFjYtH/YvrrGCbOElVQH/o+cZUwBRqtDsh5w6OHa0fU394DeRV
         X+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxMqnKZ6/vF3Sz1VG4ZmVbGw0fGc694S11E5HGVbx6s=;
        b=lE5CMzrG2yEb8xq8NK572l1UCoIdPJR4cVvrWsCDoP/+FuIFNe3SClhTUV/5xs4SlY
         rigaT0PDnrcvarcPR+SYWU6tucC+XZe1OVyqp6OHZ2Yk/55oyqIOrXP9SiRgMt3iFpty
         3W6/zotjRSlxb5sr1xSt1m1P2NZoKSi5S6hRja+UC4rnkTTSOlwuve+Yg2AoDLW6uXEE
         5ETCI7PcTzcqbDKH+FAfaRVhQDfALApne7tIKZUpK+jRmifduCEIyjIJGtcFLYwRMQMB
         4XGrc2XRhX3SzvFJgppkZdWUJVLSnaxAXe9v/HgILHoDRJlNefh4WSU8xVzGhRjvT+AB
         qe9A==
X-Gm-Message-State: AOAM530k6hq5DlHuL353ZgClB0oey6UzASQBu8JFEn7tGn+RPP3A+/EO
        +u4isnPWlrfUVdPH+33Lrufk3A==
X-Google-Smtp-Source: ABdhPJxjet3Fft4nPy2UchykKdNnrGWHxB31uPrnPEyWDLwTGsb3FgesECowF9Jy/VDozg8ma6IePQ==
X-Received: by 2002:a1c:1d04:: with SMTP id d4mr22807105wmd.156.1593524032982;
        Tue, 30 Jun 2020 06:33:52 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 04/10] gpio: gpio-pmic-eic-sprd: Fix incorrectly named property 'map'
Date:   Tue, 30 Jun 2020 14:33:39 +0100
Message-Id: <20200630133345.2232932-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133345.2232932-1-lee.jones@linaro.org>
References: <20200630133345.2232932-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A good attempt has been made to properly document 'struct
sprd_pmic_eic', but 'map' has been incorrectly described as
'regmap' since the driver's inception in 2018.

Fixes the following W=1 kernel build warning:

 drivers/gpio/gpio-pmic-eic-sprd.c:65: warning: Function parameter or member 'map' not described in 'sprd_pmic_eic'

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-pmic-eic-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 05000cace9b24..9382851905662 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -48,7 +48,7 @@ enum {
  * struct sprd_pmic_eic - PMIC EIC controller
  * @chip: the gpio_chip structure.
  * @intc: the irq_chip structure.
- * @regmap: the regmap from the parent device.
+ * @map:  the regmap from the parent device.
  * @offset: the EIC controller's offset address of the PMIC.
  * @reg: the array to cache the EIC registers.
  * @buslock: for bus lock/sync and unlock.
-- 
2.25.1

