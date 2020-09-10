Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAA2C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38A52087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FMEDkw73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgIJP5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:57:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731513AbgIJPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:55:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AF20KA110560;
        Thu, 10 Sep 2020 11:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RUjE8geQUfKJdleFxhslp2zP2B33QNPoIINZYifD8iU=;
 b=FMEDkw733leENqm6oVNBrKXrUlkoJX10udLb+AphbqatfaLEA3KgFRC4msJ+iMpDPlZa
 0+N5Xx28E9/JTDmU9HiExKyuT8T81QDpBTN0onDPC2oZJn/yzvo+N5qiviHDIo+1F4u/
 16qYfex3vHHgf9hwGfnm86ztj6kyPBQaoM0PZw4GbUXFOZQVL0uUy9+IutDIbV9slfXW
 M9paM6IA2GNodtdoDx6semhD0AR5662XyhCpRbbA6LBproPOOp+xYoxxtq6DsnT3wlts
 CTUAsigwf/ToeNSfItp4vnXL1qdE76O+SzEAZhF8jOz98Som3cPzFjOYWpS6gn09dcTR sA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33fp6ss20d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 11:18:45 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AFCAE0021779;
        Thu, 10 Sep 2020 15:18:44 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 33c2a9teqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 15:18:44 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AFIe0N47448510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 15:18:40 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 946946E050;
        Thu, 10 Sep 2020 15:18:43 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 083AA6E053;
        Thu, 10 Sep 2020 15:18:43 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.211.140.115])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 15:18:42 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-fsi@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, alistair@popple.id.au,
        jk@ozlabs.org
Subject: [PATCH 3/4] dt-bindings: fsi: Aspeed master: Add bus-frequency property
Date:   Thu, 10 Sep 2020 10:18:39 -0500
Message-Id: <20200910151840.25333-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910151840.25333-1-eajames@linux.ibm.com>
References: <20200910151840.25333-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_04:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=1 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bus-frequency property.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
index a513e65ec0c9..d84bd19526ca 100644
--- a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
@@ -17,6 +17,7 @@ Optional properties:
 
  - fsi-routing-gpios: GPIO for setting the FSI mux (internal or cabled)
  - fsi-mux-gpios: GPIO for detecting the desired FSI mux state
+ - bus-frequency: the frequency of the FSI bus
 
 
 Examples:
-- 
2.26.2

