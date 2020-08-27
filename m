Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004ADC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59632177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgH0PJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:09:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:30276 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgH0PJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:09:08 -0400
IronPort-SDR: S9Bp4f/Rzrn2qPkzgDKcAETXNUw6E+kuitsHHnWnfV+WQ+XH33R5izoPoCLHw7qRrEYHxva+b7
 YjDk/R+/E82Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136563648"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="136563648"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 08:06:59 -0700
IronPort-SDR: Zzs/tIq00IIT6afc/rOMVsxeYVwvPGq5jJFFVXHBk31Odx8dL3OuzQ9pPY32ooHfvNTc/bFfq6
 QxQRX02ck8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="332212852"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2020 08:06:59 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v7 3/9] docs: x86: Add documentation for SVA (Shared Virtual Addressing)
Date:   Thu, 27 Aug 2020 08:06:28 -0700
Message-Id: <1598540794-132666-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
features are a complicated stack with lots of interconnected pieces.
This documentation provides a big picture overview for all of the
features.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v7:
- Change the doc for updating PASID by IPI and context switch (Andy).

v3:
- Replace deprecated intel_svm_bind_mm() by iommu_sva_bind_mm() (Baolu)
- Fix a couple of typos (Baolu)

v2:
- Fix the doc format and add the doc in toctree (Thomas)
- Modify the doc for better description (Thomas, Tony, Dave)

 Documentation/x86/index.rst |   1 +
 Documentation/x86/sva.rst   | 254 ++++++++++++++++++++++++++++++++++++
 2 files changed, 255 insertions(+)
 create mode 100644 Documentation/x86/sva.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 265d9e9a093b..e5d5ff096685 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -30,3 +30,4 @@ x86-specific Documentation
    usb-legacy-support
    i386/index
    x86_64/index
