Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32630C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A7320873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgBJOmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:42:35 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46611 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgBJOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:42:35 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01AEfxVY025063, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01AEfxVY025063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 22:41:59 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 22:41:58 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 22:41:58 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTEXMB01.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server id
 15.1.1779.2 via Frontend Transport; Mon, 10 Feb 2020 22:41:58 +0800
From:   James Tai <james.tai@realtek.com>
To:     <james.ttl7447@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] [DEV_FIX][THOR][B00] Support multiple IR key [REVIEWER] Simon
Date:   Mon, 10 Feb 2020 22:41:53 +0800
Message-ID: <20200210144153.27184-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Tai <james.tai@realtek.com>
---
 rtd16xx_pm.c | 27 ++++++++++++++++-----------
 rtd16xx_pm.h | 12 ++++++++----
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/rtd16xx_pm.c b/rtd16xx_pm.c
index b34ce94..1779670 100644
--- a/rtd16xx_pm.c
+++ b/rtd16xx_pm.c
@@ -44,7 +44,7 @@ unsigned int IsSuspendToWFI;
 unsigned int suspend_ChipVer;
 
 rtk_pm_event_func_t wakeup_events[RTK_PM_MAX_EVENTS];
-param_pwm_irda_key_t param_wakeup_ir_key[RTK_PM_MAX_IR_KEY];
+param_pwm_irda_key_t param_wakeup_ir_key[MAX_KEY_TBL];
 param_pwm_gpio_key_t Param_PWM_GPIO_Key;
 
 unsigned int bt_wakeup_flag;
@@ -119,7 +119,8 @@ int ir_power_on_check(void)
 	unsigned int key_mask = 0;
 	unsigned int power_key = 0;
 	unsigned int custom_key = 0;
-	int i = 0;
+	unsigned int power_keynum = 0;
+	int i = 0, j = 0;
 
 	sr_value = ACCESS(ISO_IR_SR_reg);
 	if(sr_value & 0x1) {
@@ -131,22 +132,24 @@ int ir_power_on_check(void)
 		if (sr_value & 0x2)
 			return 0;
 
-		for (i = 0 ; i < RTK_PM_MAX_IR_KEY ; i++) {
+		for (i = 0 ; i < MAX_KEY_TBL ; i++) {
 			key_shift = param_wakeup_ir_key[i].key_shift;
 			key_mask = param_wakeup_ir_key[i].key_mask;
 			custom_shift = param_wakeup_ir_key[i].custom_shift;
 			custom_mask = param_wakeup_ir_key[i].custom_mask;
-			power_key = param_wakeup_ir_key[i].power_key;
+			power_keynum = param_wakeup_ir_key[i].power_keynum;
 			custom_key = param_wakeup_ir_key[i].custom_key;
 			tmp1 = ((reg_value & key_mask) >> key_shift);
 			tmp2 = ((reg_value & custom_mask) >> custom_shift);
 
 			if (key_mask == 0 && custom_mask == 0) 
 				return 0;
-
-			if (power_key == tmp1 &&  custom_key == tmp2) {
-				ACCESS(0xD8007640) = 0xea000000 | (RESUME_IR << 16);
-				return 1;
+			for (j = 0; j < power_keynum; j++) {
+				power_key = param_wakeup_ir_key[i].power_key[j];
+				if (power_key == tmp1 &&  custom_key == tmp2) {
+					ACCESS(0xD8007640) = 0xea000000 | (RESUME_IR << 16);
+					return 1;
+				}
 			}
 		}
 	}
@@ -409,7 +412,7 @@ int rtk_power_on_event(void)
 
 void rtk_power_on_event_init(struct suspend_param *scpu_param)
 {
-	int i = 0;
+	int i = 0, j = 0;
 	wakeup_event_int_mask = 0;
 
 	if (7093279 != trace_power)
@@ -422,10 +425,12 @@ void rtk_power_on_event_init(struct suspend_param *scpu_param)
 
 	/* Enable IR Interrupt */
 	if (suspend_wakeup_flag & fWAKEUP_ON_IR) {
-		for (i = 0 ; i< 2; i++) {
+		for (i = 0 ; i < MAX_KEY_TBL ; i++) {
 			param_wakeup_ir_key[i].protocol = scpu_param->irda_info.key_tbl[i].protocol;
 			param_wakeup_ir_key[i].key_mask = scpu_param->irda_info.key_tbl[i].scancode_mask;
-			param_wakeup_ir_key[i].power_key = scpu_param->irda_info.key_tbl[i].wakeup_scancode;
+			param_wakeup_ir_key[i].power_keynum = scpu_param->irda_info.key_tbl[i].wakeup_keynum;
+			for (j = 0; j < param_wakeup_ir_key[i].power_keynum; j++)
+				param_wakeup_ir_key[i].power_key[j] = scpu_param->irda_info.key_tbl[i].wakeup_scancode[j];
 
 			for (param_wakeup_ir_key[i].key_shift = 0; param_wakeup_ir_key[i].key_shift < 32; param_wakeup_ir_key[i].key_shift++) {
 				if ((param_wakeup_ir_key[i].key_mask & (1 << param_wakeup_ir_key[i].key_shift))) {
diff --git a/rtd16xx_pm.h b/rtd16xx_pm.h
index ebebc79..10c1eab 100644
--- a/rtd16xx_pm.h
+++ b/rtd16xx_pm.h
@@ -14,7 +14,6 @@
 #define SUSPEND_ISO_GPIO_BASE 0
 #define SUSPEND_ISO_GPIO_SIZE 86
 
-#define RTK_PM_MAX_IR_KEY 2
 #define RTK_PM_MAX_EVENTS 8
 
 #define RESUME_STATE_ADDR (boot_offset_base+0x118)
@@ -33,10 +32,14 @@
 #define BT_WAKEUP_ACTIVE_HIGH (0x1 << 23)
 #define BT_WAKEUP_MASK 0x00EFFFFF
 
+#define MAX_WAKEUP_CODE 16
+#define MAX_KEY_TBL 2
+
 struct irda_wake_up_key {
 	unsigned int protocol;
 	unsigned int scancode_mask;
-	unsigned int wakeup_scancode;
+	unsigned int wakeup_keynum;
+	unsigned int wakeup_scancode[MAX_WAKEUP_CODE];
 	unsigned int cus_mask;
 	unsigned int cus_code;
 };
@@ -44,7 +47,7 @@ struct irda_wake_up_key {
 struct ipc_shm_irda {
 	unsigned int ipc_shm_ir_magic;
 	unsigned int dev_count;
-	struct irda_wake_up_key key_tbl[2];
+	struct irda_wake_up_key key_tbl[MAX_KEY_TBL];
 };
 
 struct ipc_shm_cec {
@@ -93,7 +96,8 @@ typedef struct param_pwm_irda_key
 {
 	unsigned int is_valid;
 	unsigned int protocol;
-	unsigned int power_key;
+	unsigned int power_keynum;
+	unsigned int power_key[MAX_WAKEUP_CODE];
 	unsigned int key_mask;
 	unsigned int key_shift;
 	unsigned int custom_key;
-- 
2.25.0

