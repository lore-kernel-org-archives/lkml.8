Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3120CC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF5A2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kzq8l1ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgGURDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgGURAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:00:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E774C0619DF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so21903704wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5toOmofPdb0aWS/cX/qzEMNy/7jWKTdvFfToimNqFU=;
        b=Kzq8l1ruaR/AWJfmVIxoYH5oXrF5Sxh/oc8OT2Uxk1ov+20yL2zNArmg7vqcO3L5PG
         vs649aolZ4zpeUNir7Ehmv0T8LNiuU3IoP3UyjStqsLIuG8s2SDH3Qc4W1yIVCpqFv8f
         9lMcSu2l6pd9SGkOtmvjItozqFa8nS4r9xHOWoZdK0xyaM1w7ZgmbeEG6JhHfz4ZYqwi
         DCK+tA0fS3+g2RHdWiSHXWA8FAdv6pdOf+6BbpU7G3wSzjYOkPt7+shZ08MdRhvbhnVY
         HLwHWveVus3acSOh3u5DuUv9BkxsQQCOwspjfcs3cyV7SapecFjqhmIJtTxOqG1XYbxs
         ltOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5toOmofPdb0aWS/cX/qzEMNy/7jWKTdvFfToimNqFU=;
        b=RwXIb+Lyu5vxkZZrd5RBuQfUjMkbSdga9zUPcHopQ4w8JUYD7FlzjT2m5SKBe3w9an
         hj8Ve8+3sT638158zdUYUPqpuTYTCAexjyAUCzp3aAKZHiCXBieSvjPbGzHtj6OmI8/a
         rivjT19UReMs8kHMDJNJhOswYUza+bFsDtBlSLd70pNrhKvCztdDSWlNCQqjSkwnmWnA
         e9i1rqAaX2qQJYy+xdEYO9SWiKrFZV81eMbLse76zWhPnWTGFCVCDts50V9v6sBSwaLo
         weesjD4pnZcC+1gOSmHe6C9wp+Xx3tfc26iwqU6115V6jYDCsG30FFLWlAM3Ey2fLGby
         Tk3w==
X-Gm-Message-State: AOAM530DAt+oxRwWecFuoFMYjWiN+oMrWrf/YFi7EroZYb2csWmJzU7V
        +HXq4FXJICW26Sey3hJl8Q95Bg==
X-Google-Smtp-Source: ABdhPJzYS7aFCBBkC+2BxK07/ub7QVn25hX1kQwkGqFLdWhA/Y2ltFfJ8Z8GQ5+nOdxb5nnanwOPQg==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr27519445wrw.6.1595350819283;
        Tue, 21 Jul 2020 10:00:19 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h11sm15526327wrb.68.2020.07.21.10.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:00:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v2 5/6] ALSA: compress: bump the version
Date:   Tue, 21 Jul 2020 18:00:06 +0100
Message-Id: <20200721170007.4554-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have added support for new IOCTL and flags to
struct snd_compr_caps, bump up the version to 0,2,1
to help users find it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/uapi/sound/compress_offload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 43c78cdf492c..0d407b57a1d4 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -31,7 +31,7 @@
 #include <sound/compress_params.h>
 
 
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 2, 0)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 2, 1)
 /**
  * struct snd_compressed_buffer - compressed buffer
  * @fragment_size: size of buffer fragment in bytes
-- 
2.21.0

