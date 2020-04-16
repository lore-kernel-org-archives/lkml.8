Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED738C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40B121744
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgDPUFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:05:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730759AbgDPUD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:03:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GK3pOB038859;
        Thu, 16 Apr 2020 16:03:52 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ewfqrx49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 16:03:51 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03GK3JUI026246;
        Thu, 16 Apr 2020 20:03:43 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 30b5h7g0wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 20:03:43 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03GK3gFk41812346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 20:03:42 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F1ABAC05B;
        Thu, 16 Apr 2020 20:03:42 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9BD2AC059;
        Thu, 16 Apr 2020 20:03:40 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.163.81.122])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Apr 2020 20:03:40 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Subject: [PATCH v9 0/5] soc: aspeed: Add XDMA engine driver
Date:   Thu, 16 Apr 2020 15:03:34 -0500
Message-Id: <1587067419-5107-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_08:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=3 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=925 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a driver to control the Aspeed XDMA engine embedded in the
AST2500 and AST2600. The XDMA engine performs automatic DMA operations
over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.

Changes since v8:
 - Use DMA API to allocate memory from reserved region.
 - Fix the driver for the AST2500 by keeping the command queue in kernel
   memory and copying the whole buffer to the reserved memory area before
   starting the operation.
 - Add krefs to the client structure to prevent use-after-free.
 - Switch reset-names binding to "device", "root-complex"

Eddie James (5):
  dt-bindings: soc: Add Aspeed XDMA Engine
  soc: aspeed: Add XDMA Engine Driver
  soc: aspeed: xdma: Add user interface
  soc: aspeed: xdma: Add reset ioctl
  ARM: dts: Aspeed: AST2600: Add XDMA PCI-E root control reset

 .../devicetree/bindings/soc/aspeed/xdma.txt        |   45 +
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/aspeed-g6.dtsi                   |    3 +-
 drivers/soc/aspeed/Kconfig                         |    8 +
 drivers/soc/aspeed/Makefile                        |    1 +
 drivers/soc/aspeed/aspeed-xdma.c                   | 1099 ++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h                   |   42 +
 7 files changed, 1205 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

