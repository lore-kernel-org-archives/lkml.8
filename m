Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9832C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D4A2064B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yyklb0++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGCHqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:46:42 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51125 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593762401; x=1625298401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qe3AsKz/1NWtVp1Lygpm/UXyvvks8ItOId5LZbRDzSE=;
  b=yyklb0++eQ5MbSXtAogkfn1kylatS8DUgSxNSgDV0yHMGg8pdw84mb4t
   hcpei09jp/DvHab2M+W1BNssXTnHjfOWQXqPcCtyL+Q1ffF3qEyX6s1t1
   9DocxPzIeS2pXSNU9EiEM2pi7xlwxUEn8CLYwH8LyumUKPOXyfeAL1FBw
   4xUiIttu3duCo7XbHBA5adEkw3WjaKMk7xhnzWGoEdhLYaMp4TdLuWxAW
   eInrrgL6DbRuhKcmP6qZfYELuiihSdr/iSfNr67t3cLZHuWxI4wUP/Da7
   8M4yN9BD/kTmZsNIEa3s2q0X0tU18zGptAmfU111dQ5FmQ0wrC6PWViHi
   w==;
IronPort-SDR: AfTzNOcXbRjSM3KS+KI3U/gtKHXSrMqBkFwBiCYJNjQMzDG0zc1q7RvSLo6ksFiDlZnyMJvVAC
 5ouKWWhV+IbsIlil6Zu4QdH8vX6OW2GXIUE7saiPq75jeSHXTUlTyvAUvnuqjFnvP7578tYV85
 RNV1vgd5Fib+L0KA1hzxgBS6lOtAKhaJkmrjEaZU93MZsfAnjrewxIna1tCi4Vswi4jPhI3902
 BNAYFHeJsKiUcQJokCf/WGfDy9b10yRUJ3i92kgOh+gxh3oasQHhV82U2QDy9e2iiS/mOrYjOD
 LWw=
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="80602013"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2020 00:46:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 3 Jul 2020 00:46:39 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 3 Jul 2020 00:46:14 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <mchehab@kernel.org>, <hverkuil@xs4all.nl>, <robh+dt@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 0/4] media: introduce microchip csi2dc driver
Date:   Fri, 3 Jul 2020 10:44:12 +0300
Message-ID: <20200703074416.55272-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for the Microchip csi2dc csi-2 demux controller.

I was not fully sure where is the best place for such a helper chip, thus
I added the driver in a separate 'misc' menu under the media menu.

There are references in the binding driver to the Synopsys IDI interface,
which is not yet in kernel mainline, as per the patch series at [1].

As this driver is still new, it still can get plenty of improvement, so,
waiting for feedback.

Thanks everyone for reviewing !

Changes in v2:
- fixed warnings for binding yaml check

[1] https://lwn.net/Articles/790917/

Eugen Hristev (4):
  dt-bindings: media: csi2dc: add bindings for microchip csi2dc
  media: misc: introduce miscellaneous menu for helper chips
  media: misc: introduce microchip_csi2dc driver
  MAINTAINERS: add microchip csi2dc

 .../bindings/media/microchip,csi2dc.yaml      | 185 +++++
 MAINTAINERS                                   |   7 +
 drivers/media/Kconfig                         |   1 +
 drivers/media/Makefile                        |   2 +-
 drivers/media/misc/Kconfig                    |  22 +
 drivers/media/misc/Makefile                   |   2 +
 drivers/media/misc/microchip_csi2dc.c         | 705 ++++++++++++++++++
 7 files changed, 923 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
 create mode 100644 drivers/media/misc/Kconfig
 create mode 100644 drivers/media/misc/Makefile
 create mode 100644 drivers/media/misc/microchip_csi2dc.c

-- 
2.25.1

