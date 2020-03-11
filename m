Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C37C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EE120735
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4Lr7F+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgCKSEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:04:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53505 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:04:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so3118320wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4omj6yAnna4dJSDx6mgWTPNUU3WmtYx8C7r3eY7KJR8=;
        b=h4Lr7F+6v/hE6dalw5i+9v/T+aEcsjQazcSL+w4L8CeLySvy6RvJLOM3X9+74Ek9DO
         nhAYQtP9yUbK71IC6rY1v/SZKYwaGWBRTgiH+skZHaqaa452ul7KJT6CPjICbCQad7rg
         Mmhz2xiFvJHQ7O2UJ++ZhXLis3WQN0vrzSca47MuSn2g35SMb6hXvU0d34V+Y2jmn6ik
         VsIQJF+ySk+scY60ttpsCK+t63v4lsmVVVMw70acLn+crd8u/INAS1DLMxkk2pTQKpgN
         sr2pzPN9kPM296nb1VXTBPuFs+CQ4nJxrxT2D4p5am9veDPox5Q13YpZW5desLi6j1Ct
         uaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4omj6yAnna4dJSDx6mgWTPNUU3WmtYx8C7r3eY7KJR8=;
        b=QXmu8tpHwQa1UPuZwUnEvFErmr1WwMxmWCTmKdq+LmS3F9Pns5Ey5OGHdb9WIgyG9Q
         6aEKyo+PePtsLjuf4SJEARhdG1Jwjs6TChOGZM+XY4xPlcgtA2hs8ngHxqNdbNR0jbO8
         bSrtePwRh6Rn1wBp5SQOUoqUn5DHgka9OnCYuQ1yUGQqnCEw+pi1e/4WixBz1PhSZUD9
         P9YVPuDhmDmY6fo8lcxFVH+kfiWLXBvTSxpfFaqtWDM+eiOM/z5Gu2W3rMLHP1zaZ4Wp
         HXV4A5+RLTXVha+mTVujBkP4CRTPQL+0nx/gCoKXVQDFLwF5EoTWV+ApDzRYv8BVbI76
         RExg==
X-Gm-Message-State: ANhLgQ2Fd4yOUyORmcZszb3wmhcRNyymji/oyCvuE1Un2R23bwHH82Pm
        aycUcdGCqe2+AU8bslNMxSEwXA==
X-Google-Smtp-Source: ADFU+vvR5T/YJ0xN9O5b1ViU6reQXdGd7Z+15MpCetrHskMG8KW1ZFhX4v9Gsux7i8Rp5TuBYyt6Ug==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr4562610wmh.132.1583949885317;
        Wed, 11 Mar 2020 11:04:45 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z11sm8997840wmd.47.2020.03.11.11.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:04:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>
Subject: [PATCH 2/2] ASoC: qdsp6: q6routing: remove default routing
Date:   Wed, 11 Mar 2020 18:04:22 +0000
Message-Id: <20200311180422.28363-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
References: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frontend dais can be configured to rx or tx or both, however having default
routes without considering this configuration can lead to failures during
card probe as below for compress rx only case. These routing have to come
from sound card routing table in device tree.

"routing: ASoC: Failed to add route MM_UL1 -> direct -> MultiMedia1 Capture
msm-snd-sdm845 sound: ASoC: failed to instantiate card -19
"

Reported-by: Vinod Koul <vinod.koul@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 20724102e85a..4d5915b9a06d 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -918,25 +918,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"MM_UL6", NULL, "MultiMedia6 Mixer"},
 	{"MM_UL7", NULL, "MultiMedia7 Mixer"},
 	{"MM_UL8", NULL, "MultiMedia8 Mixer"},
-
-	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
-	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
-	{"MM_DL3",  NULL, "MultiMedia3 Playback" },
-	{"MM_DL4",  NULL, "MultiMedia4 Playback" },
-	{"MM_DL5",  NULL, "MultiMedia5 Playback" },
-	{"MM_DL6",  NULL, "MultiMedia6 Playback" },
-	{"MM_DL7",  NULL, "MultiMedia7 Playback" },
-	{"MM_DL8",  NULL, "MultiMedia8 Playback" },
-
-	{"MultiMedia1 Capture", NULL, "MM_UL1"},
-	{"MultiMedia2 Capture", NULL, "MM_UL2"},
-	{"MultiMedia3 Capture", NULL, "MM_UL3"},
-	{"MultiMedia4 Capture", NULL, "MM_UL4"},
-	{"MultiMedia5 Capture", NULL, "MM_UL5"},
-	{"MultiMedia6 Capture", NULL, "MM_UL6"},
-	{"MultiMedia7 Capture", NULL, "MM_UL7"},
-	{"MultiMedia8 Capture", NULL, "MM_UL8"},
-
 };
 
 static int routing_hw_params(struct snd_soc_component *component,
-- 
2.21.0

