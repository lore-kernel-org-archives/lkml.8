Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4682EC47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284D521655
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778654;
	bh=Z2a6BvB7V2oRcTfvpILMr6MCbyplu9h+wRMMfrZXx7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eUj/nPSXN/CWphbOXiTfzC1clXazUjt1XQPUPAXzj2mZPRYrbKAgKpBB0V6IT1Zg2
	 xouCj/sY4W15XvKeiEOx5bMTliIl9tJtsbTiayLWj0s/mW6EkT+TZdAho4ExECIIZp
	 pqBe840IHHOmy5D4Qpo2qFJvdl2Th7kNyUXPvwNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgEFPYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgEFPYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FAD21BE5;
        Wed,  6 May 2020 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778651;
        bh=Z2a6BvB7V2oRcTfvpILMr6MCbyplu9h+wRMMfrZXx7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W01y7i9nt1hesraQra2LYBVAR3tPGFHaIesl37RV3fsa7tcg0SRcxpL5XsbAz3Q/Y
         X5DkixVHSFUTVK9k8MvgaJ3WFnPb0oDck69pYpMPSP7UwQNHFC+EeD98h0OEy39XUD
         6LpoN7LcGDNMaqdIEtZiKQAECR+MkXT1LpFpOFv8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kajol Jain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Petlan <mpetlan@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/91] perf vendor events power9: Add hv_24x7 socket/chip level metric events
Date:   Wed,  6 May 2020 12:21:24 -0300
Message-Id: <20200506152234.21977-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
facility to continuously collect large numbers of hardware performance
metrics efficiently and accurately.

This patch adds hv_24x7  metric file for different Socket/chip
resources.

Result:

power9 platform:

  command:# ./perf stat --metric-only -M Memory_RD_BW_Chip -C 0 -I 1000

     1.000096188          0.9           0.3
     2.000285720          0.5           0.1
     3.000424990          0.4           0.1

  command:# ./perf stat --metric-only -M PowerBUS_Frequency -C 0 -I 1000

     1.000097981          2.3           2.3
     2.000291713          2.3           2.3
     3.000421719          2.3           2.3
     4.000550912          2.3           2.3

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20200401203340.31402-8-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/powerpc/power9/nest_metrics.json     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
new file mode 100644
index 000000000000..c121e526442a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -0,0 +1,19 @@
+[
+    {
+        "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
+        "MetricName": "Memory_RD_BW_Chip",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+	"MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
+        "MetricName": "Memory_WR_BW_Chip",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+	"MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
+        "MetricName": "PowerBUS_Frequency",
+        "ScaleUnit": "2.5e-7GHz"
+    }
+]
-- 
2.21.1

