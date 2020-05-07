Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE32C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A048124955
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877334;
	bh=qylbDRsntGWPRgUzAPfrpXGHGujqYbo7tiGdRDdqAcE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sqSrf4yh+kk+oLq9Csne6fctY4lO1NOi7DRAZXgak+2xK0UPGu+eT9Y477kwDDr+V
	 ziDHQWIzwUE8jpEzJR3GomrWQ4tITg0B7ZE9CaaYA1uVdmxzJRlomXHx4+ayE1XO/u
	 I0glMyS95lPF9HLiIslklcaA8dwIwobDE8fMDGLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgEGSsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbgEGSsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:48:53 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B3824955;
        Thu,  7 May 2020 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877332;
        bh=qylbDRsntGWPRgUzAPfrpXGHGujqYbo7tiGdRDdqAcE=;
        h=Date:From:To:Cc:Subject:From;
        b=GDuHys9ZHGrzXugt0UCQw73EaB8XjvL7K7wQTxA51gV8Sa3I7fcnBDhakopF2Z8Sx
         1L96KEUzPFM4FS+N7x/PBz7fV/0RMYIK1AkSQIBC7LRVsWZT95dMLOaTsL8YaPul2X
         7FsZcXzhsfl+3DZMgbKZNQG6dMphYG+/yDrS1QiI=
Date:   Thu, 7 May 2020 13:53:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: Replace zero-length array with
 flexible-array
Message-ID: <20200507185318.GA14393@embeddedor>
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
 drivers/greybus/arpc.h                    |    2 -
 include/linux/greybus/greybus_protocols.h |   44 +++++++++++++++---------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/greybus/arpc.h b/drivers/greybus/arpc.h
