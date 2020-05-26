Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41546C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260F12073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgEZQWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:22:38 -0400
Received: from out28-2.mail.aliyun.com ([115.124.28.2]:39130 "EHLO
        out28-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgEZQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:22:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1555966|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.17348-0.00749245-0.819028;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.HdxL88J_1590510137;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HdxL88J_1590510137)
          by smtp.aliyun-inc.com(10.147.41.231);
          Wed, 27 May 2020 00:22:31 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, hns@goldelico.com,
        paul@boddie.org.uk, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH 0/1] Ingenic: Add high resolution timer support for SMP/SMT.
Date:   Wed, 27 May 2020 00:21:53 +0800
Message-Id: <20200526162154.15443-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200526162154.15443-1-zhouyanjie@wanyeetech.com>
References: <20200526162154.15443-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable clock event handling on per CPU core basis. Make sure that
interrupts raised on the first core execute event handlers on the
correct CPU core. This driver is required by Ingenic processors
that support SMP/SMT, such as JZ4780 and X2000.

周琰杰 (Zhou Yanjie) (1):
  clocksource: Ingenic: Add high resolution timer support for SMP/SMT.

 drivers/clocksource/ingenic-timer.c | 182 ++++++++++++++++++++++++------------
 1 file changed, 124 insertions(+), 58 deletions(-)

-- 
2.11.0

