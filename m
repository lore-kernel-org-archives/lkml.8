Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62934C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41693204EF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgE3Qx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 12:53:27 -0400
Received: from out28-53.mail.aliyun.com ([115.124.28.53]:59914 "EHLO
        out28-53.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgE3Qx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 12:53:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3907478|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00733395-0.00458315-0.988083;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.HfvVT0t_1590857595;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HfvVT0t_1590857595)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 31 May 2020 00:53:22 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH 0/2] Add USB PHY support for Ingenic X1000 and X1830.
Date:   Sun, 31 May 2020 00:52:51 +0800
Message-Id: <20200530165253.17445-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add the USB PHY bindings for the X1000 SoC and
  the X1830 SoC from Ingenic.
2.Add support for probing the phy-jz4770 driver on the
  X1000 SoC and the X1830 SoC from Ingenic.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: USB: Add Ingenic X1000 and X1830 bindings.
  USB: PHY: JZ4770: Add support for Ingenic X1000 and X1830.

 .../bindings/usb/ingenic,jz4770-phy.yaml           |   5 +-
 drivers/usb/phy/Kconfig                            |   4 +-
 drivers/usb/phy/phy-jz4770.c                       | 250 ++++++++++++++-------
 3 files changed, 173 insertions(+), 86 deletions(-)

-- 
2.11.0

