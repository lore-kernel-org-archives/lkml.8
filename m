Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3229DC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114912465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBTQZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:25:39 -0500
Received: from out28-195.mail.aliyun.com ([115.124.28.195]:46125 "EHLO
        out28-195.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:25:37 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.405465|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0476772-0.00724055-0.945082;DS=CONTINUE|ham_system_inform|0.0706042-0.188907-0.740489;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.GqC0FCl_1582215911;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GqC0FCl_1582215911)
          by smtp.aliyun-inc.com(10.147.40.2);
          Fri, 21 Feb 2020 00:25:19 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de,
        ralf@linux-mips.org, paulburton@kernel.org,
        jiaxun.yang@flygoat.com, chenhc@lemote.com, sboyd@kernel.org,
        mturquette@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, paul@crapouillou.net,
        geert+renesas@glider.be, krzk@kernel.org, ebiederm@xmission.com,
        miquel.raynal@bootlin.com, keescook@chromium.org,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com,
        dongsheng.qiu@ingenic.com
Subject: Introduce SMP support for CI20 (based on JZ4780) v6.
Date:   Fri, 21 Feb 2020 00:24:41 +0800
Message-Id: <1582215889-113034-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce SMP support for MIPS Creator CI20, which is
based on Ingenic JZ4780 SoC.

