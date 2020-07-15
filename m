Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D65C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEB8206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ry5LXTgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGOPAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgGOPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:00:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4835FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:00:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so3107544wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wqhk2njYGDUfvoMiCydF/NDRZ8ScZRwPRcCbCDujnE=;
        b=ry5LXTgbZguG/UbPzILmwKElT6GKBM5G62IceUKmo09VsGFygkrWJmWgxzQz76lEEo
         aLHL0cRraTsvdR/LF9LWJh8Nn97hMd8kAe8V9KrkvSQGoYDADP9sdQKyeuHqyLtMW4qh
         xxC3Cnlla8Xuh+J+2Lg6qknxvSzDUmlnLcpzBN4BMNtxp93AaETvkOjg4W+MEghbT+K7
         tMs8rXohsO3OmNxtnH9BrwkubgWjHesAcsO+i9SHL1vDvXB7M0P6atXH/VLCHaczu1dw
         fgFRit+KR6r3mQymLryq7vEcRXyldu5TlPdyPtlwAmp+O+asuZpqZnvlkaJrRexOm/PX
         RDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wqhk2njYGDUfvoMiCydF/NDRZ8ScZRwPRcCbCDujnE=;
        b=egMmHTGbLjmKoeUydHJjJuC6SMb00qGSXdsp5C5ngbUIJSmJVCKS1O9HkivHj5hCYF
         gsf9VYKcFwyoZ0YZDPGpMMnZPQc3Z/5lNbEagR5YNG3kul7U31pyIMTKU9ocvTs6ZgJX
         8yC3QlTPA15OkpNDCyHS1JQB44MwQezpVHXmtKzAz8jnX7W76bsuaV3+IQyaqZQ+FyUr
         ztgYTbI3rtcGyTctdnL93OlDywaPpkjiBED3DuWP81VNxE+e6UTPk+FjqyKnaYokEsH3
         Zfx7sz53FO7gaHkv/2best1+cf/LT7HwdyjNyLyXpIgsU2f9DAiT/FIgM/vJKSrZTH/y
         wtdw==
X-Gm-Message-State: AOAM530n2rsJhXU4BVgqhjeoQi2VHhdzB5SZFtYrDNuwOEKxu2frF64D
        zVQL2WMkK0N1bOxDwetFqhMRvw==
X-Google-Smtp-Source: ABdhPJwl5O0qynyiyO/vc5c/ivb3JgK51iUfxXzUA/hJSpiRsmDsyxdWa2OMgLVTth8tM/eUlUgRIQ==
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr12567153wrr.226.1594825230041;
        Wed, 15 Jul 2020 08:00:30 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l18sm4007435wrm.52.2020.07.15.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:00:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling of 'exists'
Date:   Wed, 15 Jul 2020 16:00:09 +0100
Message-Id: <20200715150009.407442-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index faac6ce9a82cb..dbacdd25dfe76 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -92,7 +92,7 @@ struct fsl_asoc_card_priv {
 };
 
 /*
- * This dapm route map exits for DPCM link only.
+ * This dapm route map exists for DPCM link only.
  * The other routes shall go through Device Tree.
  *
  * Note: keep all ASRC routes in the second half
-- 
2.25.1

