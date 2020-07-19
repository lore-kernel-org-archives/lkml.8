Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9210C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30F2207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgGSLn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:43:28 -0400
Received: from out28-101.mail.aliyun.com ([115.124.28.101]:33391 "EHLO
        out28-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSLn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 07:43:28 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.27405|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0135836-0.000174014-0.986242;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I4GuTvT_1595158995;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I4GuTvT_1595158995)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sun, 19 Jul 2020 19:43:23 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
Subject: Add support for the OST in Ingenic X1000.
Date:   Sun, 19 Jul 2020 19:42:45 +0800
Message-Id: <20200719114247.56100-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7->v8:
Revert the changes made in v7, remove the "default MACH_INGENIC"
in SYSOST, and modify the bool description in OST to make it
consistent with the style of TCU and SYSOST.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: timer: Add Ingenic X1000 OST bindings.
  clocksource: Ingenic: Add support for the Ingenic X1000 OST.

 .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
 drivers/clocksource/Kconfig                        |  12 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/ingenic-sysost.c               | 539 +++++++++++++++++++++
 include/dt-bindings/clock/ingenic,sysost.h         |  12 +
 5 files changed, 626 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
 create mode 100644 drivers/clocksource/ingenic-sysost.c
 create mode 100644 include/dt-bindings/clock/ingenic,sysost.h

-- 
2.11.0

