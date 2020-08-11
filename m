Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BB6205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="CkzcnAqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgHKJpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:45:13 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:57241 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgHKJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597139112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=21LnmuTUq2pHs9BEPTKLR7uvR8pjWH5GPd9gh/+wq5s=;
  b=CkzcnAqtQ/tz5+xuOqHSr4bd6TbAGpo6Ye/Yz17Kfq2hlQXzBqkDwrQV
   37zNWpf/+UkJgZ4f+/buoTSrZ1QvJYX3HaIxh3CUNymfKtFDQR5BKFwO0
   H+7kjHGZvBXtcYHDoIT5Jzv9Dgel6+bx+BIxGkc49oW+hFWp9c5oQBBY/
   o=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: VY5VVlCFQoEMbraTS/yrZS8UqVt0ps8DLejYExspGKQRXdGYHx6bGA2Os+p4H57m0KVTnf4ETo
 A58Ud1v5xBKk0UreNYyFdq6SOXG5m2ohZ6VYo+8IFfkxaK9rYzAj92qOdySbmyuAGHFC6CHXLu
 pXAvt/6qNEzVNM41g+QN7omxDcX9rY9EwY9KUczeMlcriiFjpFoZyR6P++og5Yj3lXRWZomi+9
 8ny1E/KACaSD//Ufem6d3bKnm3jAVxF0h5A6pbWvkWT6anOcvbn8mKJ39nPavZd99plNPTlG1/
 IjQ=
X-SBRS: 2.7
X-MesageID: 24242470
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,460,1589256000"; 
   d="scan'208";a="24242470"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-nvdimm@lists.01.org>, <xen-devel@lists.xenproject.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
Date:   Tue, 11 Aug 2020 11:44:46 +0200
Message-ID: <20200811094447.31208-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811094447.31208-1-roger.pau@citrix.com>
References: <20200811094447.31208-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in preparation for the logic behind MEMORY_DEVICE_DEVDAX also
being used by non DAX devices.

No functional change intended.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-nvdimm@lists.01.org
Cc: xen-devel@lists.xenproject.org
Cc: linux-mm@kvack.org
---
 drivers/dax/device.c     | 2 +-
 include/linux/memremap.h | 9 ++++-----
 mm/memremap.c            | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 4c0af2eb7e19..1e89513f3c59 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -429,7 +429,7 @@ int dev_dax_probe(struct device *dev)
 		return -EBUSY;
 	}
 
-	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
+	dev_dax->pgmap.type = MEMORY_DEVICE_GENERIC;
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 5f5b2df06e61..e5862746751b 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -46,11 +46,10 @@ struct vmem_altmap {
  * wakeup is used to coordinate physical address space management (ex:
  * fs truncate/hole punch) vs pinned pages (ex: device dma).
  *
- * MEMORY_DEVICE_DEVDAX:
+ * MEMORY_DEVICE_GENERIC:
  * Host memory that has similar access semantics as System RAM i.e. DMA
- * coherent and supports page pinning. In contrast to
- * MEMORY_DEVICE_FS_DAX, this memory is access via a device-dax
- * character device.
+ * coherent and supports page pinning. This is for example used by DAX devices
+ * that expose memory using a character device.
  *
  * MEMORY_DEVICE_PCI_P2PDMA:
  * Device memory residing in a PCI BAR intended for use with Peer-to-Peer
@@ -60,7 +59,7 @@ enum memory_type {
 	/* 0 is reserved to catch uninitialized type fields */
 	MEMORY_DEVICE_PRIVATE = 1,
 	MEMORY_DEVICE_FS_DAX,
-	MEMORY_DEVICE_DEVDAX,
+	MEMORY_DEVICE_GENERIC,
 	MEMORY_DEVICE_PCI_P2PDMA,
 };
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 03e38b7a38f1..006dace60b1a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -216,7 +216,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 			return ERR_PTR(-EINVAL);
 		}
 		break;
-	case MEMORY_DEVICE_DEVDAX:
+	case MEMORY_DEVICE_GENERIC:
 		need_devmap_managed = false;
 		break;
 	case MEMORY_DEVICE_PCI_P2PDMA:
-- 
2.28.0

