Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0EDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BE120774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390138AbgF3RQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:16:28 -0400
Received: from out28-172.mail.aliyun.com ([115.124.28.172]:33500 "EHLO
        out28-172.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgF3RQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:16:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2698322|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0285882-0.000263164-0.971149;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03302;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.HvKRuu7_1593537376;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HvKRuu7_1593537376)
          by smtp.aliyun-inc.com(10.147.41.178);
          Wed, 01 Jul 2020 01:16:24 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 0/2] Add support for the OST in Ingenic X1000.
Date:   Wed,  1 Jul 2020 01:15:51 +0800
Message-Id: <20200630171553.70670-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
Fix wrong parameters in "clocks".

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: timer: Add Ingenic X1000 OST bindings.
  clocksource: Ingenic: Add support for the Ingenic X1000 OST.

 .../devicetree/bindings/timer/ingenic,ost.yaml     |  61 +++
 drivers/clocksource/Kconfig                        |  19 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/ingenic-sysost.c               | 509 +++++++++++++++++++++
 include/dt-bindings/clock/ingenic,ost.h            |  12 +
 5 files changed, 598 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,ost.yaml
 create mode 100755 drivers/clocksource/ingenic-sysost.c
 create mode 100644 include/dt-bindings/clock/ingenic,ost.h

-- 
2.11.0


