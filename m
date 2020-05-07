Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDE9C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FA820870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877170;
	bh=XB1OEP9Z8ItrvrQBAEAdBZa9098nTFA8fhG2K04/eok=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=r52AiIOpweTojDotooAaRXog7I9Wrk2jiZtFuiED0rDVdZAHO3G3LVef/+PsOaTwO
	 Gb7XbV8mcFTUzP5og4GnR0+HFmEDPH7/03VxvST/pd3wrP8lov21Ws+Gba+StmaAEs
	 mr6BkH/pig8dF0qb1dieHaysGaQx82bA962ZtKQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgEGSqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGSqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:46:09 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 528B920870;
        Thu,  7 May 2020 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877168;
        bh=XB1OEP9Z8ItrvrQBAEAdBZa9098nTFA8fhG2K04/eok=;
        h=Date:From:To:Cc:Subject:From;
        b=mFnxf2DfhGCpWJ35fChEKFo7scKXEnSgRzc4fjgs44yqHHDKOMRpP2HiNK22is2hz
         vw8km9ZDLLFoo1otoT0mpBoIftb+H/YgqTkDwcgdy/I4Q4DoVruboodlywjZESNtlL
         6SG/Ji33LPTMomQG3Vcn2uVOoC6l69Zv+U0d1FYY=
Date:   Thu, 7 May 2020 13:50:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: Replace zero-length array with flexible-array
Message-ID: <20200507185035.GA13907@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma/milbeaut-hdmac.c |    2 +-
 drivers/dma/milbeaut-xdmac.c |    2 +-
 drivers/dma/moxart-dma.c     |    2 +-
 drivers/dma/ti/edma.c        |    2 +-
 drivers/dma/ti/k3-udma.c     |    2 +-
 drivers/dma/timb_dma.c       |    2 +-
 include/linux/dmaengine.h    |    4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index 8853d442430b..a8cfb59f6efe 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -77,7 +77,7 @@ struct milbeaut_hdmac_device {
 	struct dma_device ddev;
 	struct clk *clk;
 	void __iomem *reg_base;
-	struct milbeaut_hdmac_chan channels[0];
+	struct milbeaut_hdmac_chan channels[];
 };
 
 static struct milbeaut_hdmac_chan *
diff --git a/drivers/dma/milbeaut-xdmac.c b/drivers/dma/milbeaut-xdmac.c
index ab3d2f395378..85a597228fb0 100644
--- a/drivers/dma/milbeaut-xdmac.c
+++ b/drivers/dma/milbeaut-xdmac.c
@@ -74,7 +74,7 @@ struct milbeaut_xdmac_chan {
 struct milbeaut_xdmac_device {
 	struct dma_device ddev;
 	void __iomem *reg_base;
-	struct milbeaut_xdmac_chan channels[0];
+	struct milbeaut_xdmac_chan channels[];
 };
 
 static struct milbeaut_xdmac_chan *
diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index e04499c1f27f..2a77fa319d78 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -127,7 +127,7 @@ struct moxart_desc {
 	unsigned int			dma_cycles;
 	struct virt_dma_desc		vd;
 	uint8_t				es;
-	struct moxart_sg		sg[0];
+	struct moxart_sg		sg[];
 };
 
 struct moxart_chan {
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index c4a5c170c1f9..35d81bd857f1 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -211,7 +211,7 @@ struct edma_desc {
 	u32				residue;
 	u32				residue_stat;
 
-	struct edma_pset		pset[0];
+	struct edma_pset		pset[];
 };
 
 struct edma_cc;
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index a9c0251adf1a..eb76d546931b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -170,7 +170,7 @@ struct udma_desc {
 	void *metadata; /* pointer to provided metadata buffer (EPIP, PSdata) */
 
 	unsigned int hwdesc_count;
-	struct udma_hwdesc hwdesc[0];
+	struct udma_hwdesc hwdesc[];
 };
 
 enum udma_chan_state {
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 39382694fdfc..68e48bf54d78 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -88,7 +88,7 @@ struct timb_dma {
 	struct dma_device	dma;
 	void __iomem		*membase;
 	struct tasklet_struct	tasklet;
-	struct timb_dma_chan	channels[0];
+	struct timb_dma_chan	channels[];
 };
 
 static struct device *chan2dev(struct dma_chan *chan)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 21065c04c4ac..18b8813fafb2 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -153,7 +153,7 @@ struct dma_interleaved_template {
 	bool dst_sgl;
 	size_t numf;
 	size_t frame_size;
-	struct data_chunk sgl[0];
+	struct data_chunk sgl[];
 };
 
 /**
@@ -537,7 +537,7 @@ struct dmaengine_unmap_data {
 	struct device *dev;
 	struct kref kref;
 	size_t len;
-	dma_addr_t addr[0];
+	dma_addr_t addr[];
 };
 
 struct dma_async_tx_descriptor;

