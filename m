Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80228C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6413B20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgIATVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:21:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:26016 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgIATVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:30 -0400
IronPort-SDR: agylgvqYIDbDc6q8i1QOtzPlbHRJ0e4VdVKJSUYDLkhrTGXdpIgr8X2hADA2PaakC/QjS8MNk/
 0oqhxTOHtbYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="144995640"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="144995640"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:27 -0700
IronPort-SDR: hUKmR4Uqlhq8Ls0cbTgJzertPv0sajciW9dkILJZ+F+J7ijW3GVf/khygE7eiioxth47xa9ulm
 D2Dr/HXYZs1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480437"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:26 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 00/19] dlb2: introduce DLB 2.0 device driver
Date:   Tue,  1 Sep 2020 14:15:29 -0500
Message-Id: <20200901191548.31646-1-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a new misc device driver for the Intel(r) Dynamic
Load Balancer 2.0 (Intel(r) DLB 2.0). The Intel DLB 2.0 is a PCIe device that
provides load-balanced, prioritized scheduling of core-to-core communication.

The Intel DLB 2.0 consists of queues and arbiters that connect producer cores
and consumer cores. The device implements load-balanced queueing features
including:
- Lock-free multi-producer/multi-consumer operation.
- Multiple priority levels for varying traffic types.
- 'Direct' traffic (i.e. multi-producer/single-consumer)
- Simple unordered load-balanced distribution.
- Atomic lock free load balancing across multiple consumers.
- Queue element reordering feature allowing ordered load-balanced
  distribution.

Intel DLB 2.0 can be used in an event-driven programming model, such as DPDK's
Event Device Library[2]. Such frameworks are commonly used in packet processing
pipelines that benefit from the framework's multi-core scalability, dynamic
load-balancing, and variety of packet distribution and synchronization schemes.

These distribution schemes include "parallel" (packets are load-balanced
across multiple cores and processed in parallel), "ordered" (similar to
"parallel" but packets are reordered into ingress order by the device), and
"atomic" (packet flows are scheduled to a single core at a time such that
locks are not required to access per-flow data, and dynamically migrated to
ensure load-balance).

The fundamental unit of communication through the device is a queue entry
(QE), which consists of 8B of data and 8B of metadata (destination queue,
priority, etc.). The data field can be any type that fits within 8B.

A core's interface to the device, a "port," consists of a memory-mappable
region through which the core enqueues a queue entry, and an in-memory
queue (the "consumer queue") to which the device schedules QEs. Each QE
is enqueued to a device-managed queue, and from there scheduled to a port.
Software specifies the "linking" of queues and ports; i.e. which ports the
device is allowed to schedule to for a given queue. The device uses a
credit scheme to prevent overflow of the on-device queue storage.

Applications can interface directly with the device by mapping the port's
memory and MMIO regions into the application's address space for enqueue
and dequeue operations, but call into the kernel driver for configuration
operations. An application can also be polling- or interrupt-driven;
Intel DLB 2.0 supports both modes of operation.

Device resources -- i.e. ports, queues, and credits -- are contained within
a scheduling domain. Scheduling domains are isolated from one another; a
port can only enqueue to and dequeue from queues within its scheduling
domain. A scheduling domain's resources are configured through a scheduling
domain file, which is acquired through an ioctl.

Intel DLB 2.0 supports SR-IOV and Scalable IOV, and allows for a flexible
division of its resources among the PF and its virtual devices. The virtual
devices are incapable of configuring the device directly; they use a hardware
mailbox to proxy configuration requests to the PF driver. This driver supports
both PF and virtual devices, as there is significant code re-use between the
two, with device-specific behavior handled through a callback interface.
Virtualization support will be added in a later patch set.

The dlb driver uses ioctls as its primary interface (it makes use of sysfs
as well, to a lesser extent). The dlb device file supports a different
ioctl interface than the scheduling domain file; the dlb device file
is used for device-wide operations (including scheduling domain creation),
and the scheduling domain file supports operations on the scheduling
domain's resources (primarily resource configuration).

[1] https://builders.intel.com/docs/networkbuilders/SKU-343247-001US-queue-management-and-load-balancing-on-intel-architecture.pdf
[2] https://doc.dpdk.org/guides/prog_guide/eventdev.html

v3:
- Remove DLB2_PCI_REG_READ/WRITE macros

