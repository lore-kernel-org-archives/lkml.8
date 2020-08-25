Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4D3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC88204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgHYCvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:51:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:37741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgHYCvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:51:13 -0400
IronPort-SDR: krRlbsjQHUt/R8imkmpdIKa1VkH9WPLH9vmpyjWjE2NrfZp1ijpCDj+lP2cJGho2wkvZslU6Ss
 aCjaHqCQOYBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690810"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:51:12 -0700
IronPort-SDR: ZKyJL3PGKN5dxPTff83kNTEde9VVHMctril+STk8p07ZuZQrStewNsyAOJWN6o/vtKuYZzCXHC
 9AeFsCKg8s4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409836"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:51:09 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH 10/17] virt: acrn: Introduce PCI configuration space PIO accesses combiner
Date:   Tue, 25 Aug 2020 10:45:10 +0800
Message-Id: <20200825024516.16766-11-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825024516.16766-1-shuo.a.liu@intel.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

A User VM can access its virtual PCI configuration spaces via port IO
approach, which has two following steps:
 1) writes address into port 0xCF8
 2) put/get data in/from port 0xCFC

To distribute a complete PCI configuration space access one time, HSM
need to combine such two accesses together.

Combine two paired PIO I/O requests into one PCI I/O request and
continue the I/O request distribution.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/virt/acrn/acrn_drv.h |  2 +
 drivers/virt/acrn/ioreq.c    | 76 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/acrn.h    | 15 +++++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index c2e32e9a17b7..62340ec90eb5 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -152,6 +152,7 @@ extern rwlock_t acrn_vm_list_lock;
  * @default_client:		The default I/O request client
  * @ioreq_buf:			I/O request shared buffer
  * @ioreq_page:			The page of the I/O request shared buffer
