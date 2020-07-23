Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C0FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11A52067D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgGWT0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:26:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgGWT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:26:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NJGGOk047201;
        Thu, 23 Jul 2020 15:26:50 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fadfc2cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 15:26:50 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NJQmA5001297;
        Thu, 23 Jul 2020 19:26:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7wrgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 19:26:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NJPLca64225548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 19:25:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A24CEAE051;
        Thu, 23 Jul 2020 19:26:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53C44AE04D;
        Thu, 23 Jul 2020 19:26:45 +0000 (GMT)
Received: from osiris (unknown [9.171.43.182])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Jul 2020 19:26:45 +0000 (GMT)
Date:   Thu, 23 Jul 2020 21:26:43 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.8-rc7
Message-ID: <20200723192643.GA7038@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=2 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007230133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 updates for 5.8-rc7.

Thanks,
Heiko

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-6

for you to fetch changes up to 0cfa112b33aba4473b00151c75b87818a835702a:

  MAINTAINERS: add Matthew for s390 IOMMU (2020-07-22 17:01:23 +0200)

----------------------------------------------------------------
- Change cpum_cf/perf counter name from DFLT_CCERROR to DFLT_CCFINISH
  to reflect reality and avoid further confusion. This is a user space
  visible change therefore the commit has also a stable tag for 5.7,
  where this counter was introduced.

- Add Matthew Rosato as s390 IOMMU maintainer.

----------------------------------------------------------------
Gerald Schaefer (1):
      MAINTAINERS: add Matthew for s390 IOMMU

Thomas Richter (1):
      s390/cpum_cf,perf: change DFLT_CCERROR counter name

 MAINTAINERS                                          | 1 +
 arch/s390/kernel/perf_cpum_cf_events.c               | 4 ++--
 tools/perf/pmu-events/arch/s390/cf_z15/extended.json | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d53db30d1365..df5fc5625ec8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14862,6 +14862,7 @@ F:	drivers/s390/block/dasd*
 F:	include/linux/dasd_mod.h
 
 S390 IOMMU (PCI)
+M:	Matthew Rosato <mjrosato@linux.ibm.com>
 M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
diff --git a/arch/s390/kernel/perf_cpum_cf_events.c b/arch/s390/kernel/perf_cpum_cf_events.c
index 1e3df52b2b65..37265f551a11 100644
--- a/arch/s390/kernel/perf_cpum_cf_events.c
+++ b/arch/s390/kernel/perf_cpum_cf_events.c
@@ -292,7 +292,7 @@ CPUMF_EVENT_ATTR(cf_z15, TX_C_TABORT_SPECIAL, 0x00f5);
 CPUMF_EVENT_ATTR(cf_z15, DFLT_ACCESS, 0x00f7);
 CPUMF_EVENT_ATTR(cf_z15, DFLT_CYCLES, 0x00fc);
 CPUMF_EVENT_ATTR(cf_z15, DFLT_CC, 0x00108);
-CPUMF_EVENT_ATTR(cf_z15, DFLT_CCERROR, 0x00109);
+CPUMF_EVENT_ATTR(cf_z15, DFLT_CCFINISH, 0x00109);
 CPUMF_EVENT_ATTR(cf_z15, MT_DIAG_CYCLES_ONE_THR_ACTIVE, 0x01c0);
 CPUMF_EVENT_ATTR(cf_z15, MT_DIAG_CYCLES_TWO_THR_ACTIVE, 0x01c1);
 
@@ -629,7 +629,7 @@ static struct attribute *cpumcf_z15_pmu_event_attr[] __initdata = {
 	CPUMF_EVENT_PTR(cf_z15, DFLT_ACCESS),
 	CPUMF_EVENT_PTR(cf_z15, DFLT_CYCLES),
 	CPUMF_EVENT_PTR(cf_z15, DFLT_CC),
-	CPUMF_EVENT_PTR(cf_z15, DFLT_CCERROR),
+	CPUMF_EVENT_PTR(cf_z15, DFLT_CCFINISH),
 	CPUMF_EVENT_PTR(cf_z15, MT_DIAG_CYCLES_ONE_THR_ACTIVE),
 	CPUMF_EVENT_PTR(cf_z15, MT_DIAG_CYCLES_TWO_THR_ACTIVE),
 	NULL,
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
index 2df2e231e9ee..24c4ba2a9ae5 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
@@ -380,7 +380,7 @@
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "265",
-		"EventName": "DFLT_CCERROR",
+		"EventName": "DFLT_CCFINISH",
 		"BriefDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or 2",
 		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or 2"
 	},
