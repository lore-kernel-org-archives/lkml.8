Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE64C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D680C2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877186;
	bh=BAszGG+DTOlyS0kCl+6JphswFfRjGJgoGAsHyQBqMOA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=d7RL46qYe58Hm3d85kWq7SKxQ3pJI7W/iG1mnOu0l4Ly94qE/1cixd7kKvzGmAWAk
	 1vP4hXFw376Fug7HkZS0ZrJ266FBCdBNmtjO4VNq+Xg9aUwq7amLEsGnwfuIlPpv1p
	 p/u0hRBh+NGkQ0PBPlv0gYfz7n4vaVGdyN7SQBVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgEGSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEGSqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:46:25 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039B9216FD;
        Thu,  7 May 2020 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877184;
        bh=BAszGG+DTOlyS0kCl+6JphswFfRjGJgoGAsHyQBqMOA=;
        h=Date:From:To:Cc:Subject:From;
        b=uIoCjQSHnTZORL1yOSkWc16nPMM3BKxY+n2f0COZl4NBDdU62Kd4sBuAUswTFlPP/
         khvF95KhPuJt1uamOwuioxv5NkfmvVIQDxq9dsOApJM3FPlA6xSHSxtj+j3Qou6E6G
         p68YYsq3b9nUP9etw3ruxaeE8Smo720E8GPEGg2s=
