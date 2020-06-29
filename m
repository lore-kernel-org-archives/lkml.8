Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233B7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECB420781
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+4oOHQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390821AbgF2VSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606FC00F817
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so15959559wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuuqoTwThT8s602WA+AxDJcFcHKmxLr2h6v/0tChBaU=;
        b=e+4oOHQ6RDs2p+Io00oa/emidcGQRqk7JerI3yILsojpqdQRpRZMvrW7GoDkx0vT2B
         lplAA0wn2r7LRBgZviGKEk7KNRvvDVKf/6+mpsv1fny0zUYEk8U9iU0EXdT3FlFx6ztY
         RwZKGW1FVaINeoz9PceNRHLgK2DNUJjJn3gHoB6Us9JgkkjrDl7fUEAUsngc9yVBFKcV
         a9pSWhBIbdO/b56Ne/tQWL9gOhACllTAZnDK4+lyRYfSTyNDRPItfZ6fnWTpRHCeLX/7
         sDdoEg17qu2dR4j4m/WNua9QIazerZqix3d7lG+wn1X63sItdtZkQk+UutRM6o4bc5VZ
         SmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuuqoTwThT8s602WA+AxDJcFcHKmxLr2h6v/0tChBaU=;
        b=Bg3hJePNYObeQNtvvEXo8d1Ss0p701r6sZj9MKxTWnFKuMhek05FRc21qBqc2kryzn
         7o73GYJRicMYz9bn0/4ILLPeXTp2WzfbGoapPowM+z2R6Wuo0en2Wp5AJR5VHfkL5mfH
         jZA+BXHCjBsoZXi7bIeEgczrb8XzUxMXmdDpnE+okvV1/lqu8kDS5roTp+dQSASTt1+j
         5xa9EWeK67riki7BJ1njqP7YXIk5/0u+1Ge8cODKBBxtnRB2lu0T0mcUliBY2AqVLiXb
         zstPhYuOCKKWTdHrUMQMnMY0LFD29EDokEQEUXYEvGCxunjQELp4co7VKaJKi8e9xIHN
         cs3g==
X-Gm-Message-State: AOAM531DvfhyEDTTSEHtnUynCoNSQDTSkiuAnokHFg4lIVR8Y3wVtKyB
        PiV37oFgMF2H559rYas0Mm1FDA==
X-Google-Smtp-Source: ABdhPJw43jNqoGVh+hJFrPOvTEjVXd9NzN7F/IbjiW/b18XUIAOo295g/2Buzs0x1LHwvEknDIfXEg==
X-Received: by 2002:a1c:309:: with SMTP id 9mr8045031wmd.164.1593433941522;
        Mon, 29 Jun 2020 05:32:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id d201sm28064111wmd.34.2020.06.29.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:32:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 2/5] mfd: lm3533-ctrlbank: Cap BRIGHTNESS_MAX to 127 since API uses u8 as carrier
Date:   Mon, 29 Jun 2020 13:32:12 +0100
Message-Id: <20200629123215.1014747-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629123215.1014747-1-lee.jones@linaro.org>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since its conception in 2012 brightness has been artificially capped
at 127 since the variable carrying the value is u8.  We could go to
the trouble of changing the whole API (crossing 3 different subsystems),
but clearly this hasn't bothered anyone in the best part of a decade.

Simply, cap BRIGHTNESS_MAX to 127 instead (for now at least).

Fixes the following W=1 warning(s):

 drivers/mfd/lm3533-ctrlbank.c: In function ‘lm3533_ctrlbank_set_brightness’:
 drivers/mfd/lm3533-ctrlbank.c:98:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
 98 | if (val > LM3533_##_NAME##_MAX) | ^
 drivers/mfd/lm3533-ctrlbank.c:125:1: note: in expansion of macro ‘lm3533_ctrlbank_set’
 125 | lm3533_ctrlbank_set(brightness, BRIGHTNESS);
 | ^~~~~~~~~~~~~~~~~~~

Cc: Johan Hovold <jhovold@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/lm3533-ctrlbank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/lm3533-ctrlbank.c b/drivers/mfd/lm3533-ctrlbank.c
index 34fba06ec7057..348ce67453092 100644
--- a/drivers/mfd/lm3533-ctrlbank.c
+++ b/drivers/mfd/lm3533-ctrlbank.c
@@ -17,7 +17,7 @@
 #define LM3533_MAX_CURRENT_MAX		29800
 #define LM3533_MAX_CURRENT_STEP		800
 
-#define LM3533_BRIGHTNESS_MAX		255
+#define LM3533_BRIGHTNESS_MAX		127  /* Capped by API - could be up to 255 */
 #define LM3533_PWM_MAX			0x3f
 
 #define LM3533_REG_PWM_BASE		0x14
-- 
2.25.1

