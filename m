Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE24A204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeFTgGFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgHQOyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgHQOyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AFFC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so13468279wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RRuBUQilgLIpnxPWUSVogcI9Rt0faedggCk2VjZzhd8=;
        b=IeFTgGFVwljXcvvw63b1InTpxYzti5szZWYWzZ7kxZPHj8A7rkvohjj8EuPSCrcPut
         ME6nLcTonV0lpTMgTVDN8qLTNncCG8VpVnJO5XLZKVecJX4xXuXM/GBw0bWzDgHdg2V6
         o39MF1HIx0cuxTGJH94GJbMWeuqZimWa6IologQ4Mf0u1YkLc7KbRim3Tn8R0Zu6vJhs
         hRF+MieDRKmYh6XR/Bh9jymKf/zm69AqzswUp7PxV/NvqWn5Fcrg/+5nrpWeBaZUXQ/L
         xA8zRWUcDwjN6zZgEZ/bcBCKs/EVjaDnzmZZo0B3Od7vwRgkGdI8ZuAYQFPj2jF/da9F
         4pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RRuBUQilgLIpnxPWUSVogcI9Rt0faedggCk2VjZzhd8=;
        b=gBbqpKZgt2FO9bV8qhPkBFoXq0N7pFTlk1ecrikpKub5WWsYTjHOevo34j78QMG9gj
         o2sU6km2jCRwWRAtYmG/4bkPJW+e+g5/Fn6xA4wbJaF7aHYLhO/d4swbtZ5v10+gl2dG
         LKs7YYsNq36NvCqEiumkff6SR5aJ1MkscqShmA34SwLWwAo5BGfbBQMlHOGtgdsbpbIa
         7loKBvhd+ODzxUnJ9+p229XZSOnNwLclrPyeovHARKzE9rb+wxWANY6igDBIJCuZf9Bq
         irvXaUhi0zZrDMmmcQpNjr2sAqO2JiTfMSgr2QypDqAr0dlYkKCSYDsTueMbYad5czPJ
         bKGA==
X-Gm-Message-State: AOAM532u9RyrTHRGvB61lV0AO3r0rT1gsd+fTrD7gT0IUxR1R9pOcZov
        2GQgsg4YTsn+H+qaRo6o0hwBDXBt/oBNL9m+
X-Google-Smtp-Source: ABdhPJxyVyY3qf2QMeZ1lnyt3uhl9BTj/ELXOQ0P0od3l1Bg8n4ATy5l0j2vksGUZl6n91mIE97RJg==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr15096872wmd.143.1597676055772;
        Mon, 17 Aug 2020 07:54:15 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:14 -0700 (PDT)
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
Subject: [PATCH RESEND v1 02/13] perf arm-spe: Fix a typo in comment
Date:   Mon, 17 Aug 2020 15:53:37 +0100
Message-Id: <20200817145348.14461-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo: s/iff/if.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 46ddb53a6457..7c7b5eb09fba 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -142,7 +142,7 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 
 	/* we use index to identify Events with a less number of
 	 * comparisons in arm_spe_pkt_desc(): E.g., the LLC-ACCESS,
-	 * LLC-REFILL, and REMOTE-ACCESS events are identified iff
+	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
 	packet->index = ret - 1;
-- 
2.17.1

