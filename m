Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE344C43445
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E20A22BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGWJJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:09:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgGWJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:09:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06N94TEZ094086;
        Thu, 23 Jul 2020 05:08:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e11p77bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:08:33 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N98XEH111182;
        Thu, 23 Jul 2020 05:08:33 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e11p77a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:08:33 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N969i9017384;
        Thu, 23 Jul 2020 09:08:30 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 32brbgu511-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 09:08:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06N98QUs60031040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 09:08:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56CD44C044;
        Thu, 23 Jul 2020 09:08:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAAF84C04A;
        Thu, 23 Jul 2020 09:08:20 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 09:08:20 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     ravi.bangoria@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org, pedromfc@br.ibm.com,
        miltonm@us.ibm.com, jniethe5@gmail.com, rogealve@br.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/10] powerpc/watchpoint: Enable 2nd DAWR on baremetal and powervm
Date:   Thu, 23 Jul 2020 14:38:03 +0530
Message-Id: <20200723090813.303838-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 mlxlogscore=735
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007230069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last series[1] was to add basic infrastructure support for more than
one watchpoint on Book3S powerpc. This series actually enables the 2nd 
DAWR for baremetal and powervm. Kvm guest is still not supported.

v4: https://lore.kernel.org/r/20200717040958.70561-1-ravi.bangoria@linux.ibm.com

v4->v5:
 - Using hardcoded values instead of macros HBP_NUM_ONE and HBP_NUM_TWO.
   Comment above HBP_NUM_MAX changed to explain it's value.
 - Included CPU_FTR_DAWR1 into CPU_FTRS_POWER10
 - Using generic function feat_enable() instead of
   feat_enable_debug_facilities_v31() to enable CPU_FTR_DAWR1.
 - ISA still includes 512B boundary in match criteria. But that's a
   documentation mistake. Mentioned about this in the last patch.
 - Rebased to powerpc/next
 - Added Jordan's Reviewed-by/Tested-by tags

[1]: https://lore.kernel.org/linuxppc-dev/20200514111741.97993-1-ravi.bangoria@linux.ibm.com/

Ravi Bangoria (10):
  powerpc/watchpoint: Fix 512 byte boundary limit
  powerpc/watchpoint: Fix DAWR exception constraint
  powerpc/watchpoint: Fix DAWR exception for CACHEOP
  powerpc/watchpoint: Enable watchpoint functionality on power10 guest
  powerpc/dt_cpu_ftrs: Add feature for 2nd DAWR
  powerpc/watchpoint: Set CPU_FTR_DAWR1 based on pa-features bit
  powerpc/watchpoint: Rename current H_SET_MODE DAWR macro
  powerpc/watchpoint: Guest support for 2nd DAWR hcall
  powerpc/watchpoint: Return available watchpoints dynamically
  powerpc/watchpoint: Remove 512 byte boundary

 arch/powerpc/include/asm/cputable.h       |  8 +-
 arch/powerpc/include/asm/hvcall.h         |  3 +-
 arch/powerpc/include/asm/hw_breakpoint.h  |  4 +-
 arch/powerpc/include/asm/machdep.h        |  2 +-
 arch/powerpc/include/asm/plpar_wrappers.h |  7 +-
 arch/powerpc/kernel/dawr.c                |  2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  1 +
 arch/powerpc/kernel/hw_breakpoint.c       | 98 +++++++++++++++--------
 arch/powerpc/kernel/prom.c                |  2 +
 arch/powerpc/kvm/book3s_hv.c              |  2 +-
 arch/powerpc/platforms/pseries/setup.c    |  7 +-
 11 files changed, 91 insertions(+), 45 deletions(-)

-- 
2.26.2

