Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98008C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D47024670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgANRFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:05:10 -0500
Received: from out28-97.mail.aliyun.com ([115.124.28.97]:54322 "EHLO
        out28-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgANRFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:05:10 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1414993|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0564114-0.00543623-0.938152;DS=CONTINUE|ham_system_inform|0.0788228-0.00257501-0.918602;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.Gc2hy8j_1579021451;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Gc2hy8j_1579021451)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 15 Jan 2020 01:04:42 +0800
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
Subject: [PATCH 2/2] MIPS: CU1000-Neo: Refresh defconfig to support HWMON and WiFi.
Date:   Wed, 15 Jan 2020 01:03:48 +0800
Message-Id: <1579021428-43535-4-git-send-email-zhouyanjie@wanyeetech.com>
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

Refresh CU1000-Neo's defconfig to support ADS7830 based HWMON
and AP6212A WiFi module.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 arch/mips/configs/cu1000-neo_defconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/configs/cu1000-neo_defconfig b/arch/mips/configs/cu1000-neo_defconfig
index 9f988ed..9b05a8f 100644
--- a/arch/mips/configs/cu1000-neo_defconfig
+++ b/arch/mips/configs/cu1000-neo_defconfig
@@ -34,8 +34,10 @@ CONFIG_HZ_100=y
 CONFIG_CMA=y
 CONFIG_CMA_AREAS=7
 CONFIG_NET=y
+CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
+CONFIG_CFG80211=y
 CONFIG_UEVENT_HELPER=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -44,6 +46,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_NETDEVICES=y
 CONFIG_STMMAC_ETH=y
 CONFIG_SMSC_PHY=y
+CONFIG_BRCMFMAC=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -58,10 +61,12 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=3
 CONFIG_SERIAL_8250_INGENIC=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_JZ4780=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_SENSORS_ADS7828=y
 CONFIG_WATCHDOG=y
 CONFIG_JZ4740_WDT=y
-# CONFIG_HWMON is not set
 # CONFIG_LCD_CLASS_DEVICE is not set
 # CONFIG_BACKLIGHT_CLASS_DEVICE is not set
 # CONFIG_VGA_CONSOLE is not set
@@ -83,6 +88,7 @@ CONFIG_PROC_KCORE=y
 # CONFIG_PROC_PAGE_MONITOR is not set
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
+CONFIG_NFS_FS=y
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_936=y
 CONFIG_NLS_CODEPAGE_950=y
-- 
2.7.4

