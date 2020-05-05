Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECDC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A04D2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgEEQ6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:58:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729949AbgEEQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:58:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045GYAxg103744;
        Tue, 5 May 2020 12:58:28 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4r4a1w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 12:58:28 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045GZXNT014501;
        Tue, 5 May 2020 16:58:27 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 30s0g6tadv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 16:58:27 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 045GwReA26149314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 May 2020 16:58:27 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00D2D78063;
        Tue,  5 May 2020 16:58:27 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62BA97805F;
        Tue,  5 May 2020 16:58:26 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.211.137.116])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  5 May 2020 16:58:26 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Subject: [PATCH v11 0/8] soc: aspeed: Add XDMA engine driver
Date:   Tue,  5 May 2020 11:58:17 -0500
Message-Id: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_09:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=805 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=3 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a driver to control the Aspeed XDMA engine embedded in the
AST2500 and AST2600. The XDMA engine performs automatic DMA operations
over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.

Changes since v10:
 - Fix devicetree binding documentation
 - Add patches to enable the device on witherspoon and tacoma systems
 - Fix the driver to actually use the updated bindings
 - Remove the device managed memory in favor of manually allocating and freeing
   This adds considerable complexity to the probe function and requires the
   use of a kobject and associated release method, but it fixes the problem of
   the device context being deleted during an operation or with memory still
   mapped if the device is unbound from the driver
 - Remove the client kref system
 - Reset the device when a user closes a file handle with an on-going operation

Changes since v9:
 - Remove the kernel command queue
 - Use memcpy_toio instead to copy commands to the buffer
 - Free the client's genalloc'd memory in the release method
 - Switch the bindings documentation to yaml
 - Add patches to fix SCU interrupt controller include

Changes since v8:
 - Use DMA API to allocate memory from reserved region.
 - Fix the driver for the AST2500 by keeping the command queue in kernel
   memory and copying the whole buffer to the reserved memory area before
   starting the operation.
 - Add krefs to the client structure to prevent use-after-free.
 - Switch reset-names binding to "device", "root-complex"

Eddie James (8):
  dt-bindings: soc: Add Aspeed XDMA Engine
  soc: aspeed: Add XDMA Engine Driver
  soc: aspeed: xdma: Add user interface
  soc: aspeed: xdma: Add reset ioctl
  ARM: dts: Aspeed: AST2600: Update XDMA engine node
  ARM: dts: Aspeed: AST2500: Update XDMA engine node
  ARM: dts: Aspeed: Witherspoon: Enable XDMA engine
  ARM: dts: Aspeed: Tacoma: Enable XDMA engine

 .../devicetree/bindings/soc/aspeed/xdma.yaml       |  103 ++
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |   11 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |   11 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    5 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |    8 +-
 drivers/soc/aspeed/Kconfig                         |    8 +
 drivers/soc/aspeed/Makefile                        |    1 +
 drivers/soc/aspeed/aspeed-xdma.c                   | 1205 ++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h                   |   42 +
 10 files changed, 1397 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

