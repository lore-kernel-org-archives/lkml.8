Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEEEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F21207BB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LShq89WJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgGGOiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgGGOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so42988476wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3fyU5lC2kiQoR/Tx6i2htjANdo4PmUgTNG8kh6JAhc=;
        b=LShq89WJxb94MrlLI3/486aK65cDtxG0oE+rhlgTmASAYfb/Np7yb+JavN6r2ft9ig
         AwQPAs5kHPqycz2QUKlP4nkN/SKskU0kSdYnqHPC74v0/benUGDSMuVmY2/f9Kipk6RW
         gZmZE9RA44h5S5//yiG8puSQxxYPDXovIrKY8v5f+Mu99NOeUtvlkmdl6/y/m2bq0Eze
         5J3TuNo5qLEoDrceDVnvkr9q/2nSp7tHNv64ApVICS1NVKPt1+GK6szIpP0evAVdgyBt
         S8R/3ZsAgU0rXkkv/pvPnnvYjSwjwm1cv4QUDBxGcUOalIMy5y5VPw2rQ+iAfJLU5D5R
         5AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3fyU5lC2kiQoR/Tx6i2htjANdo4PmUgTNG8kh6JAhc=;
        b=H/tFZNMl3a2Fk4eolN1DLeYKr0mvdmQ4lJLfWUtqTQjZTQguAYYIGEe44F8D9CcYSE
         CqLWei5IYBl+b/+Vk3hIM17XcY/iSX0kR1xrur73Hu5ADYtaDZ0UTeY55RVQMgTJZIPG
         w2UZigW4KWutWBtUi5Oap0SrIgDBypJYhBX2K9WJRwDL4KQhMar2uutoQkyi4yFFEuRZ
         3BeWtZFMMlWbZ7iMa4BPHEbWZZAL0kjgNzmpPNEc0IchnXdX/xjYVRVfil/o1UX0e+nc
         9t2QPL/XkEEuJoer+vTVKSgq57qaaAARXDQ8tj8lSkV4L+5tu2fq5lDj5zUJ6hIOjaU3
         Lomw==
X-Gm-Message-State: AOAM53023ioHa/WMnpqHwU2PW9Jub3rCST1ju2UAMbLvBi/QKRFiO+go
        mtf8oqPiI1+E6xqXwPoXueJNrA==
X-Google-Smtp-Source: ABdhPJzqqvWG7oi6hsuXMzqyAR794fl+k3BzyasAa7HE9dNDChNhc30Io0ZzoSOzpgV3OPJPWurV5A==
X-Received: by 2002:a5d:4607:: with SMTP id t7mr58171903wrq.251.1594132698293;
        Tue, 07 Jul 2020 07:38:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        David Chen <Dajun.chen@diasemi.com>,
        Kuninori Morimoto <morimoto.kuninori@renesas.com>
Subject: [PATCH v2 22/28] ASoC: codecs: da7210: Fix formatting issues in da7210_set_dai_pll() header
Date:   Tue,  7 Jul 2020 15:37:36 +0100
Message-Id: <20200707143742.2959960-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects parameter documentation to be in the format '@.*: '.
If that convention is not followed, the kerneldoc checker gets confused.

Fixes the following W=1 kernel build warning(s):

 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'codec_dai' not described in 'da7210_set_dai_pll'
 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'pll_id' not described in 'da7210_set_dai_pll'
 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'source' not described in 'da7210_set_dai_pll'
 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'fref' not described in 'da7210_set_dai_pll'
 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'fout' not described in 'da7210_set_dai_pll'

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: David Chen <Dajun.chen@diasemi.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/da7210.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 0c99dcf242e42..159b5f0eb7100 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -971,11 +971,13 @@ static int da7210_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 /**
  * da7210_set_dai_pll	:Configure the codec PLL
- * @param codec_dai	: pointer to codec DAI
- * @param pll_id	: da7210 has only one pll, so pll_id is always zero
- * @param fref		: MCLK frequency, should be < 20MHz
- * @param fout		: FsDM value, Refer page 44 & 45 of datasheet
- * @return int		: Zero for success, negative error code for error
+ * @codec_dai:	pointer to codec DAI
+ * @pll_id:	da7210 has only one pll, so pll_id is always zero
+ * @source:	unused
+ * @fref:	MCLK frequency, should be < 20MHz
+ * @fout:	FsDM value, Refer page 44 & 45 of datasheet
+ *
+ * Returns: Zero for success, negative error code for error
  *
  * Note: Supported PLL input frequencies are 12MHz, 13MHz, 13.5MHz, 14.4MHz,
  *       19.2MHz, 19.6MHz and 19.8MHz
-- 
2.25.1

