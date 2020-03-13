Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A15C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126A5206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCMJTW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:19:22 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:52576 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCMJTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:19:22 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 02D9IqOT011465; Fri, 13 Mar 2020 18:18:52 +0900
X-Iguazu-Qid: 34trcFcTQzdBvyh6cj
X-Iguazu-QSIG: v=2; s=0; t=1584091132; q=34trcFcTQzdBvyh6cj; m=dvXoewQWhEGI8o+42umGQv7bWI7dxSoWszKalJslMK8=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1510) id 02D9IpPU028396;
        Fri, 13 Mar 2020 18:18:51 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 02D9Ip9Q019706;
        Fri, 13 Mar 2020 18:18:51 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 02D9Iok8031529;
        Fri, 13 Mar 2020 18:18:50 +0900
From:   <masahiro31.yamada@kioxia.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] nvme: Add compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH V2] nvme: Add compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Thread-Index: AdXy3d6dwSgpOC+0SI6LHpzHuGP6yQGOmZ3g
Date:   Fri, 13 Mar 2020 09:18:48 +0000
X-TSB-HOP: ON
Message-ID: <151e755b6ea841669b1dfeac4a1fe607@TGXML281.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.9.22]
msscp.transfermailtomossagent: 103
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

>Currently 32 bit application gets ENOTTY when it calls
>compat_ioctl with NVME_IOCTL_SUBMIT_IO in 64 bit kernel.
>
>The cause is that the results of sizeof(struct nvme_user_io),
>which is used to define NVME_IOCTL_SUBMIT_IO,
>are not same between 32 bit compiler and 64 bit compiler.
>
>* 32 bit: the result of sizeof nvme_user_io is 44.
>* 64 bit: the result of sizeof nvme_user_io is 48.
>
>64 bit compiler seems to add 32 bit padding for multiple of 8 bytes.
>
>This patch adds a compat_ioctl handler.
>The handler replaces NVME_IOCTL_SUBMIT_IO32 with NVME_IOCTL_SUBMIT_IO
>in case 32 bit application calls compat_ioctl for submit in 64 bit kernel.
>Then, it calls nvme_ioctl as usual.
>
>Signed-off-by: Masahiro Yamada (KIOXIA) <masahiro31.yamada@kioxia.com>
>---
>v2:
>- Add a comment explaining what is going on in nvme_compat_ioctl()
>- Put nvme_compat_ioctl() under CONFIG_COMPAT and add #else branch
>- Move struct nvme_user_io32 #ifdef CONFIG_COMPAT block in core.c
>- Fix packed pragma warning by checkpatch.pl
>  WARNING: __packed is preferred over __attribute__((packed))
>
> drivers/nvme/host/core.c | 45 ++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 43 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 641c07347e8d..8c6998920b2a 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -1584,6 +1584,47 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
> 	return ret;
> }
> 
>+#ifdef CONFIG_COMPAT
>+struct nvme_user_io32 {
>+	__u8	opcode;
>+	__u8	flags;
>+	__u16	control;
>+	__u16	nblocks;
>+	__u16	rsvd;
>+	__u64	metadata;
>+	__u64	addr;
>+	__u64	slba;
>+	__u32	dsmgmt;
>+	__u32	reftag;
>+	__u16	apptag;
>+	__u16	appmask;
>+} __attribute__((__packed__));
>+
>+#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
>+
>+static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
>+		unsigned int cmd, unsigned long arg)
>+{
>+	/*
>+	 * Corresponds to the difference of NVME_IOCTL_SUBMIT_IO
>+	 * between 32 bit programs and 64 bit kernel.
>+	 * The cause is that the results of sizeof(struct nvme_user_io),
>+	 * which is used to define NVME_IOCTL_SUBMIT_IO,
>+	 * are not same between 32 bit compiler and 64 bit compiler.
>+	 * NVME_IOCTL_SUBMIT_IO32 is for 64 bit kernel handling
>+	 * NVME_IOCTL_SUBMIT_IO issued from 32 bit programs.
>+	 * Other IOCTL numbers are same between 32 bit and 64 bit.
>+	 * So there is nothing to do regarding to other IOCTL numbers.
>+	 */
>+	if (cmd == NVME_IOCTL_SUBMIT_IO32)
>+		return nvme_ioctl(bdev, mode, NVME_IOCTL_SUBMIT_IO, arg);
>+
>+	return nvme_ioctl(bdev, mode, cmd, arg);
>+}
>+#else
>+#define nvme_compat_ioctl	NULL
>+#endif /* CONFIG_COMPAT */
>+
> static int nvme_open(struct block_device *bdev, fmode_t mode)
> {
> 	struct nvme_ns *ns = bdev->bd_disk->private_data;
>@@ -2027,7 +2068,7 @@ EXPORT_SYMBOL_GPL(nvme_sec_submit);
> static const struct block_device_operations nvme_fops = {
> 	.owner		= THIS_MODULE,
> 	.ioctl		= nvme_ioctl,
>-	.compat_ioctl	= nvme_ioctl,
>+	.compat_ioctl	= nvme_compat_ioctl,
> 	.open		= nvme_open,
> 	.release	= nvme_release,
> 	.getgeo		= nvme_getgeo,
>@@ -2055,7 +2096,7 @@ const struct block_device_operations nvme_ns_head_ops = {
> 	.open		= nvme_ns_head_open,
> 	.release	= nvme_ns_head_release,
> 	.ioctl		= nvme_ioctl,
>-	.compat_ioctl	= nvme_ioctl,
>+	.compat_ioctl	= nvme_compat_ioctl,
> 	.getgeo		= nvme_getgeo,
> 	.pr_ops		= &nvme_pr_ops,
> };
>-- 
>2.20.1
>
>
>
