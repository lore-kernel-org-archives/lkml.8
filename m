Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF094C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE4920767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARVv8HhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406218AbgFYQbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406195AbgFYQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A83C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so6177747wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WT7h1Rv45O3atqnarAKKAFYuh59qbPlwPNodrXrSPg=;
        b=ARVv8HhUOnUYrUqklxVAxxRHJM0L4zbLlrC6PuHsKVz+pl9qu2EmdJVm2WIqJFCgbR
         U0bNDkLkLD0AtQxk6WAfnyDBsVYqXiIfUxUtbN94mYHriEytUv76VRMv5xMYUC7Ni8Ar
         a5TYx1foBZNaPvLg9DB5kg/pANL4nZ7PIIBIjUjvaPjMCupvQVpT0S4RStIWAgWOPrJQ
         EL7YNzaNvPJtUD4FXyxm2OY59xVcQ2OilUE/OxPx1QtM47arj0JF+rpFjFH1AU7l6oz7
         +r4IrLacD/9n+iVVxd523LlQ8EiD5zMzhjXoxpEKHN11f76hMUB9BDbNAOOx6lgZ47ow
         9XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WT7h1Rv45O3atqnarAKKAFYuh59qbPlwPNodrXrSPg=;
        b=ZXuCRFOa7Gkrck4l2LMumiyW39y9++pYcftQ5QkQK6utnestA5IrTsRk+BZzDeDxxI
         ZN5eFlHLYbJEnvr/piH5x4lZW9wCcWK2GPMJBgY/wJCNtRqtcufDNzdk80gNnprVlyyH
         BU7uBWJfxSXW8QE/+ueFzWQgrbHNoDlnNeDOZzAyFdP3rF0hwTLcuiNTp4OFj2SLZG94
         JVCcYqHgDR9vvavwdKfmspK4jAE4b6QMMlSgGWJVforASwposkU+9STQ35+mSoiWbA1o
         9oHbOdKfrAs3GwLhOtL698PAcvmPGX2gC7aE1Ofb+X4RvUDg+aTVetScLH1nw1IXw+n5
         6dvg==
X-Gm-Message-State: AOAM530YhYU3Btr/UeSzMFvCQ8kyhbD4xp+XoV89EsK4nWw5170PvdBq
        47qASE+2q7+nc+o0AfCaUXi7XQ==
X-Google-Smtp-Source: ABdhPJwJwWjOF0ZaS/IPLE2Q4MNqGjjLQnhA8K9AoN9yt+zSvcXTt+viMKV9cibJeAkDvqX5+5rcTw==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr4258261wmc.188.1593102701324;
        Thu, 25 Jun 2020 09:31:41 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 07/10] mfd: si476x-cmd: Add missing colon(s) for all documented kerneldoc arguments
Date:   Thu, 25 Jun 2020 17:31:24 +0100
Message-Id: <20200625163127.4000462-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163127.4000462-1-lee.jones@linaro.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc validation gets confused if syntax isn't "@.*: ".

