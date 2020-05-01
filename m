Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4536FC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2B8216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgEAPJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:09:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50006 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729247AbgEAPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:09:13 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041Ee3HG086746;
        Fri, 1 May 2020 11:08:36 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r8223ate-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 11:08:36 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041F6bDT029914;
        Fri, 1 May 2020 15:08:35 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 30mcu8bm46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 15:08:35 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041F8X7O12124654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 15:08:33 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EE6D7805C;
        Fri,  1 May 2020 15:08:34 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D67D57805E;
        Fri,  1 May 2020 15:08:33 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.211.128.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 15:08:33 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        alistair@popple.id.au, joel@jms.id.au, jk@ozlabs.org,
        robh+dt@kernel.org, eajames@linux.ibm.com
Subject: [PATCH 0/3] occ: Add support for P10
Date:   Fri,  1 May 2020 10:08:30 -0500
Message-Id: <20200501150833.5251-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_08:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 suspectscore=1 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=902 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OCC in the P10 has a number of differences from the P9. Add some logic to
handle the differences in accessing the OCC from the service processor, and
support the new temperature sensor type.

Eddie James (3):
  dt-bindings: fsi: Add P10 OCC device documentation
  fsi: occ: Add support for P10
  hwmon: (occ) Add new temperature sensor type

 .../devicetree/bindings/fsi/ibm,p9-occ.txt    |  12 +-
 drivers/fsi/fsi-occ.c                         | 126 +++++++++++++-----
 drivers/hwmon/occ/common.c                    |  75 +++++++++++
 3 files changed, 173 insertions(+), 40 deletions(-)

-- 
2.24.0

