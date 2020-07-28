Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A7AC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D525621883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgG1GGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:06:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34897 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727807AbgG1GGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:06:14 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 28 Jul 2020 09:06:08 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06S668is016851;
        Tue, 28 Jul 2020 09:06:08 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 06S6684t004236;
        Tue, 28 Jul 2020 09:06:08 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 06S668Cn004234;
        Tue, 28 Jul 2020 09:06:08 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com,
        Eli Cohen <eli@mellanox.com>
Subject: [PATCH V3 vhost next 07/10] vdpa/mlx5: Add hardware descriptive header file
Date:   Tue, 28 Jul 2020 09:05:36 +0300
Message-Id: <20200728060539.4163-8-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200728060539.4163-1-eli@mellanox.com>
References: <20200728060539.4163-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep all vdpa related hardware definitions in this file.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h | 168 +++++++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h b/drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
new file mode 100644
index 000000000000..f6f57a29b38e
--- /dev/null
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2020 Mellanox Technologies Ltd. */
+
+#ifndef __MLX5_VDPA_IFC_H_
+#define __MLX5_VDPA_IFC_H_
+
+#include <linux/mlx5/mlx5_ifc.h>
+
+enum {
+	MLX5_VIRTIO_Q_EVENT_MODE_NO_MSIX_MODE  = 0x0,
+	MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE       = 0x1,
+	MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE     = 0x2,
+};
+
+enum {
+	MLX5_VIRTIO_EMULATION_CAP_VIRTIO_QUEUE_TYPE_SPLIT   = 0x1, // do I check this caps?
+	MLX5_VIRTIO_EMULATION_CAP_VIRTIO_QUEUE_TYPE_PACKED  = 0x2,
+};
+
+enum {
+	MLX5_VIRTIO_EMULATION_VIRTIO_QUEUE_TYPE_SPLIT   = 0,
+	MLX5_VIRTIO_EMULATION_VIRTIO_QUEUE_TYPE_PACKED  = 1,
+};
+
+struct mlx5_ifc_virtio_q_bits {
+	u8    virtio_q_type[0x8];
+	u8    reserved_at_8[0x5];
+	u8    event_mode[0x3];
+	u8    queue_index[0x10];
+
+	u8    full_emulation[0x1];
+	u8    virtio_version_1_0[0x1];
+	u8    reserved_at_22[0x2];
+	u8    offload_type[0x4];
+	u8    event_qpn_or_msix[0x18];
+
+	u8    doorbell_stride_index[0x10];
+	u8    queue_size[0x10];
+
+	u8    device_emulation_id[0x20];
+
+	u8    desc_addr[0x40];
+
+	u8    used_addr[0x40];
+
+	u8    available_addr[0x40];
+
+	u8    virtio_q_mkey[0x20];
+
+	u8    max_tunnel_desc[0x10];
+	u8    reserved_at_170[0x8];
+	u8    error_type[0x8];
+
+	u8    umem_1_id[0x20];
+
+	u8    umem_1_size[0x20];
+
+	u8    umem_1_offset[0x40];
+
+	u8    umem_2_id[0x20];
+
+	u8    umem_2_size[0x20];
+
+	u8    umem_2_offset[0x40];
+
+	u8    umem_3_id[0x20];
+
+	u8    umem_3_size[0x20];
+
+	u8    umem_3_offset[0x40];
+
+	u8    counter_set_id[0x20];
+
+	u8    reserved_at_320[0x8];
+	u8    pd[0x18];
+
+	u8    reserved_at_340[0xc0];
+};
+
+struct mlx5_ifc_virtio_net_q_object_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    vhca_id[0x10];
+	u8    reserved_at_70[0x10];
+
+	u8    queue_feature_bit_mask_12_3[0xa];
+	u8    dirty_bitmap_dump_enable[0x1];
+	u8    vhost_log_page[0x5];
+	u8    reserved_at_90[0xc];
+	u8    state[0x4];
+
+	u8    reserved_at_a0[0x5];
+	u8    queue_feature_bit_mask_2_0[0x3];
+	u8    tisn_or_qpn[0x18];
+
+	u8    dirty_bitmap_mkey[0x20];
+
+	u8    dirty_bitmap_size[0x20];
+
+	u8    dirty_bitmap_addr[0x40];
+
+	u8    hw_available_index[0x10];
+	u8    hw_used_index[0x10];
+
+	u8    reserved_at_160[0xa0];
+
+	struct mlx5_ifc_virtio_q_bits virtio_q_context;
+};
+
+struct mlx5_ifc_create_virtio_net_q_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+
+	struct mlx5_ifc_virtio_net_q_object_bits obj_context;
+};
+
+struct mlx5_ifc_create_virtio_net_q_out_bits {
+	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
+};
+
+struct mlx5_ifc_destroy_virtio_net_q_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_out_cmd_hdr;
+};
+
+struct mlx5_ifc_destroy_virtio_net_q_out_bits {
+	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
+};
+
+struct mlx5_ifc_query_virtio_net_q_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+};
+
+struct mlx5_ifc_query_virtio_net_q_out_bits {
+	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
+
+	struct mlx5_ifc_virtio_net_q_object_bits obj_context;
+};
+
+enum {
+	MLX5_VIRTQ_MODIFY_MASK_STATE                    = (u64)1 << 0,
+	MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      = (u64)1 << 3,
+	MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE = (u64)1 << 4,
+};
+
+enum {
+	MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT     = 0x0,
+	MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY      = 0x1,
+	MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND  = 0x2,
+	MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
+};
+
+enum {
+	MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
+	MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
+};
+
+struct mlx5_ifc_modify_virtio_net_q_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+
+	struct mlx5_ifc_virtio_net_q_object_bits obj_context;
+};
+
+struct mlx5_ifc_modify_virtio_net_q_out_bits {
+	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
+};
+
+#endif /* __MLX5_VDPA_IFC_H_ */
-- 
2.26.0

