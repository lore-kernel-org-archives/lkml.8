Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B2C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938F7206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCQOn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:43:26 -0400
Received: from out28-3.mail.aliyun.com ([115.124.28.3]:35401 "EHLO
        out28-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgCQOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:43:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3413772|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.0125818-0.000352598-0.987066;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.H0z8vsy_1584456185;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H0z8vsy_1584456185)
          by smtp.aliyun-inc.com(10.147.41.121);
          Tue, 17 Mar 2020 22:43:15 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v2] Add support for TCU of X1000 v2
Date:   Tue, 17 Mar 2020 22:42:39 +0800
Message-Id: <1584456160-40060-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584456160-40060-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584456160-40060-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
Rewrite the commit message as Marc's suggestion.

周琰杰 (Zhou Yanjie) (1):
  irqchip: Ingenic: Add support for TCU of X1000.

 drivers/irqchip/irq-ingenic-tcu.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.4

