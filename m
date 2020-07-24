Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F14C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0641D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGXHN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:13:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbgGXHNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:13:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 753654FFC4C5876183F0;
        Fri, 24 Jul 2020 15:13:19 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 15:13:10 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <guohanjun@huawei.com>
Subject: [PATCH v2 0/2] perf tools: Fix record failure when mixed with ARM SPE event
Date:   Fri, 24 Jul 2020 15:11:09 +0800
Message-ID: <20200724071111.35593-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
 - Optimize code in patch 1 as Mathieu adviced.
 - Fix memleak in patch 2.
 - Detail the commit info to explain the reason.

This patch set fixes perf record failure when we mix arm_spe_x event
with other events in specific order.

Wei Li (2):
  perf tools: Fix record failure when mixed with ARM SPE event
  perf tools: ARM SPE code cleanup

 tools/perf/arch/arm/util/auxtrace.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.17.1