Adding the missing colons squashes the following W=1 warnings:

 drivers/mfd/si476x-cmd.c:525: warning: Function parameter or member 'dout' not described in 'si476x_core_cmd_dig_audio_pin_c
 drivers/mfd/si476x-cmd.c:525: warning: Function parameter or member 'xout' not described in 'si476x_core_cmd_dig_audio_pin_c
 drivers/mfd/si476x-cmd.c:574: warning: Function parameter or member 'core' not described in 'si476x_core_cmd_zif_pin_cfg'
 drivers/mfd/si476x-cmd.c:574: warning: Function parameter or member 'iqclk' not described in 'si476x_core_cmd_zif_pin_cfg'
 drivers/mfd/si476x-cmd.c:574: warning: Function parameter or member 'iqfs' not described in 'si476x_core_cmd_zif_pin_cfg'
 drivers/mfd/si476x-cmd.c:574: warning: Function parameter or member 'iout' not described in 'si476x_core_cmd_zif_pin_cfg'
 drivers/mfd/si476x-cmd.c:574: warning: Function parameter or member 'qout' not described in 'si476x_core_cmd_zif_pin_cfg'
 drivers/mfd/si476x-i2c.c:550: warning: Function parameter or member 'func' not described in 'si476x_core_fwver_to_revision'
 drivers/mfd/si476x-cmd.c:631: warning: Function parameter or member 'core' not described in 'si476x_core_cmd_ic_link_gpo_ctl
 drivers/mfd/si476x-cmd.c:631: warning: Function parameter or member 'icin' not described in 'si476x_core_cmd_ic_link_gpo_ctl
 drivers/mfd/si476x-cmd.c:631: warning: Function parameter or member 'icip' not described in 'si476x_core_cmd_ic_link_gpo_ctl
 drivers/mfd/si476x-cmd.c:631: warning: Function parameter or member 'icon' not described in 'si476x_core_cmd_ic_link_gpo_ctl
 drivers/mfd/si476x-cmd.c:631: warning: Function parameter or member 'icop' not described in 'si476x_core_cmd_ic_link_gpo_ctl
 drivers/mfd/si476x-cmd.c:662: warning: Function parameter or member 'core' not described in 'si476x_core_cmd_ana_audio_pin_c
 drivers/mfd/si476x-cmd.c:662: warning: Function parameter or member 'lrout' not described in 'si476x_core_cmd_ana_audio_pin_
 drivers/mfd/si476x-cmd.c:697: warning: Function parameter or member 'core' not described in 'si476x_core_cmd_intb_pin_cfg_a1
 drivers/mfd/si476x-cmd.c:697: warning: Function parameter or member 'intb' not described in 'si476x_core_cmd_intb_pin_cfg_a1
 drivers/mfd/si476x-cmd.c:697: warning: Function parameter or member 'a1' not described in 'si476x_core_cmd_intb_pin_cfg_a10'
 drivers/mfd/si476x-cmd.c:746: warning: Function parameter or member 'core' not described in 'si476x_core_cmd_am_rsq_status'
 drivers/mfd/si476x-cmd.c:746: warning: Function parameter or member 'rsqargs' not described in 'si476x_core_cmd_am_rsq_statu
 drivers/mfd/si476x-cmd.c:746: warning: Function parameter or member 'report' not described in 'si476x_core_cmd_am_rsq_status
 drivers/mfd/si476x-cmd.c:878: warning: Function parameter or member 'core' not described in 'si476x_core_cmd_fm_seek_start'
 drivers/mfd/si476x-cmd.c:878: warning: Function parameter or member 'seekup' not described in 'si476x_core_cmd_fm_seek_start
 drivers/mfd/si476x-cmd.c:878: warning: Function parameter or member 'wrap' not described in 'si476x_core_cmd_fm_seek_start'
 drivers/mfd/si476x-cmd.c:907: warning: Function parameter or member 'core' not described in 'si476x_core_cmd_fm_rds_status'
 drivers/mfd/si476x-cmd.c:907: warning: Function parameter or member 'status_only' not described in 'si476x_core_cmd_fm_rds_s
 drivers/mfd/si476x-cmd.c:907: warning: Function parameter or member 'mtfifo' not described in 'si476x_core_cmd_fm_rds_status
 drivers/mfd/si476x-cmd.c:907: warning: Function parameter or member 'intack' not described in 'si476x_core_cmd_fm_rds_status
 drivers/mfd/si476x-cmd.c:907: warning: Function parameter or member 'report' not described in 'si476x_core_cmd_fm_rds_status
 drivers/mfd/si476x-cmd.c:1052: warning: Function parameter or member 'core' not described in 'si476x_core_cmd_am_seek_start'
 drivers/mfd/si476x-cmd.c:1052: warning: Function parameter or member 'seekup' not described in 'si476x_core_cmd_am_seek_star
 drivers/mfd/si476x-cmd.c:1052: warning: Function parameter or member 'wrap' not described in 'si476x_core_cmd_am_seek_start'

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-cmd.c | 66 ++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/si476x-cmd.c b/drivers/mfd/si476x-cmd.c
index 316d44c2edcd4..5b42dfab431a3 100644
--- a/drivers/mfd/si476x-cmd.c
+++ b/drivers/mfd/si476x-cmd.c
@@ -496,7 +496,7 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_get_property);
  *                             enable 1MOhm pulldown
  *      SI476X_DFS_DAUDIO    - set the pin to be a part of digital
  *                             audio interface
- * @dout - DOUT pin function configuration:
+ * @dout: - DOUT pin function configuration:
  *      SI476X_DOUT_NOOP       - do not modify the behaviour
  *      SI476X_DOUT_TRISTATE   - put the pin in tristate condition,
  *                               enable 1MOhm pulldown
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_get_property);
  *                               port 1
  *      SI476X_DOUT_I2S_INPUT  - set this pin to be digital in on I2S
  *                               port 1
