Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A9AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F1020748
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHvpaJPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgHQOzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgHQOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DCFC061348
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so13472883wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1dl9iN/nFpn9nQ/o2hWJbStfmcmyaZYPwLcTOTQ3acg=;
        b=BHvpaJPsSim0HffzBJBkJLDM+qPQ96Z6WlAJOEI9hyiI7cPsSCEtuFMkkZDaz26LbN
         4NgCU9/YWSsLy38xd4+MnKtgiEVDlDNj6e+rJcRUmBWc9sfKxE6mhmj4+v9yyEQtAy1Q
         hS9e85MQGUZJO1H/iMF2LX7Zw0wWCbnYLlqwYT8BPdYPg/gOtu3svzqfai/FHNzZYS4W
         Hem0ewzh7hSG+9mk0/JfQlFOvi91BQW6+BfQksvdh/DeXYqIUwhkadgdcq9ufmW2Bbja
         79qJou1JuX7BjreZaxHOcnZPfokKgKKYB02zUMcWA8g/VPtLtKkYKGQLDfoAgiym3j2+
         84RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1dl9iN/nFpn9nQ/o2hWJbStfmcmyaZYPwLcTOTQ3acg=;
        b=tL17dtkwGkfesLu6hNDHg1PGhTuiQhtghw/86vyQEvnO0cCmAh3iMJJLhDPrNk0cMH
         gVp7nRRNwHi8LBZxJDpjVFLShop9jrnTZspNpVmoiZDqdjELDw6rxR39tYtvrSRULrUr
         e/0tAOXJP62X1/t7rfUuoGn2GySWAoMyaY7XmvrLEQkj7bykq+Nt+ZuTlN6xkk5i4Mvf
         3dqHWMBdI5ChShwAlsIpG53CSsu1Yrfw6PU5oEI/OykbNh4K3XHWbip6uH/FVQhGAJUR
         pUriT5utZiTaDafRmng9mJ2ku4S6F8+iYkeJJga4nc4Ye0tBrRVjCqWPC5d3Gxfy11jj
         djNA==
X-Gm-Message-State: AOAM530LVlBul9dmVGdS6HiNqzW8T++7nYW6ZnK/2s2DGcZ91yQpKeKp
        SPrdEZf6H4YG7pClS/2NZ3voNg==
X-Google-Smtp-Source: ABdhPJz4jGQLUHpeGErMGdGo0JKXStuXsBrAjTJb6Rxm9Pi7mDVtWyo5PTpwYaiiqG0pJRmokvC1Sw==
X-Received: by 2002:a1c:62d6:: with SMTP id w205mr15865775wmb.154.1597676064778;
        Mon, 17 Aug 2020 07:54:24 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>, Al Grant <Al.Grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 10/13] perf arm-spe: Detect failure for snprintf()
Date:   Mon, 17 Aug 2020 15:53:45 +0100
Message-Id: <20200817145348.14461-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When any failure is returned from snprintf(), the event packet decoding
detects the failure and bail out with reporting failure code to up
layer.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 78250c8d74ca..121414e4ae23 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -262,68 +262,89 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 
 		ret = 0;
 		ret = snprintf(buf, buf_len, "EV");
+		if (ret < 0)
+			return ret;
 		buf += ret;
 		blen -= ret;
 		if (payload & SPE_EVT_PKT_GEN_EXCEPTION) {
 			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
 		}
 		if (payload & SPE_EVT_PKT_ARCH_RETIRED) {
 			ret = snprintf(buf, buf_len, " RETIRED");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
 		}
 		if (payload & SPE_EVT_PKT_L1D_ACCESS) {
 			ret = snprintf(buf, buf_len, " L1D-ACCESS");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
 		}
 		if (payload & SPE_EVT_PKT_L1D_REFILL) {
 			ret = snprintf(buf, buf_len, " L1D-REFILL");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
 		}
 		if (payload & SPE_EVT_PKT_TLB_ACCESS) {
 			ret = snprintf(buf, buf_len, " TLB-ACCESS");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
 		}
 		if (payload & SPE_EVT_PKT_TLB_WALK) {
 			ret = snprintf(buf, buf_len, " TLB-REFILL");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
 		}
 		if (payload & SPE_EVT_PKT_NOT_TAKEN) {
 			ret = snprintf(buf, buf_len, " NOT-TAKEN");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
 		}
 		if (payload & SPE_EVT_PKT_MISPREDICTED) {
 			ret = snprintf(buf, buf_len, " MISPRED");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
 		}
 		if (idx > 1) {
 			if (payload & SPE_EVT_PKT_LLC_ACCESS) {
 				ret = snprintf(buf, buf_len, " LLC-ACCESS");
+				if (ret < 0)
+					return ret;
 				buf += ret;
 				blen -= ret;
 			}
 			if (payload & SPE_EVT_PKT_LLC_MISS) {
 				ret = snprintf(buf, buf_len, " LLC-REFILL");
+				if (ret < 0)
+					return ret;
 				buf += ret;
 				blen -= ret;
 			}
 			if (payload & SPE_EVT_PKT_REMOTE_ACCESS) {
 				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
+				if (ret < 0)
+					return ret;
 				buf += ret;
 				blen -= ret;
 			}
 		}
-		if (ret < 0)
-			return ret;
-		blen -= ret;
 		return buf_len - blen;
 	}
 	case ARM_SPE_OP_TYPE:
-- 
2.17.1

