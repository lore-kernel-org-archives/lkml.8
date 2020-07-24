Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B1CC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2912063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGXJSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:18:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8371 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbgGXJSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:18:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D177F14D3339F5F86A8A;
        Fri, 24 Jul 2020 17:17:57 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 17:17:51 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, <zhangshaokun@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <guohanjun@huawei.com>
Subject: [PATCH 0/4] Add support for ARMv8.3-SPE
Date:   Fri, 24 Jul 2020 17:16:03 +0800
Message-ID: <20200724091607.41903-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARMv8.3-SPE adds an Alignment Flag in the Events packet and filtering
on this event using PMSEVFR_EL1, together with support for the profiling
of Scalable Vector Extension operations.

Patch 1: Update the kernel driver, mainly for PMSEVFR_EL1.

Patch 2: Update the decode process of Events packet and Operation Type
  packet in perf tool.

Patch 3-4: Synthesize unaligned address access events and partial/empty
  predicated SVE events, also add two itrace options for filtering.

Wei Li (4):
  drivers/perf: Add support for ARMv8.3-SPE
  perf: arm-spe: Add support for ARMv8.3-SPE
  perf auxtrace: Add new itrace options for ARMv8.3-SPE
  perf: arm-spe: Synthesize new events for ARMv8.3-SPE

 arch/arm64/include/asm/sysreg.h               |  4 +-
 drivers/perf/arm_spe_pmu.c                    | 18 +++--
 tools/perf/Documentation/itrace.txt           |  2 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 11 +++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  3 +
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 69 ++++++++++++++++++-
 tools/perf/util/arm-spe.c                     | 61 ++++++++++++++++
 tools/perf/util/auxtrace.c                    |  8 +++
 tools/perf/util/auxtrace.h                    |  4 ++
 9 files changed, 173 insertions(+), 7 deletions(-)

-- 
2.17.1

