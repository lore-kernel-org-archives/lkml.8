Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A024C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F652073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgHaPoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:44:22 -0400
Received: from out28-53.mail.aliyun.com ([115.124.28.53]:38611 "EHLO
        out28-53.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgHaPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:44:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1233177|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0283242-0.00161577-0.97006;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.IQnAArN_1598888641;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IQnAArN_1598888641)
          by smtp.aliyun-inc.com(10.147.41.143);
          Mon, 31 Aug 2020 23:44:13 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linus.walleij@linaro.org, paul@crapouillou.net
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        aric.pzqi@ingenic.com, dongsheng.qiu@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v2 0/3] pinctrl: Ingenic: Add support for SSI and I2S pins.
Date:   Mon, 31 Aug 2020 23:43:21 +0800
Message-Id: <20200831154324.64951-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add SSI pins support for JZ4770 and JZ4780.
2.Correct the pullup and pulldown parameters of JZ4780.
3.Add I2S pins support for JZ4780, X1000, X1500, and X1830.

周琰杰 (Zhou Yanjie) (3):
  pinctrl: Ingenic: Add SSI pins support for JZ4770 and JZ4780.
  pinctrl: Ingenic: Correct the pullup and pulldown parameters of JZ4780
  pinctrl: Ingenic: Add I2S pins support for Ingenic SoCs.

 drivers/pinctrl/pinctrl-ingenic.c | 349 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 347 insertions(+), 2 deletions(-)

-- 
2.11.0

