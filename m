Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874EFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6103D207DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjsQaDQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgGGOiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgGGOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83FC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so45291538wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvkfvflL72kN7LZNfXrEA+gETlAfB400MfXaywOwHac=;
        b=mjsQaDQYPUXaqe/g2dKsXNXr+7jrGE4gHc1/ZEMmctM17H8epnfpYGpc69ciz9exAt
         vKN8+AkaEx/gn6EHBU4QVRlYPfIlD8sgXTzscKM0wzZM+5oJ66huwErQbKU5PZhbrEah
         Hws2v3v6fr8uOj1dv/ORfJaSw6pYCv0r8IXkBLQpmjRoqokN8O0qao4Jr8+hX/5FYrdb
         V2kE4xzZgYRakwN/LsCwncknbGHnJaFL7XuNqsTN4VXculb3MKfwjPe4956FyA+mGSjl
         QWzBADvD2hhEkushVerjKlac8O1Zwi+91Y/OSC/0qGkTkOO4aBJsUGT+Ta5vxSmLmFWA
         C/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvkfvflL72kN7LZNfXrEA+gETlAfB400MfXaywOwHac=;
        b=N7CB8wr8copPvLoWFOpCPXdAmM+g8+L2wOVpyhtKbfrucT6d1Xp+r93Dd6eh5WwHWc
         tJC575nNCYv8o5uzCvJsQPgh2mcLgevVmzenNvG6NqcxoiUBHrINn7p7f4DIM4MhOdWU
         hDlQIB+VHLjVbEZGO7t9oXnipomhiliI1ovg/FAxL2HoOhILpUiqDCmhCJLHsYpsUS4p
         pTDDJqKixIZb5opA45CAhNjlOsMendYm2APWX19Du7yvrnkeRaKemQZ3pLqPYZQTndOZ
         eD1IMkDi5Iw9G3M/zDyYfCvGnTz3+HFTBAktTUTpD6Zsc45bFQK9z9RIXx3CLxSdiiyR
         48uA==
X-Gm-Message-State: AOAM531gqTPYAwfUOJlba6eCbtAPEAFxESfwCq8gOMtAagM2/wFFl/GE
        ArR+E5YQjnapT+Sqbe6oZpKn/A==
X-Google-Smtp-Source: ABdhPJz2nCLsOfgeVFtOafx/HAFdZTbjjaJ2muxDQjix4kEwHujevhKyX7Gcrv0w5cFSyTNdM6S0hA==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr4450878wme.0.1594132691332;
        Tue, 07 Jul 2020 07:38:11 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 17/28] ASoC: uniphier: aio-core: Fix incorrectly named struct property and remove another
Date:   Tue,  7 Jul 2020 15:37:31 +0100
Message-Id: <20200707143742.2959960-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both issues are likely due to bitrot.  Let's bring them up-to-date.

Fixes the following W=1 kernel build warning(s):

 sound/soc/uniphier/aio-core.c:107: warning: Function parameter or member 'pll_id' not described in 'aio_chip_set_pll'
 sound/soc/uniphier/aio-core.c:107: warning: Excess function parameter 'source' description in 'aio_chip_set_pll'
 sound/soc/uniphier/aio-core.c:279: warning: Excess function parameter 'ch' description in 'aio_port_set_ch'

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/uniphier/aio-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 9bcba06ba52ea..86eb0915d80ad 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -93,9 +93,9 @@ void aio_iecout_set_enable(struct uniphier_aio_chip *chip, bool enable)
 
 /**
  * aio_chip_set_pll - set frequency to audio PLL
- * @chip  : the AIO chip pointer
- * @source: PLL
- * @freq  : frequency in Hz, 0 is ignored
+ * @chip:	the AIO chip pointer
+ * @pll_id:	PLL
+ * @freq:	frequency in Hz, 0 is ignored
  *
  * Sets frequency of audio PLL. This function can be called anytime,
  * but it takes time till PLL is locked.
@@ -267,7 +267,6 @@ void aio_port_reset(struct uniphier_aio_sub *sub)
 /**
  * aio_port_set_ch - set channels of LPCM
  * @sub: the AIO substream pointer, PCM substream only
- * @ch : count of channels
  *
  * Set suitable slot selecting to input/output port block of AIO.
  *
-- 
2.25.1

