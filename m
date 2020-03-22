Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE015C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B294E20753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCVTIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:08:17 -0400
Received: from out28-122.mail.aliyun.com ([115.124.28.122]:45680 "EHLO
        out28-122.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgCVTIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 15:08:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2745475|-1;CH=green;DM=||false|;DS=CONTINUE|ham_news_journal|0.0226627-0.000317842-0.977019;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.H3Z9uBl_1584904084;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H3Z9uBl_1584904084)
          by smtp.aliyun-inc.com(10.147.41.199);
          Mon, 23 Mar 2020 03:08:13 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: Add support for the X1830 and fix bugs for X1000 v7.
Date:   Mon, 23 Mar 2020 03:07:31 +0800
Message-Id: <1584904058-53155-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
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

