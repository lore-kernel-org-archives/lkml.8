Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF8C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF34C207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgEXPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:48:05 -0400
Received: from out28-77.mail.aliyun.com ([115.124.28.77]:54087 "EHLO
        out28-77.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgEXPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:48:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.375452|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0182425-0.000259138-0.981498;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HcyTzUM_1590335272;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HcyTzUM_1590335272)
          by smtp.aliyun-inc.com(10.147.44.118);
          Sun, 24 May 2020 23:47:59 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v9 0/6] Add support for the X1830 and fix bugs for X1000
Date:   Sun, 24 May 2020 23:47:23 +0800
Message-Id: <20200524154729.30958-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200524154729.30958-1-zhouyanjie@wanyeetech.com>
References: <20200524154729.30958-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v8->v9:
Add Paul Cercueil's Reviewed-by, somehow his emails are not displayed
on the mailing list and patchwork of clock framework subsystem.

周琰杰 (Zhou Yanjie) (6):
  clk: Ingenic: Remove unnecessary spinlock when reading registers.
  clk: Ingenic: Adjust cgu code to make it compatible with X1830.
  dt-bindings: clock: Add X1830 bindings.
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
 drivers/clk/ingenic/x1000-cgu.c                    | 114 +++++-
 drivers/clk/ingenic/x1830-cgu.c                    | 436 +++++++++++++++++++++
 include/dt-bindings/clock/x1000-cgu.h              |  64 +--
 include/dt-bindings/clock/x1830-cgu.h              |  54 +++
 13 files changed, 684 insertions(+), 48 deletions(-)
 create mode 100644 drivers/clk/ingenic/x1830-cgu.c
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h

-- 
2.11.0

