Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0A7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4942420729
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g48q1UKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgHQObt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgHQObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:31:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE852C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:31:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a79so8313988pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/IkGl2EOkCygc2Xy/bD6bKK5+ruzUaNHckkTHveFQKQ=;
        b=g48q1UKmNgCa+wusUyNc9Rnj/NQ3iOKmXTnl1CEkHBEHtY5BbinMGh2CQ6D/PHNJKZ
         sQc2gDBiosPbfRqSOBG5y3xwsesjL5jQfW+ZAl0oKi8OgkjXQmjM/25OQrLo/ypWxA6y
         V5dq8GaTniNOzwJ6f8/ve81fsS/tznFhFQD24clW3giXa8Plr+Bik+pekNJ/HbrynsAB
         ak9CjqEpz38QDVGI+T8t3ogAq+gtAcFH4hTlEpHv92UsoTpcK7KY03sjop7/Fw4iI8SZ
         QbAZ/Id3bCqULKp/5QDsLg6uhbDgslli7txGHZf2cy8UsH9N4EgbVxmWY6ciJAyBv/S+
         QpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/IkGl2EOkCygc2Xy/bD6bKK5+ruzUaNHckkTHveFQKQ=;
        b=I+UFv1Zra0i/fVs0AjSg5FW5qg8weIlERblLN2QJ404NjR2rVGheuo+tubqSxPJoBS
         wcUn8/T/vOZb5VilXznxp2W+YFgHkEjsVTZ/GefMXsnOecMDCbFa4Oe+MCn0frKg8iwL
         69WDFYr/SGklS5457cZwRX7GaaMs4Zvwi+H42jJSl79pRTYwfOXPBzzE9FpqBmyxepVX
         ssqAXuN5tLz1JEzpTdH9MxTYNZiDLLFf5y8dE3erS4JXbYAbekOrW9AyaxLx2vXJyVRv
         amrs7PCRTMMpHfB2fxXl6MKSh/nE6xqqVS+mNQxLT+B/PGreztYJdiaDPYuk5NU89PQX
         rTOw==
X-Gm-Message-State: AOAM530Km5L4er/e8ZNVn6bf6W5iGMfJaSXBd0jNhzC4s3l8nrlK2sa5
        zUBBZAIL9BKCTKB4DSDe0aiibA==
X-Google-Smtp-Source: ABdhPJyhIiNBoizgCqmXOKxui4Nyda6xu8LJK7LVMBZ9awEcUvPXKybI5RVK6qwcRl2mQVGRBfYayA==
X-Received: by 2002:a63:f00a:: with SMTP id k10mr10241757pgh.76.1597674706104;
        Mon, 17 Aug 2020 07:31:46 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y65sm19804778pfb.155.2020.08.17.07.31.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 07:31:45 -0700 (PDT)
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
Subject: [PATCH v1 00/13] perf arm-spe: Refactor decoding & dumping flow
Date:   Mon, 17 Aug 2020 22:31:01 +0800
Message-Id: <20200817143114.13393-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prominent issue for the SPE trace decoding and dumping is the packet
header and payload values are hard coded with numbers and it's not
readable and difficult to maintain; and has other minor issues, e.g. the
packet length (header + payload) calculation is not correct for some
packet types, and the dumping flow misses to support specific sub
classes for operation packet, etc.

So this patch set is to refactor the Arm SPE decoding SPE with:
- Patches 01, 02 are minor cleans up;
- Patches 03, 04 are used to fix and polish the packet and payload
  length calculation;
- Patches 05 ~ 12 are used to refactor decoding for different types
  packet one by one (address packet, context packet, counter packet,
  event packet, operation packet);
- Patch 13 is coming from Wei Li to add decoding for ARMv8.3
  extension, in this version it has been improved to use defined
  macros, also is improved for failure handling and commit log.

Prerequisite: This patch set is applied on the top of perf/core branch
with commit 492e4edba6e2 ("perf ftrace: Make option description initials
all capital letters"), and also it relies on Wei Li's bug fixing patch
"perf: arm-spe: Fix check error when synthesizing events" [1].

This patch set has been verified on Hisilicon D06 platform.

[1] https://lkml.org/lkml/2020/7/24/132


Leo Yan (12):
  perf arm-spe: Include bitops.h for BIT() macro
  perf arm-spe: Fix a typo in comment
  perf arm-spe: Refactor payload length calculation
  perf arm-spe: Fix packet length handling
  perf arm-spe: Refactor packet header parsing
  perf arm-spe: Refactor address packet handling
  perf arm-spe: Refactor context packet handling
  perf arm-spe: Refactor counter packet handling
  perf arm-spe: Refactor event type handling
  perf arm-spe: Detect failure for snprintf()
  perf arm-spe: Refactor operation packet handling
  perf arm-spe: Add more sub classes for operation packet

Wei Li (1):
  perf arm-spe: Add support for ARMv8.3-SPE

 .../util/arm-spe-decoder/arm-spe-decoder.c    |  54 ++-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 433 ++++++++++++------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 117 ++++-
 4 files changed, 418 insertions(+), 203 deletions(-)

-- 
2.17.1

