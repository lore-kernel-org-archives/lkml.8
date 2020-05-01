Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEACAC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D09820708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZ1zpulf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgEAOgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgEAOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:36:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA25C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 07:36:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j1so11773990wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qezlbEs26gOrWFMyWMZpjZ8xghXGSjIgdcezc4CI8eY=;
        b=NZ1zpulfQHxcBjCRJz+dbH9uUgkQbKPQ4ynbioMg3EyOYoyttoozmzd4rVucZG+QwM
         lG+HGJa4UBSLSeXGDS/JXQrES1ICu5e8IjsMnRuPYIoD3wDFNZHX4A8ieVie6dygnVJM
         Rmio6BxmYlbncELdKHsRCE+Ll6Yj/MlpimGsfRFvI4gXcIF8F/GrGQpWT0i742jfnSMv
         TyCdf/OqiR+NiixAYfE+sOSNZZ0/ldTAO2Fi3nD6Wdi43vFwoWihvWvWYQu/qH00pR7I
         vrRVR5/76W3XUVR7dLKkR+ATp2F4JEepMXV2bQP4+/nPoJpfRq7y5GD509/dk+GV7CKO
         in6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qezlbEs26gOrWFMyWMZpjZ8xghXGSjIgdcezc4CI8eY=;
        b=mmLx1Dx3R6A1I6aeslvbCA4YyQtC/VctNDANG5Xa8iH5+Lie4NfSWMsFodBYzKAJKB
         V9/2TlWCH48vPahW3Rt9Pstci68fknmV4yftr3AiNlOrxfW1atpxTstIZWRf3D14OyoR
         BTJVRB8Lxk4K0uA4jNBpvXrsd06iXQi8J6ZAnIe1/GO3wVAg/lbJrAsZFKm8l1KBUXqs
         Hg6k5QkXmB1w4X7qAzLpItdTHHNA4NNndAdvbuCt8Oqy5y16ZhulMpQN7eCslgha7ctZ
         8lbJzA9Os1TacuaavwKHQy+GASkI4R5PQA1j1FrJBiYWmzhRKdEYcnXMujxFeIkdd+3T
         lbpQ==
X-Gm-Message-State: AGi0PuaLeSwQJK+JduMKrpMN4kEMmZQkPVeL812uXnxuqC+XOOKBRW6C
        ixjQyYL+3xQe9p0B8gVKB8m9bQ==
X-Google-Smtp-Source: APiQypImSe8yuivKOHKCNp93T5FkysYQ8r2xtCVoVj1NQvb8wNUiHJE5THy5jkxXcbBhPCjFB1Of8w==
X-Received: by 2002:adf:82ac:: with SMTP id 41mr2436039wrc.110.1588343779109;
        Fri, 01 May 2020 07:36:19 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:8bee:312:6092:58f2])
        by smtp.gmail.com with ESMTPSA id z22sm4204992wma.20.2020.05.01.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 07:36:18 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2] perf: cs-etm: Update to build with latest opencsd version.
Date:   Fri,  1 May 2020 15:36:15 +0100
Message-Id: <20200501143615.1180-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OpenCSD version v0.14.0 adds in a new output element. This is represented
by a new value in the generic element type enum, which must be added to
the handling code in perf cs-etm-decoder to prevent build errors due to
build options on the perf project.

This element is not currently used by the perf decoder.

Perf build feature test updated to require a minimum of 0.14.0

Tested on Linux 5.7-rc3.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/build/feature/test-libopencsd.c           | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index 2b0e02c38870..1547bc2c0950 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
+#define OCSD_MIN_VER ((0 << 16) | (14 << 8) | (0))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 0.11.0 is required"
+#error "OpenCSD >= 0.14.0 is required"
 #endif
 
 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cd92a99eb89d..cd007cc9c283 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -564,6 +564,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
 					       elem, trace_chan_id);
 		break;
+	/* Unused packet types */
+	case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
 	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
-- 
2.17.1

