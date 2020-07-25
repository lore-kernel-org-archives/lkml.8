Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45933C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EC120767
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGYFMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:12:16 -0400
Received: from out28-101.mail.aliyun.com ([115.124.28.101]:44342 "EHLO
        out28-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgGYFMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:12:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2899688|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00241777-0.000472233-0.99711;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10422;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I7G.t3W_1595653922;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I7G.t3W_1595653922)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sat, 25 Jul 2020 13:12:08 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 0/3] Add RTC related clocks for Ingenic SoCs.
Date:   Sat, 25 Jul 2020 13:11:33 +0800
Message-Id: <20200725051136.58220-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add RTC related clocks bindings for the JZ4780 SoC,
  the X1000 SoC, and the X1830 SoC.
2.Add "XXXX_CLK_EXCLK_DIV512" and "XXXX_CLK_RTC" for
  the JZ4780 SoC, the X1000 SoC, and the X1830 SoC.

周琰杰 (Zhou Yanjie) (3):
  dt-bindings: clock: Add RTC related clocks for Ingenic SoCs.
  dt-bindings: clock: Add tabs to align code.
  clk: Ingenic: Add RTC related clocks for Ingenic SoCs.

 drivers/clk/ingenic/jz4780-cgu.c       |  12 +++
 drivers/clk/ingenic/x1000-cgu.c        |  13 +++
 drivers/clk/ingenic/x1830-cgu.c        |  13 +++
 include/dt-bindings/clock/jz4780-cgu.h | 144 +++++++++++++++++----------------
 include/dt-bindings/clock/x1000-cgu.h  |   2 +
 include/dt-bindings/clock/x1830-cgu.h  |   2 +
 6 files changed, 115 insertions(+), 71 deletions(-)

-- 
2.11.0

