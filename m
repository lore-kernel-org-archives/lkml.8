Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B12C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040502063A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CtWGgPeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHRFdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:33:10 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:42135 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:33:04 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200818053257epoutp03ec4e98511c407e186e9c35783a47bce1~sRdu4OSP71275712757epoutp03U
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:32:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200818053257epoutp03ec4e98511c407e186e9c35783a47bce1~sRdu4OSP71275712757epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597728777;
        bh=mUhWs/szW1dp7nKde28/YKeiZ68yJmth1pYSH4yoEno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtWGgPeS9OEjkJAMtdl1G9USPfobK9CytUNThh6Yfz8chGelQ43L/zolIJIzel+z5
         5zIsOMWs2OwKah9Q8eKYt9KI3XkxQGM5XOKKV5E7aZnhKqHNfyWcVWRDnvaOVK2SRG
         39cOBha1nCUDni0iUUQ+VtE0K18zScJ/INU6rEtE=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200818053257epcas5p2287d066f8952aa8b17ad6eaad32283d8~sRduPNwfZ1442114421epcas5p2j;
        Tue, 18 Aug 2020 05:32:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.E9.09467.8086B3F5; Tue, 18 Aug 2020 14:32:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f~sRdtmErcA1620816208epcas5p4Q;
        Tue, 18 Aug 2020 05:32:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200818053256epsmtrp257ca3496ada7d01be97a3fafe4c08fbf~sRdtlRoII2801128011epsmtrp2T;
        Tue, 18 Aug 2020 05:32:56 +0000 (GMT)
X-AuditID: b6c32a49-a29ff700000024fb-a2-5f3b68087e50
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.DA.08382.8086B3F5; Tue, 18 Aug 2020 14:32:56 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200818053254epsmtip2bfd705b2716ae64d11537fc713b7658e~sRdrmIhzh2096320963epsmtip2G;
        Tue, 18 Aug 2020 05:32:54 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     kbusch@kernel.org, hch@lst.de, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: [PATCH 2/2] nvme: add emulation for zone-append
