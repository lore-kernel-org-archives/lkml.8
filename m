Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF453C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91258207DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R+8A9QDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgHRJfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:35:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgHRJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:35:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I9Vji7037344;
        Tue, 18 Aug 2020 05:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=75bJPjtkrmzOAQRJ0sclycEteSPINBpHqTq3A/TacfY=;
 b=R+8A9QDVKQ8CSsfRIoNLRkQKgyN5tDjUDHvjBbb/PIcTWdOKAw7lzjhUi7Wxg+yZOI9R
 TA5YG0ikmkS4bgk4Hz3f2F+Bj+bGRH2q2U6X+Pv33YNIBTX4qfcknYp36vNVZPZI2t8V
 iqcEzriEKtK05zt8+JNPhfRFLNSY1xfGawPoWdh+vRwgrqjafp3+D/euX6cbgXk71jO3
 olDJXwSqLdjTPZMc2xExadsHnmrzMkaC6S3CeKzC33uFf+9K2LD+u8b87U52ORYfl2ny
 LVDu7cL7orboRmHIoxUT+WIl1bPrztJj4SjDKMkN8Q9BTTbSwvvPIYrDdYVF8NxMPQlu gQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3304tdb9d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 05:35:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07I9YlXC007597;
        Tue, 18 Aug 2020 09:35:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3304cc0fgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 09:35:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07I9Z8iq26804546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 09:35:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 036765205F;
        Tue, 18 Aug 2020 09:35:08 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 03BD652051;
        Tue, 18 Aug 2020 09:35:06 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 0/2] scripts:gdb: Add few structs info in gdb scripts
Date:   Tue, 18 Aug 2020 15:04:59 +0530
Message-Id: <cover.1597742951.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_06:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=559 malwarescore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was using these structs info internally in my gdb scripts.
So sending it out for merge to upstream.
Patch-2 is just adding some headers and improves spacing.

-- 
2.25.4

