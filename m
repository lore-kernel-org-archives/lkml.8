Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E20C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ADD24695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCBG3Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 01:29:16 -0500
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:60800 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCBG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:29:15 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0226SYIB024592; Mon, 2 Mar 2020 15:28:34 +0900
X-Iguazu-Qid: 2wGrZsIRE3OS1b6YEL
X-Iguazu-QSIG: v=2; s=0; t=1583130514; q=2wGrZsIRE3OS1b6YEL; m=X60almfTyOdz9J+1VrluHbhCEEh2o3p2cHwKn7ITjqA=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id 0226SW51018421;
        Mon, 2 Mar 2020 15:28:32 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 0226SVbh001454;
        Mon, 2 Mar 2020 15:28:31 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 0226SVF0030943;
        Mon, 2 Mar 2020 15:28:31 +0900
From:   <masahiro31.yamada@kioxia.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: add a compat_ioctl handler for NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH] nvme: add a compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Thread-Index: AdXwWtP+3uT/YWciSkKTlF+qgQWgkQ==
Date:   Mon, 2 Mar 2020 06:28:29 +0000
X-TSB-HOP: ON
Message-ID: <c0d7091c43154d9ea7a978c42a78b01a@TGXML281.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.177.171]
msscp.transfermailtomossagent: 103
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently 32 bit application gets ENOTTY when it calls
compat_ioctl with NVME_IOCTL_SUBMIT_IO in 64 bit kernel.

The cause is that the results of sizeof(struct nvme_user_io),
which is used to define NVME_IOCTL_SUBMIT_IO,
are not same between 32 bit compiler and 64 bit compiler.

* 32 bit: the result of sizeof nvme_user_io is 44.
* 64 bit: the result of sizeof nvme_user_io is 48.

64 bit compiler seems to add 32 bit padding for multiple of 8 bytes.

This patch adds a compat_ioctl handler.
The handler replaces NVME_IOCTL_SUBMIT_IO32 with NVME_IOCTL_SUBMIT_IO
in case 32 bit application calls compat_ioctl for submit in 64 bit kernel.
Then, it calls nvme_ioctl as usual.

Signed-off-by: Masahiro Yamada (KIOXIA) <masahiro31.yamada@kioxia.com>
---
 drivers/nvme/host/core.c        | 13 +++++++++++--
 include/uapi/linux/nvme_ioctl.h | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 641c07347e8d..7bc1e39b7cc9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1584,6 +1584,15 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
+static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	if (cmd == NVME_IOCTL_SUBMIT_IO32)
+		return nvme_ioctl(bdev, mode, NVME_IOCTL_SUBMIT_IO, arg);
+
+	return nvme_ioctl(bdev, mode, cmd, arg);
+}
+
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
@@ -2027,7 +2036,7 @@ EXPORT_SYMBOL_GPL(nvme_sec_submit);
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_ioctl,
+	.compat_ioctl	= nvme_compat_ioctl,
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
@@ -2055,7 +2064,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.open		= nvme_ns_head_open,
 	.release	= nvme_ns_head_release,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_ioctl,
+	.compat_ioctl	= nvme_compat_ioctl,
 	.getgeo		= nvme_getgeo,
 	.pr_ops		= &nvme_pr_ops,
 };
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..52699a26b9b3 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -24,6 +24,21 @@ struct nvme_user_io {
 	__u16	appmask;
 };
 
+struct nvme_user_io32 {
+	__u8	opcode;
+	__u8	flags;
+	__u16	control;
+	__u16	nblocks;
+	__u16	rsvd;
+	__u64	metadata;
+	__u64	addr;
+	__u64	slba;
+	__u32	dsmgmt;
+	__u32	reftag;
+	__u16	apptag;
+	__u16	appmask;
+} __attribute__((packed));
+
 struct nvme_passthru_cmd {
 	__u8	opcode;
 	__u8	flags;
@@ -72,6 +87,7 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_ID		_IO('N', 0x40)
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
+#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
 #define NVME_IOCTL_RESET	_IO('N', 0x44)
 #define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x45)
-- 
2.20.1



