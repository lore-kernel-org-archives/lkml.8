Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE1D20748
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkiOOxn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgHQOzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgHQOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D63C061349
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g8so13471658wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nSQWq5DZBnwicCqRyoCQ0WCsGQIiOd/SS4Qq+uwaSRg=;
        b=tkiOOxn6XccxrXT5FWRcysXudx1h0AEr8Rr6Py66etXgJgZ7F+s0xk9KCEWpAPIWf4
         LSdDn5ybcQCaWiJ/EvE3IQDFySsYRPCJXqudMlhBxgWJ5psqVEhWUOJkZVeMo1zcRUti
         epL0M/TkEM91Y7p0OI5X4jk/48+gR3A1DclFW6Po069eKsmYRXdUWrF5WR1hB6BxmA9U
         X4oBaawv/VCLYFDVmJHqaLoWqjVyNWztPw4PgfxIiN6SbrlKfYsdsuVRrp4oxaDa8Eft
         KUiFCN3SzJze6/ExbFfEDY2LK2klgV3xX9dg0cDyWLKeIJUd/McZaAUzcA9X+ctXEagv
         tFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nSQWq5DZBnwicCqRyoCQ0WCsGQIiOd/SS4Qq+uwaSRg=;
        b=LBZs2H22Owc8X7r/lL5d6bnpgEelAMikS8TiN1W7z0qS4JzDEi3ioIwDEGPQaHIDry
         KOV8blRPQNpMeBI6AeAhk8L0FtPTLxeeLiAo/LuK17S+EG1uPeCVwIxn5sVCTc+gNtVV
         VObPazal1RDP/k8Dd+iTsamxdk3zxUotlGT1vwdImvLukejZXvZLetE/D6vFDP/XJZTy
         0rZapxsacU2Ck5a7PPnRrJtSrbHYplX1Xw++z52pHGqGbI3Pr8W7cpDrXWUKhWq5KNsA
         Ob7BCyCpAPQI0hLxax40XUIcOjJDHWkRAyTVhEICSNZRfJnjrlglPSZuYptSusV5QApt
         Jhfg==
X-Gm-Message-State: AOAM533UPvQHVNoMgux5dacP75ogN0U6EhsdED8vscGYq+kLSQKzEfMG
        yGTOBU2Wh1Ol30PS4GdFZSgSPA==
X-Google-Smtp-Source: ABdhPJxb72RHf1WljDaMw4McsQVrWCzMcOMukUTc++8CZqZ0wzS3sF4S6c2WnsBVG6L1jeMWT893LA==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr14361019wmc.164.1597676067013;
        Mon, 17 Aug 2020 07:54:27 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:26 -0700 (PDT)
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
Subject: [PATCH RESEND v1 12/13] perf arm-spe: Add more sub classes for operation packet
Date:   Mon, 17 Aug 2020 15:53:47 +0100
Message-Id: <20200817145348.14461-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the operation type packet payload with load/store class, it misses
to support below sub classes:

  - A load/store targeting the general-purpose registers;
  - A load/store targeting unspecified registers;
  - An MRS or MSR operation at EL1 transformed to a load/store.

This patch is to add support for these sub classes.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index ab966885e892..095f344ee26c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -395,6 +395,27 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 					return ret;
 				buf += ret;
 				blen -= ret;
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_GP_REG) {
+				ret = snprintf(buf, buf_len, " GP-REG");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG) {
+				ret = snprintf(buf, buf_len, " UNSPEC-REG");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_MRS_MSR) {
+				ret = snprintf(buf, buf_len, " MRS-MSR");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
 			}
 			return buf_len - blen;
 		case SPE_OP_PKT_HDR_CLASS_BR_ERET:
-- 
2.17.1

