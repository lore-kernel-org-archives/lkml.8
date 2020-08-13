Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5916C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C13F20885
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BWo8e6TX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgHMLbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:31:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgHMLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:31:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DB7GVt188885;
        Thu, 13 Aug 2020 07:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ljCBCiiYpDgxvDOTtfe4PLR32MdRo5LltpIdtIIz/8c=;
 b=BWo8e6TXIVDSd7t7qHyP3iaSCwsvgUUywYiPOjglT8rvZQEKPgJoF2c9toPN2irdRK3V
 z14ngTJ3Qn58dMgaEx11ZTv3i3lL55NOBhP33UHvmKOypmg97aAfJVpiotqotDNQMsW6
 stzII9ulSRQetpxdLWtQu5bXWFoQR5oKrKE3mnb3FPBZ+ZOWHQ4b8sfsRbvJxdd0RFQC
 T6g3SOuj7xC8v/xEQcpGFtSAoSQaAqmXMZuemJsHCTlQev5j1R3aNpVEQ73t8Ll3fqbI
 3W6ji468QIRfJID5/2fAsIgSvkfSBxHmvWmK4ShYWUgmXAZ80yUh4e34JX1XUYiPhbnD JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32v7v10h18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 07:30:48 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DBPW9G034465;
        Thu, 13 Aug 2020 07:30:48 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32v7v10gyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 07:30:48 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DBPEsE032503;
        Thu, 13 Aug 2020 11:30:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 32skp8dfrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:30:46 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DBUiUZ24838462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 11:30:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 354404203F;
        Thu, 13 Aug 2020 11:30:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A33E42041;
        Thu, 13 Aug 2020 11:30:43 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.147.109])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Aug 2020 11:30:43 +0000 (GMT)
Date:   Thu, 13 Aug 2020 13:30:42 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Balamuruhan S <bala24@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH v3 1/2] perf bench numa: fix cpumask memory leak in
 node_has_cpus()
Message-ID: <20200813113041.GA1685@oc3871087118.ibm.com>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
 <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
 <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_09:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=2 mlxscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple numa_allocate_cpumask() and numa_free_cpumask() functions

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 31e2601..9066511 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -248,16 +248,21 @@ static int is_node_present(int node)
 static bool node_has_cpus(int node)
 {
 	struct bitmask *cpu = numa_allocate_cpumask();
+	bool ret = false; /* fall back to nocpus */
 	unsigned int i;
 
-	if (cpu && !numa_node_to_cpus(node, cpu)) {
+	BUG_ON(!cpu);
+	if (!numa_node_to_cpus(node, cpu)) {
 		for (i = 0; i < cpu->size; i++) {
-			if (numa_bitmask_isbitset(cpu, i))
-				return true;
+			if (numa_bitmask_isbitset(cpu, i)) {
+				ret = true;
+				break;
+			}
 		}
 	}
+	numa_free_cpumask(cpu);
 
-	return false; /* lets fall back to nocpus safely */
+	return ret;
 }
 
 static cpu_set_t bind_to_cpu(int target_cpu)
-- 
1.8.3.1

