Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AFCC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FCE21D81
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nZV1c6Sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIJTTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:19:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7020 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731368AbgIJPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:54:29 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AF2tjt169967;
        Thu, 10 Sep 2020 11:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8Mlftey53B/H6IK5E2iIO4KQDXor/nn1hnefl9i/DEI=;
 b=nZV1c6SyU/XJM+SmfzYYQR45GhzOfmVxod/LNdlKa+UEedZzQp/XQHjkAKYw7IYLtcaC
 XN8wgVcRxkiOOCHEOJUdbof1ywbgr6RR9gXlK7ST7JIZ9wh27Fev1XpyzykkqmNNx6EH
 jKT43RXBgitOfZhzugXp9mYslQ3ww7H9OaU1x7Mph3GQeLTYadxWarB4SZhbTiMI3yfP
 WKUUkMrnPsfYEpxaNhTE3XeOZ6Dfodum+2hzPN3HY7GCK1TK5C8dZLfIwDPuXdV8xQJ+
 BmvLJPjBCI6xj7G1JauBrmYGBuPMDdCmcJGEXshrDeC6+jb8hCFTD3R4YnH+151rWzjF jw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fms8vt4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 11:18:43 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AFBvXo012745;
        Thu, 10 Sep 2020 15:18:42 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 33d46n59xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 15:18:42 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AFIfSB61407558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 15:18:41 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1C6A6E04C;
        Thu, 10 Sep 2020 15:18:41 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D9F36E04E;
        Thu, 10 Sep 2020 15:18:40 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.211.140.115])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 15:18:40 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-fsi@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, alistair@popple.id.au,
        jk@ozlabs.org
Subject: [PATCH 0/4] clk: AST2600 and FSI: Add APLL to control FSI bus frequency
Date:   Thu, 10 Sep 2020 10:18:36 -0500
Message-Id: <20200910151840.25333-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_04:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 mlxlogscore=754
 suspectscore=1 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality to control the APLL clock on the AST2600. The APLL provides
the clock for the FSI master on the AST2600. Then add a devicetree property to
set the AST2600 FSI master bus frequency.

Eddie James (4):
  dt-bindings: clock: Add AST2600 APLLdivN definition
  clk: ast2600: Add functionality to the APLL clock
  dt-bindings: fsi: Aspeed master: Add bus-frequency property
  fsi: Aspeed master: Set bus frequency from devicetree

 .../bindings/fsi/fsi-master-aspeed.txt        |   1 +
 drivers/clk/clk-ast2600.c                     | 177 ++++++++++++++++--
 drivers/fsi/fsi-master-aspeed.c               |   5 +
 include/dt-bindings/clock/ast2600-clock.h     |   1 +
 4 files changed, 172 insertions(+), 12 deletions(-)

-- 
2.26.2

