Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DFCC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D47520644
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503695AbgDPJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502300AbgDPIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10559C03C1AD;
        Thu, 16 Apr 2020 01:31:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOzvj-0000oL-TX; Thu, 16 Apr 2020 10:31:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7E4571C0481;
        Thu, 16 Apr 2020 10:31:27 +0200 (CEST)
Date:   Thu, 16 Apr 2020 08:31:27 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158702588715.28353.6580556963314135830.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3df4d4bf3c6cf3b7509ff11d7b02b64603b43d24
Gitweb:        https://git.kernel.org/tip/3df4d4bf3c6cf3b7509ff11d7b02b64603b43d24
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 14 Apr 2020 09:12:55 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Apr 2020 11:02:46 -03:00

tools include UAPI: Sync linux/vhost.h with the kernel sources

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
index 40d028e..9fe72e4 100644
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
