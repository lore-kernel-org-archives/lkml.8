Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25489C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F297420774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaQwlT/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437608AbgDOUOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406385AbgDOUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:14:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EF3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:14:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so1349327wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ODOvndW4LiKNLVugKfg+XGH/+IQIVz2j2QhcNZNNNDw=;
        b=CaQwlT/FCuz7txLgHcAuiZlNax5IL/PAk5jNXi58jO/V0R0XMdSUedQt3XjwGuffpQ
         w5qyuWW3O0jV7QBqiFXC6lIrAbmvyS2aBMxxd09tJWQIh/b3IOl6+07MzV+JIZT88r9I
         tj09BzwMPvCUHz/A7QU6rVC31qy8bBMKrmPb0+k997dTjFgmjF5VGYsHg9AAjntgJK+2
         np3AJmZxJtZ77SH4JBsebQbF+FLiOPOeCXVwnjUwOh5RjnQjsfaxGDSYE33NMrKF3UTq
         AGoG4ES1hV9TSrd87RYLJUVpL0+T50ia80qh9yIMgDNSaY3K3/ZKzXMhDa+8gxjR4bgH
         JYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ODOvndW4LiKNLVugKfg+XGH/+IQIVz2j2QhcNZNNNDw=;
        b=Roqx6ZX8rBo7gbD5PKDgb8Q39LnZeYupGUCIU7ZlfQOXAU4TzVgunON9WMuuExU6xb
         Ra15xwCEhZniXEqsIevkzYcRlzNeG+czeKbq3jJp3CbS79SQ2vegi5URnN+UrLdWOs+k
         ezq3mC+1p5ynXuidSqrAdWMrMPNUPdclLxckEOKdUMNIAi+i2W/JFwMyjIvy1sskYlIo
         x18W6oxZyz3X8xNcLCJIiE4kFQVRGkiJ9oEQOSZUqaIHoTaUsXYUD+6olvcYsj6gt1nP
         jf9wrNZO6ftVA5wm1g3smh8GwirZMy3YlxMi9LuMLrk/jsprveC7kH6oP2WparqjjnhA
         c1cg==
X-Gm-Message-State: AGi0PuZCj+4u2Ar+/66wGdXiYDULC+yEe8Or7LXp1wbShRRzuvuB5WFW
        7d8LRtEVB5Xdacog538eCiEMLw==
X-Google-Smtp-Source: APiQypJZIP9bAo45DYG4zOGjoaVp9RiNqSCx3wezM6Eex8q2r3S+QMaUKrN6PphcUwxMmDdzYEgmQw==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr1055203wme.126.1586981662560;
        Wed, 15 Apr 2020 13:14:22 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:8bee:312:6092:58f2])
        by smtp.gmail.com with ESMTPSA id 17sm812782wmo.2.2020.04.15.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:14:22 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] perf: cs-etm: Update to build with latest opencsd version.
Date:   Wed, 15 Apr 2020 21:14:20 +0100
Message-Id: <20200415201420.15958-1-mike.leach@linaro.org>
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

Tested on Linux 5.7-rc1.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cd92a99eb89d..da4737cbc2ab 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -564,6 +564,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
 					       elem, trace_chan_id);
 		break;
+	/* Unused packet types */
+#if OCSD_VER_NUM >= 0x0E00
+	case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
+#endif
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
 	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
-- 
2.17.1

