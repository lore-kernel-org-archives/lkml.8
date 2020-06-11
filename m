Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0949C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8423A2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgFKLte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:49:34 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34934 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgFKLte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:49:34 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjLhn-0001Dv-TM; Thu, 11 Jun 2020 21:49:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2020 21:49:11 +1000
Date:   Thu, 11 Jun 2020 21:49:11 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [v2 PATCH] iov_iter: Move unnecessary inclusion of crypto/hash.h
Message-ID: <20200611114911.GA17594@gondor.apana.org.au>
References: <20200611074332.GA12274@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611074332.GA12274@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file linux/uio.h includes crypto/hash.h which pulls in
most of the Crypto API.  Since linux/uio.h is used throughout the
kernel this means that every tiny bit of change to the Crypto API
causes the entire kernel to get rebuilt.

This patch fixes this by moving it into lib/iov_iter.c instead
where it is actually used.

This patch also fixes the ifdef to use CRYPTO_HASH instead of just
CRYPTO which does not guarantee the existence of ahash.

Unfortunately a number of drivers were relying on linux/uio.h to
provide access to linux/slab.h.  This patch adds inclusions of
linux/slab.h as detected by build failures.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6d0bec947636..e237d6038407 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -20,6 +20,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include "sf-pdma.h"
 
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d39307f060bd..5a984df0e95e 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -4,6 +4,7 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/poll.h>
+#include <linux/slab.h>
 #include <linux/uacce.h>
 
 static struct class *uacce_class;
diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 17ad3b8698e1..aa2e3fe19c0f 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..d1e03b8cb6bb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include <crypto/hash.h>
 #include <linux/kernel.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 9576fd8158d7..3835a8a8e9ea 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -7,7 +7,6 @@
 
 #include <linux/kernel.h>
 #include <linux/thread_info.h>
-#include <crypto/hash.h>
 #include <uapi/linux/uio.h>
 
 struct page;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 51595bf3af85..2830daf46c73 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <crypto/hash.h>
 #include <linux/export.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
@@ -1566,7 +1567,7 @@ EXPORT_SYMBOL(csum_and_copy_to_iter);
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i)
 {
-#ifdef CONFIG_CRYPTO
+#ifdef CONFIG_CRYPTO_HASH
 	struct ahash_request *hash = hashp;
 	struct scatterlist sg;
 	size_t copied;
diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index a4fe6060b960..a3ae8778f6a9 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -7,6 +7,7 @@
 #include <linux/pstore_blk.h>
 #include <linux/mtd/mtd.h>
 #include <linux/bitops.h>
+#include <linux/slab.h>
 
 static struct mtdpstore_context {
 	int index;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
