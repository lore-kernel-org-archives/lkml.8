Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126FC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1AC216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgEAPJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:09:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23438 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbgEAPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:09:10 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041Ee3HH086746;
        Fri, 1 May 2020 11:08:37 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r8223atf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 11:08:36 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041F5GP5030744;
        Fri, 1 May 2020 15:08:36 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 30mcu761sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 15:08:35 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041F8ZZG23855478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 15:08:35 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FAAE7805E;
        Fri,  1 May 2020 15:08:35 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82F3878060;
        Fri,  1 May 2020 15:08:34 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.211.128.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 15:08:34 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        alistair@popple.id.au, joel@jms.id.au, jk@ozlabs.org,
        robh+dt@kernel.org, eajames@linux.ibm.com
Subject: [PATCH 1/3] dt-bindings: fsi: Add P10 OCC device documentation
Date:   Fri,  1 May 2020 10:08:31 -0500
Message-Id: <20200501150833.5251-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200501150833.5251-1-eajames@linux.ibm.com>
References: <20200501150833.5251-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_08:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=1 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the P10 compatible string.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
index 99ca9862a586..e73358075a90 100644
--- a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
+++ b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
@@ -1,13 +1,13 @@
-Device-tree bindings for FSI-attached POWER9 On-Chip Controller (OCC)
----------------------------------------------------------------------
+Device-tree bindings for FSI-attached POWER9/POWER10 On-Chip Controller (OCC)
+-----------------------------------------------------------------------------
 
-This is the binding for the P9 On-Chip Controller accessed over FSI from a
-service processor. See fsi.txt for details on bindings for FSI slave and CFAM
+This is the binding for the P9 or P10 On-Chip Controller accessed over FSI from
+a service processor. See fsi.txt for details on bindings for FSI slave and CFAM
 nodes. The OCC is not an FSI slave device itself, rather it is accessed
-through the SBE fifo.
+through the SBE FIFO.
 
 Required properties:
- - compatible = "ibm,p9-occ"
+ - compatible = "ibm,p9-occ" or "ibm,p10-occ"
 
 Examples:
 
-- 
2.24.0