Date:   Thu, 7 May 2020 13:50:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Replace zero-length array with flexible-array
Message-ID: <20200507185050.GA13953@embeddedor>
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
 include/net/bluetooth/l2cap.h |    6 +++---
 include/net/bluetooth/mgmt.h  |   40 ++++++++++++++++++++--------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index dada14d0622c..8f1e6a7a2df8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -499,7 +499,7 @@ struct l2cap_ecred_conn_req {
 	__le16 mtu;
 	__le16 mps;
 	__le16 credits;
-	__le16 scid[0];
+	__le16 scid[];
 } __packed;
 
 struct l2cap_ecred_conn_rsp {
@@ -507,13 +507,13 @@ struct l2cap_ecred_conn_rsp {
 	__le16 mps;
 	__le16 credits;
 	__le16 result;
-	__le16 dcid[0];
+	__le16 dcid[];
 };
 
 struct l2cap_ecred_reconf_req {
 	__le16 mtu;
 	__le16 mps;
-	__le16 scid[0];
+	__le16 scid[];
 } __packed;
 
 #define L2CAP_RECONF_SUCCESS		0x0000
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f41cd87550dc..e104329e227f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -70,14 +70,14 @@ struct mgmt_rp_read_version {
 struct mgmt_rp_read_commands {
 	__le16	num_commands;
 	__le16	num_events;
-	__le16	opcodes[0];
+	__le16	opcodes[];
 } __packed;
 
 #define MGMT_OP_READ_INDEX_LIST		0x0003
 #define MGMT_READ_INDEX_LIST_SIZE	0
 struct mgmt_rp_read_index_list {
 	__le16	num_controllers;
-	__le16	index[0];
+	__le16	index[];
 } __packed;
 
 /* Reserve one extra byte for names in management messages so that they
@@ -183,7 +183,7 @@ struct mgmt_link_key_info {
 struct mgmt_cp_load_link_keys {
 	__u8	debug_keys;
 	__le16	key_count;
-	struct	mgmt_link_key_info keys[0];
+	struct	mgmt_link_key_info keys[];
 } __packed;
 #define MGMT_LOAD_LINK_KEYS_SIZE	3
 
@@ -206,7 +206,7 @@ struct mgmt_ltk_info {
 #define MGMT_OP_LOAD_LONG_TERM_KEYS	0x0013
 struct mgmt_cp_load_long_term_keys {
 	__le16	key_count;
-	struct	mgmt_ltk_info keys[0];
+	struct	mgmt_ltk_info keys[];
 } __packed;
 #define MGMT_LOAD_LONG_TERM_KEYS_SIZE	2
 
@@ -223,7 +223,7 @@ struct mgmt_rp_disconnect {
 #define MGMT_GET_CONNECTIONS_SIZE	0
 struct mgmt_rp_get_connections {
 	__le16 conn_count;
-	struct mgmt_addr_info addr[0];
+	struct mgmt_addr_info addr[];
 } __packed;
 
 #define MGMT_OP_PIN_CODE_REPLY		0x0016
@@ -413,7 +413,7 @@ struct mgmt_irk_info {
 #define MGMT_OP_LOAD_IRKS		0x0030
 struct mgmt_cp_load_irks {
 	__le16 irk_count;
-	struct mgmt_irk_info irks[0];
+	struct mgmt_irk_info irks[];
 } __packed;
 #define MGMT_LOAD_IRKS_SIZE		2
 
@@ -465,7 +465,7 @@ struct mgmt_conn_param {
 #define MGMT_OP_LOAD_CONN_PARAM		0x0035
 struct mgmt_cp_load_conn_param {
 	__le16 param_count;
-	struct mgmt_conn_param params[0];
+	struct mgmt_conn_param params[];
 } __packed;
 #define MGMT_LOAD_CONN_PARAM_SIZE	2
 
@@ -473,7 +473,7 @@ struct mgmt_cp_load_conn_param {
 #define MGMT_READ_UNCONF_INDEX_LIST_SIZE 0
 struct mgmt_rp_read_unconf_index_list {
 	__le16	num_controllers;
-	__le16	index[0];
+	__le16	index[];
 } __packed;
 
 #define MGMT_OPTION_EXTERNAL_CONFIG	0x00000001
@@ -504,7 +504,7 @@ struct mgmt_cp_start_service_discovery {
 	__u8 type;
 	__s8 rssi;
 	__le16 uuid_count;
-	__u8 uuids[0][16];
+	__u8 uuids[][16];
 } __packed;
 #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
 
@@ -516,7 +516,7 @@ struct mgmt_cp_read_local_oob_ext_data {
 struct mgmt_rp_read_local_oob_ext_data {
 	__u8    type;
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_OP_READ_EXT_INDEX_LIST	0x003C
@@ -527,7 +527,7 @@ struct mgmt_rp_read_ext_index_list {
 		__le16 index;
 		__u8   type;
 		__u8   bus;
-	} entry[0];
+	} entry[];
 } __packed;
 
 #define MGMT_OP_READ_ADV_FEATURES	0x0003D
@@ -538,7 +538,7 @@ struct mgmt_rp_read_adv_features {
 	__u8   max_scan_rsp_len;
 	__u8   max_instances;
 	__u8   num_instances;
-	__u8   instance[0];
+	__u8   instance[];
 } __packed;
 
 #define MGMT_OP_ADD_ADVERTISING		0x003E
@@ -549,7 +549,7 @@ struct mgmt_cp_add_advertising {
 	__le16	timeout;
 	__u8	adv_data_len;
 	__u8	scan_rsp_len;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 #define MGMT_ADD_ADVERTISING_SIZE	11
 struct mgmt_rp_add_advertising {
@@ -603,7 +603,7 @@ struct mgmt_rp_read_ext_info {
 	__le32   supported_settings;
 	__le32   current_settings;
 	__le16   eir_len;
-	__u8     eir[0];
+	__u8     eir[];
 } __packed;
 
 #define MGMT_OP_SET_APPEARANCE		0x0043
@@ -668,7 +668,7 @@ struct mgmt_blocked_key_info {
 
 struct mgmt_cp_set_blocked_keys {
 	__le16 key_count;
-	struct mgmt_blocked_key_info keys[0];
+	struct mgmt_blocked_key_info keys[];
 } __packed;
 #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
 
@@ -678,7 +678,7 @@ struct mgmt_cp_set_blocked_keys {
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
 	__u8	status;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 #define MGMT_EV_CMD_STATUS		0x0002
@@ -726,7 +726,7 @@ struct mgmt_ev_device_connected {
 	struct mgmt_addr_info addr;
 	__le32	flags;
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_DEV_DISCONN_UNKNOWN	0x00
@@ -781,7 +781,7 @@ struct mgmt_ev_device_found {
 	__s8	rssi;
 	__le32	flags;
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_EV_DISCOVERING		0x0013
@@ -876,7 +876,7 @@ struct mgmt_ev_ext_index {
 struct mgmt_ev_local_oob_data_updated {
 	__u8    type;
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_EV_ADVERTISING_ADDED	0x0023
@@ -892,7 +892,7 @@ struct mgmt_ev_advertising_removed {
 #define MGMT_EV_EXT_INFO_CHANGED	0x0025
 struct mgmt_ev_ext_info_changed {
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_EV_PHY_CONFIGURATION_CHANGED	0x0026

