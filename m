Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226A0C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008CE2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgANREw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:04:52 -0500
Received: from out28-49.mail.aliyun.com ([115.124.28.49]:53974 "EHLO
        out28-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:04:52 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3167531|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.057565-0.00469513-0.93774;DS=CONTINUE|ham_system_inform|0.518708-0.00449658-0.476795;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03302;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.Gc2hy8j_1579021451;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Gc2hy8j_1579021451)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 15 Jan 2020 01:04:38 +0800
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
Subject: Add HWMON and WiFi support for CU1000-Neo
Date:   Wed, 15 Jan 2020 01:03:45 +0800
Message-Id: <1579021428-43535-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
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

