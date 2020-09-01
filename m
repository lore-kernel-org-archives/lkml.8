Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21956C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9A3207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgIATVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:21:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:26017 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgIATVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:30 -0400
IronPort-SDR: nOl+IGO2njYoRwUM8GbdCUrANX9WPLRCj5GqG3tFyTVvRUgNX6TAW+lZjiB98uFmXyItodO1VZ
 +DeS7NYNd18A==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="144995644"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="144995644"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:27 -0700
IronPort-SDR: TmLv+7KB0lnp0W7NjSjHVhK/0A+xeSod+MSfD30dXaUfQK3LiYzmDbtpYGrFdBYYgigrMc3POh
 0ZZXCR/gA31w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480442"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:27 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
Date:   Tue,  1 Sep 2020 14:15:30 -0500
Message-Id: <20200901191548.31646-2-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This initial commit contains basic driver functionality (load, unload,
probe, and remove callbacks) file_operations stubs, and device
documentation as well.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 Documentation/misc-devices/dlb2.rst  | 310 +++++++++++++++++++++++++++++++++++
 Documentation/misc-devices/index.rst |   1 +
 MAINTAINERS                          |   7 +
 drivers/misc/Kconfig                 |   1 +
 drivers/misc/Makefile                |   1 +
 drivers/misc/dlb2/Kconfig            |  17 ++
 drivers/misc/dlb2/Makefile           |   8 +
 drivers/misc/dlb2/dlb2_hw_types.h    |  29 ++++
 drivers/misc/dlb2/dlb2_main.c        | 208 +++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.h        |  37 +++++
 include/linux/pci_ids.h              |   2 +
 11 files changed, 621 insertions(+)
 create mode 100644 Documentation/misc-devices/dlb2.rst
 create mode 100644 drivers/misc/dlb2/Kconfig
 create mode 100644 drivers/misc/dlb2/Makefile
 create mode 100644 drivers/misc/dlb2/dlb2_hw_types.h
 create mode 100644 drivers/misc/dlb2/dlb2_main.c
 create mode 100644 drivers/misc/dlb2/dlb2_main.h

