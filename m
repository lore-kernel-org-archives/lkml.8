Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86950C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5202072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgHYCvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:51:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:37741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgHYCv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:51:26 -0400
IronPort-SDR: rqVmJdbKGzS+NkTe17M0PF8B691mj1X5fZEcl/HczmUBL8nFm58k/imyIMJkmiIkZDGpwRqb1Q
 nk/q9RNJMkxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690840"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690840"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:51:25 -0700
IronPort-SDR: 4WESpQwx7vD3oN+IVcvHiC3Q/rV9VOZDL5csPVOEbEiWJDHqWbEccCmSOtxvk06p8i0J2+AYOV
 5ty7K/N5mL6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409876"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:51:22 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 14/17] virt: acrn: Introduce I/O ranges operation interfaces
Date:   Tue, 25 Aug 2020 10:45:14 +0800
Message-Id: <20200825024516.16766-15-shuo.a.liu@intel.com>
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

An I/O request of a User VM, which is constructed by hypervisor, is
distributed by the ACRN Hypervisor Service Module to an I/O client
corresponding to the address range of the I/O request.

I/O client maintains a list of address ranges. Introduce
acrn_ioreq_range_{add,del}() to manage these address ranges.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/virt/acrn/acrn_drv.h |  4 +++
 drivers/virt/acrn/ioreq.c    | 59 ++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index c08235ba21fc..05836dcefbd6 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -195,6 +195,10 @@ struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
 						   void *data, bool is_default,
 						   const char *name);
 void acrn_ioreq_client_destroy(struct acrn_ioreq_client *client);
+int acrn_ioreq_range_add(struct acrn_ioreq_client *client,
+			 u32 type, u64 start, u64 end);
+void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
+			  u32 type, u64 start, u64 end);
 
 int acrn_msi_inject(u16 vmid, u64 msi_addr, u64 msi_data);
 
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index 7e312b8e5edd..48ce6955699e 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -102,6 +102,65 @@ int acrn_ioreq_request_default_complete(struct acrn_vm *vm, u16 vcpu)
 	return ret;
 }
 
+/**
+ * acrn_ioreq_range_add() - Add an iorange monitored by an ioreq client
+ * @client:	The ioreq client
+ * @type:	Type (ACRN_IOREQ_TYPE_MMIO or ACRN_IOREQ_TYPE_PORTIO)
+ * @start:	Start address of iorange
+ * @end:	End address of iorange
+ *
+ * Return: 0 on success, <0 on error
+ */
+int acrn_ioreq_range_add(struct acrn_ioreq_client *client,
+			 u32 type, u64 start, u64 end)
+{
+	struct acrn_ioreq_range *range;
+
+	if (end < start) {
+		pr_err("Invalid IO range [0x%llx,0x%llx]\n", start, end);
+		return -EFAULT;
+	}
+
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+
+	range->type = type;
+	range->start = start;
+	range->end = end;
+
+	write_lock_bh(&client->range_lock);
+	list_add(&range->list, &client->range_list);
+	write_unlock_bh(&client->range_lock);
+
+	return 0;
+}
+
+/**
+ * acrn_ioreq_range_del() - Del an iorange monitored by an ioreq client
+ * @client:	The ioreq client
+ * @type:	Type (ACRN_IOREQ_TYPE_MMIO or ACRN_IOREQ_TYPE_PORTIO)
+ * @start:	Start address of iorange
+ * @end:	End address of iorange
+ */
+void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
+			  u32 type, u64 start, u64 end)
+{
+	struct acrn_ioreq_range *range;
+
+	write_lock_bh(&client->range_lock);
+	list_for_each_entry(range, &client->range_list, list) {
+		if (type == range->type &&
+		    start == range->start &&
+		    end == range->end) {
+			list_del(&range->list);
+			kfree(range);
+			break;
+		}
+	}
+	write_unlock_bh(&client->range_lock);
+}
+
 /*
  * ioreq_task() is the execution entity of handler thread of an I/O client.
  * The handler callback of the I/O client is called within the handler thread.
-- 
2.28.0

