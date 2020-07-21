Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98338C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771622073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgGULsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6952 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgGULsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:48:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LBYCnC027422;
        Tue, 21 Jul 2020 07:48:49 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5pfp7r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 07:48:49 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LBjEa0023592;
        Tue, 21 Jul 2020 11:48:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 32dbmn0jxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 11:48:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LBmjBX59703296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 11:48:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFE1842049;
        Tue, 21 Jul 2020 11:48:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E4334203F;
        Tue, 21 Jul 2020 11:48:43 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.102.1.141])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 11:48:43 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     <linux-doc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] docs: kprobes: Update URLs and move under trace/
Date:   Tue, 21 Jul 2020 17:18:19 +0530
Message-Id: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_05:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=855 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates some of the URLs in the kprobes document and moves 
the same under trace/ directory.

- Naveen


Naveen N. Rao (3):
  docs: staging/kprobes.rst: Update some of the references
  docs: staging/kprobes.rst: Move references to a separate appendix
  docs: Move kprobes.rst from staging/ to trace/

 Documentation/staging/index.rst              |  1 -
 Documentation/trace/index.rst                |  1 +
 Documentation/{staging => trace}/kprobes.rst | 16 +++++++++-------
 3 files changed, 10 insertions(+), 8 deletions(-)
 rename Documentation/{staging => trace}/kprobes.rst (99%)


base-commit: f33d4075e512274c0c6edcd7602da2cf1d5a0341
-- 
2.25.4