+   sva
diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
new file mode 100644
index 000000000000..6e7ac565e127
--- /dev/null
+++ b/Documentation/x86/sva.rst
@@ -0,0 +1,254 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+Shared Virtual Addressing (SVA) with ENQCMD
+===========================================
+
+Background
+==========
+
+Shared Virtual Addressing (SVA) allows the processor and device to use the
+same virtual addresses avoiding the need for software to translate virtual
+addresses to physical addresses. SVA is what PCIe calls Shared Virtual
+Memory (SVM)
+
+In addition to the convenience of using application virtual addresses
+by the device, it also doesn't require pinning pages for DMA.
+PCIe Address Translation Services (ATS) along with Page Request Interface
+(PRI) allow devices to function much the same way as the CPU handling
+application page-faults. For more information please refer to PCIe
+specification Chapter 10: ATS Specification.
+
+Use of SVA requires IOMMU support in the platform. IOMMU also is required
+to support PCIe features ATS and PRI. ATS allows devices to cache
+translations for the virtual address. IOMMU driver uses the mmu_notifier()
+support to keep the device tlb cache and the CPU cache in sync. PRI allows
+the device to request paging the virtual address before using if they are
+not paged in the CPU page tables.
+
+
+Shared Hardware Workqueues
+==========================
+
+Unlike Single Root I/O Virtualization (SRIOV), Scalable IOV (SIOV) permits
+the use of Shared Work Queues (SWQ) by both applications and Virtual
+Machines (VM's). This allows better hardware utilization vs. hard
+partitioning resources that could result in under utilization. In order to
+allow the hardware to distinguish the context for which work is being
+executed in the hardware by SWQ interface, SIOV uses Process Address Space
+ID (PASID), which is a 20bit number defined by the PCIe SIG.
+
+PASID value is encoded in all transactions from the device. This allows the
+IOMMU to track I/O on a per-PASID granularity in addition to using the PCIe
+Resource Identifier (RID) which is the Bus/Device/Function.
+
+
+ENQCMD
+======
+
+ENQCMD is a new instruction on Intel platforms that atomically submits a
+work descriptor to a device. The descriptor includes the operation to be
+performed, virtual addresses of all parameters, virtual address of a completion
+record, and the PASID (process address space ID) of the current process.
+
+ENQCMD works with non-posted semantics and carries a status back if the
+command was accepted by hardware. This allows the submitter to know if the
+submission needs to be retried or other device specific mechanisms to
+implement fairness or ensure forward progress can be made.
+
+ENQCMD is the glue that ensures applications can directly submit commands
+to the hardware and also permit hardware to be aware of application context
+to perform I/O operations via use of PASID.
+
+Process Address Space Tagging
+=============================
+
+A new thread scoped MSR (IA32_PASID) provides the connection between
+user processes and the rest of the hardware. When an application first
+accesses an SVA capable device this MSR is initialized with a newly
+allocated PASID. The driver for the device calls an IOMMU specific API
+that sets up the routing for DMA and page-requests.
+
+For example, the Intel Data Streaming Accelerator (DSA) uses
+iommu_sva_bind_device(), which will do the following.
+
+- Allocate the PASID, and program the process page-table (cr3) in the PASID
+  context entries.
+- Register for mmu_notifier() to track any page-table invalidations to keep
+  the device tlb in sync. For example, when a page-table entry is invalidated,
+  IOMMU propagates the invalidation to device tlb. This will force any
+  future access by the device to this virtual address to participate in
+  ATS. If the IOMMU responds with proper response that a page is not
+  present, the device would request the page to be paged in via the PCIe PRI
+  protocol before performing I/O.
+
+This MSR is managed with the XSAVE feature set as "supervisor state" to
+ensure the MSR is updated during context switch.
+
+PASID Management
+================
+
+The kernel must allocate a PASID on behalf of each process and program it
+into the new MSR to communicate the process identity to platform hardware.
+ENQCMD uses the PASID stored in this MSR to tag requests from this process.
+When a user submits a work descriptor to a device using the ENQCMD
+instruction, the PASID field in the descriptor is auto-filled with the
+value from MSR_IA32_PASID. Requests for DMA from the device are also tagged
+with the same PASID. The platform IOMMU uses the PASID in the transaction to
+perform address translation. The IOMMU APIs setup the corresponding PASID
+entry in IOMMU with the process address used by the CPU (for e.g cr3 in x86).
+
+The MSR must be configured on each logical CPU before any application
+thread can interact with a device. Threads that belong to the same
+process share the same page tables, thus the same MSR value.
+
+PASID is cleared when a process is created. The PASID allocation and MSR
+programming may occur long after a process and its threads have been created.
+One thread must call iommu_sva_bind_device() to allocate the PASID for the
+process. If a thread uses ENQCMD without the MSR first being populated, it
+will cause #GP. The kernel will update the PASID MSR with the PASID for all
+threads in the process. A single process PASID can be used simultaneously
+with multiple devices since they all share the same address space.
+
+One thread can call iommu_sva_unbind_device() to free the allocated PASID.
+The kernel will clear the PASID MSR for all threads in the process.
+
+New threads inherit the MSR value from the parent.
+
+Relationships
+=============
+
+ * Each process has many threads, but only one PASID
+ * Devices have a limited number (~10's to 1000's) of hardware
+   workqueues and each portal maps down to a single workqueue.
+   The device driver manages allocating hardware workqueues.
+ * A single mmap() maps a single hardware workqueue as a "portal"
+ * For each device with which a process interacts, there must be
+   one or more mmap()'d portals.
+ * Many threads within a process can share a single portal to access
+   a single device.
+ * Multiple processes can separately mmap() the same portal, in
+   which case they still share one device hardware workqueue.
+ * The single process-wide PASID is used by all threads to interact
+   with all devices.  There is not, for instance, a PASID for each
+   thread or each thread<->device pair.
+
+FAQ
+===
+
+* What is SVA/SVM?
+
+Shared Virtual Addressing (SVA) permits I/O hardware and the processor to
+work in the same address space. In short, sharing the address space. Some
+call it Shared Virtual Memory (SVM), but Linux community wanted to avoid
+it with Posix Shared Memory and Secure Virtual Machines which were terms
+already in circulation.
+
+* What is a PASID?
+
+A Process Address Space ID (PASID) is a PCIe-defined TLP Prefix. A PASID is
+a 20 bit number allocated and managed by the OS. PASID is included in all
+transactions between the platform and the device.
+
+* How are shared work queues different?
+
+Traditionally to allow user space applications interact with hardware,
+there is a separate instance required per process. For example, consider
+doorbells as a mechanism of informing hardware about work to process. Each
+doorbell is required to be spaced 4k (or page-size) apart for process
+isolation. This requires hardware to provision that space and reserve in
+MMIO. This doesn't scale as the number of threads becomes quite large. The
+hardware also manages the queue depth for Shared Work Queues (SWQ), and
+consumers don't need to track queue depth. If there is no space to accept
+a command, the device will return an error indicating retry. Also
+submitting a command to an MMIO address that can't accept ENQCMD will
+return retry in response. In the new DMWr PCIe terminology, devices need to
+support DMWr completer capability. In addition it requires all switch ports
+to support DMWr routing and must be enabled by the PCIe subsystem, much
+like how PCIe Atomics() are managed for instance.
+
+SWQ allows hardware to provision just a single address in the device. When
+used with ENQCMD to submit work, the device can distinguish the process
+submitting the work since it will include the PASID assigned to that
+process. This decreases the pressure of hardware requiring to support
+hardware to scale to a large number of processes.
+
+* Is this the same as a user space device driver?
+
+Communicating with the device via the shared work queue is much simpler
+than a full blown user space driver. The kernel driver does all the
+initialization of the hardware. User space only needs to worry about
+submitting work and processing completions.
+
+* Is this the same as SR-IOV?
+
+Single Root I/O Virtualization (SR-IOV) focuses on providing independent
+hardware interfaces for virtualizing hardware. Hence its required to be
+almost fully functional interface to software supporting the traditional
+BAR's, space for interrupts via MSI-x, its own register layout.
+Virtual Functions (VFs) are assisted by the Physical Function (PF)
+driver.
+
+Scalable I/O Virtualization builds on the PASID concept to create device
+instances for virtualization. SIOV requires host software to assist in
+creating virtual devices, each virtual device is represented by a PASID
+along with the BDF of the device.  This allows device hardware to optimize
+device resource creation and can grow dynamically on demand. SR-IOV creation
+and management is very static in nature. Consult references below for more
+details.
+
+* Why not just create a virtual function for each app?
+
+Creating PCIe SRIOV type virtual functions (VF) are expensive. They create
+duplicated hardware for PCI config space requirements, Interrupts such as
+MSIx for instance. Resources such as interrupts have to be hard partitioned
+between VF's at creation time, and cannot scale dynamically on demand. The
+VF's are not completely independent from the Physical function (PF). Most
+VF's require some communication and assistance from the PF driver. SIOV
+creates a software defined device. Where all the configuration and control
+aspects are mediated via the slow path. The work submission and completion
+happen without any mediation.
+
+* Does this support virtualization?
+
+ENQCMD can be used from within a guest VM. In these cases the VMM helps
+with setting up a translation table to translate from Guest PASID to Host
+PASID. Please consult the ENQCMD instruction set reference for more
+details.
+
+* Does memory need to be pinned?
+
+When devices support SVA, along with platform hardware such as IOMMU
+supporting such devices, there is no need to pin memory for DMA purposes.
+Devices that support SVA also support other PCIe features that remove the
+pinning requirement for memory.
+
+Device TLB support - Device requests the IOMMU to lookup an address before
+use via Address Translation Service (ATS) requests.  If the mapping exists
+but there is no page allocated by the OS, IOMMU hardware returns that no
+mapping exists.
+
+Device requests that virtual address to be mapped via Page Request
+Interface (PRI). Once the OS has successfully completed  the mapping, it
+returns the response back to the device. The device continues again to
+request for a translation and continues.
+
+IOMMU works with the OS in managing consistency of page-tables with the
+device. When removing pages, it interacts with the device to remove any
+device-tlb that might have been cached before removing the mappings from
+the OS.
+
+References
+==========
+
+VT-D:
+https://01.org/blogs/ashokraj/2018/recent-enhancements-intel-virtualization-technology-directed-i/o-intel-vt-d
+
+SIOV:
+https://01.org/blogs/2019/assignable-interfaces-intel-scalable-i/o-virtualization-linux
+
+ENQCMD in ISE:
+https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
+
+DSA spec:
+https://software.intel.com/sites/default/files/341204-intel-data-streaming-accelerator-spec.pdf
-- 
2.19.1

