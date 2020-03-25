Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6EEC2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75501206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SRvWyMoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCYUra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:47:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40236 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYUr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:47:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02PKl7q1077586;
        Wed, 25 Mar 2020 15:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585169227;
        bh=RF7Sp5o9bDQI1W0VhjcDoi4XTIxipSNPRoX49Sx5MgM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SRvWyMoCmvOjcU4a6eQT1FdipP7RIVJ58F/wQzicU1gR7AgE1e4Honv013YeBbbcK
         4gOsW4mnvnFf43UfFO84BsLYoQfU+XnhysN8Y+ozWYvPmvs6D3k/zathMeZqzuRv3+
         xU033Jn30ihi6HC+xZBT0dRKel1SmMw7QrlwWjG8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02PKl7DJ068069
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Mar 2020 15:47:07 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 25
 Mar 2020 15:47:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 25 Mar 2020 15:47:06 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02PKl6oi080213;
        Wed, 25 Mar 2020 15:47:06 -0500
Received: from localhost ([10.250.35.147])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 02PKl6Up063396;
        Wed, 25 Mar 2020 15:47:06 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/4] remoteproc: introduce version element into resource type field
Date:   Wed, 25 Mar 2020 15:46:59 -0500
Message-ID: <20200325204701.16862-3-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325204701.16862-1-s-anna@ti.com>
References: <20200325204701.16862-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current remoteproc core has supported only 32-bit remote
processors and as such some of the current resource structures
may not scale well for 64-bit remote processors, and would
require new versions of resource types. Each resource is currently
identified by a 32-bit type field. Introduce the concept of version
for these resource types by overloading this 32-bit type field
into two 16-bit version and type fields with the existing resources
behaving as version 0 thereby providing backward compatibility.

The version field is passed as an additional argument to each of
the handler functions, and all the existing handlers are updated
accordingly. Each specific handler will be updated on a need basis
when a new version of the resource type is added.

An alternate way would be to introduce the new types as completely
new resource types which would require additional customization of
the resource handlers based on the 32-bit or 64-bit mode of a remote
processor, and introduction of an additional mode flag to the rproc
structure.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_core.c    | 25 +++++++++++++++----------
 drivers/remoteproc/remoteproc_debugfs.c | 17 ++++++++++-------
 include/linux/remoteproc.h              |  8 +++++++-
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 6e0b91fa6f11..53bc37c508c6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -46,7 +46,7 @@ static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
 
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
-				 void *, int offset, int avail);
+				 void *, int offset, int avail, u16 ver);
 
 static int rproc_alloc_carveout(struct rproc *rproc,
 				struct rproc_mem_entry *mem);
@@ -453,6 +453,7 @@ static void rproc_rvdev_release(struct device *dev)
  * @rsc: the vring resource descriptor
  * @offset: offset of the resource entry
  * @avail: size of available data (for sanity checking the image)
+ * @ver: version number of the resource type
  *
  * This resource entry requests the host to statically register a virtio
  * device (vdev), and setup everything needed to support it. It contains
@@ -476,7 +477,7 @@ static void rproc_rvdev_release(struct device *dev)
  * Returns 0 on success, or an appropriate error code otherwise
  */
 static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
