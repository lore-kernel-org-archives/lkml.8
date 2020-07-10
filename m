Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF1CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B422078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGJRDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:03:17 -0400
Received: from out28-2.mail.aliyun.com ([115.124.28.2]:49407 "EHLO
        out28-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgGJRDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:03:16 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.411383|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00903296-0.000207816-0.990759;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I.khRXN_1594400587;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I.khRXN_1594400587)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sat, 11 Jul 2020 01:03:13 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v6 0/2] Add support for the OST in Ingenic X1000.
Date:   Sat, 11 Jul 2020 01:02:57 +0800
Message-Id: <20200710170259.29028-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5->v6:
1.Drop "oneOf" and the blank line in "ingenic,sysost.yaml".
2.Add "additionalProperties: false" in "ingenic,sysost.yaml".

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: timer: Add Ingenic X1000 OST bindings.
  clocksource: Ingenic: Add support for the Ingenic X1000 OST.

 .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
 drivers/clocksource/Kconfig                        |  11 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/ingenic-sysost.c               | 539 +++++++++++++++++++++
 include/dt-bindings/clock/ingenic,sysost.h         |  12 +
 5 files changed, 626 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
 create mode 100644 drivers/clocksource/ingenic-sysost.c
 create mode 100644 include/dt-bindings/clock/ingenic,sysost.h

-- 
2.11.0

