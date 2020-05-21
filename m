Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD489C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B551D206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgEUNdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:33:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4877 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729497AbgEUNdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:33:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D6B1EC6BA5F8B4BE7E53;
        Thu, 21 May 2020 21:33:03 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 21:32:56 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Bin <huawei.libin@huawei.com>,
        "Xie XiuQi" <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Subject: [PATCH 0/4] perf: Fix memory errors
Date:   Thu, 21 May 2020 21:32:14 +0800
Message-ID: <20200521133218.30150-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several memory errors in perf tool.

Hongbo Yao (1):
  perf metrictroup: Fix memory leak of metric_events

Li Bin (2):
  perf svghelper: Fix memory leak in svg_build_topology_map
  perf util: Fix potential segment fault in put_tracepoints_path

Xie XiuQi (1):
  perf util: Fix memory leak of prefix_if_not_in

 tools/perf/util/metricgroup.c      |  3 +++
 tools/perf/util/sort.c             |  2 +-
 tools/perf/util/svghelper.c        | 10 +++++++---
 tools/perf/util/trace-event-info.c |  2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.17.1