Date:   Tue, 18 Aug 2020 10:59:36 +0530
Message-Id: <20200818052936.10995-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818052936.10995-1-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZdlhTQ5czwzre4OVMRovf06ewWqy+289m
        0dr+jcli5eqjTBaP73xmt/jbdY/J4uj/t2wWkw5dY7S4vGsOm8X8ZU/ZLbb9ns9scWXKImaL
        da/fs1i8/nGSzYHP4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHn1bVjF6fN4k59F+oJspgCOK
        yyYlNSezLLVI3y6BK+Piw4SCxc2MFVuu3mJuYNyT08XIySEhYCLxfeZjli5GLg4hgd2MEodO
        zmeFcD4xSjz8cJcRwvnGKLH40zagDAdYS9+FYIj4XkaJKzPPQ3W0Mkmc2v+cBaSITUBT4sLk
        UpAVIgKxEjMudYOtYBZoYpI4eew/K0hCWMBCouvbEWYQm0VAVWLli0tgNi9Q/F/zHjaI++Ql
        Vm84ABbnFLCU+HryP9ggCYFeDokj/y+yQhS5SFzofw7VICzx6vgWdghbSuLzu71Q8WKJX3eO
        MkM0dzBKXG+YyQKRsJe4uOcvE8jVzEBXr9+lDxJmFuCT6P39hAniY16JjjYhiGpFiXuTnkKt
        FZd4OGMJlO0h8bdrDTMkIHoYJR4vPco+gVF2FsLUBYyMqxglUwuKc9NTi00LDPNSy/WKE3OL
        S/PS9ZLzczcxglOLlucOxrsPPugdYmTiYDzEKMHBrCTCm3TCPF6INyWxsiq1KD++qDQntfgQ
        ozQHi5I4r9KPM3FCAumJJanZqakFqUUwWSYOTqkGptpwC/7q9AY2pTvdf3NkjAK3beD2X8I8
        1Vd0TqTLDHaPT49Tsm8sWx8W3P1i05vPW/Mccqf5HdijOGF1gcLCRc9sX0wpb23++Uhnca+E
        kM/2p+v3xTff/KDokTQrYVPu90i172GbDJQOGWzyC+Wb2azWvag8c853FfvYaHPxV8qnc59d
        u7fN4v7ESR75D9+Vr3Ri/rLj/bG4Jzu7jS4s+dy3ed8D84tJSdveHZ08++Kzb5+NVKeUz9Be
        cHuedefjiMnfP11JOM2/gqVF2FhqF599wXq7TBf7gybW1sKKLIFbZHxkitTPBV+xd+wIvN5h
        lcpZs+i8Z+Yf/pYLF2Wer3hpdmXtOfnP+mKP/xyZ9keJpTgj0VCLuag4EQB3RTGenAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSvC5HhnW8wemp/Ba/p09htVh9t5/N
        orX9G5PFytVHmSwe3/nMbvG36x6TxdH/b9ksJh26xmhxedccNov5y56yW2z7PZ/Z4sqURcwW
        616/Z7F4/eMkmwOfx/l7G1k8Lp8t9di0qpPNY/OSeo/dNxvYPPq2rGL0+LxJzqP9QDdTAEcU
        l01Kak5mWWqRvl0CV8bFhwkFi5sZK7ZcvcXcwLgnp4uRg0NCwESi70JwFyMnh5DAbkaJfX8i
        QGwJAXGJ5ms/2CFsYYmV/54D2VxANc1MEqc6VjGB9LIJaEpcmFwKUiMikCzRumgvC4jNLNDB
        JDFxtj+ILSxgIdH17QgziM0ioCqx8sUlMJsXKP6veQ8bxHx5idUbDoDFOQUsJb6e/M8CcY+F
        xL5VF5kmMPItYGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHNBamjsYt6/6oHeI
        kYmD8RCjBAezkghv0gnzeCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8NwoXxgkJpCeWpGanphak
        FsFkmTg4pRqYklZyLpWMulF/hs/9+fKLW8y8Dy//XJK8NCQp9zqTaut8hf//D1q8+Jq6d/qC
        iuPMtovzVDzXRaWc36CjsIjpan/O0+cLd0i63dgySUotK6aSc9t/q4X/Fz2bwXVY7rlz6Wb7
        M8tCOTaYPFQU4L3FG/BH5EPMpsBfU8sf9xo7vJu0LSJ6R5r80fNh/hf4C/7d5ezbL8rsk3E7
        uPHLrTpdyWmKmny7D7iHVWUfTc/gmrC5+kzAo0k3j7N+VbyR29dTmjL7f8D2pgvW6UFPaz+p
        zmH4pLzhxMtL/PJl/wOFc5Zv/7W4eu/eLw9COtfyeqW0LnjpFK/1JnfnvIColYwTHBIDmgzv
        Bbdffb/ETa9eRYmlOCPRUIu5qDgRABqRKPHXAgAA
X-CMS-MailID: 20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f
References: <20200818052936.10995-1-joshi.k@samsung.com>
        <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If drive does not support zone-append natively, enable emulation using
regular write.
Make emulated zone-append cmd write-lock the zone, preventing
concurrent append/write on the same zone.

To determine the start-lba for such writes, an array of 32 bit
zone-relative write-pointer (WP) positions is attached with namespace.
This cached WP-position is updated on successful completion as follows:
- APPEND/WRITE/WRITE_ZEROS/WRITE_SAME update it by number of sectors
(512b) copied
- ZONE_RESET updates it to 0 for target zone. ZONE_RESET_ALL does the
same for all zones.
- ZONE_FINISH sets it to zone-size.

On failed-completion for above requests, cached WP-position of target zone
is marked invalid. On subsequent zone-append to that zone, WP position is
refreshed by querying it from device (i.e. zone-report).

If emulated-append cannot immediately proceed due to zone write-lock
or invalid WP position, block-layer is asked to retry it.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c |  41 +++++-
 drivers/nvme/host/nvme.h |  60 ++++++++
 drivers/nvme/host/zns.c  | 306 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 398 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4..78faddf444c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -287,10 +287,17 @@ void nvme_complete_rq(struct request *req)
 			nvme_retry_req(req);
 			return;
 		}
