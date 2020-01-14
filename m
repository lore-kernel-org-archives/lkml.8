Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BC6C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B7324670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgANREr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:04:47 -0500
Received: from out28-123.mail.aliyun.com ([115.124.28.123]:42149 "EHLO
        out28-123.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANREr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:04:47 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1482133|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.032255-0.00206675-0.965678;DS=CONTINUE|ham_system_inform|0.020482-0.00111349-0.978404;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07426;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.Gc2hy8j_1579021451;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Gc2hy8j_1579021451)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 15 Jan 2020 01:04:39 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        jhogan@kernel.org, mark.rutland@arm.com, syq@debian.org,
        ralf@linux-mips.org, rick.tyliu@ingenic.com, jason@lakedaemon.net,
        keescook@chromium.org, geert+renesas@glider.be, krzk@kernel.org,
        paul@crapouillou.net, prasannatsmkumar@gmail.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com,
        ebiederm@xmission.com
Subject: [PATCH 0/2] Add HWMON and WiFi support for CU1000-Neo.
Date:   Wed, 15 Jan 2020 01:03:46 +0800
Message-Id: <1579021428-43535-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579021428-43535-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1579021428-43535-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C0/I2C1/I2C2 nodes for X1000 and add I2C0, ADS7830,
MSC1, AP6212A, wlan_pwrseq nodes for CU1000-Neo. Refresh
CU1000-Neo's defconfig to support ADS7830 based HWMON
and AP6212A WiFi module.

周琰杰 (Zhou Yanjie) (2):
  MIPS: Ingenic: Add missing nodes for X1000 and CU1000-Neo.
  MIPS: CU1000-Neo: Refresh defconfig to support HWMON and WiFi.

 arch/mips/boot/dts/ingenic/cu1000-neo.dts | 71 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/ingenic/x1000.dtsi     | 45 ++++++++++++++++++++
 arch/mips/configs/cu1000-neo_defconfig    |  8 +++-
 3 files changed, 123 insertions(+), 1 deletion(-)

-- 
2.7.4