index c8b83c5cfa79..b9ea81b55b29 100644
--- a/drivers/greybus/arpc.h
+++ b/drivers/greybus/arpc.h
@@ -21,7 +21,7 @@ struct arpc_request_message {
 	__le16	id;		/* RPC unique id */
 	__le16	size;		/* Size in bytes of header + payload */
 	__u8	type;		/* RPC type */
-	__u8	data[0];	/* ARPC data */
+	__u8	data[];	/* ARPC data */
 } __packed;
 
 struct arpc_response_message {
diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
index dfbc6c39a74b..aeb8f9243545 100644
--- a/include/linux/greybus/greybus_protocols.h
+++ b/include/linux/greybus/greybus_protocols.h
@@ -345,7 +345,7 @@ struct gb_cap_get_ims_certificate_request {
 
 struct gb_cap_get_ims_certificate_response {
 	__u8			result_code;
-	__u8			certificate[0];
+	__u8			certificate[];
 } __packed;
 
 /* CAP authenticate request/response */
@@ -358,7 +358,7 @@ struct gb_cap_authenticate_request {
 struct gb_cap_authenticate_response {
 	__u8			result_code;
 	__u8			response[64];
-	__u8			signature[0];
+	__u8			signature[];
 } __packed;
 
 
@@ -642,7 +642,7 @@ struct gb_hid_get_report_request {
 struct gb_hid_set_report_request {
 	__u8				report_type;
 	__u8				report_id;
-	__u8				report[0];
+	__u8				report[];
 } __packed;
 
 /* HID input report request, via interrupt pipe */
@@ -680,7 +680,7 @@ struct gb_i2c_transfer_op {
 
 struct gb_i2c_transfer_request {
 	__le16				op_count;
-	struct gb_i2c_transfer_op	ops[0];		/* op_count of these */
+	struct gb_i2c_transfer_op	ops[];		/* op_count of these */
 } __packed;
 struct gb_i2c_transfer_response {
 	__u8				data[0];	/* inbound data */
@@ -908,7 +908,7 @@ struct gb_spi_transfer_request {
 	__u8			chip_select;	/* of the spi device */
 	__u8			mode;		/* of the spi device */
 	__le16			count;
-	struct gb_spi_transfer	transfers[0];	/* count of these */
+	struct gb_spi_transfer	transfers[];	/* count of these */
 } __packed;
 
 struct gb_spi_transfer_response {
@@ -1188,7 +1188,7 @@ struct gb_svc_pwrmon_rail_count_get_response {
 
 struct gb_svc_pwrmon_rail_names_get_response {
 	__u8	status;
-	__u8	name[0][GB_SVC_PWRMON_RAIL_NAME_BUFSIZE];
+	__u8	name[][GB_SVC_PWRMON_RAIL_NAME_BUFSIZE];
 } __packed;
 
 #define GB_SVC_PWRMON_TYPE_CURR			0x01
@@ -1281,7 +1281,7 @@ struct gb_svc_intf_oops_request {
 
 struct gb_raw_send_request {
 	__le32	len;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 
@@ -1300,7 +1300,7 @@ struct gb_raw_send_request {
 /* Represents data from AP -> Module */
 struct gb_uart_send_data_request {
 	__le16	size;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 /* recv-data-request flags */
@@ -1313,7 +1313,7 @@ struct gb_uart_send_data_request {
 struct gb_uart_recv_data_request {
 	__le16	size;
 	__u8	flags;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 struct gb_uart_receive_credits_request {
@@ -1382,14 +1382,14 @@ struct gb_loopback_transfer_request {
 	__le32	len;
 	__le32  reserved0;
 	__le32  reserved1;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 struct gb_loopback_transfer_response {
 	__le32	len;
 	__le32	reserved0;
 	__le32	reserved1;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 /* SDIO */
@@ -1530,13 +1530,13 @@ struct gb_sdio_transfer_request {
 
 	__le16	data_blocks;
 	__le16	data_blksz;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 struct gb_sdio_transfer_response {
 	__le16	data_blocks;
 	__le16	data_blksz;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 /* event request: generated by module and is defined as unidirectional */
@@ -1572,7 +1572,7 @@ struct gb_camera_configure_streams_request {
 	__u8 flags;
 #define GB_CAMERA_CONFIGURE_STREAMS_TEST_ONLY	0x01
 	__le16 padding;
-	struct gb_camera_stream_config_request config[0];
+	struct gb_camera_stream_config_request config[];
 } __packed;
 
 /* Greybus Camera Configure Streams response payload */
@@ -1593,7 +1593,7 @@ struct gb_camera_configure_streams_response {
 	__u8 flags;
 	__u8 padding[2];
 	__le32 data_rate;
-	struct gb_camera_stream_config_response config[0];
+	struct gb_camera_stream_config_response config[];
 };
 
 /* Greybus Camera Capture request payload - response has no payload */
@@ -1602,7 +1602,7 @@ struct gb_camera_capture_request {
 	__u8 streams;
 	__u8 padding;
 	__le16 num_frames;
-	__u8 settings[0];
+	__u8 settings[];
 } __packed;
 
 /* Greybus Camera Flush response payload - request has no payload */
@@ -1616,7 +1616,7 @@ struct gb_camera_metadata_request {
 	__le16 frame_number;
 	__u8 stream;
 	__u8 padding;
-	__u8 metadata[0];
+	__u8 metadata[];
 } __packed;
 
 /* Lights */
@@ -1993,7 +1993,7 @@ struct gb_audio_integer64 {
 struct gb_audio_enumerated {
 	__le32	items;
 	__le16	names_length;
-	__u8	names[0];
+	__u8	names[];
 } __packed;
 
 struct gb_audio_ctl_elem_info { /* See snd_ctl_elem_info in Linux source */
@@ -2033,7 +2033,7 @@ struct gb_audio_widget {
 	__u8	type;		/* GB_AUDIO_WIDGET_TYPE_* */
 	__u8	state;		/* GB_AUDIO_WIDGET_STATE_* */
 	__u8	ncontrols;
-	struct gb_audio_control	ctl[0];	/* 'ncontrols' entries */
+	struct gb_audio_control	ctl[];	/* 'ncontrols' entries */
 } __packed;
 
 struct gb_audio_route {
@@ -2059,7 +2059,7 @@ struct gb_audio_topology {
 	 * struct gb_audio_widget	widgets[num_widgets];
 	 * struct gb_audio_route	routes[num_routes];
 	 */
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 struct gb_audio_get_topology_size_response {
@@ -2157,7 +2157,7 @@ struct gb_audio_streaming_event_request {
 
 struct gb_audio_send_data_request {
 	__le64	timestamp;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 
@@ -2171,7 +2171,7 @@ struct gb_audio_send_data_request {
 
 struct gb_log_send_log_request {
 	__le16	len;
-	__u8    msg[0];
+	__u8    msg[];
 } __packed;
 
 #endif /* __GREYBUS_PROTOCOLS_H */

