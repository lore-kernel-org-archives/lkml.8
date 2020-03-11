Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5272C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37872146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgCKLDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:03:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgCKLDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:03:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BB2ADt136879
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:03:51 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ypv2m82rv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:03:50 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 11 Mar 2020 11:03:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Mar 2020 11:03:08 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02BB37IO50856086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 11:03:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA98752054;
        Wed, 11 Mar 2020 11:03:07 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.102.25.51])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B90852050;
        Wed, 11 Mar 2020 11:03:04 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] powerpc/numa: Prefer node id queried from vphn
Date:   Wed, 11 Mar 2020 16:32:36 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20031111-0028-0000-0000-000003E31109
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031111-0029-0000-0000-000024A85504
Message-Id: <20200311110237.5731-3-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_04:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node id queried from the static device tree may not
be correct. For example: it may always show 0 on a shared processor.
Hence prefer the node id queried from vphn and fallback on the device tree
based node id if vphn query fails.

Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Christopher Lameter <cl@linux.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 54dcd49..8735fed 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -719,20 +719,20 @@ static int __init parse_numa_properties(void)
 	 */
 	for_each_present_cpu(i) {
 		struct device_node *cpu;
-		int nid;
-
-		cpu = of_get_cpu_node(i, NULL);
-		BUG_ON(!cpu);
-		nid = of_node_to_nid_single(cpu);
-		of_node_put(cpu);
+		int nid = vphn_get_nid(i);
 
 		/*
 		 * Don't fall back to default_nid yet -- we will plug
 		 * cpus into nodes once the memory scan has discovered
 		 * the topology.
 		 */
-		if (nid < 0)
-			continue;
+		if (nid == NUMA_NO_NODE) {
+			cpu = of_get_cpu_node(i, NULL);
+			if (cpu) {
+				nid = of_node_to_nid_single(cpu);
+				of_node_put(cpu);
+			}
+		}
 		node_set_online(nid);
 	}
 
-- 
1.8.3.1

