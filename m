Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D23C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D9C20679
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BUcEtW5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBPrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 10:47:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15703 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgBBPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580658451; x=1612194451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yjQuSD40krTJ5lbMtA0mAHZ+m2VaBFNpM0wv92vjO+w=;
  b=BUcEtW5+1/EZpiDOkazxwE/lbIaZPkzR8U8KZNSCFF2hepHoJjGEm+rD
   CZwUV9lfZrQbS1R0uRTMY4neiu8wfDXnLy9O2nYibS66NIjP9b+bzRD0e
   ih0Es5K1bQhMaDCAn/KVf5bOCKPsRwg+6fZcs3kVQdcjHk+Yc9c/UBIlV
   N8AQ+aNfy0ycSWPDmLyN08yykPSXzfOdBTcF3GylS/nABC7rk89aA3vFe
   sZp1pEzMLj5x3+CK/ZQnCc2KNd1cdGWReOdUFMf3nHgQ21qhT5UPrlmmr
   rB8AFf02V0vT/N8LJXNrdGuXb4iA1YIaMemaosiYJoDndrvKAyEDjJXkq
   Q==;
IronPort-SDR: 5Ug3xjax5r0LmwiP9WsIqjSpHaXPRqmAn+uzlZZBsjgffCX4/4ks+vVEM5E9Du1/4a1GJh6f14
 jWv2tkblm0ZyrihY9lSdLSzRGyO3JFVSzs78f4F4DyLWyoNlKDJxgjZhGBDlx+GHFg2a4ILgoz
 Pvkf8OcmcWZYlo6UmmQB/yT4VrrKEzBYqmqn3g/Km6sr5gXgKgOuQPX94Rui7SWpSvTD31wzwK
 5cJdNQlOhyRgKt/ccrjk9Ktco+4U0ByvgPXpM15am0yiqCpt6zxuTE3Jn3qGDU7/v0IrSKP3hY
 ILc=
X-IronPort-AV: E=Sophos;i="5.70,394,1574092800"; 
   d="scan'208";a="128932815"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2020 23:47:31 +0800
IronPort-SDR: 40acwZYROph2jknKzx/+ByHfE++AyKbJGx34XzDWaVNn96kkw4FtnxsGV/UD0pT0+gWsC7lGfZ
 eeCAHIt5QfAtiRYXKqwCjRJBLA/9ARDTQKOgjbkLgbOcPrzvDuYaHdk68gyX+pKHA2NgVOdBQX
 5plrHeKLDJRD5+C7MyxWfJ+JrNXtiXvIv6ym9Hnc7K14JgQbwFPEzr6Ae5GXiLNTIt0IwFOLN+
 mUqrVDDb1j5WOlmZq/ykiOh7paNVtVMX4j3dASmL+j204P51Mh+Kz38z925o/8t7IKzSmSF74I
 Qqieonjp51N6ZdN1cZJ2LkaX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 07:40:37 -0800
IronPort-SDR: peB792mNCbU6MdT12/NxCTEjqGUC6tC85M+l2TTEL5H0vaUr04FAc5Tnh+0D2H7lPgVM6h8tRB
 UCAyNPf436Lrj5Ywb35xmd5cyqT8eUt7IraUg4iTNUycKQ8k29JxIamMWZv2V9tAldZxhmykdj
 +6J4Q+RHQN/VcJBkPQtY7jw7ymi4U88B5OG5m+6gYth0T5S3DThmUWz0nESSCkkNqJkgho7MvN
 a+QVyKkm5iZUHlS1mxh4B1SQfazYuQfKOnsgS1PN6vclt/812OoG7zcOoWW0w2EQaZra8I5Zo8
 BMg=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Feb 2020 07:47:30 -0800
From:   Avi Shchislowski <avi.shchislowski@wdc.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        linux-kernel@vger.kernel.org
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>
Subject: [PATCH 0/5] scsi: ufs: ufs device as a temperature sensor
Date:   Sun,  2 Feb 2020 17:47:20 +0200
Message-Id: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS3.0 allows using the ufs device as a temperature sensor. The
purpose of this feature is to provide notification to the host of the
UFS device case temperature. It allows reading of a rough estimate
(+-10 degrees centigrade) of the current case temperature, And
setting a lower and upper temperature bounds, in which the device
will trigger an applicable exception event.

We added the capability of responding to such notifications, while
notifying the kernel's thermal core, which further exposes the thermal
zone attributes to user space. UFS temperature attributes are all
read-only, so only thermal read ops (.get_xxx) can be implemented.

Avi Shchislowski (5):
  scsi: ufs: Add ufs thermal support
  scsi: ufs: export ufshcd_enable_ee
  scsi: ufs: enable thermal exception event
  scsi: ufs-thermal: implement thermal file ops
  scsi: ufs: temperature atrributes add to ufs_sysfs

 drivers/scsi/ufs/Kconfig       |  11 ++
 drivers/scsi/ufs/Makefile      |   1 +
 drivers/scsi/ufs/ufs-sysfs.c   |   6 +
 drivers/scsi/ufs/ufs-thermal.c | 247 +++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-thermal.h |  25 +++++
 drivers/scsi/ufs/ufs.h         |  20 +++-
 drivers/scsi/ufs/ufshcd.c      |   9 +-
 drivers/scsi/ufs/ufshcd.h      |  12 ++
 8 files changed, 329 insertions(+), 2 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufs-thermal.c
 create mode 100644 drivers/scsi/ufs/ufs-thermal.h

-- 
1.9.1

