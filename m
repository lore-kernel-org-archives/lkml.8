Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ACDC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578EA246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgB1JlR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:41:17 -0500
Received: from mo-csw-fb1516.securemx.jp ([210.130.202.172]:46078 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1JlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:41:17 -0500
X-Greylist: delayed 752 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 04:41:15 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 01S9SixH015035; Fri, 28 Feb 2020 18:28:44 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 01S9SHrZ022430; Fri, 28 Feb 2020 18:28:17 +0900
X-Iguazu-Qid: 34tKTVUXkYDeRCJdTQ
X-Iguazu-QSIG: v=2; s=0; t=1582882096; q=34tKTVUXkYDeRCJdTQ; m=hDNM8iYkbBz9TmtlPdDqOqFMqiqMO7IKzPQHr8IwsrA=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1512) id 01S9SF7T019538;
        Fri, 28 Feb 2020 18:28:15 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 01S9SFko025756;
        Fri, 28 Feb 2020 18:28:15 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 01S9SEvf018570;
        Fri, 28 Feb 2020 18:28:15 +0900
From:   <masahiro31.yamada@kioxia.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: fix NVME_IOCTL_SUBMIT_IO for compat_ioctl
Thread-Topic: [PATCH] nvme: fix NVME_IOCTL_SUBMIT_IO for compat_ioctl
Thread-Index: AdXuGMxvHgc8BpX4QzmU2g6f3T18FA==
Date:   Fri, 28 Feb 2020 09:28:13 +0000
X-TSB-HOP: ON
Message-ID: <2caa4c913579464bbfdf06b36001ffc9@TGXML281.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.6.136]
msscp.transfermailtomossagent: 103
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiro31.yamada@kioxia.com>

Currently 32 bit application gets ENOTTY when it calls
compat_ioctl with NVME_IOCTL_SUBMIT_IO in 64 bit kernel.

The cause is that the results of sizeof(struct nvme_user_io),
which is used to define NVME_IOCTL_SUBMIT_IO,
are not same between 32 bit compiler and 64 bit compiler.

* 32 bit: the result of sizeof nvme_user_io is 44.
* 64 bit: the result of sizeof nvme_user_io is 48.

64 bit compiler seems to add 32 bit padding for multiple of 8 bytes.

This patch adds 32 bit padding to struct nvme_user_io
for 32 bit compiler to define same NVME_IOCTL_SUBMIT_IO as 64 bit.

nvme-cli also needs to be fixed if this patch is accepted.

Signed-off-by: Masahiro Yamada <masahiro31.yamada@kioxia.com>
---
 include/uapi/linux/nvme_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..a50ea474c21a 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -14,7 +14,7 @@ struct nvme_user_io {
 	__u8	flags;
 	__u16	control;
 	__u16	nblocks;
-	__u16	rsvd;
+	__u16	rsvd1;
 	__u64	metadata;
 	__u64	addr;
 	__u64	slba;
@@ -22,6 +22,7 @@ struct nvme_user_io {
 	__u32	reftag;
 	__u16	apptag;
 	__u16	appmask;
+	__u32	rsvd2;
 };
 
 struct nvme_passthru_cmd {
-- 
2.20.1



