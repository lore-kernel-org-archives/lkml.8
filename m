Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A613C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA122184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588998983;
	bh=MsHyWUcutHDu0TRrl1L1LHV5yIWyMJML42Cy1l5wH8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AMK8Bi1Dp2IfZJYXqawq1xYsG+YQvwoKGCyKZI+4MX+Q3od9N4hHJQO7a22l0LzZz
	 NyzCER1h063ttA0CM2F2qW8AsjqxoZfa/71Sarq92q1wvYolx/1yGMLHTNb4yoclRG
	 BRVPLjXSCbSAITxv8IcQ1TbLuD+OjzSGZbM+CAvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgEIEgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:36:21 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55657 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgEIEgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:36:16 -0400
Received: by mail-pj1-f66.google.com with SMTP id k7so229117pjs.5;
        Fri, 08 May 2020 21:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0XUPR8gTRBaK/zVNrQDrzctO9dsoRkXZA68QpWb+cw=;
        b=hJ0h2BDp55l7fsTlVfnT9HPmIM8rGMSS2nIYaU6P5Xz/m4ewUhNIT2dernZJNy2ulm
         UJueO0sAGESaVpd+TKmt6ziykKlHrgGW/wRflARfQF093mDTFWGg4xVf6jPlLCdrtKN/
         VgEnOQZSEJRS7wTGGFTeQbcW9sGu91vc+eQBKFV19JEU1zd/MW9E3wQDdpUVs1yviBSU
         VFAWF74ajS4jdeG3WagsBf56lTT2XGTktTFtZHXSzn9cVd8JQGV/GzRY8XvoDP0aHWwB
         Jmb7e1RbUule8TUmeNQIJpUomFA4Kb+ePi9YAzmiQP2X627izT2GtlD7AAPGnW9ZDUoT
         RMJQ==
X-Gm-Message-State: AGi0PuYOhFrYUlLMLALcR8Mhj8upw071mYQfGQTIENMJGvC4+gyURe+e
        97XW1UXrgPHCw0FV9KpA10s=
X-Google-Smtp-Source: APiQypIpLPKRngDi2nwKB/l9ruVNOfAboQdFftzYLEjRsOGUFsV5rsG+XovjkSD/u+zzSn9mOCV65w==
X-Received: by 2002:a17:90a:498a:: with SMTP id d10mr10105139pjh.194.1588998974401;
        Fri, 08 May 2020 21:36:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 1sm3248272pff.151.2020.05.08.21.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 21:36:07 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 34880422E5; Sat,  9 May 2020 04:36:01 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com
Subject: [PATCH 09/15] qed: use new module_firmware_crashed()
Date:   Sat,  9 May 2020 04:35:46 +0000
Message-Id: <20200509043552.8745-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200509043552.8745-1-mcgrof@kernel.org>
References: <20200509043552.8745-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes use of the new module_firmware_crashed() to help
annotate when firmware for device drivers crash. When firmware
crashes devices can sometimes become unresponsive, and recovery
sometimes requires a driver unload / reload and in the worst cases
a reboot.

Using a taint flag allows us to annotate when this happens clearly.

Cc: Ariel Elior <aelior@marvell.com>
Cc: GR-everest-linux-l2@marvell.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index f4eebaabb6d0..9cc6287b889b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -7854,6 +7854,7 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 						 REGDUMP_HEADER_SIZE,
 						 &feature_size);
 		if (!rc) {
+			module_firmware_crashed();
 			*(u32 *)((u8 *)buffer + offset) =
 			    qed_calc_regdump_header(cdev, PROTECTION_OVERRIDE,
 						    cur_engine,
@@ -7869,6 +7870,7 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 		rc = qed_dbg_fw_asserts(cdev, (u8 *)buffer + offset +
 					REGDUMP_HEADER_SIZE, &feature_size);
 		if (!rc) {
+			module_firmware_crashed();
 			*(u32 *)((u8 *)buffer + offset) =
 			    qed_calc_regdump_header(cdev, FW_ASSERTS,
 						    cur_engine, feature_size,
@@ -7906,6 +7908,7 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 		rc = qed_dbg_grc(cdev, (u8 *)buffer + offset +
 				 REGDUMP_HEADER_SIZE, &feature_size);
 		if (!rc) {
+			module_firmware_crashed();
 			*(u32 *)((u8 *)buffer + offset) =
 			    qed_calc_regdump_header(cdev, GRC_DUMP,
 						    cur_engine,
-- 
2.25.1

