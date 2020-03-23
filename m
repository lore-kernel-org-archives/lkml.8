Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5FDC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF9620735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgCWN3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:29:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728240AbgCWN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:29:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ND5GPt058626
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:29:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuu5jbn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:29:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <agordeev@linux.ibm.com>;
        Mon, 23 Mar 2020 13:29:35 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Mar 2020 13:29:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02NDTXYI56885300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 13:29:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFBE142042;
        Mon, 23 Mar 2020 13:29:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DF9042041;
        Mon, 23 Mar 2020 13:29:32 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.39.189])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Mar 2020 13:29:32 +0000 (GMT)
From:   agordeev@linux.ibm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 0/2] mm/mmap: check mapping limits more strictly
Date:   Mon, 23 Mar 2020 14:29:27 +0100
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 20032313-0016-0000-0000-000002F63D86
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032313-0017-0000-0000-00003359D655
Message-Id: <cover.1584958099.git.agordeev@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_04:2020-03-21,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=412
 suspectscore=1 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

This series is against v5.6-rc7

Alexander Gordeev (2):
  mm/mmap.c: add more sanity checks to get_unmapped_area()
  mm/mmap.c: do not allow mappings outside of allowed limits

 mm/mmap.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

-- 
2.23.0

