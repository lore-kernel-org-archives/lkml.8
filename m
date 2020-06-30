Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43652C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0120723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbgF3Qjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:39:33 -0400
Received: from out28-170.mail.aliyun.com ([115.124.28.170]:38448 "EHLO
        out28-170.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgF3Qjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:39:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3830189|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.133446-0.0109234-0.85563;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HvJGFHX_1593535155;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HvJGFHX_1593535155)
          by smtp.aliyun-inc.com(10.147.43.230);
          Wed, 01 Jul 2020 00:39:27 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 0/3] Add functions to operate USB PHY related clock.
Date:   Wed,  1 Jul 2020 00:38:49 +0800
Message-Id: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
1.Remove the wrong "WARN()".
2.Remove extra blank line.
3.Fix wrong parameters in recalc_rate/set_rate functions.

周琰杰 (Zhou Yanjie) (3):
  clk: JZ4780: Add functions for enable and disable USB PHY.
  clk: JZ4780: Reformat the code to align it.
  clk: X1000: Add support for calculat REFCLK of USB PHY.

 drivers/clk/ingenic/jz4780-cgu.c | 153 ++++++++++++++++++++-------------------
 drivers/clk/ingenic/x1000-cgu.c  |  84 ++++++++++++++++++++-
 2 files changed, 162 insertions(+), 75 deletions(-)

-- 
2.11.0


