Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F7C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 07:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8150C206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 07:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGYHsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 03:48:37 -0400
Received: from out28-2.mail.aliyun.com ([115.124.28.2]:51753 "EHLO
        out28-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGYHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 03:48:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.17077|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0325214-0.0448014-0.922677;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03275;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.I7J6ttN_1595663307;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I7J6ttN_1595663307)
          by smtp.aliyun-inc.com(10.147.42.16);
          Sat, 25 Jul 2020 15:48:33 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linus.walleij@linaro.org, paul@crapouillou.net
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 0/1] Ingenic: Add SSI pins support for JZ4770 and JZ4780.
Date:   Sat, 25 Jul 2020 15:46:04 +0800
Message-Id: <20200725074605.67919-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SSI pins support for the JZ4770 SoC and the
JZ4780 SoC from Ingenic.

周琰杰 (Zhou Yanjie) (1):
  pinctrl: Ingenic: Add SSI pins support for JZ4770 and JZ4780.

 drivers/pinctrl/pinctrl-ingenic.c | 267 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

-- 
2.11.0

