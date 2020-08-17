Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D21D20786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uR7KxJzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgHQOcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgHQOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:32:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28ABC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:32:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so8304856pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RRuBUQilgLIpnxPWUSVogcI9Rt0faedggCk2VjZzhd8=;
        b=uR7KxJzQmzXmgfdXMwa6zbC+zQldeCZfNEcoEHBt6OrekkTVZZM+CsUkI3Cpq18zUz
         xRQ7VL9LzrbzYc7hW6KGluLpYPTQRurziE+O0035vy46eYBH7qpB4vUztEiDh2cN5VsX
         Jqpb1hHmiqbfiUDhBlwGudqfmh1vMdz6sZe/KDyLPvKTxNOAC+CdYBFfaJMRwCYuQvS6
         KD+6hAwR18MEVKUPnv9W3EWYu02H+xJ6un72+EumKluK4k1VVlq2KKZOWiN8l4YhIj7e
         VgbK5w4AEzh23MZU0GgWGt59/+np0xNbgByQo9NyzWmPv0r4E5yy0aCrzjvmFPuq2YO/
         gweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RRuBUQilgLIpnxPWUSVogcI9Rt0faedggCk2VjZzhd8=;
        b=Zx4uRq7XzlsZWFrmTCAGrzZXnH8tgEYGs+oMYSK6PVUi+VQhsMAC7OSpgPiFHbGxQ6
         L19LDF2M0uqFNexHFCkA/BpLv1fXhkj5v4Z59vNU2MxC5K2L41nKkNNT4BGZsWK3vzO8
         9OsGT5vImVu0gwhJJE9x+En8tI3JSUTpsupM1WCozckkurEDQYGqBXVhwlxEiv0AVv/M
         bVbu6jaVuNh5Zev1sUnlhDbj2DDiQ9MGgdgjtgCyCXtur+hDAwkc8qKzwhE+uuziAq7C
         PSbY1m7EFYwwLk5ZEqrVUvrwAyAu/rCDZPQRLsqr1wIcLJHSucmWMdIvkVwxF0nhKpty
         XzHA==
X-Gm-Message-State: AOAM530dDGMW8mzvJrbIWyXNb4iT0lxpbLSudA5/7VLIKlHBLkZAW7B0
        havCGKT6QZNJ+8dTPthiGSjrvQ==
X-Google-Smtp-Source: ABdhPJwdwYymMkh7exsKATqvcWIb6AWW7fBGJw85lSXXDwuHxjRCbcG9Bm6pY8GZV63k7HVePZhhEw==
X-Received: by 2002:a05:6a00:c9:: with SMTP id e9mr11568310pfj.224.1597674721589;
        Mon, 17 Aug 2020 07:32:01 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id d93sm18263047pjk.44.2020.08.17.07.32.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 07:32:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: [PATCH v1 02/13] perf arm-spe: Fix a typo in comment
Date:   Mon, 17 Aug 2020 22:31:03 +0800
Message-Id: <20200817143114.13393-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817143114.13393-1-leo.yan@linaro.org>
References: <20200817143114.13393-1-leo.yan@linaro.org>
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

