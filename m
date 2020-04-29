Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6E1C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65ED2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgD2GEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:04:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbgD2GEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:04:45 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T637hE084724;
        Wed, 29 Apr 2020 02:04:36 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mguwscub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 02:04:35 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03T5sbai023927;
        Wed, 29 Apr 2020 06:04:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5qqfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 06:04:33 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03T64VuI60358788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 06:04:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFB40A4064;
        Wed, 29 Apr 2020 06:04:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2FA5A405F;
        Wed, 29 Apr 2020 06:04:28 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.127.103])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Apr 2020 06:04:28 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, anju@linux.vnet.ibm.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, jolsa@kernel.org
Subject: [PATCH 1/2] tools/perf: set no_auxtrace for powerpc
Date:   Wed, 29 Apr 2020 11:34:14 +0530
Message-Id: <20200429060415.25930-2-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429060415.25930-1-anju@linux.vnet.ibm.com>
References: <20200429060415.25930-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_01:2020-04-28,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=1
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/perf_regs.h is included by util/intel-pt.c, which will get compiled
when buiding perf on powerpc. Since x86/perf_regs.h has
`PERF_EXTENDED_REG_MASK` defined, defining `PERF_EXTENDED_REG_MASK` for
powerpc to add support for perf extended regs will result in perf build
error on powerpc.

Currently powerpc architecture is not having support for auxtrace. So as
a workaround for this issue, set NO_AUXTRACE for powerpc.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index e58d00d62f02..9ebb5f513605 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -3,6 +3,7 @@ ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
 
+NO_AUXTRACE := 1
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
-- 
2.20.1

