Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A446205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TD/3dJhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgHQOzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbgHQOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFF1C061346
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so15330290wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GYK7b+ch5oBJMth12A/ffABzUF3J4c4+qW4fix2N7yk=;
        b=TD/3dJhmtFSRKqErVu+xdcEJVtqgPK6ciiYz4QM4emdYyq7I11mbEX5PO/ZYx7UlNW
         BD6vMMSGJgcAIjSOuyXyqKWAQ/i16XGiSWrLgRXEbXnV/Pl3p5GhnWzz+RCynN7XNJc7
         VdTI6v/vnCsQMNwpI6ruiCIugsUSb49CgmF9x49VU9qgY3vEcJeqqBBOQpv6sCFVn/Af
         p5u/rwjAberh6ozIYtmC8N35eJvNRLUh0kgp4dc/7UleblWVZRrieoWXiETaAVXZHEaA
         qtK0SvqiATPwjG+rmec9l3Gnhiw9ELTNnFDYzHg2DFaD9D2KJreA/Mq2oNz2VRH+nP1e
         BKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GYK7b+ch5oBJMth12A/ffABzUF3J4c4+qW4fix2N7yk=;
        b=EBIRsL6S4BJaSughGI6aaMmzogdlJ2E5hPfqVoKunaU0p/iU51pMzpJcdUBYtpk45G
         qu/GuxLigJlClqYpba6pl7BxHo/L1J40P7jTL7Py2xFsLAQE3HIrFKoCOhGOFOSr6kqD
         B9m8dULPouz6SmL9orTnV39ZZ3L8t73bCWOUhdfOC4rHBzYFAZ55lALp2o6ARhwPOs/9
         5m3Dh4Z8wgVVqmOiUt5mYy/xAyqcTfZc+39QrqbMGtLsyzLrbP2tTs6xx896WIduiZek
         OGvbPCZvg4D+yLD8pDidDK0A2lCyTKPLcgiuTH40G8I6gz7aEU/2N0kglwbD0Wl3QvxI
         1EoQ==
X-Gm-Message-State: AOAM530bGESnvM8uLDx/Hhv/qNrxzeUXSaUb9klPTx1zJVrYMNNeE78s
        fZxrY7rZfyPUVe7rUfRE62oBgg==
X-Google-Smtp-Source: ABdhPJygIFLGkA2sQBIySVHxr21C17dfB37RWWXQQNDWI+/atbxT0jRLef6EJnw8s/foxD5djhl5Pw==
X-Received: by 2002:adf:e690:: with SMTP id r16mr9418931wrm.161.1597676061550;
        Mon, 17 Aug 2020 07:54:21 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:20 -0700 (PDT)
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
Subject: [PATCH RESEND v1 07/13] perf arm-spe: Refactor context packet handling
Date:   Mon, 17 Aug 2020 15:53:42 +0100
Message-Id: <20200817145348.14461-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor refactoring to use macro for index mask.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index bbc8b0178f67..ad8797f12d36 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -133,7 +133,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_CONTEXT;
-	packet->index = buf[0] & 0x3;
+	packet->index = buf[0] & SPE_CTX_PKT_HDR_INDEX_MASK;
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index d09082fc9853..db9f124fb1f4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -82,6 +82,9 @@ struct arm_spe_pkt {
 #define SPE_ADDR_PKT_INST_VA_EL2		(2)
 #define SPE_ADDR_PKT_INST_VA_EL3		(3)
 
+/* Context packet header */
+#define SPE_CTX_PKT_HDR_INDEX_MASK		(0x3)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

