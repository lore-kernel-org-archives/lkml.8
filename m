Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2641C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF27020B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778629;
	bh=F123k+dQoXefB4XaJFKPqZtZKE+1lFDG9zA42Zu1yw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uhg1PehI4YrmCIkTiMZGyC2bwVvBa2yV56VBGs+u24iXTwEuuZ+TGyHS785qgaTM7
	 cpRscAipqYm/ftLcMluOX3B8q86cyQPBflAqxAIGDZugI0TnUPY7EPmEaS9Pbcl5fO
	 8q67pQtADzCt+FVF9fl1WIWdF5IKh3JJmfngCdvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgEFPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729749AbgEFPXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF2421655;
        Wed,  6 May 2020 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778625;
        bh=F123k+dQoXefB4XaJFKPqZtZKE+1lFDG9zA42Zu1yw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8+/IZwRDxvf6tQcDq/5PQNYURXtZpTNRxvXnwTooYsGUeiI7NssA/LhMQfWMGDcZ
         are4YhwwAbZEF6DfAav6nDtk0wZ67peUDSfo3b2s/keDY420aAfm6/anOofxSNOvTf
         +4qcHjKiQKZroTI1GSyMuYitZgvPfy85PStl0nXA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/91] perf pmu: Fix function name in comment, its get_cpuid_str(), not get_cpustr()
Date:   Wed,  6 May 2020 12:21:20 -0300
Message-Id: <20200506152234.21977-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

get_cpuid_str() is used in tools/perf/arch/xxx/util/header.c,
fix the name in comment.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lore.kernel.org/lkml/1588141992-48382-1-git-send-email-zhangshaokun@hisilicon.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/pmu-events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 53e76d5d5b37..c8f306b572f4 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -26,7 +26,7 @@ struct pmu_event {
  * Map a CPU to its table of PMU events. The CPU is identified by the
  * cpuid field, which is an arch-specific identifier for the CPU.
  * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
- * must match the get_cpustr() in tools/perf/arch/xxx/util/header.c)
+ * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
  *
  * The  cpuid can contain any character other than the comma.
  */
-- 
2.21.1

