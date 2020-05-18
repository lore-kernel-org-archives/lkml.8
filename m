Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17BEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91E620787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgERCzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:55:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:29280 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgERCzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:55:22 -0400
IronPort-SDR: jEwfjgTW73c42okrEuuT7PBqz32zu76m2cohSCWJFZRDuINEgQgzmNLC3eCO3UCr4XP+cKmxfp
 iWq+Gw3begWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 19:55:21 -0700
IronPort-SDR: OglWgLH78bA92/WGFbFfRAjAgOZ3+ncDSkAz2DVB2civwg7YxMXX52i0cJOEpn49OAm94bmAL6
 sKi6ocpyuOWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,405,1583222400"; 
   d="scan'208";a="411104064"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.16])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2020 19:55:18 -0700
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        kevin.tian@intel.com, shaopeng.he@intel.com, yi.l.liu@intel.com,
        xin.zeng@intel.com, hang.yuan@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH v4 02/10] vfio/pci: macros to generate module_init and module_exit for vendor modules
Date:   Sun, 17 May 2020 22:45:10 -0400
Message-Id: <20200518024510.14115-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518024202.13996-1-yan.y.zhao@intel.com>
References: <20200518024202.13996-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vendor modules call macro module_vfio_pci_register_vendor_handler to
generate module_init and module_exit.
It is necessary to ensure that vendor modules always call
vfio_pci_register_vendor_driver() on driver loading and
vfio_pci_unregister_vendor_driver on driver unloading,
because
(1) at compiling time, there's only a dependency of vendor modules on
vfio_pci.
(2) at runtime,
- vendor modules add refs of vfio_pci on a successful calling of
  vfio_pci_register_vendor_driver() and deref of vfio_pci on a
  successful calling of vfio_pci_unregister_vendor_driver().
- vfio_pci only adds refs of vendor module on a successful probe of vendor
  driver.
  vfio_pci derefs vendor module when unbinding from a device.

So, after vfio_pci is unbound from a device, the vendor module to that
device is free to get unloaded. However, if that vendor module does not
call vfio_pci_unregister_vendor_driver() in its module_exit, vfio_pci may
hold a stale pointer to vendor module.

Cc: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/vfio.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 3e53deb012b6..f3746608c2d9 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -223,4 +223,31 @@ struct vfio_pci_vendor_driver_ops {
 };
 int __vfio_pci_register_vendor_driver(struct vfio_pci_vendor_driver_ops *ops);
 void vfio_pci_unregister_vendor_driver(struct vfio_device_ops *device_ops);
+
+#define vfio_pci_register_vendor_driver(__name, __probe, __remove,	\
+					__device_ops)			\
+static struct vfio_pci_vendor_driver_ops  __ops ## _node = {		\
+	.owner		= THIS_MODULE,					\
+	.name		= __name,					\
+	.probe		= __probe,					\
+	.remove		= __remove,					\
+	.device_ops	= __device_ops,					\
+};									\
+__vfio_pci_register_vendor_driver(&__ops ## _node)
+
+#define module_vfio_pci_register_vendor_handler(name, probe, remove,	\
+						device_ops)		\
+static int __init device_ops ## _module_init(void)			\
+{									\
+	vfio_pci_register_vendor_driver(name, probe, remove,		\
+					device_ops);			\
+	return 0;							\
+};									\
+static void __exit device_ops ## _module_exit(void)			\
+{									\
+	vfio_pci_unregister_vendor_driver(device_ops);			\
+};									\
+module_init(device_ops ## _module_init);				\
+module_exit(device_ops ## _module_exit)
+
 #endif /* VFIO_H */
-- 
2.17.1

