Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06D1C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D8820782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDTU00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:26:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:26:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KK4Cc2022033;
        Mon, 20 Apr 2020 16:26:15 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ggr1r1dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 16:26:15 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03KKQ3Cj010970;
        Mon, 20 Apr 2020 20:26:14 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 30fs66gj4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 20:26:14 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03KKQDjV46203294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 20:26:13 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F102AE05F;
        Mon, 20 Apr 2020 20:26:13 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F943AE066;
        Mon, 20 Apr 2020 20:26:12 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.56.120])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 20:26:12 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Subject: [PATCH v10 0/7] soc: aspeed: Add XDMA engine driver
Date:   Mon, 20 Apr 2020 15:26:04 -0500
Message-Id: <20200420202611.17776-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_07:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=755
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=3 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a driver to control the Aspeed XDMA engine embedded in the
AST2500 and AST2600. The XDMA engine performs automatic DMA operations
over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.

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

Eddie James (7):
  dt-bindings: soc: Add Aspeed XDMA Engine
  soc: aspeed: Add XDMA Engine Driver
  soc: aspeed: xdma: Add user interface
  soc: aspeed: xdma: Add reset ioctl
  ARM: dts: Aspeed: AST2600: Add XDMA PCI-E root control reset
  ARM: dts: Aspeed: AST2500: Add missing SCU interrupt controller
    include
  ARM: dts: Aspeed: AST2600: Add missing SCU interrupt controller
    include

 .../devicetree/bindings/soc/aspeed/xdma.yaml  |  108 ++
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |    1 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |    4 +-
 drivers/soc/aspeed/Kconfig                    |    8 +
 drivers/soc/aspeed/Makefile                   |    1 +
 drivers/soc/aspeed/aspeed-xdma.c              | 1106 +++++++++++++++++
 include/uapi/linux/aspeed-xdma.h              |   42 +
 8 files changed, 1277 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
2.24.0

