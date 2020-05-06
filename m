Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B3C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D7B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778578;
	bh=57079+qnXPUNMO3c6YCLvvIFq90fxJ/NQOEsELRQXB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IAPglG6OslRPKRGsj43C1iT8uUX6H+M+V99RzXtgboiVvzZkIC/LKQNBMBl9J5LUv
	 Mw0z2Gl4RCtzAuRYKDBZUvP3X9BNYIN1uXbeD6PrNZ9jKPO6j3UG2phVoOArG2tYKK
	 fZhg7QhK1Lp639CSr5739vW6ffdipoJ/nSx4WaKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgEFPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgEFPWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:22:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3B52145D;
        Wed,  6 May 2020 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778574;
        bh=57079+qnXPUNMO3c6YCLvvIFq90fxJ/NQOEsELRQXB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nzpQdYR3XX/fLVUUF9iOloyVxjrr5RxjwxhIrcGoKWWDKl/QArlCQIBbyQC0NGaM
         sX408xIpgUDJIKKzIfuQfPTgQIwm6mdfx68y0o+TKqUwOr24aY4H3QC9wiWiXqhKTN
         5Ud+vH9liGJsVKGUUsfA85yAcdvpJhF/Fkoz1hKM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/91] perf evlist: Remove duplicate headers
Date:   Wed,  6 May 2020 12:21:06 -0300
Message-Id: <20200506152234.21977-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Code cleanup: Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/1587276836-17088-1-git-send-email-jagdsh.linux@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/evlist.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 5b9f2ca50591..def55054c55b 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -11,10 +11,8 @@
 #include <internal/mmap.h>
 #include <internal/cpumap.h>
 #include <internal/threadmap.h>
-#include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <linux/zalloc.h>
-#include <sys/ioctl.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.21.1

