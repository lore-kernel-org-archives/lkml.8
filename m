Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E46C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C14A2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4h1Ca5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgFKMmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgFKMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:42:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC5AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x13so6013015wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DNGruM6B9mSP+joziG19q2cWIhnj5b++piG0JMa2V6w=;
        b=V4h1Ca5nmbkGj2hladouj3f0enZ42GxqHryh272WGrCyPuT8xAqb5wtLULOLNDb+kC
         4nQJutDNKmqUgli3yOe3RjfHFZaSVQ19vyaJsIfIPTBQY8Djk8nvgmc+cLynOwY483hE
         +j/KXAsI6qxCx/3+go7O4EV+4+zHdi9amag7lzmPK6C1Pc0f5/gueHRHXHCloSoGx5wE
         oQw5gZFdYR3DQEGt4IpZC6IyjcxKMBtvidnKZ4MoZXG42gGEyoM7bHwuHH5p0KoFSjTv
         JSKm5hl4tsRxMY0LiWiW2QKqLF2UTBI0Tz96AH8b2WczI3be44UTQa/le2UeX/qI5JgH
         Nw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DNGruM6B9mSP+joziG19q2cWIhnj5b++piG0JMa2V6w=;
        b=BlUTJ+mlNYkPat89Ke74yd5DmN4zwx3ECbLyaM3nlRP7OCd69aq+mJSVqloMc1v2Fs
         DURiP3xuy1/KFcKKqICkIyYFuJFHumZQTcbALJBgsEyzaxNMPRUEOl+I7rhDKk8RYgRv
         kuCSb7g6r1DD1hYmDDnxXXA8SlV2dyX+yleBz3scQQhRjJb2Evc95mRnSXODn8t3AUqd
         rzQ7BplVi/Ue3I4V//lHSRoT3VJmSA9n9Fld89B8itKOFw4PqxFkCznLqQ3YrmCrCuTN
         58RQuaQSZHZtBFoNBCvC3uTwb/ke9C0wQzNrFMvbvLkn2detXiq5fW2P+hT9dpEkBfgY
         xAWw==
X-Gm-Message-State: AOAM531zYzVtlLgZ0CitAbXBESamfG3VivFdRTYdR6GSfzPDyJ47Uy9q
        ugXiNtxvyJmDCwh3Y33Ve3k+bw==
X-Google-Smtp-Source: ABdhPJz4z+o5PKHUFnC5aUpJgoVQGqDgO8B3X+8NJKRrokT1gn4IjQF8Z7a2PR+JqR94h+2kLxN8eA==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr9200628wrv.112.1591879325343;
        Thu, 11 Jun 2020 05:42:05 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:42:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/8] ASoC: q6asm: handle EOS correctly
Date:   Thu, 11 Jun 2020 13:41:53 +0100
Message-Id: <20200611124159.20742-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
References: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Successful send of EOS command does not indicate that EOS is actually
finished, correct event to wait EOS is finished is EOS_RENDERED event.
EOS_RENDERED means that the DSP has finished processing all the buffers
for that particular session and stream.

This patch fixes EOS handling!

Fixes: 68fd8480bb7b ("ASoC: qdsp6: q6asm: Add support to audio stream apis")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 0ce70a5c7d9e..e0983970cba9 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -25,6 +25,7 @@
 #define ASM_STREAM_CMD_FLUSH			0x00010BCE
 #define ASM_SESSION_CMD_PAUSE			0x00010BD3
 #define ASM_DATA_CMD_EOS			0x00010BDB
+#define ASM_DATA_EVENT_RENDERED_EOS		0x00010C1C
 #define ASM_NULL_POPP_TOPOLOGY			0x00010C68
 #define ASM_STREAM_CMD_FLUSH_READBUFS		0x00010C09
 #define ASM_STREAM_CMD_SET_ENCDEC_PARAM		0x00010C10
@@ -622,9 +623,6 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 		case ASM_SESSION_CMD_SUSPEND:
 			client_event = ASM_CLIENT_EVENT_CMD_SUSPEND_DONE;
 			break;
-		case ASM_DATA_CMD_EOS:
-			client_event = ASM_CLIENT_EVENT_CMD_EOS_DONE;
-			break;
 		case ASM_STREAM_CMD_FLUSH:
 			client_event = ASM_CLIENT_EVENT_CMD_FLUSH_DONE;
 			break;
@@ -727,6 +725,9 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 			spin_unlock_irqrestore(&ac->lock, flags);
 		}
 
+		break;
+	case ASM_DATA_EVENT_RENDERED_EOS:
+		client_event = ASM_CLIENT_EVENT_CMD_EOS_DONE;
 		break;
 	}
 
-- 
2.21.0

