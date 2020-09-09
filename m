Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61750C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D99216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIIJJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:09:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:23096 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIJJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:09:15 -0400
IronPort-SDR: QRFF6RdCZRMkpsoBRXF2YmUDVCHwAcL+t3LUKsFiPePIU5BE23u90I7IYcNDyS/D7M7ipg7AbU
 xheFaCdG4feA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="146014482"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="146014482"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:09:02 -0700
IronPort-SDR: VvA5joNqGoswulgDxqu4fj4IXT9ZsOa2yEvWLUfzYlKgryuDIGsBhbFuk9BXvIPTzrYgpwu5tl
 bG06xvIYG1pg==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="505390866"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:08:56 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v3 01/17] docs: acrn: Introduce ACRN
Date:   Wed,  9 Sep 2020 17:08:20 +0800
Message-Id: <20200909090836.46762-2-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909090836.46762-1-shuo.a.liu@intel.com>
References: <20200909090836.46762-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

Add documentation on the following aspects of ACRN:

  1) A brief introduction on the architecture of ACRN.
  2) I/O request handling in ACRN.

To learn more about ACRN, please go to ACRN project website
https://projectacrn.org, or the documentation page
https://projectacrn.github.io/.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sen Christopherson <sean.j.christopherson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/virt/acrn/index.rst        | 11 +++
 Documentation/virt/acrn/introduction.rst | 40 ++++++++++
 Documentation/virt/acrn/io-request.rst   | 97 ++++++++++++++++++++++++
 Documentation/virt/index.rst             |  1 +
 MAINTAINERS                              |  7 ++
 5 files changed, 156 insertions(+)
 create mode 100644 Documentation/virt/acrn/index.rst
 create mode 100644 Documentation/virt/acrn/introduction.rst
 create mode 100644 Documentation/virt/acrn/io-request.rst

