Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231DBC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AC220678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883064;
	bh=e8sa2L9jrsFs8MZxmSzZtk35TsqpIfaY4VUQqf3DBa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jbMq0gwcxXRWQb9KhDq8MV8eSZYQW07h104+XyKp7Chz6pt8ppibVWwyW034gORp4
	 /Gs/iLAJ/Wn/K761tXpTHEAJic6WSblHDQmyQMH2oh2vju15gUOMIIdnAcC/XJftV9
	 j7rII7WXpuK1Y0QDY71AnBx6oLLzkJMpD953Wiz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440615AbgDNQvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440428AbgDNQt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F43208FE;
        Tue, 14 Apr 2020 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882966;
        bh=e8sa2L9jrsFs8MZxmSzZtk35TsqpIfaY4VUQqf3DBa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5n+Ul2F1XVNQ1AQAU6F1NPlDnGVsDUbcb1/j+DXUSV9YceAsnW+CCddjBCLLv89i
         1UJSuvzjDufw+nhr94MMOtMFIJXGAyNw7hTR98uNmjss1PqCcjLE5vnumkGR75j+bq
         eTIndeL3qtd/C9LsTxs/gCwLcuqGfBnMplg+OieU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH 08/15] tools include UAPI: Sync linux/vhost.h with the kernel sources
Date:   Tue, 14 Apr 2020 13:48:47 -0300
Message-Id: <20200414164854.26026-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  4c8cf31885f6 ("vhost: introduce vDPA-based backend")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/vhost.h' differs from latest version at 'include/uapi/linux/vhost.h'
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

This automatically picks these new ioctls, making tools such as 'perf
trace' aware of them and possibly allowing to use the strings in
filters, etc:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp include/uapi/linux/vhost.h tools/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2020-04-14 09:12:28.559748968 -0300
  +++ after	2020-04-14 09:12:38.781696242 -0300
  @@ -24,9 +24,16 @@
   	[0x44] = "SCSI_GET_EVENTS_MISSED",
   	[0x60] = "VSOCK_SET_GUEST_CID",
   	[0x61] = "VSOCK_SET_RUNNING",
  +	[0x72] = "VDPA_SET_STATUS",
  +	[0x74] = "VDPA_SET_CONFIG",
  +	[0x75] = "VDPA_SET_VRING_ENABLE",
   };
   static const char *vhost_virtio_ioctl_read_cmds[] = {
   	[0x00] = "GET_FEATURES",
   	[0x12] = "GET_VRING_BASE",
   	[0x26] = "GET_BACKEND_FEATURES",
  +	[0x70] = "VDPA_GET_DEVICE_ID",
  +	[0x71] = "VDPA_GET_STATUS",
  +	[0x73] = "VDPA_GET_CONFIG",
  +	[0x76] = "VDPA_GET_VRING_NUM",
   };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index 40d028eed645..9fe72e4b1373 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -116,4 +116,28 @@
 #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
 #define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
 
+/* VHOST_VDPA specific defines */
+
+/* Get the device id. The device ids follow the same definition of
+ * the device id defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_DEVICE_ID	_IOR(VHOST_VIRTIO, 0x70, __u32)
+/* Get and set the status. The status bits follow the same definition
+ * of the device status defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_STATUS		_IOR(VHOST_VIRTIO, 0x71, __u8)
+#define VHOST_VDPA_SET_STATUS		_IOW(VHOST_VIRTIO, 0x72, __u8)
+/* Get and set the device config. The device config follows the same
+ * definition of the device config defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_CONFIG		_IOR(VHOST_VIRTIO, 0x73, \
+					     struct vhost_vdpa_config)
+#define VHOST_VDPA_SET_CONFIG		_IOW(VHOST_VIRTIO, 0x74, \
+					     struct vhost_vdpa_config)
+/* Enable/disable the ring. */
+#define VHOST_VDPA_SET_VRING_ENABLE	_IOW(VHOST_VIRTIO, 0x75, \
+					     struct vhost_vring_state)
+/* Get the max ring size. */
+#define VHOST_VDPA_GET_VRING_NUM	_IOR(VHOST_VIRTIO, 0x76, __u16)
+
 #endif
-- 
2.21.1

