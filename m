Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3191AC7619B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D19B20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 11:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgBPLRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 06:17:50 -0500
Received: from out28-3.mail.aliyun.com ([115.124.28.3]:41184 "EHLO
        out28-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgBPLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 06:17:50 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1320878|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0601371-0.00308368-0.936779;DS=CONTINUE|ham_system_inform|0.0463973-0.00408474-0.949518;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.GodzYLk_1581851850;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GodzYLk_1581851850)
          by smtp.aliyun-inc.com(10.147.41.121);
          Sun, 16 Feb 2020 19:17:39 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, linus.walleij@linaro.org,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com,
        dongsheng.qiu@ingenic.com
Subject: [PATCH] pinctrl: Ingenic: Add missing parts for X1830.
Date:   Sun, 16 Feb 2020 19:17:07 +0800
Message-Id: <1581851828-3493-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581851828-3493-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1581851828-3493-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lcd pinctrl driver for Ingenic X1830.

周琰杰 (Zhou Yanjie) (1):
  pinctrl: Ingenic: Add missing parts for X1830.

 drivers/pinctrl/pinctrl-ingenic.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

-- 
2.7.4