-	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-		   req_op(req) == REQ_OP_ZONE_APPEND) {
-		req->__sector = nvme_lba_to_sect(req->q->queuedata,
-			le64_to_cpu(nvme_req(req)->result.u64));
+	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+		bool need_wp_offset_update = false;
+		struct nvme_ns *ns = req->q->queuedata;
+		/* append-emulation requires wp update for some cmds*/
+		if (ns && nvme_is_append_emulated(ns))
+			need_wp_offset_update = nvme_need_zone_wp_update(req);
+		if (need_wp_offset_update)
+			nvme_zone_wp_update(ns, req, status);
+		else if (req_op(req) == REQ_OP_ZONE_APPEND)
+			req->__sector = nvme_lba_to_sect(ns,
+					le64_to_cpu(nvme_req(req)->result.u64));
 	}
 
 	nvme_trace_bio_complete(req, status);
@@ -456,6 +463,8 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	if (nvme_is_append_emulated(ns))
+		nvme_teardown_append_emulate(ns);
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
 
@@ -809,7 +818,15 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
 		break;
 	case REQ_OP_ZONE_APPEND:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
+		if (!nvme_is_append_emulated(ns))
+			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
+		else {
+			/* prepare append like write, and adjust lba afterwards */
+			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
+			if (ret)
+				break;
+			ret = nvme_append_to_write(ns, req, cmd);
+		}
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -2150,7 +2167,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		struct nvme_ns *ns = disk->private_data;
 		struct nvme_ctrl *ctrl = ns->ctrl;
 
-		ret = blk_revalidate_disk_zones(disk, NULL);
+		ret = nvme_revalidate_disk_zones(disk);
 		if (!ret)
 			blk_queue_max_zone_append_sectors(disk->queue,
 							  ctrl->max_zone_append);
@@ -3900,6 +3917,18 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (__nvme_revalidate_disk(disk, id))
 		goto out_put_disk;
 
+	/* setup append-emulation if required */
+	if (nvme_is_append_emulated(ns)) {
+		ret = nvme_setup_append_emulate(ns);
+		if (ret) {
+			dev_warn(ns->ctrl->device,
+				"append-emulation failed, zoned namespace:%d\n",
+				ns->head->ns_id);
+			nvme_clear_append_emulated(ns);
+			goto out_put_disk;
+		}
+	}
+
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		ret = nvme_nvm_register(ns, disk_name, node);
 		if (ret) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ebb8c3ed3885..c84d418fb001 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -421,6 +421,19 @@ enum nvme_ns_features {
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
 };
 
+#ifdef CONFIG_BLK_DEV_ZONED
+struct nvme_za_emul {
+	unsigned int nr_zones;
+	spinlock_t zones_wp_offset_lock;
+	u32 *zones_wp_offset;
+	u32 *rev_wp_offset;
+	struct work_struct zone_wp_offset_work;
+	char *zone_wp_update_buf;
+	struct mutex rev_mutex;
+	struct nvme_ns *ns;
+};
+#endif
+
 struct nvme_ns {
 	struct list_head list;
 
@@ -443,6 +456,10 @@ struct nvme_ns {
 	u8 pi_type;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64 zsze;
+	/* set if append needs to be emulated */
+	u8 append_emulate;
+	/* contains all other append-emulation fields */
+	struct nvme_za_emul *za_emul;
 #endif
 	unsigned long features;
 	unsigned long flags;
@@ -759,9 +776,52 @@ int nvme_report_zones(struct gendisk *disk, sector_t sector,
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 				       struct nvme_command *cmnd,
 				       enum nvme_zone_mgmt_action action);
+
+int nvme_revalidate_disk_zones(struct gendisk *disk);
+/* append-emulation only helpers */
+int nvme_setup_append_emulate(struct nvme_ns *ns);
+void nvme_teardown_append_emulate(struct nvme_ns *ns);
+blk_status_t nvme_append_to_write(struct nvme_ns *ns, struct request *req,
+				  struct nvme_command *cmd);
+bool nvme_need_zone_wp_update(struct request *rq);
+void nvme_zone_wp_update(struct nvme_ns *ns, struct request *rq,
+			 blk_status_t status);
+void nvme_set_append_emulated(struct nvme_ns *ns);
+void nvme_clear_append_emulated(struct nvme_ns *ns);
+int nvme_is_append_emulated(struct nvme_ns *ns);
 #else
 #define nvme_report_zones NULL
 
+static inline void nvme_set_append_emulated(struct nvme_ns *ns) {}
+
+static inline void nvme_clear_append_emulated(struct nvme_ns *ns) {}
+
+static inline int nvme_is_append_emulated(struct nvme_ns *ns)
+{
+	return 0;
+}
+
+static inline int nvme_setup_append_emulate(struct nvme_ns *ns)
+{
+	return 0;
+}
+
+static inline void nvme_teardown_append_emulate(struct nvme_ns *ns) {}
+
+static inline blk_status_t nvme_append_to_write(struct nvme_ns *ns, struct request *req,
+						struct nvme_command *cmd)
+{
+	return BLK_STS_NOTSUPP;
+}
+
+static inline bool nvme_need_zone_wp_update(struct request *rq)
+{
+	return false;
+}
+
+static inline void nvme_zone_wp_update(struct nvme_ns *ns, struct request *rq,
+			 blk_status_t status) {}
+
 static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_zone_mgmt_action action)
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index cabd870fb64e..0b1e9f62045a 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -7,6 +7,10 @@
 #include <linux/vmalloc.h>
 #include "nvme.h"
 
+/* used for append-emulation */
+#define ZNS_INVALID_WP_OFST  (~0u)
+#define ZNS_UPDATING_WP_OFST (ZNS_INVALID_WP_OFST - 1)
+
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 {
 	struct nvme_command c = { };
@@ -44,13 +48,14 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	struct nvme_id_ns_zns *id;
 	int status;
 
-	/* Driver requires zone append support */
+	/* Driver does append-emulation if drive does not support zone-append */
 	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
 			NVME_CMD_EFFECTS_CSUPP)) {
 		dev_warn(ns->ctrl->device,
-			"append not supported for zoned namespace:%d\n",
+			"append is emulated for zoned namespace:%d\n",
 			ns->head->ns_id);
-		return -EINVAL;
+		/* activate append-emulation */
+		nvme_set_append_emulated(ns);
 	}
 
 	/* Lazily query controller append limit for the first zoned namespace */
