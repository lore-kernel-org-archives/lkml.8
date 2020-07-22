Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB45EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F7420A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgGVGeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:34:31 -0400
Received: from out28-97.mail.aliyun.com ([115.124.28.97]:50796 "EHLO
        out28-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVGea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:34:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3244049|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00839481-0.000476403-0.991129;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03268;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I5ji.5V_1595399657;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I5ji.5V_1595399657)
          by smtp.aliyun-inc.com(10.147.44.129);
          Wed, 22 Jul 2020 14:34:23 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v4 0/3] Add USB PHY support for new Ingenic SoCs.
Date:   Wed, 22 Jul 2020 14:33:52 +0800
Message-Id: <20200722063355.67781-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v4:
Fix typos.

周琰杰 (Zhou Yanjie) (3):
  dt-bindings: USB: Add bindings for new Ingenic SoCs.
  USB: PHY: JZ4770: Add support for new Ingenic SoCs.
  USB: PHY: JZ4770: Reformat the code to align it.

 .../bindings/usb/ingenic,jz4770-phy.yaml           |   6 +-
 drivers/usb/phy/Kconfig                            |   4 +-
 drivers/usb/phy/phy-jz4770.c                       | 252 ++++++++++++++-------
 3 files changed, 177 insertions(+), 85 deletions(-)

-- 
2.11.0

