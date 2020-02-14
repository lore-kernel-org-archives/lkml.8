Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FADC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B371C24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404320AbgBNR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:28:28 -0500
Received: from out28-197.mail.aliyun.com ([115.124.28.197]:50278 "EHLO
        out28-197.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390971AbgBNR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:28:22 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3562688|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0420594-0.000702339-0.957238;DS=CONTINUE|ham_system_inform|0.10361-0.00045707-0.895933;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.Go9djQb_1581701284;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Go9djQb_1581701284)
          by smtp.aliyun-inc.com(10.147.41.231);
          Sat, 15 Feb 2020 01:28:16 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Add support for the X1830 and fix bugs for X1000 v5.
Date:   Sat, 15 Feb 2020 01:27:35 +0800
Message-Id: <1581701262-110556-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4->v5:
1.Rebase on top of kernel 5.6-rc1.
2.Fix bugs for X1000.

