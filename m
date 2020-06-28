Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3595C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 17:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C029520768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 17:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgF1RSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 13:18:18 -0400
Received: from out28-221.mail.aliyun.com ([115.124.28.221]:58010 "EHLO
        out28-221.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1RSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 13:18:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4525175|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0220848-0.000517743-0.977398;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03307;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.Hu3fckw_1593364687;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Hu3fckw_1593364687)
          by smtp.aliyun-inc.com(10.147.42.197);
          Mon, 29 Jun 2020 01:18:13 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v2 0/3] Add functions to operate USB PHY related clock.
Date:   Mon, 29 Jun 2020 01:15:40 +0800
Message-Id: <20200628171543.51478-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
1.Use "WARN()" instead "BUG()".
2.Move the reformat part ot the new patch.
3.Remove unnecessary get_parent/set_parent functions.

周琰杰 (Zhou Yanjie) (3):
  clk: JZ4780: Add functions for enable and disable USB PHY.
  clk: JZ4780: Reformat the code to align it.
  clk: X1000: Add support for calculat REFCLK of USB PHY.

 drivers/clk/ingenic/jz4780-cgu.c | 155 ++++++++++++++++++++-------------------
 drivers/clk/ingenic/x1000-cgu.c  |  85 ++++++++++++++++++++-
 2 files changed, 165 insertions(+), 75 deletions(-)

-- 
2.11.0


