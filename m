Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CA820738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCQPNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:13:51 -0400
Received: from out28-220.mail.aliyun.com ([115.124.28.220]:60628 "EHLO
        out28-220.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgCQPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:13:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2034004|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.0742784-0.00260228-0.923119;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03296;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.H0zKH5l_1584457917;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H0zKH5l_1584457917)
          by smtp.aliyun-inc.com(10.147.42.241);
          Tue, 17 Mar 2020 23:13:13 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH RESEND] Add support for TCU of X1000.
Date:   Tue, 17 Mar 2020 23:11:32 +0800
Message-Id: <1584457893-40418-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584457893-40418-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584457893-40418-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TCU of X1000 from Ingenic. X1000 has a different TCU,
since X1000 OST has been independent of TCU. This patch is add TCU
support of X1000, and prepare for later OST driver.

周琰杰 (Zhou Yanjie) (1):
  clk: Ingenic: Add support for TCU of X1000.

 drivers/clk/ingenic/tcu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.7.4