-			     int offset, int avail)
+			     int offset, int avail, u16 ver)
 {
 	struct device *dev = &rproc->dev;
 	struct rproc_vdev *rvdev;
@@ -596,6 +597,7 @@ void rproc_vdev_release(struct kref *ref)
  * @rsc: the trace resource descriptor
  * @offset: offset of the resource entry
  * @avail: size of available data (for sanity checking the image)
+ * @ver: version number of the resource type
  *
  * In case the remote processor dumps trace logs into memory,
  * export it via debugfs.
@@ -608,7 +610,7 @@ void rproc_vdev_release(struct kref *ref)
  * Returns 0 on success, or an appropriate error code otherwise
  */
 static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
-			      int offset, int avail)
+			      int offset, int avail, u16 ver)
 {
 	struct rproc_debug_trace *trace;
 	struct device *dev = &rproc->dev;
@@ -662,6 +664,7 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
  * @rsc: the devmem resource entry
  * @offset: offset of the resource entry
  * @avail: size of available data (for sanity checking the image)
+ * @ver: version number of the resource type
  *
  * Remote processors commonly need to access certain on-chip peripherals.
  *
@@ -683,7 +686,7 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
  * are outside those ranges.
  */
 static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
-			       int offset, int avail)
+			       int offset, int avail, u16 ver)
 {
 	struct rproc_mem_entry *mapping;
 	struct device *dev = &rproc->dev;
@@ -865,6 +868,7 @@ static int rproc_release_carveout(struct rproc *rproc,
  * @rsc: the resource entry
  * @offset: offset of the resource entry
  * @avail: size of available data (for image validation)
+ * @ver: version number of the resource type
  *
  * This function will handle firmware requests for allocation of physically
  * contiguous memory regions.
@@ -880,7 +884,7 @@ static int rproc_release_carveout(struct rproc *rproc,
  */
 static int rproc_handle_carveout(struct rproc *rproc,
 				 struct fw_rsc_carveout *rsc,
-				 int offset, int avail)
+				 int offset, int avail, u16 ver)
 {
 	struct rproc_mem_entry *carveout;
 	struct device *dev = &rproc->dev;
@@ -1067,7 +1071,7 @@ static int rproc_handle_resources(struct rproc *rproc,
 			return -EINVAL;
 		}
 
-		dev_dbg(dev, "rsc: type %d\n", hdr->type);
+		dev_dbg(dev, "rsc: type %d vers %d\n", hdr->st.t, hdr->st.v);
 
 		if (hdr->type >= RSC_VENDOR_START &&
 		    hdr->type <= RSC_VENDOR_END) {
@@ -1083,16 +1087,17 @@ static int rproc_handle_resources(struct rproc *rproc,
 			continue;
 		}
 
-		if (hdr->type >= RSC_LAST) {
-			dev_warn(dev, "unsupported resource %d\n", hdr->type);
+		if (hdr->st.t >= RSC_LAST) {
+			dev_warn(dev, "unsupported resource %d\n", hdr->st.t);
 			continue;
 		}
 
-		handler = handlers[hdr->type];
+		handler = handlers[hdr->st.t];
 		if (!handler)
 			continue;
 
-		ret = handler(rproc, rsc, offset + sizeof(*hdr), avail);
+		ret = handler(rproc, rsc, offset + sizeof(*hdr), avail,
+			      hdr->st.v);
 		if (ret)
 			break;
 	}
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index d734cadb16e3..3560eed7a360 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -206,10 +206,11 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
 		struct fw_rsc_hdr *hdr = (void *)table + offset;
 		void *rsc = (void *)hdr + sizeof(*hdr);
 
-		switch (hdr->type) {
+		switch (hdr->st.t) {
 		case RSC_CARVEOUT:
 			c = rsc;
-			seq_printf(seq, "Entry %d is of type %s\n", i, types[hdr->type]);
+			seq_printf(seq, "Entry %d is of type %s\n",
+				   i, types[hdr->st.t]);
 			seq_printf(seq, "  Device Address 0x%x\n", c->da);
 			seq_printf(seq, "  Physical Address 0x%x\n", c->pa);
 			seq_printf(seq, "  Length 0x%x Bytes\n", c->len);
@@ -219,7 +220,8 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
 			break;
 		case RSC_DEVMEM:
 			d = rsc;
-			seq_printf(seq, "Entry %d is of type %s\n", i, types[hdr->type]);
+			seq_printf(seq, "Entry %d is of type %s\n",
+				   i, types[hdr->st.t]);
 			seq_printf(seq, "  Device Address 0x%x\n", d->da);
 			seq_printf(seq, "  Physical Address 0x%x\n", d->pa);
 			seq_printf(seq, "  Length 0x%x Bytes\n", d->len);
@@ -229,7 +231,8 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
 			break;
 		case RSC_TRACE:
 			t = rsc;
-			seq_printf(seq, "Entry %d is of type %s\n", i, types[hdr->type]);
+			seq_printf(seq, "Entry %d is of type %s\n",
+				   i, types[hdr->st.t]);
 			seq_printf(seq, "  Device Address 0x%x\n", t->da);
 			seq_printf(seq, "  Length 0x%x Bytes\n", t->len);
 			seq_printf(seq, "  Reserved (should be zero) [%d]\n", t->reserved);
@@ -237,8 +240,8 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
 			break;
 		case RSC_VDEV:
 			v = rsc;
-			seq_printf(seq, "Entry %d is of type %s\n", i, types[hdr->type]);
-
+			seq_printf(seq, "Entry %d is of type %s\n",
+				   i, types[hdr->st.t]);
 			seq_printf(seq, "  ID %d\n", v->id);
 			seq_printf(seq, "  Notify ID %d\n", v->notifyid);
 			seq_printf(seq, "  Device features 0x%x\n", v->dfeatures);
@@ -261,7 +264,7 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
 			break;
 		default:
 			seq_printf(seq, "Unknown resource type found: %d [hdr: %pK]\n",
-				   hdr->type, hdr);
+				   hdr->st.t, hdr);
 			break;
 		}
 	}
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 77788a4bb94e..526d3cb45e37 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -86,7 +86,13 @@ struct resource_table {
  * this header, and it should be parsed according to the resource type.
  */
 struct fw_rsc_hdr {
-	u32 type;
+	union {
+		u32 type;
+		struct {
+			u16 t;
+			u16 v;
+		} st;
+	};
 	u8 data[0];
 } __packed;
 
-- 
2.23.0

