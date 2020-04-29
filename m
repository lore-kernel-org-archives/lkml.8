Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9279C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01072083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD2GEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:04:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39522 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbgD2GEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:04:46 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T63kUg095440;
        Wed, 29 Apr 2020 02:04:32 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mg17st2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 02:04:32 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03T5sbaf023927;
        Wed, 29 Apr 2020 06:04:30 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5qqfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 06:04:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03T64SqK57016424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 06:04:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F8FFA4064;
        Wed, 29 Apr 2020 06:04:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90BFCA4054;
        Wed, 29 Apr 2020 06:04:26 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.127.103])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Apr 2020 06:04:26 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, anju@linux.vnet.ibm.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, jolsa@kernel.org
Subject: [PATCH 0/2] powerpc/perf: Add support for perf extended regs in powerpc
Date:   Wed, 29 Apr 2020 11:34:13 +0530
Message-Id: <20200429060415.25930-1-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_01:2020-04-28,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=1 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch set to add support for perf extended register capability in
powerpc. The capability flag PERF_PMU_CAP_EXTENDED_REGS, is used to
indicate the PMU which support extended registers. The generic code
define the mask of extended registers as 0 for non supported architectures.

patch 2/2 defines this PERF_PMU_CAP_EXTENDED_REGS mask to output the
values of mmcr0,mmcr1,mmcr2 for POWER9.                
                                                                           
x86/perf_regs.h is included by util/intel-pt.c, which will get compiled       
when buiding perf on powerpc. Since x86/perf_regs.h has                    
`PERF_EXTENDED_REG_MASK` defined, defining `PERF_EXTENDED_REG_MASK` for       
powerpc to add support for perf extended regs will result in perf build       
error on powerpc. Currently powerpc architecture is not having support
for auxtrace. So as a workaround for this issue, patch 1/2 set
NO_AUXTRACE for powerpc. (Any other solutions are welcome.)

Patch 2/2 also add extended regs to sample_reg_mask in the tool side to use
with `-I?` option.

Anju T Sudhakar (2):
  tools/perf: set no_auxtrace for powerpc
  powerpc/perf: Add support for outputting extended regs in perf
    intr_regs

 arch/powerpc/include/asm/perf_event_server.h  |  5 +++
 arch/powerpc/include/uapi/asm/perf_regs.h     | 13 +++++++-
 arch/powerpc/perf/core-book3s.c               |  1 +
 arch/powerpc/perf/perf_regs.c                 | 29 ++++++++++++++--
 arch/powerpc/perf/power9-pmu.c                |  1 +
 .../arch/powerpc/include/uapi/asm/perf_regs.h | 13 +++++++-
 tools/perf/arch/powerpc/Makefile              |  1 +
 tools/perf/arch/powerpc/include/perf_regs.h   |  6 +++-
 tools/perf/arch/powerpc/util/perf_regs.c      | 33 +++++++++++++++++++
 9 files changed, 96 insertions(+), 6 deletions(-)

-- 
2.20.1

