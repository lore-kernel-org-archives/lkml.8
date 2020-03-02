Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846D0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E4A24697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCBFYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:24:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgCBFYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:24:34 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0225OLN1042408
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 00:24:33 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfmyq9kr4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:24:33 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 2 Mar 2020 05:24:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 05:24:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0225OOeI23134332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 05:24:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82AEE52057;
        Mon,  2 Mar 2020 05:24:24 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.175])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2AC425204E;
        Mon,  2 Mar 2020 05:24:21 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, peterz@infradead.org, mpe@ellerman.id.au,
        paulus@samba.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        alexey.budankov@linux.intel.com, yao.jin@linux.intel.com,
        robert.richter@amd.com, kim.phillips@amd.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC 02/11] perf/core: Data structure to present hazard data
Date:   Mon,  2 Mar 2020 10:53:46 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030205-0020-0000-0000-000003AF5D1B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030205-0021-0000-0000-00002207865A
Message-Id: <20200302052355.36365-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_01:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Introduce new perf sample_type PERF_SAMPLE_PIPELINE_HAZ to request kernel
to provide cpu pipeline hazard data. Also, introduce arch independent
structure 'perf_pipeline_haz_data' to pass hazard data to userspace. This
is generic structure and arch specific data needs to be converted to this
format.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 include/linux/perf_event.h            |  7 ++++++
 include/uapi/linux/perf_event.h       | 32 ++++++++++++++++++++++++++-
 kernel/events/core.c                  |  6 +++++
 tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++++++++++++-
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 547773f5894e..d5b606e3c57d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1001,6 +1001,7 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+	struct perf_pipeline_haz_data	pipeline_haz;
 } ____cacheline_aligned;
 
 /* default value for data source */
@@ -1021,6 +1022,12 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->weight = 0;
 	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
+	data->pipeline_haz.itype = PERF_HAZ__ITYPE_NA;
+	data->pipeline_haz.icache = PERF_HAZ__ICACHE_NA;
+	data->pipeline_haz.hazard_stage = PERF_HAZ__PIPE_STAGE_NA;
+	data->pipeline_haz.hazard_reason = PERF_HAZ__HREASON_NA;
+	data->pipeline_haz.stall_stage = PERF_HAZ__PIPE_STAGE_NA;
+	data->pipeline_haz.stall_reason = PERF_HAZ__SREASON_NA;
 }
 
 extern void perf_output_sample(struct perf_output_handle *handle,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 377d794d3105..ff252618ca93 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_PIPELINE_HAZ		= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -870,6 +871,13 @@ enum perf_event_type {
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u8			itype;
+	 *	  u8			icache;
+	 *	  u8			hazard_stage;
+	 *	  u8			hazard_reason;
+	 *	  u8			stall_stage;
+	 *	  u8			stall_reason;
+	 *	  u16			pad;} && PERF_SAMPLE_PIPELINE_HAZ
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1185,4 +1193,26 @@ struct perf_branch_entry {
 		reserved:40;
 };
 
+struct perf_pipeline_haz_data {
+	/* Instruction/Opcode type: Load, Store, Branch .... */
+	__u8	itype;
+	/* Instruction Cache source */
+	__u8	icache;
+	/* Instruction suffered hazard in pipeline stage */
+	__u8	hazard_stage;
+	/* Hazard reason */
+	__u8	hazard_reason;
+	/* Instruction suffered stall in pipeline stage */
+	__u8	stall_stage;
+	/* Stall reason */
+	__u8	stall_reason;
+	__u16	pad;
+};
+
+#define PERF_HAZ__ITYPE_NA	0x0
+#define PERF_HAZ__ICACHE_NA	0x0
+#define PERF_HAZ__PIPE_STAGE_NA	0x0
+#define PERF_HAZ__HREASON_NA	0x0
+#define PERF_HAZ__SREASON_NA	0x0
+
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e453589da97c..d00037c77ccf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1754,6 +1754,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		size += sizeof(data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_PIPELINE_HAZ)
+		size += sizeof(data->pipeline_haz);
+
 	event->header_size = size;
 }
 
@@ -6712,6 +6715,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_aux_sample_output(event, handle, data);
 	}
 
+	if (sample_type & PERF_SAMPLE_PIPELINE_HAZ)
+		perf_output_put(handle, data->pipeline_haz);
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 377d794d3105..ff252618ca93 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_PIPELINE_HAZ		= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -870,6 +871,13 @@ enum perf_event_type {
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u8			itype;
+	 *	  u8			icache;
+	 *	  u8			hazard_stage;
+	 *	  u8			hazard_reason;
+	 *	  u8			stall_stage;
+	 *	  u8			stall_reason;
+	 *	  u16			pad;} && PERF_SAMPLE_PIPELINE_HAZ
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1185,4 +1193,26 @@ struct perf_branch_entry {
 		reserved:40;
 };
 
+struct perf_pipeline_haz_data {
+	/* Instruction/Opcode type: Load, Store, Branch .... */
+	__u8	itype;
+	/* Instruction Cache source */
+	__u8	icache;
+	/* Instruction suffered hazard in pipeline stage */
+	__u8	hazard_stage;
+	/* Hazard reason */
+	__u8	hazard_reason;
+	/* Instruction suffered stall in pipeline stage */
+	__u8	stall_stage;
+	/* Stall reason */
+	__u8	stall_reason;
+	__u16	pad;
+};
+
+#define PERF_HAZ__ITYPE_NA	0x0
+#define PERF_HAZ__ICACHE_NA	0x0
+#define PERF_HAZ__PIPE_STAGE_NA	0x0
+#define PERF_HAZ__HREASON_NA	0x0
+#define PERF_HAZ__SREASON_NA	0x0
+
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
-- 
2.21.1

