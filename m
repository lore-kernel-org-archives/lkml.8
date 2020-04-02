Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99529C2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF35206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbgDBNll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:41:41 -0400
Received: from foss.arm.com ([217.140.110.172]:42834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388813AbgDBNlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F13C7FA;
        Thu,  2 Apr 2020 06:41:39 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.29.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0882F3F52E;
        Thu,  2 Apr 2020 06:41:37 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     arnaldo.melo@gmail.com, shikemeng@huawei.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>
Subject: [PATCH 1/1] perf tools: fix compilation on Arm
Date:   Thu,  2 Apr 2020 14:41:28 +0100
Message-Id: <20200402134128.14493-2-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402134128.14493-1-james.clark@arm.com>
References: <20200330131810.GC31702@kernel.org>
 <20200402134128.14493-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit "perf report: Fix arm64 gap between kernel
start and module end" introduces the following build
error with GCC 7.3.0 on Arm:

"error: implicit declaration of function ‘strchr’"

Adding the required header fixes the issue.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 94745131e89a..d41b27e781d3 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stdio.h>
+#include <string.h>
 #include "debug.h"
 #include "symbol.h"
 
-- 
2.17.1

