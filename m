Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6313C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C648F2076E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgCVTIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:08:21 -0400
Received: from out28-101.mail.aliyun.com ([115.124.28.101]:34002 "EHLO
        out28-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgCVTIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 15:08:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2603443|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.0093256-0.000243152-0.990431;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.H3Z9uBl_1584904084;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H3Z9uBl_1584904084)
          by smtp.aliyun-inc.com(10.147.41.199);
          Mon, 23 Mar 2020 03:08:14 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v7 0/6] Add support for the X1830 and fix bugs for X1000
Date:   Mon, 23 Mar 2020 03:07:32 +0800
Message-Id: <1584904058-53155-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584904058-53155-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584904058-53155-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6->v7:
1.Update commit message of [2/6].
2.Adjust includes in [4/6], add blank line as Paul Cercueil's suggest,
  and Move "*cgu" into x1830_cgu_init() as a local variable.
3.Update commit message of [6/6].

周琰杰 (Zhou Yanjie) (6):
  clk: Ingenic: Remove unnecessary spinlock when reading registers.
  clk: Ingenic: Adjust cgu code to make it compatible with X1830.
  dt-bindings: clock: Add X1830 bindings.
  clk: Ingenic: Add CGU driver for X1830.
  dt-bindings: clock: Add and reorder ABI for X1000.
  clk: X1000: Add FIXDIV for SSI clock of X1000.

 .../devicetree/bindings/clock/ingenic,cgu.txt      |   1 +
 drivers/clk/ingenic/Kconfig                        |  10 +
 drivers/clk/ingenic/Makefile                       |   1 +
 drivers/clk/ingenic/cgu.c                          |  28 +-
 drivers/clk/ingenic/cgu.h                          |   4 +
 drivers/clk/ingenic/jz4725b-cgu.c                  |   4 +
 drivers/clk/ingenic/jz4740-cgu.c                   |   4 +
 drivers/clk/ingenic/jz4770-cgu.c                   |   8 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |   4 +
 drivers/clk/ingenic/x1000-cgu.c                    |  62 +++-
 drivers/clk/ingenic/x1830-cgu.c                    | 388 +++++++++++++++++++++
 include/dt-bindings/clock/x1000-cgu.h              |  62 ++--
 include/dt-bindings/clock/x1830-cgu.h              |  53 +++
 13 files changed, 580 insertions(+), 49 deletions(-)
 create mode 100644 drivers/clk/ingenic/x1830-cgu.c
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h

-- 
2.7.4