diff --git a/Documentation/virt/acrn/index.rst b/Documentation/virt/acrn/index.rst
new file mode 100644
index 000000000000..e3cf99033bdb
--- /dev/null
+++ b/Documentation/virt/acrn/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ACRN Hypervisor
+===============
+
+.. toctree::
+   :maxdepth: 1
+
+   introduction
+   io-request
diff --git a/Documentation/virt/acrn/introduction.rst b/Documentation/virt/acrn/introduction.rst
new file mode 100644
index 000000000000..6b44924d5c0e
--- /dev/null
+++ b/Documentation/virt/acrn/introduction.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+ACRN Hypervisor Introduction
+============================
+
+The ACRN Hypervisor is a Type 1 hypervisor, running directly on the bare-metal
+hardware. It has a privileged management VM, called Service VM, to manage User
+VMs and do I/O emulation.
+
+ACRN userspace is an application running in the Service VM that emulates
+devices for a User VM based on command line configurations. ACRN Hypervisor
+Service Module (HSM) is a kernel module in the Service VM which provides
+hypervisor services to the ACRN userspace.
+
+Below figure shows the architecture.
+
+::
+
+                Service VM                    User VM
+      +----------------------------+  |  +------------------+
+      |        +--------------+    |  |  |                  |
+      |        |ACRN userspace|    |  |  |                  |
+      |        +--------------+    |  |  |                  |
+      |-----------------ioctl------|  |  |                  |   ...
+      |kernel space   +----------+ |  |  |                  |
+      |               |   HSM    | |  |  | Drivers          |
+      |               +----------+ |  |  |                  |
+      +--------------------|-------+  |  +------------------+
+  +---------------------hypercall----------------------------------------+
+  |                         ACRN Hypervisor                              |
+  +----------------------------------------------------------------------+
+  |                          Hardware                                    |
+  +----------------------------------------------------------------------+
+
+ACRN userspace allocates memory for the User VM, configures and initializes the
+devices used by the User VM, loads the virtual bootloader, initializes the
+virtual CPU state and handles I/O request accesses from the User VM. It uses
+ioctls to communicate with the HSM. HSM implements hypervisor services by
+interacting with the ACRN Hypervisor via hypercalls. HSM exports a char device
+interface (/dev/acrn_hsm) to userspace.
diff --git a/Documentation/virt/acrn/io-request.rst b/Documentation/virt/acrn/io-request.rst
new file mode 100644
index 000000000000..019dc5978f7c
--- /dev/null
+++ b/Documentation/virt/acrn/io-request.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+I/O request handling
+====================
+
+An I/O request of a User VM, which is constructed by the hypervisor, is
+distributed by the ACRN Hypervisor Service Module to an I/O client
+corresponding to the address range of the I/O request. Details of I/O request
+handling are described in the following sections.
+
+1. I/O request
+--------------
+
+For each User VM, there is a shared 4-KByte memory region used for I/O requests
+communication between the hypervisor and Service VM. An I/O request is a
+256-byte structure buffer, which is 'struct acrn_io_request', that is filled by
+an I/O handler of the hypervisor when a trapped I/O access happens in a User
+VM. ACRN userspace in the Service VM first allocates a 4-KByte page and passes
+the GPA (Guest Physical Address) of the buffer to the hypervisor. The buffer is
+used as an array of 16 I/O request slots with each I/O request slot being 256
+bytes. This array is indexed by vCPU ID.
+
+2. I/O clients
+--------------
+
+An I/O client is responsible for handling User VM I/O requests whose accessed
+GPA falls in a certain range. Multiple I/O clients can be associated with each
+User VM. There is a special client associated with each User VM, called the
+default client, that handles all I/O requests that do not fit into the range of
+any other clients. The ACRN userspace acts as the default client for each User
+VM.
+
+Below illustration shows the relationship between I/O requests shared buffer,
+I/O requests and I/O clients.
+
+::
+
+     +------------------------------------------------------+
+     |                                       Service VM     |
+     |+--------------------------------------------------+  |
+     ||      +----------------------------------------+  |  |
+     ||      | shared page            ACRN userspace  |  |  |
+     ||      |    +-----------------+  +------------+ |  |  |
+     ||   +----+->| acrn_io_request |<-+  default   | |  |  |
+     ||   |  | |  +-----------------+  | I/O client | |  |  |
+     ||   |  | |  |       ...       |  +------------+ |  |  |
+     ||   |  | |  +-----------------+                 |  |  |
+     ||   |  +-|--------------------------------------+  |  |
+     ||---|----|-----------------------------------------|  |
+     ||   |    |                             kernel      |  |
+     ||   |    |            +----------------------+     |  |
+     ||   |    |            | +-------------+  HSM |     |  |
+     ||   |    +--------------+             |      |     |  |
+     ||   |                 | | I/O clients |      |     |  |
+     ||   |                 | |             |      |     |  |
+     ||   |                 | +-------------+      |     |  |
+     ||   |                 +----------------------+     |  |
+     |+---|----------------------------------------------+  |
+     +----|-------------------------------------------------+
+          |
+     +----|-------------------------------------------------+
+     |  +-+-----------+                                     |
+     |  | I/O handler |              ACRN Hypervisor        |
+     |  +-------------+                                     |
+     +------------------------------------------------------+
+
+3. I/O request state transition
+-------------------------------
+
+The state transitions of a ACRN I/O request are as follows.
+
+::
+
+   FREE -> PENDING -> PROCESSING -> COMPLETE -> FREE -> ...
+
+- FREE: this I/O request slot is empty
+- PENDING: a valid I/O request is pending in this slot
+- PROCESSING: the I/O request is being processed
+- COMPLETE: the I/O request has been processed
+
+An I/O request in COMPLETE or FREE state is owned by the hypervisor. HSM and
+ACRN userspace are in charge of processing the others.
+
+4. Processing flow of I/O requests
+-------------------------------
+
+a. The I/O handler of the hypervisor will fill an I/O request with PENDING
+   state when a trapped I/O access happens in a User VM.
+b. The hypervisor makes an upcall, which is a notification interrupt, to
+   the Service VM.
+c. The upcall handler schedules a tasklet to dispatch I/O requests.
+d. The tasklet looks for the PENDING I/O requests, assigns them to different
+   registered clients based on the address of the I/O accesses, updates
+   their state to PROCESSING, and notifies the corresponding client to handle.
+e. The notified client handles the assigned I/O requests.
+f. The HSM updates I/O requests states to COMPLETE and notifies the hypervisor
+   of the completion via hypercalls.
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index de1ab81df958..c10b519507f5 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -11,6 +11,7 @@ Linux Virtualization Support
    uml/user_mode_linux
    paravirt_ops
    guest-halt-polling
+   acrn/index
 
 .. only:: html and subproject
 
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..e0fea5e464b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -436,6 +436,13 @@ S:	Orphan
 F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h
 
+ACRN HYPERVISOR SERVICE MODULE
+M:	Shuo Liu <shuo.a.liu@intel.com>
+L:	acrn-dev@lists.projectacrn.org
+S:	Supported
+W:	https://projectacrn.org
+F:	Documentation/virt/acrn/
+
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
 S:	Maintained
-- 
2.28.0

