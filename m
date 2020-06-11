Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A78C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D96320801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PB6ee25/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgFKMmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFKMmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:42:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6070FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so4898737wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5Sa2AQrDHSWdZzqpjBH4h//ceIVQSzjk3tUp3KsmEE=;
        b=PB6ee25/CV55OHayB5k+7ASePj+owVMvtkgsE2VDkdvUpOUbyRJl9UG/kB0wDm8ual
         F7z/5IVqwgELP4SvmbZT8UOA8MQoNOetza6/cMBUsUDN64GPM/f5lP2N8V9aqwafrl4J
         GbF0quLVQiVzYIoDlreB4S37o25i8xHGmRzKMrBWaMCQy0XuA4chrDkx/c37SjLTDrMJ
         /AdEgYhxK6DSWuixce/P63zqDrtGxzU6GhmwTOi/pZsyDGMlKB7UUJw+LTsL41XyEGYB
         coczXH5fThZ2G13m8uW7OHo8VYF9aOUGC/h8yVZDtY0es4PO0vqAFDaOEMkijmEC8fxz
         tbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5Sa2AQrDHSWdZzqpjBH4h//ceIVQSzjk3tUp3KsmEE=;
        b=Wgs7FUJ9vmoYItMWjxyUr+OXIuA+d3l5fPQVAnqHC+oxiBSLMSlQjSsvms+36lesAm
         /wwcy5T/FcLlCcahEWg0t6DGDZULTuoaLDCHfQWFWLHIk5dex5tC4QHnvqT9QDcFEYTL
         zBzXXiQCwmI5wBCbtT4PpwZQAYcdCIQGUg7i1Nhk3OpPZqdb8gCV+8O1Jq9yKbUXJorp
         OhHeAbyKoa2/4GjP91EJr7OMXxw7aiXpvBqC994dzqjbA0D8wF7BJT1YyxMGPhov5DUb
         k0x24VZzP1I0ac48bXOBi8CrJQo0C/sGG5XMS6Jm5OZuSyQdiophR1fvXwl4bFp4AmJ6
         UJSA==
X-Gm-Message-State: AOAM533evbAKXUjjoQeq8nXnM2BYSzG+tSUIG96B4Q97RVqXGu2n4MrP
        j03veVWnYOlvZneNnCWNlLsU4w==
X-Google-Smtp-Source: ABdhPJy8MbdIYkW8OpzVcUydBi2O4mW62kazC5GR9AyPxfefygPOSzJ5Xs3AmjkHlnXxBfdmU+dL2w==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr7894520wmi.0.1591879324065;
        Thu, 11 Jun 2020 05:42:04 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:42:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/8] ASoC: q6asm: add command opcode to timeout error report
Date:   Thu, 11 Jun 2020 13:41:52 +0100
Message-Id: <20200611124159.20742-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
References: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the error reporting more useful by adding opcode to it.
Without this its almost impossible to say which command actually
timed out.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 0e0e8f7a460a..0ce70a5c7d9e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -310,7 +310,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
 					5 * HZ);
 
 	if (!rc) {
-		dev_err(a->dev, "CMD timeout\n");
+		dev_err(a->dev, "CMD %x timeout\n", hdr->opcode);
 		rc = -ETIMEDOUT;
 	} else if (ac->result.status > 0) {
 		dev_err(a->dev, "DSP returned error[%x]\n",
@@ -890,7 +890,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
 	rc = wait_event_timeout(ac->cmd_wait,
 				(ac->result.opcode == hdr->opcode), 5 * HZ);
 	if (!rc) {
-		dev_err(ac->dev, "CMD timeout\n");
+		dev_err(ac->dev, "CMD %x timeout\n", hdr->opcode);
 		rc =  -ETIMEDOUT;
 		goto err;
 	}
-- 
2.21.0

