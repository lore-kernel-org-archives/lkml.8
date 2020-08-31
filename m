Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB1CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFED720719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHaNvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:51:54 -0400
Received: from out28-76.mail.aliyun.com ([115.124.28.76]:33484 "EHLO
        out28-76.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHaNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:51:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1641472|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0633989-0.0157613-0.92084;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.IQkeIH2_1598881885;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IQkeIH2_1598881885)
          by smtp.aliyun-inc.com(10.147.43.230);
          Mon, 31 Aug 2020 21:51:42 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     kishon@ti.com, vkoul@kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, christophe.jaillet@wanadoo.fr,
        aric.pzqi@ingenic.com, dongsheng.qiu@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v2 0/1] Use the generic PHY framework for Ingenic USB PHY.
Date:   Mon, 31 Aug 2020 21:50:45 +0800
Message-Id: <20200831135046.54460-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
Fix bug, ".of_match_table = of_match_ptr(ingenic_usb_phy_of_matches)" is wrong
and should be replaced with ".of_match_table = ingenic_usb_phy_of_matches".

周琰杰 (Zhou Yanjie) (1):
  USB: PHY: JZ4770: Use the generic PHY framework.

 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/ingenic/Kconfig                        |  12 +
 drivers/phy/ingenic/Makefile                       |   2 +
 .../phy-jz4770.c => phy/ingenic/phy-ingenic-usb.c} | 256 ++++++++++++---------
 drivers/usb/phy/Kconfig                            |   8 -
 drivers/usb/phy/Makefile                           |   1 -
 7 files changed, 165 insertions(+), 116 deletions(-)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 rename drivers/{usb/phy/phy-jz4770.c => phy/ingenic/phy-ingenic-usb.c} (63%)

-- 
2.11.0