@@ -255,3 +260,298 @@ blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 
 	return BLK_STS_OK;
 }
+
+static void nvme_revalidate_zones_cb(struct gendisk *disk)
+{
+	struct nvme_ns_head *head = NULL;
+	struct nvme_ns *ns;
+	int srcu_idx;
+
+	ns = nvme_get_ns_from_disk(disk, &head, &srcu_idx);
+	swap(ns->za_emul->zones_wp_offset, ns->za_emul->rev_wp_offset);
+	nvme_put_ns_from_disk(head, srcu_idx);
+}
+
+inline int nvme_is_append_emulated(struct nvme_ns *ns)
+{
+	return (ns->append_emulate == 1);
+}
+
+inline void nvme_set_append_emulated(struct nvme_ns *ns)
+{
+	ns->append_emulate = 1;
+}
+
+inline void nvme_clear_append_emulated(struct nvme_ns *ns)
+{
+	ns->append_emulate = 0;
+}
+
+int nvme_revalidate_disk_zones(struct gendisk *disk)
+{
+	int ret = 0;
+	struct nvme_ns *ns = disk->private_data;
+
+	if (!nvme_is_append_emulated(ns))
+		ret = blk_revalidate_disk_zones(disk, NULL);
+	else {
+		struct nvme_za_emul *za_emul = ns->za_emul;
+		unsigned int nr_zones;
+
+		/* serialize multiple revalidate calls */
+		mutex_lock(&za_emul->rev_mutex);
+		nr_zones = get_capacity(disk) >> ilog2(ns->zsze);
+
+		/* avoid rescan zones if possible */
+		if (nr_zones == za_emul->nr_zones &&
+				disk->queue->nr_zones == nr_zones) {
+			mutex_unlock(&za_emul->rev_mutex);
+			goto out;
+		}
+		za_emul->rev_wp_offset = kvcalloc(nr_zones,
+						sizeof(u32), GFP_NOIO);
+		if (!za_emul->rev_wp_offset) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		ret = blk_revalidate_disk_zones(disk,
+				nvme_revalidate_zones_cb);
+		/* rev_wp_offset has been swapped with zones_wp_offset */
+		kvfree(za_emul->rev_wp_offset);
+		za_emul->rev_wp_offset = NULL;
+unlock:
+		mutex_unlock(&za_emul->rev_mutex);
+	}
+out:
+	return ret;
+}
+
+static unsigned int nvme_get_zone_wp_offset(struct blk_zone *zone)
+{
+	switch (zone->cond) {
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
+		return zone->wp - zone->start;
+	case BLK_ZONE_COND_FULL:
+		return zone->len;
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+	default:
+		/*
+		 * Offline and read-only zones do not have a valid
+		 * write pointer. Use 0 as for an empty zone.
+		 */
+		return 0;
+	}
+}
+
+static int nvme_update_wp_offset_cb(struct blk_zone *zone, unsigned int idx,
+				    void *data)
+{
+	struct nvme_za_emul *za_emul = data;
+
+	lockdep_assert_held(&za_emul->zones_wp_offset_lock);
+	za_emul->zones_wp_offset[idx] = nvme_get_zone_wp_offset(zone);
+	return 0;
+}
+
+static void nvme_update_wp_offset_workfn(struct work_struct *work)
+{
+	struct nvme_za_emul *za_emul;
+	struct nvme_ns *ns;
+	unsigned int zno;
+	unsigned long flags;
+	struct nvme_zone_report *report;
+	int buflen, ret;
+
+	buflen = sizeof(struct nvme_zone_report) +
+				   sizeof(struct nvme_zone_descriptor);
+	za_emul = container_of(work, struct nvme_za_emul, zone_wp_offset_work);
+	ns = za_emul->ns;
+
+	spin_lock_irqsave(&za_emul->zones_wp_offset_lock, flags);
+
+	for (zno = 0; zno < za_emul->nr_zones; zno++) {
+		if (za_emul->zones_wp_offset[zno] != ZNS_UPDATING_WP_OFST)
+			continue;
+		spin_unlock_irqrestore(&za_emul->zones_wp_offset_lock, flags);
+
+		report = (struct nvme_zone_report *)za_emul->zone_wp_update_buf;
+		memset(report, 0, buflen);
+		ret = __nvme_ns_report_zones(ns, (zno * ns->zsze),
+					     report,
+					     buflen);
+
+		spin_lock_irqsave(&za_emul->zones_wp_offset_lock, flags);
+		if (ret > 0)
+			nvme_zone_parse_entry(ns, &report->entries[0],
+					    zno, nvme_update_wp_offset_cb,
+					    za_emul);
+	}
+	spin_unlock_irqrestore(&za_emul->zones_wp_offset_lock, flags);
+	/* remove the reference obtained earlier */
+	nvme_put_ns(ns);
+}
+
+blk_status_t nvme_append_to_write(struct nvme_ns *ns, struct request *req,
+				  struct nvme_command *cmd)
+{
+	blk_status_t ret = 0;
+	struct nvme_za_emul *za_emul = ns->za_emul;
+	unsigned int nr_sectors = (blk_rq_bytes(req) >> SECTOR_SHIFT);
+	unsigned int wp_offset, zno = blk_rq_zone_no(req);
+	sector_t lba = blk_rq_pos(req);
+	unsigned long flags;
+
+	if (!blk_req_zone_write_trylock(req))
+		return BLK_STS_RESOURCE;
+
+	spin_lock_irqsave(&za_emul->zones_wp_offset_lock, flags);
+	wp_offset = za_emul->zones_wp_offset[zno];
+	switch (wp_offset) {
+	case ZNS_INVALID_WP_OFST:
+		/*
+		 * update zone wp-offset in a deferred worker.
+		 * postpone processing current request until worker manages
+		 * to refresh wp by querying from device.
+		 */
+		kref_get(&ns->kref);
+		za_emul->zones_wp_offset[zno] = ZNS_UPDATING_WP_OFST;
+		queue_work(nvme_wq, &za_emul->zone_wp_offset_work);
+		fallthrough;
+	case ZNS_UPDATING_WP_OFST:
+		ret = BLK_STS_RESOURCE;
+		break;
+	default:
+		if (wp_offset + nr_sectors > ns->zsze) {
+			ret = BLK_STS_IOERR;
+			break;
+		}
+		lba += wp_offset;
+	}
+	spin_unlock_irqrestore(&za_emul->zones_wp_offset_lock, flags);
+	/* unlock zone in case of error, update lba otherwise */
+	if (ret)
+		blk_req_zone_write_unlock(req);
+	else
+		cmd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, lba));
+	return ret;
+}
+
+bool nvme_need_zone_wp_update(struct request *rq)
+{
+	switch (req_op(rq)) {
+	case REQ_OP_ZONE_APPEND:
+	case REQ_OP_ZONE_FINISH:
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
+		return true;
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_WRITE_SAME:
+		return blk_rq_zone_is_seq(rq);
+	default:
+		return false;
+	}
+}
+
+void nvme_zone_wp_update(struct nvme_ns *ns, struct request *rq,
+			 blk_status_t status)
+{
+	struct nvme_za_emul *za_emul = ns->za_emul;
+	unsigned long flags;
+	unsigned int zno = blk_rq_zone_no(rq);
+	enum req_opf op = req_op(rq);
+	unsigned int res_bytes = blk_rq_bytes(rq);
+
+	spin_lock_irqsave(&za_emul->zones_wp_offset_lock, flags);
+	/*
+	 * Failure handling first, mark wp_offset invalid.
+	 * This will force updating wp from device on subsequent access
+	 */
+	if (status) {
+		if (op != REQ_OP_ZONE_RESET_ALL) {
+			if (za_emul->zones_wp_offset[zno] !=
+					ZNS_UPDATING_WP_OFST)
+				za_emul->zones_wp_offset[zno] = ZNS_INVALID_WP_OFST;
+
+		} else
+			memset(za_emul->zones_wp_offset, ZNS_INVALID_WP_OFST,
+				za_emul->nr_zones * sizeof(unsigned int));
+		goto unlock;
+	}
+	/* success case handling, update wp-offset */
+	switch (op) {
+	case REQ_OP_ZONE_APPEND:
+		rq->__sector += za_emul->zones_wp_offset[zno];
+		fallthrough;
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_WRITE_SAME:
+	case REQ_OP_WRITE:
+		/* every write should update the wp_offset */
+		if (za_emul->zones_wp_offset[zno] < ns->zsze)
+			za_emul->zones_wp_offset[zno] +=
+						res_bytes >> SECTOR_SHIFT;
+		break;
+	case REQ_OP_ZONE_RESET:
+		za_emul->zones_wp_offset[zno] = 0;
+		break;
+	case REQ_OP_ZONE_FINISH:
+		za_emul->zones_wp_offset[zno] = ns->zsze;
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		memset(za_emul->zones_wp_offset, 0,
+		       za_emul->nr_zones * sizeof(unsigned int));
+		break;
+	default:
+		break;
+	}
+unlock:
+	spin_unlock_irqrestore(&za_emul->zones_wp_offset_lock, flags);
+	/* release zone write-lock for append */
+	if (op == REQ_OP_ZONE_APPEND)
+		blk_req_zone_write_unlock(rq);
+}
+
+int nvme_setup_append_emulate(struct nvme_ns *ns)
+{
+	struct nvme_za_emul *za_emul;
+	size_t bufsize;
+
+	WARN_ON(ns->za_emul);
+	za_emul = kmalloc(sizeof(struct nvme_za_emul), GFP_KERNEL);
+	if (!za_emul)
+		return -ENOMEM;
+
+	za_emul->zones_wp_offset = NULL;
+	spin_lock_init(&za_emul->zones_wp_offset_lock);
+	za_emul->rev_wp_offset = NULL;
+	mutex_init(&za_emul->rev_mutex);
+	INIT_WORK(&za_emul->zone_wp_offset_work, nvme_update_wp_offset_workfn);
+	/* preallocate buffer for single zone-report */
+	bufsize = sizeof(struct nvme_zone_report) +
+			sizeof(struct nvme_zone_descriptor);
+	za_emul->zone_wp_update_buf = kzalloc(bufsize, GFP_KERNEL);
+	if (!za_emul->zone_wp_update_buf) {
+		kfree(za_emul);
+		return -ENOMEM;
+	}
+	za_emul->nr_zones = get_capacity(ns->disk) >> ilog2(ns->zsze);
+
+	ns->za_emul = za_emul;
+	za_emul->ns = ns;
+
+	return 0;
+}
+
+void nvme_teardown_append_emulate(struct nvme_ns *ns)
+{
+	WARN_ON(!ns->za_emul);
+	kvfree(ns->za_emul->zones_wp_offset);
+	kfree(ns->za_emul->zone_wp_update_buf);
+	ns->za_emul->zones_wp_offset = NULL;
+	ns->za_emul->rev_wp_offset = NULL;
+	kfree(ns->za_emul);
+}
-- 
2.17.1

