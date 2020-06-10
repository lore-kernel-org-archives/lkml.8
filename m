Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD52078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFJIqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:46:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgFJIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:46:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A8WtvQ124369;
        Wed, 10 Jun 2020 04:46:00 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jgsj2d3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 04:45:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A8fRGt026110;
        Wed, 10 Jun 2020 08:45:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7ybpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 08:45:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A8jtni5505232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 08:45:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0250011C052;
        Wed, 10 Jun 2020 08:45:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C13FB11C05C;
        Wed, 10 Jun 2020 08:45:54 +0000 (GMT)
Received: from osiris (unknown [9.171.21.235])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Jun 2020 08:45:54 +0000 (GMT)
Date:   Wed, 10 Jun 2020 10:45:53 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: set NODES_SHIFT=0 when NUMA=n
Message-ID: <20200610084553.GB4894@osiris>
References: <20200610014501.4268-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610014501.4268-1-cai@lca.pw>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_04:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=56
 clxscore=1011 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 09:45:01PM -0400, Qian Cai wrote:
> When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,
> 
> for_each_node(node) {
> 	if (wq_calc_node_cpumask(...
> 
> where it will trigger a booting warning,
> 
> WARNING: workqueue cpumask: online intersect > possible intersect
> 
> because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
> cpumask. NUMA=y has no such problem because node_possible_map will be
> initialized properly containing only node 0. Fix it by setting
> NODES_SHIFT=0 when NUMA=n.
> 
> Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/s390/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks! However I committed a different solution. Hope you don't mind:

From dd3f1f08f2317768b35b2df3ff8285185df7e195 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 10 Jun 2020 10:36:05 +0200
Subject: [PATCH] s390/numa: let NODES_SHIFT depend on NEED_MULTIPLE_NODES

Qian Cai reported:
---
When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,

for_each_node(node) {
        if (wq_calc_node_cpumask(...

where it will trigger a booting warning,

WARNING: workqueue cpumask: online intersect > possible intersect

because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
cpumask.
---

Let NODES_SHIFT depend on NEED_MULTIPLE_NODES like it is done
on other architectures in order to fix this.

Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2167bce993ff..ae01be202204 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -462,6 +462,7 @@ config NUMA
 
 config NODES_SHIFT
 	int
+	depends on NEED_MULTIPLE_NODES
 	default "1"
 
 config SCHED_SMT
-- 
2.17.1

