Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258F8C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB94222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgBUD32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:29:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54260 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729612AbgBUD2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:28:21 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3K7oi028508
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:28:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y92xf23he-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:28:20 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 21 Feb 2020 03:28:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 03:28:08 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3S7Xw51314800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 03:28:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BADFCA405C;
        Fri, 21 Feb 2020 03:28:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E1F6A4054;
        Fri, 21 Feb 2020 03:28:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 03:28:07 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 82291A0209;
        Fri, 21 Feb 2020 14:28:02 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
Date:   Fri, 21 Feb 2020 14:26:53 +1100
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022103-0020-0000-0000-000003AC220E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0021-0000-0000-000022042A30
Message-Id: <20200221032720.33893-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=1 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

This series adds support for OpenCAPI Persistent Memory devices, exposing
them as nvdimms so that we can make use of the existing infrastructure.

Alastair D'Silva (27):
  powerpc: Add OPAL calls for LPC memory alloc/release
  mm/memory_hotplug: Allow check_hotplug_memory_addressable to be called
    from drivers
  powerpc: Map & release OpenCAPI LPC memory
  ocxl: Remove unnecessary externs
  ocxl: Address kernel doc errors & warnings
  ocxl: Tally up the LPC memory on a link & allow it to be mapped
  ocxl: Add functions to map/unmap LPC memory
  ocxl: Emit a log message showing how much LPC memory was detected
  ocxl: Save the device serial number in ocxl_fn
  powerpc: Add driver for OpenCAPI Persistent Memory
  powerpc: Enable the OpenCAPI Persistent Memory driver for
    powernv_defconfig
  powerpc/powernv/pmem: Add register addresses & status values to the
    header
  powerpc/powernv/pmem: Read the capability registers & wait for device
    ready
  powerpc/powernv/pmem: Add support for Admin commands
  powerpc/powernv/pmem: Add support for near storage commands
  powerpc/powernv/pmem: Register a character device for userspace to
    interact with
  powerpc/powernv/pmem: Implement the Read Error Log command
  powerpc/powernv/pmem: Add controller dump IOCTLs
  powerpc/powernv/pmem: Add an IOCTL to report controller statistics
  powerpc/powernv/pmem: Forward events to userspace
  powerpc/powernv/pmem: Add an IOCTL to request controller health & perf
    data
  powerpc/powernv/pmem: Implement the heartbeat command
  powerpc/powernv/pmem: Add debug IOCTLs
  powerpc/powernv/pmem: Expose SMART data via ndctl
  powerpc/powernv/pmem: Expose the serial number in sysfs
  powerpc/powernv/pmem: Expose the firmware version in sysfs
  MAINTAINERS: Add myself & nvdimm/ocxl to ocxl

 MAINTAINERS                                   |    3 +
 arch/powerpc/configs/powernv_defconfig        |    5 +
 arch/powerpc/include/asm/opal-api.h           |    2 +
 arch/powerpc/include/asm/opal.h               |    3 +
 arch/powerpc/include/asm/pnv-ocxl.h           |   40 +-
 arch/powerpc/platforms/powernv/Kconfig        |    3 +
 arch/powerpc/platforms/powernv/Makefile       |    1 +
 arch/powerpc/platforms/powernv/ocxl.c         |   43 +
 arch/powerpc/platforms/powernv/opal-call.c    |    2 +
 arch/powerpc/platforms/powernv/pmem/Kconfig   |   21 +
 arch/powerpc/platforms/powernv/pmem/Makefile  |    7 +
 arch/powerpc/platforms/powernv/pmem/ocxl.c    | 1991 +++++++++++++++++
 .../platforms/powernv/pmem/ocxl_internal.c    |  213 ++
 .../platforms/powernv/pmem/ocxl_internal.h    |  254 +++
 .../platforms/powernv/pmem/ocxl_sysfs.c       |   46 +
 drivers/misc/ocxl/config.c                    |   74 +-
 drivers/misc/ocxl/core.c                      |   61 +
 drivers/misc/ocxl/link.c                      |   53 +
 drivers/misc/ocxl/ocxl_internal.h             |   45 +-
 include/linux/memory_hotplug.h                |    5 +
 include/misc/ocxl.h                           |  122 +-
 include/uapi/linux/ndctl.h                    |    1 +
 include/uapi/nvdimm/ocxl-pmem.h               |  127 ++
 mm/memory_hotplug.c                           |    4 +-
 24 files changed, 3029 insertions(+), 97 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/pmem/Kconfig
 create mode 100644 arch/powerpc/platforms/powernv/pmem/Makefile
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl.c
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl_sysfs.c
 create mode 100644 include/uapi/nvdimm/ocxl-pmem.h

-- 
2.24.1

