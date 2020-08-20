Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497ECC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213E020885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKnchOaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHTRzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHTRzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:55:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F55BC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:55:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x25so1409114pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QxfCfa75MN/ENm3PPySsNVQ0g2HCd5f2aDsMAgIXZg=;
        b=XKnchOaMRwi6xzmgGQPrRO1RueooRUwplr96IZpJ6a0jMB38FUPiZ76JAEkMLyONzk
         2YTVhhb5l/tKEqgWEKIki/F5RVqw1FxPkNoUb4WkuhT2nvPaLdU+ozeLvY13nkwBoqHd
         /sd/mGii5y7mSPmHaR9PgJUrsB6+MaL9NQIqwGRqBIuggf0mWW7qpsYsqc1KdHXESFGS
         qPdWNZLDbbQ26o5wMPJGJs5/HgE1Bj5G5uPtboQQnQacVZusU/5lz2UUeyMPQWqt7r6b
         rsZf6pbW5KY+k/XwZLYF3d8VgAPlSsjGynncGSiJqCJOLgwEucDjcgI7wtoIQdhVhaPr
         WdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QxfCfa75MN/ENm3PPySsNVQ0g2HCd5f2aDsMAgIXZg=;
        b=tD3P+kfkQyEeVi822KXMmt0rfS91JGnyKXOyzvsNk9Ve8xWlqGu5aYZrSoxvld7ZGq
         8TsW5jd2kdCzRiZi5HLZVIagaF6BlRRjbQN4Ce18BgEllZS23k5cXZT3MSWX+UXqbcPX
         sjGRoMFLtpb4kG0bB9ikcSEqkE4JkIvNqg9ezhK98wI3x7jZ78SZuFj+ofg8tZZJMV2K
         Joz1tWsCKKRB3WryWs9mdpoblRXbmHWpl6sGAHJRof3xeHHezvqnWCbmHigNWo23sl89
         bgal4OHVkHv/fTYKPJe3QGIog0XG3siNDjFuL1jyJa1K2tVCtdDxAx07RizuLhkRBCei
         /m3Q==
X-Gm-Message-State: AOAM533sR3LKM4Y1s4ODdTtvmxyTs5YH5/W4LPbEEvPTt5KpCOk73gxe
        ifbn4CJKKHxhxvPc8gAr7qR8bQ==
X-Google-Smtp-Source: ABdhPJw+CkZFkMACIAmwU96+31Asn3KsB/bMQQ1kmEOuTGNPLGROu9oHp0AOOArPTUvuc9Y0dl1K/g==
X-Received: by 2002:aa7:9390:: with SMTP id t16mr2969292pfe.311.1597946111902;
        Thu, 20 Aug 2020 10:55:11 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 132sm3144189pgg.83.2020.08.20.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:55:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     john.garry@huawei.com, will@kernel.org, leo.yan@linaro.org,
        jolsa@redhat.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Add entries for CoreSight and Arm SPE
Date:   Thu, 20 Aug 2020 11:55:10 -0600
Message-Id: <20200820175510.3935932-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for perf tools elements related to the support of Arm CoreSight
and Arm SPE.  Also lump in Arm and Arm64 architecture files to provide
coverage.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
V2:
- Completed fileset for SPE.
- Added Arm and Arm64 architecture files.

 MAINTAINERS | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..e76f7bb014ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13569,12 +13569,18 @@ F:	kernel/events/*
 F:	tools/lib/perf/
 F:	tools/perf/
 
-PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
+PERFORMANCE EVENTS SUBSYSTEM ARM64
 R:	John Garry <john.garry@huawei.com>
 R:	Will Deacon <will@kernel.org>
+R:	Mathieu Poirier <mathieu.poirier@linaro.org>
+R:	Leo Yan <leo.yan@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
+F:	tools/build/feature/test-libopencsd.c
+F:	tools/perf/arch/arm*/
 F:	tools/perf/pmu-events/arch/arm64/
+F:	tools/perf/util/arm-spe*
+F:	tools/perf/util/cs-etm*
 
 PERSONALITY HANDLING
 M:	Christoph Hellwig <hch@infradead.org>
-- 
2.25.1

