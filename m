Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3149DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D54F2073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3utOKUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgGGOjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgGGOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B6EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a6so1897077wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceIee8YBFX9kzqJWoK/1iqOS7aaLJ7GoK8i5sFpusg4=;
        b=a3utOKUUtmKkFumgYHWsrcA1cg/wCdSJzx/eQgQLrrlD+gKnImbCleOaOXKOhYAKbQ
         wFtcCg0Zo07kbM7/6b2WCbMEHtqRx0z5z8x45mkeHdE3bvPHfdCb/TUOyMt7XXoEq+KQ
         o8/c8hFiFt4TI3ZC+VsiuM7fi3SZ8WfEOadMim+lOC72FVkmNDmll/pBDzmpXzouNgZF
         mUbq2kGI6/L1hRYrnhevYOeHjGlQmRVZAAtBN2SQ6pF+rb9isxab6LqIUpDrOsAI0MhP
         DQwJZds52dUHxrq1ypA88jHKSu/zyLTc4WUK+bTAjzBhJXhdv7fX8pvOqDcGdewSDIZG
         aGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceIee8YBFX9kzqJWoK/1iqOS7aaLJ7GoK8i5sFpusg4=;
        b=hHGe3Zfb9+3YabPMzPtsSfZFzfz0Q72eyfIvfClJzdn7IIUf2enazfMQhh7/Gx2xGC
         3gb0F8AkBSHGS1SyLc+SvsPHabJc3XyhG/J7zgYHD20JWAFhPZi71l/2GZIF2dEqC4XL
         WN68/OIzVbOCq5UbwG2dZcNMQL5dhBK6r247VeDtWd/QCKee53ihsq2olW+4nWde/j8r
         KJFuWDcQYL0L6zSgm1PhYUczZI6zpyPwqR3Q11qfchw8wRxBx8Dy3TglGMdU+WokvGRJ
         9N7PcKWR9eb99cX1ug24Kj2DPFUu25tnaITCRTQpPOXHUAyijnwSTovnS74gFhJc3vwn
         QBbw==
X-Gm-Message-State: AOAM533WKik92T5+uaFeYltgACgUtEYAKp1vn7h54lKmvpH6lNAXd0rv
        3O382XYXNo9QA15j+e/alLn8tA==
X-Google-Smtp-Source: ABdhPJwBhFtwMc09q5I1X/u5knzfYzz3vq0gulrDOAYoVOgPpYR9Udx/EMDFNfeERzWsGHW0kriQDg==
X-Received: by 2002:a1c:b409:: with SMTP id d9mr4245606wmf.99.1594132682705;
        Tue, 07 Jul 2020 07:38:02 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/28] ASoC: fsl: fsl_esai: Add descriptions for 'tx_mask' and 'rx_mask' to 'fsl_esai'
Date:   Tue,  7 Jul 2020 15:37:24 +0100
Message-Id: <20200707143742.2959960-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_esai.c:86: warning: Function parameter or member 'tx_mask' not described in 'fsl_esai'
 sound/soc/fsl/fsl_esai.c:86: warning: Function parameter or member 'rx_mask' not described in 'fsl_esai'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_esai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index bb3c405df623c..3f67f4a465780 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -49,6 +49,8 @@ struct fsl_esai_soc_data {
  * @fifo_depth: depth of tx/rx FIFO
  * @slot_width: width of each DAI slot
  * @slots: number of slots
+ * @tx_mask: tx register mask
+ * @rx_mask: rx register mask
  * @channels: channel num for tx or rx
  * @hck_rate: clock rate of desired HCKx clock
  * @sck_rate: clock rate of desired SCKx clock
-- 
2.25.1

