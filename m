Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0ABC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC0206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgGLNql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:46:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:8461 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbgGLNql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:46:41 -0400
IronPort-SDR: mwCGpF3H87/MdUJrNkIzvWdXlGFaaomvqW8JkwzbiV4rqEcdyog22JOKPmCTlHErdAjiAmjYK5
 r9V9ACey7k+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540888"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540888"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:41 -0700
IronPort-SDR: JQVxbhj6If0mkuy3BQvbSfUv0FMAr0fZg9FrjZsYdlcX03IIDdKHLWYRjUBqjd1Kllh4H/MEjd
 IzUSFWFDB8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148585"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:40 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 00/20] dlb2: introduce DLB 2.0 device driver
Date:   Sun, 12 Jul 2020 08:43:11 -0500
Message-Id: <20200712134331.8169-1-gage.eads@intel.com>
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

The dlb driver is partially dual-licensed (GPLv2 and BSD 3 clause). The
dual-licensed files implement a "hardware access library" that is largely
Linux independent (except, for example, kmalloc() and kfree() calls), so
that they can be ported to other environments (e.g. DPDK).

[1] https://builders.intel.com/docs/networkbuilders/SKU-343247-001US-queue-management-and-load-balancing-on-intel-architecture.pdf
[2] https://doc.dpdk.org/guides/prog_guide/eventdev.html

Note: This patchset underwent multiple internal reviews and revisions, and
those changes include:
- Many style corrections (multi-line comments, header order, etc.)
- Add device and software documentation (dlb2.rst)
- Use dyndbg for debug messages
- Refactor mmap and device file architecture
- Use ida library for ID management
- Fill data structure holes
- Add missing static keyword for various functions
- Various bug fixes

Gage Eads (20):
  dlb2: add skeleton for DLB 2.0 driver
  dlb2: initialize PF device
  dlb2: add resource and device initialization
  dlb2: add device ioctl layer and first 4 ioctls
  dlb2: add sched domain config and reset support
  dlb2: add ioctl to get sched domain fd
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

 Documentation/ABI/testing/sysfs-driver-dlb2 |  202 +
 Documentation/misc-devices/dlb2.rst         |  313 ++
 Documentation/misc-devices/index.rst        |    1 +
 MAINTAINERS                                 |    7 +
 drivers/misc/Kconfig                        |    1 +
 drivers/misc/Makefile                       |    1 +
 drivers/misc/dlb2/Kconfig                   |   11 +
 drivers/misc/dlb2/Makefile                  |   13 +
 drivers/misc/dlb2/dlb2_bitmap.h             |  286 ++
 drivers/misc/dlb2/dlb2_file.c               |  133 +
 drivers/misc/dlb2/dlb2_file.h               |   19 +
 drivers/misc/dlb2/dlb2_hw_types.h           |  357 ++
 drivers/misc/dlb2/dlb2_intr.c               |  140 +
 drivers/misc/dlb2/dlb2_intr.h               |   30 +
 drivers/misc/dlb2/dlb2_ioctl.c              | 1319 +++++
 drivers/misc/dlb2/dlb2_ioctl.h              |   19 +
 drivers/misc/dlb2/dlb2_main.c               | 1181 +++++
 drivers/misc/dlb2/dlb2_main.h               |  285 ++
 drivers/misc/dlb2/dlb2_pf_ops.c             | 1313 +++++
 drivers/misc/dlb2/dlb2_regs.h               | 3702 ++++++++++++++
 drivers/misc/dlb2/dlb2_resource.c           | 7119 +++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h           |  924 ++++
 include/linux/pci_ids.h                     |    2 +
 include/uapi/linux/dlb2_user.h              | 1158 +++++
 24 files changed, 18536 insertions(+)
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


base-commit: 2d41d2ab85d414f6ea9eac2f853b1aa31ba0820f
-- 
2.13.6