+ * @pci_conf_addr:		Address of a PCI configuration access emulation
  */
 struct acrn_vm {
 	struct list_head		list;
@@ -166,6 +167,7 @@ struct acrn_vm {
 	struct acrn_ioreq_client	*default_client;
 	struct acrn_io_request_buffer	*ioreq_buf;
 	struct page			*ioreq_page;
+	u32				pci_conf_addr;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index 3339fc7c8b54..7e312b8e5edd 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -220,6 +220,80 @@ int acrn_ioreq_client_wait(struct acrn_ioreq_client *client)
 	return 0;
 }
 
+static bool is_cfg_addr(struct acrn_io_request *req)
+{
+	return ((req->type == ACRN_IOREQ_TYPE_PORTIO) &&
+		(req->reqs.pio_request.address == 0xcf8));
+}
+
+static bool is_cfg_data(struct acrn_io_request *req)
+{
+	return ((req->type == ACRN_IOREQ_TYPE_PORTIO) &&
+		((req->reqs.pio_request.address >= 0xcfc) &&
+		 (req->reqs.pio_request.address < (0xcfc + 4))));
+}
+
+/* The low 8-bit of supported pci_reg addr.*/
+#define PCI_LOWREG_MASK  0xFC
+/* The high 4-bit of supported pci_reg addr */
+#define PCI_HIGHREG_MASK 0xF00
+/* Max number of supported functions */
+#define PCI_FUNCMAX	7
+/* Max number of supported slots */
+#define PCI_SLOTMAX	31
+/* Max number of supported buses */
+#define PCI_BUSMAX	255
+#define CONF1_ENABLE	0x80000000UL
+/*
+ * A PCI configuration space access via PIO 0xCF8 and 0xCFC normally has two
+ * following steps:
+ *   1) writes address into 0xCF8 port
+ *   2) accesses data in/from 0xCFC
+ * This function combines such paired PCI configuration space I/O requests into
+ * one ACRN_IOREQ_TYPE_PCICFG type I/O request and continues the processing.
+ */
+static bool handle_cf8cfc(struct acrn_vm *vm,
+			  struct acrn_io_request *req, u16 vcpu)
+{
+	int offset, pci_cfg_addr, pci_reg;
+	bool is_handled = false;
+
+	if (is_cfg_addr(req)) {
+		WARN_ON(req->reqs.pio_request.size != 4);
+		if (req->reqs.pio_request.direction == ACRN_IOREQ_DIR_WRITE)
+			vm->pci_conf_addr = req->reqs.pio_request.value;
+		else
+			req->reqs.pio_request.value = vm->pci_conf_addr;
+		is_handled = true;
+	} else if (is_cfg_data(req)) {
+		if (!(vm->pci_conf_addr & CONF1_ENABLE)) {
+			if (req->reqs.pio_request.direction ==
+					ACRN_IOREQ_DIR_READ)
+				req->reqs.pio_request.value = 0xffffffff;
+			is_handled = true;
+		} else {
+			offset = req->reqs.pio_request.address - 0xcfc;
+
+			req->type = ACRN_IOREQ_TYPE_PCICFG;
+			pci_cfg_addr = vm->pci_conf_addr;
+			req->reqs.pci_request.bus =
+					(pci_cfg_addr >> 16) & PCI_BUSMAX;
+			req->reqs.pci_request.dev =
+					(pci_cfg_addr >> 11) & PCI_SLOTMAX;
+			req->reqs.pci_request.func =
+					(pci_cfg_addr >> 8) & PCI_FUNCMAX;
+			pci_reg = (pci_cfg_addr & PCI_LOWREG_MASK) +
+				   ((pci_cfg_addr >> 16) & PCI_HIGHREG_MASK);
+			req->reqs.pci_request.reg = pci_reg + offset;
+		}
+	}
+
+	if (is_handled)
+		ioreq_complete_request(vm->vmid, vcpu, req);
+
+	return is_handled;
+}
+
 static bool in_range(struct acrn_ioreq_range *range,
 		     struct acrn_io_request *req)
 {
@@ -378,6 +452,8 @@ static int acrn_ioreq_dispatch(struct acrn_vm *vm)
 				ioreq_complete_request(vm->vmid, i, req);
 				continue;
 			}
+			if (handle_cf8cfc(vm, req, i))
+				continue;
 
 			spin_lock_bh(&vm->ioreq_clients_lock);
 			client = find_ioreq_client(vm, req);
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 713b22110a99..c8bb71a1cef7 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -20,6 +20,7 @@
 
 #define ACRN_IOREQ_TYPE_PORTIO		0
 #define ACRN_IOREQ_TYPE_MMIO		1
+#define ACRN_IOREQ_TYPE_PCICFG		2
 
 #define ACRN_IOREQ_DIR_READ		0
 #define ACRN_IOREQ_DIR_WRITE		1
@@ -40,6 +41,18 @@ struct acrn_pio_request {
 	__u32	value;
 } __attribute__((aligned(8)));
 
+/* Need keep same header fields with pio_request */
+struct acrn_pci_request {
+	__u32	direction;
+	__u32	reserved[3];
+	__u64	size;
+	__u32	value;
+	__u32	bus;
+	__u32	dev;
+	__u32	func;
+	__u32	reg;
+} __attribute__((aligned(8)));
+
 /**
  * struct acrn_io_request - 256-byte ACRN I/O request
  * @type:		Type of this request (ACRN_IOREQ_TYPE_*).
@@ -48,6 +61,7 @@ struct acrn_pio_request {
  * @reserved0:		Reserved fields.
  * @reqs:		Union of different types of request. Byte offset: 64.
  * @reqs.pio_request:	PIO request data of the I/O request.
+ * @reqs.pci_request:	PCI configuration space request data of the I/O request.
  * @reqs.mmio_request:	MMIO request data of the I/O request.
  * @reqs.data:		Raw data of the I/O request.
  * @reserved1:		Reserved fields.
@@ -107,6 +121,7 @@ struct acrn_io_request {
 	__u32	reserved0[14];
 	union {
 		struct acrn_pio_request		pio_request;
+		struct acrn_pci_request		pci_request;
 		struct acrn_mmio_request	mmio_request;
 		__u64				data[8];
 	} reqs;
-- 
2.28.0

