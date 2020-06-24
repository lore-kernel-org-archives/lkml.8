Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84855C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694AC20836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405318AbgFXRI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:08:28 -0400
Received: from out28-145.mail.aliyun.com ([115.124.28.145]:44128 "EHLO
        out28-145.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404209AbgFXRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:08:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.140131|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.17348-0.00749246-0.819028;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.HrwUtgU_1593018493;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HrwUtgU_1593018493)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 25 Jun 2020 01:08:20 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH RESEND 0/1] Ingenic: Add high resolution timer support for SMP/SMT.
Date:   Thu, 25 Jun 2020 01:07:48 +0800
Message-Id: <20200624170749.31762-1-zhouyanjie@wanyeetech.com>
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

周琰杰 (Zhou Yanjie) (1):
  clocksource: Ingenic: Add high resolution timer support for SMP/SMT.

 drivers/clocksource/ingenic-timer.c | 182 ++++++++++++++++++++++++------------
 1 file changed, 124 insertions(+), 58 deletions(-)

-- 
2.11.0


