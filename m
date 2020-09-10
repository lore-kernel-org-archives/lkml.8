Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A2C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7394206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jeOPEFs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIJTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:23:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41844 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731399AbgIJPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:50:35 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AF2oQe195661;
        Thu, 10 Sep 2020 11:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JOgiBh8i9eFcK4L0kZnRCGl04BXJvtGSR/Tg8yzhjsY=;
 b=jeOPEFs48b5qUFmLoBvDeWqzuMQqGiTGhTaO4DFmJ//sjxRN8AEuuhBVjzMzpAwLOhx9
 ihQFalyLmpJbPSz8VN0JA/pPNOKU96XKTo0sRNfScil2lBXJeFJxwg9ukyC87XkF7j/W
 OjWDucynNoYBS+wXJAdZYjPtBe37T5ivzObYSv6esO+1Q5/48RtDQkCwLFjMYzzmgxKH
 VlitlS8enCrkZUuK+RlUNgqCh9NXRJ+jTjSrvJe97vYOqbc0e6G1dzLbMgs5PBSUPwas
 7PBCHIDE9u3OuaUU01y5NDc3MpYx4HKs8sLGA4ahTUu1MjHo9qlCU2AkVA02mAL/bib4 lw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fmme3y7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 11:18:51 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AFCBRZ021811;
        Thu, 10 Sep 2020 15:18:43 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 33c2a9teqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 15:18:43 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AFIgYF65143224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 15:18:42 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54AFE6E04C;
        Thu, 10 Sep 2020 15:18:42 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5D136E04E;
        Thu, 10 Sep 2020 15:18:41 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.211.140.115])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 15:18:41 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-fsi@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, alistair@popple.id.au,
        jk@ozlabs.org
Subject: [PATCH 1/4] dt-bindings: clock: Add AST2600 APLLdivN definition
Date:   Thu, 10 Sep 2020 10:18:37 -0500
Message-Id: <20200910151840.25333-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910151840.25333-1-eajames@linux.ibm.com>
References: <20200910151840.25333-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_04:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=1 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new clock definition for the "APLLdivN" as described in the
AST2600 specification. This clock is simply the APLL divided by a
factor defined in the SCU registers. It is the input to the FSI
bus.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 include/dt-bindings/clock/ast2600-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 62b9520a00fd..5a9ae0a1d574 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -87,6 +87,7 @@
 #define ASPEED_CLK_MAC2RCLK		68
 #define ASPEED_CLK_MAC3RCLK		69
 #define ASPEED_CLK_MAC4RCLK		70
+#define ASPEED_CLK_APLLN		71
 
 /* Only list resets here that are not part of a gate */
 #define ASPEED_RESET_ADC		55
-- 
2.26.2