- * @xout - XOUT pin function configuration:
+ * @xout: - XOUT pin function configuration:
  *	SI476X_XOUT_NOOP        - do not modify the behaviour
  *      SI476X_XOUT_TRISTATE    - put the pin in tristate condition,
  *                                enable 1MOhm pulldown
@@ -540,25 +540,25 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_dig_audio_pin_cfg);
 
 /**
  * si476x_cmd_zif_pin_cfg - send 'ZIF_PIN_CFG_COMMAND'
- * @core - device to send the command to
- * @iqclk - IQCL pin function configuration:
+ * @core: - device to send the command to
+ * @iqclk: - IQCL pin function configuration:
  *       SI476X_IQCLK_NOOP     - do not modify the behaviour
  *       SI476X_IQCLK_TRISTATE - put the pin in tristate condition,
  *                               enable 1MOhm pulldown
  *       SI476X_IQCLK_IQ       - set pin to be a part of I/Q interace
  *                               in master mode
- * @iqfs - IQFS pin function configuration:
+ * @iqfs: - IQFS pin function configuration:
  *       SI476X_IQFS_NOOP     - do not modify the behaviour
  *       SI476X_IQFS_TRISTATE - put the pin in tristate condition,
  *                              enable 1MOhm pulldown
  *       SI476X_IQFS_IQ       - set pin to be a part of I/Q interace
  *                              in master mode
- * @iout - IOUT pin function configuration:
+ * @iout: - IOUT pin function configuration:
  *       SI476X_IOUT_NOOP     - do not modify the behaviour
  *       SI476X_IOUT_TRISTATE - put the pin in tristate condition,
  *                              enable 1MOhm pulldown
  *       SI476X_IOUT_OUTPUT   - set pin to be I out
- * @qout - QOUT pin function configuration:
+ * @qout: - QOUT pin function configuration:
  *       SI476X_QOUT_NOOP     - do not modify the behaviour
  *       SI476X_QOUT_TRISTATE - put the pin in tristate condition,
  *                              enable 1MOhm pulldown
@@ -590,29 +590,29 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_zif_pin_cfg);
 /**
  * si476x_cmd_ic_link_gpo_ctl_pin_cfg - send
  * 'IC_LINK_GPIO_CTL_PIN_CFG' comand to the device
- * @core - device to send the command to
- * @icin - ICIN pin function configuration:
+ * @core: - device to send the command to
+ * @icin: - ICIN pin function configuration:
  *      SI476X_ICIN_NOOP      - do not modify the behaviour
  *      SI476X_ICIN_TRISTATE  - put the pin in tristate condition,
  *                              enable 1MOhm pulldown
  *      SI476X_ICIN_GPO1_HIGH - set pin to be an output, drive it high
  *      SI476X_ICIN_GPO1_LOW  - set pin to be an output, drive it low
  *      SI476X_ICIN_IC_LINK   - set the pin to be a part of Inter-Chip link
- * @icip - ICIP pin function configuration:
+ * @icip: - ICIP pin function configuration:
  *      SI476X_ICIP_NOOP      - do not modify the behaviour
  *      SI476X_ICIP_TRISTATE  - put the pin in tristate condition,
  *                              enable 1MOhm pulldown
  *      SI476X_ICIP_GPO1_HIGH - set pin to be an output, drive it high
  *      SI476X_ICIP_GPO1_LOW  - set pin to be an output, drive it low
  *      SI476X_ICIP_IC_LINK   - set the pin to be a part of Inter-Chip link
- * @icon - ICON pin function configuration:
+ * @icon: - ICON pin function configuration:
  *      SI476X_ICON_NOOP     - do not modify the behaviour
  *      SI476X_ICON_TRISTATE - put the pin in tristate condition,
  *                             enable 1MOhm pulldown
  *      SI476X_ICON_I2S      - set the pin to be a part of audio
  *                             interface in slave mode (DCLK)
  *      SI476X_ICON_IC_LINK  - set the pin to be a part of Inter-Chip link
- * @icop - ICOP pin function configuration:
+ * @icop: - ICOP pin function configuration:
  *      SI476X_ICOP_NOOP     - do not modify the behaviour
  *      SI476X_ICOP_TRISTATE - put the pin in tristate condition,
  *                             enable 1MOhm pulldown
@@ -647,8 +647,8 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_ic_link_gpo_ctl_pin_cfg);
 /**
  * si476x_cmd_ana_audio_pin_cfg - send 'ANA_AUDIO_PIN_CFG' to the
  * device
- * @core - device to send the command to
- * @lrout - LROUT pin function configuration:
+ * @core: - device to send the command to
+ * @lrout: - LROUT pin function configuration:
  *       SI476X_LROUT_NOOP     - do not modify the behaviour
  *       SI476X_LROUT_TRISTATE - put the pin in tristate condition,
  *                               enable 1MOhm pulldown
@@ -675,15 +675,15 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_ana_audio_pin_cfg);
 
 /**
  * si476x_cmd_intb_pin_cfg - send 'INTB_PIN_CFG' command to the device
- * @core - device to send the command to
- * @intb - INTB pin function configuration:
+ * @core: - device to send the command to
+ * @intb: - INTB pin function configuration:
  *      SI476X_INTB_NOOP     - do not modify the behaviour
  *      SI476X_INTB_TRISTATE - put the pin in tristate condition,
  *                             enable 1MOhm pulldown
  *      SI476X_INTB_DAUDIO   - set pin to be a part of digital
  *                             audio interface in slave mode
  *      SI476X_INTB_IRQ      - set pin to be an interrupt request line
- * @a1 - A1 pin function configuration:
+ * @a1: - A1 pin function configuration:
  *      SI476X_A1_NOOP     - do not modify the behaviour
  *      SI476X_A1_TRISTATE - put the pin in tristate condition,
  *                           enable 1MOhm pulldown
@@ -728,14 +728,14 @@ static int si476x_core_cmd_intb_pin_cfg_a20(struct si476x_core *core,
 /**
  * si476x_cmd_am_rsq_status - send 'AM_RSQ_STATUS' command to the
  * device
- * @core  - device to send the command to
- * @rsqack - if set command clears RSQINT, SNRINT, SNRLINT, RSSIHINT,
+ * @core:  - device to send the command to
+ * @rsqack: - if set command clears RSQINT, SNRINT, SNRLINT, RSSIHINT,
  *           RSSSILINT, BLENDINT, MULTHINT and MULTLINT
- * @attune - when set the values in the status report are the values
+ * @attune: - when set the values in the status report are the values
  *           that were calculated at tune
- * @cancel - abort ongoing seek/tune opertation
- * @stcack - clear the STCINT bin in status register
- * @report - all signal quality information retured by the command
+ * @cancel: - abort ongoing seek/tune opertation
+ * @stcack: - clear the STCINT bin in status register
+ * @report: - all signal quality information retured by the command
  *           (if NULL then the output of the command is ignored)
  *
  * Function returns 0 on success and negative error code on failure
@@ -862,9 +862,9 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_am_acf_status);
 /**
  * si476x_cmd_fm_seek_start - send 'FM_SEEK_START' command to the
  * device
- * @core  - device to send the command to
- * @seekup - if set the direction of the search is 'up'
- * @wrap   - if set seek wraps when hitting band limit
+ * @core:  - device to send the command to
+ * @seekup: - if set the direction of the search is 'up'
+ * @wrap:   - if set seek wraps when hitting band limit
  *
  * This function begins search for a valid station. The station is
  * considered valid when 'FM_VALID_SNR_THRESHOLD' and
@@ -890,12 +890,12 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_fm_seek_start);
 /**
  * si476x_cmd_fm_rds_status - send 'FM_RDS_STATUS' command to the
  * device
- * @core - device to send the command to
- * @status_only - if set the data is not removed from RDSFIFO,
+ * @core: - device to send the command to
+ * @status_only: - if set the data is not removed from RDSFIFO,
  *                RDSFIFOUSED is not decremented and data in all the
  *                rest RDS data contains the last valid info received
- * @mtfifo if set the command clears RDS receive FIFO
- * @intack if set the command clards the RDSINT bit.
+ * @mtfifo: if set the command clears RDS receive FIFO
+ * @intack: if set the command clards the RDSINT bit.
  *
  * Function returns 0 on success and negative error code on failure
  */
@@ -1036,9 +1036,9 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_fm_phase_div_status);
 /**
  * si476x_cmd_am_seek_start - send 'FM_SEEK_START' command to the
  * device
- * @core  - device to send the command to
- * @seekup - if set the direction of the search is 'up'
- * @wrap   - if set seek wraps when hitting band limit
+ * @core:  - device to send the command to
+ * @seekup: - if set the direction of the search is 'up'
+ * @wrap:   - if set seek wraps when hitting band limit
  *
  * This function begins search for a valid station. The station is
  * considered valid when 'FM_VALID_SNR_THRESHOLD' and
-- 
2.25.1