v2:
- Change driver license to GPLv2 only
- Expand Kconfig help text and remove unnecessary (R)s
- Remove unnecessary prints
- Add a new entry in ioctl-number.rst
- Convert the ioctl handler into a switch statement
- Correct some instances of IOWR that should have been IOR
- Align macro blocks
- Don't break ioctl ABI when introducing new commands
- Remove indirect pointers from ioctl data structures
- Remove the get-sched-domain-fd ioctl command

Gage Eads (19):
  dlb2: add skeleton for DLB 2.0 driver
  dlb2: initialize PF device
  dlb2: add resource and device initialization
  dlb2: add device ioctl layer and first three ioctls
  dlb2: add sched domain config and reset support
  dlb2: add runtime power-management support
  dlb2: add queue create and queue-depth-get ioctls
  dlb2: add ioctl to configure ports, query poll mode
  dlb2: add port mmap support
  dlb2: add start domain ioctl
  dlb2: add queue map and unmap ioctls
  dlb2: add port enable/disable ioctls
  dlb2: add CQ interrupt support
  dlb2: add domain alert support
  dlb2: add sequence-number management ioctls
  dlb2: add cos bandwidth get/set ioctls
  dlb2: add device FLR support
  dlb2: add basic PF sysfs interfaces
  dlb2: add ingress error handling

 Documentation/ABI/testing/sysfs-driver-dlb2        |  202 +
 Documentation/misc-devices/dlb2.rst                |  310 +
 Documentation/misc-devices/index.rst               |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 MAINTAINERS                                        |    7 +
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/dlb2/Kconfig                          |   17 +
 drivers/misc/dlb2/Makefile                         |   13 +
 drivers/misc/dlb2/dlb2_bitmap.h                    |  286 +
 drivers/misc/dlb2/dlb2_file.c                      |  133 +
 drivers/misc/dlb2/dlb2_file.h                      |   19 +
 drivers/misc/dlb2/dlb2_hw_types.h                  |  353 +
 drivers/misc/dlb2/dlb2_intr.c                      |  137 +
 drivers/misc/dlb2/dlb2_intr.h                      |   30 +
 drivers/misc/dlb2/dlb2_ioctl.c                     |  892 +++
 drivers/misc/dlb2/dlb2_ioctl.h                     |   14 +
 drivers/misc/dlb2/dlb2_main.c                      | 1091 +++
 drivers/misc/dlb2/dlb2_main.h                      |  285 +
 drivers/misc/dlb2/dlb2_pf_ops.c                    | 1286 ++++
 drivers/misc/dlb2/dlb2_regs.h                      | 3702 ++++++++++
 drivers/misc/dlb2/dlb2_resource.c                  | 7117 ++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h                  |  924 +++
 include/linux/pci_ids.h                            |    2 +
 include/uapi/linux/dlb2_user.h                     | 1045 +++
 25 files changed, 17869 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-dlb2
 create mode 100644 Documentation/misc-devices/dlb2.rst
 create mode 100644 drivers/misc/dlb2/Kconfig
 create mode 100644 drivers/misc/dlb2/Makefile
 create mode 100644 drivers/misc/dlb2/dlb2_bitmap.h
 create mode 100644 drivers/misc/dlb2/dlb2_file.c
 create mode 100644 drivers/misc/dlb2/dlb2_file.h
 create mode 100644 drivers/misc/dlb2/dlb2_hw_types.h
 create mode 100644 drivers/misc/dlb2/dlb2_intr.c
 create mode 100644 drivers/misc/dlb2/dlb2_intr.h
 create mode 100644 drivers/misc/dlb2/dlb2_ioctl.c
 create mode 100644 drivers/misc/dlb2/dlb2_ioctl.h
 create mode 100644 drivers/misc/dlb2/dlb2_main.c
 create mode 100644 drivers/misc/dlb2/dlb2_main.h
 create mode 100644 drivers/misc/dlb2/dlb2_pf_ops.c
 create mode 100644 drivers/misc/dlb2/dlb2_regs.h
 create mode 100644 drivers/misc/dlb2/dlb2_resource.c
 create mode 100644 drivers/misc/dlb2/dlb2_resource.h
 create mode 100644 include/uapi/linux/dlb2_user.h


base-commit: dd5597245d35cfbb0890b8a868028aa1d2018701
-- 
2.13.6