diff --git a/Documentation/misc-devices/dlb2.rst b/Documentation/misc-devices/dlb2.rst
new file mode 100644
index 000000000000..a278662c66e0
--- /dev/null
+++ b/Documentation/misc-devices/dlb2.rst
@@ -0,0 +1,310 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+===========================================
+Intel(R) Dynamic Load Balancer 2.0 Overview
+===========================================
+
+:Author: Gage Eads
+
+Contents
+========
+
+- Introduction
+- Scheduling
+- Queue Entry
+- Port
+- Queue
+- Credits
+- Scheduling Domain
+- Interrupts
+- Power Management
+- Virtualization
+- User Interface
+- Reset
+
+Introduction
+============
+
+The Intel(r) Dynamic Load Balancer 2.0 (Intel(r) DLB 2.0) is a PCIe device that
+provides load-balanced, prioritized scheduling of core-to-core communication.
+
+The Intel DLB 2.0 device consists of queues and arbiters that connect producer
+cores and consumer cores. The device implements load-balanced queueing features
+including:
+- Lock-free multi-producer/multi-consumer operation.
+- Multiple priority levels for varying traffic types.
+- 'Direct' traffic (i.e. multi-producer/single-consumer)
+- Simple unordered load-balanced distribution.
+- Atomic lock free load balancing across multiple consumers.
+- Queue element reordering feature allowing ordered load-balanced distribution.
+
+Intel DLB 2.0 can be used in an event-driven programming model, such as DPDK's
+Event Device Library[2]. Such frameworks are commonly used in packet processing
+pipelines that benefit from the framework's multi-core scalability, dynamic
+load-balancing, and variety of packet distribution and synchronization schemes.
+
+Scheduling Types
+================
+
+Intel DLB 2.0 supports four types of scheduling of 'events' (using DPDK
+terminology), where an event can represent any type of data (e.g. a network
+packet). The first, ``directed``, is multi-producer/single-consumer style
+core-to-core communication. The remaining three are
+multi-producer/multi-consumer, and support load-balancing across the consumers.
+
+- ``Unordered``: events are load-balanced across consumers without any ordering
+                 guarantees.
+
+- ``Ordered``: events are load-balanced across consumers, and when the consumer
+               re-injects each event into the device it is re-ordered into the
+               original order. This scheduling type allows software to
+               parallelize ordered event processing without the synchronization
+               cost of re-ordering packets.
+
+- ``Atomic``: events are load-balanced across consumers, with the guarantee that
+              events from a particular 'flow' are only scheduled to a single
+              consumer at a time (but can migrate over time). This allows, for
+              example, packet processing applications to parallelize while
+              avoiding locks on per-flow data and maintaining ordering within a
+              flow.
+
+Intel DLB 2.0 provides hierarchical priority scheduling, with eight priority
+levels within each. Each consumer selects up to eight queues to receive events
+from, and assigns a priority to each of these 'connected' queues. To schedule
+an event to a consumer, the device selects the highest priority non-empty queue
+of the (up to) eight connected queues. Within that queue, the device selects
+the highest priority event available (selecting a lower priority event for
+starvation avoidance 1% of the time, by default).
+
+The device also supports four load-balanced scheduler classes of service. Each
+class of service receives a (user-configurable) guaranteed percentage of the
+scheduler bandwidth, and any unreserved bandwidth is divided evenly among the
+four classes.
+
+Queue Entry
+===========
+
+Each event is contained in a queue entry (QE), the fundamental unit of
+communication through the device, which consists of 8B of data and 8B of
+metadata, as depicted below.
+
+QE structure format
+::
+    data     :64
+    opaque   :16
+    qid      :8
+    sched    :2
+    priority :3
+    msg_type :3
+    lock_id  :16
+    rsvd     :8
+    cmd      :8
+
+The ``data`` field can be any type that fits within 8B (pointer, integer,
+etc.); DLB 2.0 merely copies this field from producer to consumer. The
+``opaque`` and ``msg_type`` fields behave the same way.
+
+``qid`` is set by the producer to specify to which DLB 2.0 queue it wishes to
+enqueue this QE. The ID spaces for load-balanced and directed queues are both
+zero-based; the ``sched`` field is used to distinguish whether the queue is
+load-balanced or directed.
+
+``sched`` controls the scheduling type: atomic, unordered, ordered, or
+directed. The first three scheduling types are only valid for load-balanced
+queues, and the directed scheduling type is only valid for directed queues.
+
+``priority`` is the priority with which this QE should be scheduled.
+
+``lock_id``, used only by atomic scheduling, identifies the atomic flow to
+which the QE belongs. When sending a directed event, ``lock_id`` is simply
+copied like the ``data``, ``opaque``, and ``msg_type`` fields.
+
+``cmd`` specifies the operation, such as:
+- Enqueue a new QE
+- Forward a QE that was dequeued
+- Complete/terminate a QE that was dequeued
+- Return one or more consumer queue tokens.
+- Arm the port's consumer queue interrupt.
+
+Port
+====
+
+A core's interface to the DLB 2.0 is called a "port," and consists of an MMIO
+region through which the core enqueues a queue entry, and an in-memory queue
+(the "consumer queue") to which the device schedules QEs. A core enqueues a QE
+to a device queue, then the device schedules the event to a port. Software
+specifies the connection of queues and ports; i.e. for each queue, to which
+ports the device is allowed to schedule its events. The device uses a credit
+scheme to prevent overflow of the on-device queue storage.
+
+Applications interface directly with the device by mapping the port's memory
+and MMIO regions into the application's address space for enqueue and dequeue
+operations, but call into the kernel driver for configuration operations. An
+application can also be polling- or interrupt-driven; DLB 2.0 supports both
+modes of operation.
+
+Queue
+=====
+
+The device contains 32 load-balanced (i.e. capable of atomic, ordered, and
+unordered scheduling) queues and 64 directed queues. Each queue comprises 8
+internal queues, one per priority level. The internal queue that an event is
+enqueued to is selected by the event's priority field.
+
+A load-balanced queue is capable of scheduling its events to any combination of
+load-balanced ports, whereas each directed queue has one-to-one mapping with a
+directed port. There is no restriction on port or queue types when a port
+enqueues an event to a queue; that is, a load-balanced port can enqueue to a
+directed queue and vice versa.
+
+Credits
+=======
+
+The Intel DLB 2.0 uses a credit scheme to prevent overflow of the on-device
+queue storage, with separate credits for load-balanced and directed queues. A
+port spends one credit when it enqueues a QE, and one credit is replenished
+when a QE is scheduled to a consumer queue. Each scheduling domain has one pool
+of load-balanced credits and one pool of directed credits; software is
+responsible for managing the allocation and replenishment of these credits among
+the scheduling domain's ports.
+
+Scheduling Domain
+=================
+
+Device resources -- including ports, queues, and credits -- are contained
+within a scheduling domain. Scheduling domains are isolated from one another; a
+port can only enqueue to and dequeue from queues within its scheduling domain.
+
+The scheduling domain creation ioctl returns a domain file descriptor, through
+which the domain's resources are configured. For a multi-process scenario, the
+owner of this descriptor must share it with the other processes (e.g. inherited
+through fork() or shared over a unix domain socket).
+
+Consumer Queue Interrupts
+=========================
+
+Each port has its own interrupt which fires, if armed, when the consumer queue
+depth becomes non-zero. Software arms an interrupt by enqueueing a special
+'interrupt arm' command to the device through the port's MMIO window.
+
+Power Management
+================
+
+The kernel driver keeps the device in D3Hot when not in use. The driver
+transitions the device to D0 when the first device file is opened or a virtual
+function is created, and keeps it there until there are no open device files,
+memory mappings, or virtual functions.
+
+Virtualization
+==============
+
+The DLB 2.0 supports both SR-IOV and Scalable IOV, and can flexibly divide its
+resources among the physical function (PF) and its virtual devices. Virtual
+devices do not configure the device directly; they use a hardware mailbox to
+proxy configuration requests to the PF driver. Mailbox communication is
+initiated by the virtual device with a registration message that establishes
+the mailbox interface version.
+
+SR-IOV
+------
+
+Each SR-IOV virtual function (VF) has 32 interrupts, 1 for PF->VF mailbox
+messages and the remainder for CQ interrupts. If a VF user (e.g. a guest OS)
+needs more CQ interrupts, they have to use more than one VF.
+
+To support this case, the driver introduces the notion of primary and auxiliary
+VFs. A VF is either considered primary or auxiliary:
+- Primary: the VF is used as a regular DLB 2.0 device. The primary VF has 0+
+           auxiliary VFs supporting it.
+- Auxiliary: the VF doesn't have any resources of its own, and serves only to
+             provide the primary VF with MSI vectors for its CQ interrupts.
+
+Each VF has an aux_vf_ids file in its sysfs directory, which is a R/W file that
+controls the primary VF’s auxiliaries. When a VF is made auxiliary to another,
+its resources are relinquished to the PF device.
+
+When the VF driver registers its device with the PF driver, the PF driver tells
+the VF driver whether its device is auxiliary or primary, and if so then the ID
+of its primary VF. If it is auxiliary, the VF device will “claim” up to 31 of
+the primary VF’s CQs, such that they use the auxiliary VF’s MSI vectors.
+
+When a primary VF has one or more auxiliary VFs, the entire VF group must be
+assigned to the same virtual machine. The PF driver will not allow the primary
+VF to configure its resources until all its auxiliary VFs have been registered
+by the guest OS’s driver.
+
+Scalable IOV
+------------
+
+Scalable IOV is a virtualization solution that, compared to SR-IOV, enables
+highly-scalable, high-performance, and fine-grained sharing of I/O devices
+across isolated domains.
+
+In Scalable IOV, the smallest granularity of sharing a device is the Assignable Device
+Interface (ADI). Similar to SR-IOV’s Virtual Function, Scalable IOV defines the
+Virtual Device (VDEV) as the abstraction at which a Scalable IOV device is exposed to
+guest software, and a VDEV contains one or more ADIs.
+
+Kernel software is responsible for composing and managing VDEV instances in
+Scalable IOV. The device-specific software components are the Host (PF) Driver,
+the Guest (VDEV) Driver, and the Virtual Device Composition Module (VDCM). The
+VDCM is responsible for managing the software-based virtualization of (slow)
+control path operations, like the mailbox between Host and Guest drivers.
+
+For DLB 2.0, the ADI is the scheduling domain, which consists of load-balanced
+and directed queues, ports, and other resources. Each port, whether
+load-balanced or directed, consists of:
+- A producer port: a 4-KB separated MMIO window
+- A consumer queue: a memory-based ring to which the device writes queue entries
+- One CQ interrupt message
+
+DLB 2.0 supports up to 16 VDEVs per PF.
+
+For Scalable IOV guest-host communication, DLB 2.0 uses a software-based
+mailbox. This mailbox interface matches the SR-IOV hardware mailbox (i.e. PF2VF
+and VF2PF MMIO regions) except that it is backed by shared memory (allocated
+and managed by the VDCM). Similarly, the VF2PF interrupt trigger register
+instead causes a VM exit into the VDCM driver, and the PF2VF interrupt is
+replaced by a virtual interrupt injected into the guest through the VDCM.
+
+User Interface
+==============
+
+The dlb2 driver uses ioctls as its primary interface. It provides two types of
+files: the dlb2 device file and the scheduling domain file.
+
+The two types support different ioctl interfaces; the dlb2 device file is used
+for device-wide operations (including scheduling domain creation), and the
+scheduling domain device file supports operations on the scheduling domain's
+resources such as port and queue configuration.
+
+The driver also exports an mmap interface through port files, which are
+acquired through scheduling domain ioctls. This mmap interface is used to map
+a port's memory and MMIO window into the process's address space.
+
+Reset
+=====
+
+The dlb2 driver supports reset at two levels: scheduling domain and device-wide
+(i.e. FLR).
+
+Scheduling domain reset occurs when an application stops using its domain.
+Specifically, when no more file references or memory mappings exist. At this
+time, the driver resets all the domain's resources (flushes its queues and
+ports) and puts them in their respective available-resource lists for later
+use.
+
+An FLR can occur while the device is in use by user-space software, so the
+driver uses its reset_prepare callback to ensure that no applications continue
+to use the device while the FLR executes. First, the driver blocks user-space
+from executing ioctls or opening a device file, and evicts any threads blocked
+on a CQ interrupt. The driver then notifies applications and virtual functions
+that an FLR is pending, and waits for them to clean up with a timeout (default
+of 5 seconds). If the timeout expires and the device is still in use by an
+application, the driver zaps its MMIO mappings. Virtual functions, whether in
+use or not, are reset as part of a PF FLR.
+
+While PF FLR is a hardware procedure, VF FLR is a software procedure. When a
+VF FLR is triggered, this causes an interrupt to be delivered to the PF driver,
+which performs the actual reset. This consists of performing the scheduling
+domain reset operation for each of the VF's scheduling domains.
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 46072ce3d7ef..653bd32316b8 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -17,6 +17,7 @@ fit into other categories.
    ad525x_dpot
    apds990x
    bh1770glc
