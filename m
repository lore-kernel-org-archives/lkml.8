Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C019C2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgEZQWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:22:34 -0400
Received: from out28-52.mail.aliyun.com ([115.124.28.52]:56259 "EHLO
        out28-52.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgEZQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:22:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2193173|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.340634-0.0241632-0.635203;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16384;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.HdxL88J_1590510137;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HdxL88J_1590510137)
          by smtp.aliyun-inc.com(10.147.41.231);
          Wed, 27 May 2020 00:22:30 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, hns@goldelico.com,
        paul@boddie.org.uk, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
Subject: Ingenic: Add high resolution timer support for SMP/SMT.
Date:   Wed, 27 May 2020 00:21:52 +0800
Message-Id: <20200526162154.15443-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
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

