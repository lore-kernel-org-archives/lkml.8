Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A550C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515812084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391780AbgE0R7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:59:21 -0400
Received: from out28-123.mail.aliyun.com ([115.124.28.123]:48214 "EHLO
        out28-123.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388544AbgE0R7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:59:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2468916|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0315748-0.000160287-0.968265;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.HeTcPrZ_1590602337;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HeTcPrZ_1590602337)
          by smtp.aliyun-inc.com(10.147.43.95);
          Thu, 28 May 2020 01:59:16 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v12 0/7] Add support for the X1830 and fix bugs for X1000.
Date:   Thu, 28 May 2020 01:56:28 +0800
Message-Id: <20200527175635.5558-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v10->v11:
Split [3/6] in v10 to [3/7] in v11 and [4/7] in v11.

v11->v12:
Use "CLK_OF_DECLARE_DRIVER" instead "CLK_OF_DECLARE",
this modification was mentioned in the comments, but
did not really exist in the patch.
Reported-by: Paul Cercueil <paul@crapouillou.net>

周琰杰 (Zhou Yanjie) (7):
  clk: Ingenic: Remove unnecessary spinlock when reading registers.
  clk: Ingenic: Adjust cgu code to make it compatible with X1830.
  dt-bindings: clock: Add documentation for X1830 bindings.
  dt-bindings: clock: Add X1830 clock bindings.
  clk: Ingenic: Add CGU driver for X1830.
  dt-bindings: clock: Add and reorder ABI for X1000.
  clk: X1000: Add FIXDIV for SSI clock of X1000.

 .../devicetree/bindings/clock/ingenic,cgu.yaml     |   2 +
 drivers/clk/ingenic/Kconfig                        |  10 +
 drivers/clk/ingenic/Makefile                       |   1 +
 drivers/clk/ingenic/cgu.c                          |  28 +-
 drivers/clk/ingenic/cgu.h                          |   4 +
 drivers/clk/ingenic/jz4725b-cgu.c                  |   4 +
 drivers/clk/ingenic/jz4740-cgu.c                   |   4 +
 drivers/clk/ingenic/jz4770-cgu.c                   |   8 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |   3 +
 drivers/clk/ingenic/x1000-cgu.c                    | 118 +++++-
 drivers/clk/ingenic/x1830-cgu.c                    | 443 +++++++++++++++++++++
 include/dt-bindings/clock/x1000-cgu.h              |  64 +--
 include/dt-bindings/clock/x1830-cgu.h              |  55 +++
 13 files changed, 695 insertions(+), 49 deletions(-)
 create mode 100644 drivers/clk/ingenic/x1830-cgu.c
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h

-- 
2.11.0