+   dlb2
    eeprom
    c2port
    ibmvmc
diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c84c987..8c479e675a12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8716,6 +8716,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	arch/x86/include/asm/intel-family.h
 
+INTEL DYNAMIC LOAD BALANCER 2.0 DRIVER
+M:	Gage Eads <gage.eads@intel.com>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-dlb2
+F:	drivers/misc/dlb*
+F:	include/uapi/linux/dlb2_user.h
+
 INTEL DRM DRIVERS (excluding Poulsbo, Moorestown and derivative chipsets)
 M:	Jani Nikula <jani.nikula@linux.intel.com>
 M:	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ce136d685d14..efe070f63f60 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -472,4 +472,5 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/dlb2/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..b6afc8edea2b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_INTEL_DLB2)	+= dlb2/
diff --git a/drivers/misc/dlb2/Kconfig b/drivers/misc/dlb2/Kconfig
new file mode 100644
index 000000000000..677114247f7e
--- /dev/null
+++ b/drivers/misc/dlb2/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config INTEL_DLB2
+	tristate "Intel Dynamic Load Balancer 2.0 Driver"
+	depends on 64BIT && PCI && X86
+	help
+	  This driver supports the Intel Dynamic Load Balancer 2.0 (DLB 2.0), a
+	  PCIe device (PCI ID 8086:2710) that provides load-balanced,
+	  prioritized scheduling of core-to-core communication.
+
+	  The user-space interface is described in
+	  include/uapi/linux/dlb2_user.h
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called dlb2.
+
+	  If unsure, select N.
diff --git a/drivers/misc/dlb2/Makefile b/drivers/misc/dlb2/Makefile
new file mode 100644
index 000000000000..90ae953d2a8f
--- /dev/null
+++ b/drivers/misc/dlb2/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the Intel(R) Dynamic Load Balancer 2.0 (dlb2.ko) driver
+#
+
+obj-$(CONFIG_INTEL_DLB2) := dlb2.o
+
+dlb2-objs :=  \
+  dlb2_main.o \
diff --git a/drivers/misc/dlb2/dlb2_hw_types.h b/drivers/misc/dlb2/dlb2_hw_types.h
new file mode 100644
index 000000000000..a0f908c603eb
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_hw_types.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2016-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_HW_TYPES_H
+#define __DLB2_HW_TYPES_H
+
+#define DLB2_MAX_NUM_VDEVS			16
+#define DLB2_MAX_NUM_DOMAINS			32
+#define DLB2_MAX_NUM_LDB_QUEUES			32 /* LDB == load-balanced */
+#define DLB2_MAX_NUM_DIR_QUEUES			64 /* DIR == directed */
+#define DLB2_MAX_NUM_LDB_PORTS			64
+#define DLB2_MAX_NUM_DIR_PORTS			DLB2_MAX_NUM_DIR_QUEUES
+#define DLB2_MAX_NUM_LDB_CREDITS		8192
+#define DLB2_MAX_NUM_DIR_CREDITS		2048
+#define DLB2_MAX_NUM_HIST_LIST_ENTRIES		2048
+#define DLB2_MAX_NUM_AQED_ENTRIES		2048
+#define DLB2_MAX_NUM_QIDS_PER_LDB_CQ		8
+#define DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS	2
+#define DLB2_MAX_NUM_SEQUENCE_NUMBER_MODES	5
+#define DLB2_QID_PRIORITIES			8
+#define DLB2_NUM_ARB_WEIGHTS			8
+#define DLB2_MAX_WEIGHT				255
+#define DLB2_NUM_COS_DOMAINS			4
+#define DLB2_MAX_CQ_COMP_CHECK_LOOPS		409600
+#define DLB2_MAX_QID_EMPTY_CHECK_LOOPS		(32 * 64 * 1024 * (800 / 30))
+#define DLB2_HZ					800000000
+
+#endif /* __DLB2_HW_TYPES_H */
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
new file mode 100644
index 000000000000..ffd6df788e2e
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2018-2020 Intel Corporation */
+
+#include <linux/aer.h>
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/uaccess.h>
+
+#include "dlb2_main.h"
+
+static const char
+dlb2_driver_copyright[] = "Copyright(c) 2018-2020 Intel Corporation";
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
+MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer 2.0 Driver");
+
+/* The driver lock protects data structures that used by multiple devices. */
+static DEFINE_MUTEX(dlb2_driver_lock);
+static struct list_head dlb2_dev_list = LIST_HEAD_INIT(dlb2_dev_list);
+
+static struct class *dlb2_class;
+static dev_t dlb2_dev_number_base;
+
+/*****************************/
+/****** Devfs callbacks ******/
+/*****************************/
+
+static int dlb2_open(struct inode *i, struct file *f)
+{
+	return 0;
+}
+
+static int dlb2_close(struct inode *i, struct file *f)
+{
+	return 0;
+}
+
+static const struct file_operations dlb2_fops = {
+	.owner   = THIS_MODULE,
+	.open    = dlb2_open,
+	.release = dlb2_close,
+};
+
+/**********************************/
+/****** PCI driver callbacks ******/
+/**********************************/
+
+static DEFINE_IDA(dlb2_ids);
+
+static int dlb2_alloc_id(void)
+{
+	return ida_alloc_max(&dlb2_ids, DLB2_MAX_NUM_DEVICES - 1, GFP_KERNEL);
+}
+
+static void dlb2_free_id(int id)
+{
+	ida_free(&dlb2_ids, id);
+}
+
+static int dlb2_probe(struct pci_dev *pdev,
+		      const struct pci_device_id *pdev_id)
+{
+	struct dlb2_dev *dlb2_dev;
+	int ret;
+
+	dlb2_dev = devm_kzalloc(&pdev->dev, sizeof(*dlb2_dev), GFP_KERNEL);
+	if (!dlb2_dev)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, dlb2_dev);
+
+	dlb2_dev->pdev = pdev;
+
+	dlb2_dev->id = dlb2_alloc_id();
+	if (dlb2_dev->id < 0) {
+		dev_err(&pdev->dev, "probe: device ID allocation failed\n");
+
+		ret = dlb2_dev->id;
+		goto alloc_id_fail;
+	}
+
+	ret = pci_enable_device(pdev);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "pci_enable_device() returned %d\n", ret);
+
+		goto pci_enable_device_fail;
+	}
+
+	ret = pci_request_regions(pdev, dlb2_driver_name);
+	if (ret != 0) {
+		dev_err(&pdev->dev,
+			"pci_request_regions(): returned %d\n", ret);
+
+		goto pci_request_regions_fail;
+	}
+
+	pci_set_master(pdev);
+
+	if (pci_enable_pcie_error_reporting(pdev))
+		dev_info(&pdev->dev, "[%s()] Failed to enable AER\n", __func__);
+
+	mutex_lock(&dlb2_driver_lock);
+	list_add(&dlb2_dev->list, &dlb2_dev_list);
+	mutex_unlock(&dlb2_driver_lock);
+
+	return 0;
+
+pci_request_regions_fail:
+	pci_disable_device(pdev);
+pci_enable_device_fail:
+	dlb2_free_id(dlb2_dev->id);
+alloc_id_fail:
+	devm_kfree(&pdev->dev, dlb2_dev);
+	return ret;
+}
+
+static void dlb2_remove(struct pci_dev *pdev)
+{
+	struct dlb2_dev *dlb2_dev;
+
+	/* Undo all the dlb2_probe() operations */
+	dlb2_dev = pci_get_drvdata(pdev);
+
+	mutex_lock(&dlb2_driver_lock);
+	list_del(&dlb2_dev->list);
+	mutex_unlock(&dlb2_driver_lock);
+
+	pci_disable_pcie_error_reporting(pdev);
+
+	pci_release_regions(pdev);
+
+	pci_disable_device(pdev);
+
+	dlb2_free_id(dlb2_dev->id);
+
+	devm_kfree(&pdev->dev, dlb2_dev);
+}
+
+static struct pci_device_id dlb2_id_table[] = {
+	{ PCI_DEVICE_DATA(INTEL, DLB2_PF, NULL) },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, dlb2_id_table);
+
+static struct pci_driver dlb2_pci_driver = {
+	.name		 = (char *)dlb2_driver_name,
+	.id_table	 = dlb2_id_table,
+	.probe		 = dlb2_probe,
+	.remove		 = dlb2_remove,
+};
+
+static int __init dlb2_init_module(void)
+{
+	int err;
+
+	dlb2_class = class_create(THIS_MODULE, dlb2_driver_name);
+
+	if (IS_ERR(dlb2_class)) {
+		pr_err("%s: class_create() returned %ld\n",
+		       dlb2_driver_name, PTR_ERR(dlb2_class));
+
+		return PTR_ERR(dlb2_class);
+	}
+
+	/* Allocate one minor number per domain */
+	err = alloc_chrdev_region(&dlb2_dev_number_base,
+				  0,
+				  DLB2_MAX_NUM_DEVICES,
+				  dlb2_driver_name);
+
+	if (err < 0) {
+		pr_err("%s: alloc_chrdev_region() returned %d\n",
+		       dlb2_driver_name, err);
+
+		return err;
+	}
+
+	err = pci_register_driver(&dlb2_pci_driver);
+	if (err < 0) {
+		pr_err("%s: pci_register_driver() returned %d\n",
+		       dlb2_driver_name, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit dlb2_exit_module(void)
+{
+	pci_unregister_driver(&dlb2_pci_driver);
+
+	unregister_chrdev_region(dlb2_dev_number_base,
+				 DLB2_MAX_NUM_DEVICES);
+
+	if (dlb2_class) {
+		class_destroy(dlb2_class);
+		dlb2_class = NULL;
+	}
+}
+
+module_init(dlb2_init_module);
+module_exit(dlb2_exit_module);
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
new file mode 100644
index 000000000000..cc05546fba13
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2017-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_MAIN_H
+#define __DLB2_MAIN_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "dlb2_hw_types.h"
+
+static const char dlb2_driver_name[] = KBUILD_MODNAME;
+
+/*
+ * The dlb2 driver uses a different minor number for each device file, of which
+ * there are:
+ * - 33 per device (PF or VF/VDEV): 1 for the device, 32 for scheduling domains
+ * - Up to 17 devices per PF: 1 PF and up to 16 VFs/VDEVs
+ * - Up to 16 PFs per system
+ */
+#define DLB2_MAX_NUM_PFS	  16
+#define DLB2_NUM_FUNCS_PER_DEVICE (1 + DLB2_MAX_NUM_VDEVS)
+#define DLB2_MAX_NUM_DEVICES	  (DLB2_MAX_NUM_PFS * DLB2_NUM_FUNCS_PER_DEVICE)
+
+struct dlb2_dev {
+	struct pci_dev *pdev;
+	struct list_head list;
+	int id;
+};
+
+#endif /* __DLB2_MAIN_H */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1ab1e24bcbce..fbb2223e617b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2813,6 +2813,8 @@
 #define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
 #define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
 #define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
+#define PCI_DEVICE_ID_INTEL_DLB2_PF	0x2710
+#define PCI_DEVICE_ID_INTEL_DLB2_VF	0x2711
 #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
 #define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
-- 
2.13.6

