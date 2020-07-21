Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C99C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DB7207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2x7VwIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbgGUQnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbgGUQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA05C0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so3483382wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5moYOsQHNMfa9tXzAVeWKCnn+cRnTzIzblynCSGXK4c=;
        b=O2x7VwIfuIZ3VNbLlighaWVfeB0yeXS/Lx+xdzBYMU07UNVsKrw8y+RFjjuWcgu5Ui
         1lZPuwa3wVCDIHy2hQHjdPEbXLdb+UPNXUtwZ31338DZpcrBT3hFSEQOuDflnVPc7HDn
         qVnJlsY56XgMeGLaCaUl0f+r1e5I16ZfQCXycLMgKrqlbxYdqWHSzjQtwnqQn+DqcDpK
         FQia3OI6pCN34dlP3LYwReIqZ4ZVcK9yhGqjYmu2hsgvFDC7c4wElxn6qLZ3cTgaGLS8
         XaOeLg63z5mr2Fn4jXY+47jgAb8lQSvfTdcvNxbg+FErsHmgw81DUqfE++GTKH3upTuN
         Gvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5moYOsQHNMfa9tXzAVeWKCnn+cRnTzIzblynCSGXK4c=;
        b=H+0wW0yD9ez1yK9EsjaLifce54RvZ5Nx1bxmuct+iLBqKzXwbrpQeZy45G1sMumg1b
         eJ+GWQlWee5EJjuUOZ8iAeLielX3pUHh9+djnO6feGiGHAuGbYCoKkLLFsDRWLkS3tRF
         9qROUl3fEt+6kz7O6FIus50v0WV4263ANHUlbNC9vCR8UiRvj9aWPJwklS0HFy95GdSj
         Ibgvbub42wCor/Y5Kp/VUblQIWpSRbEQcP38gwFajmSd457FG2WUHp/xzIkL2gPbjblQ
         yldIzTExPk5rtVObZhsDPusL13EZPZhqK/9nWAZTL/uDxEKaDrN1YETApMyhT1BfwS2n
         U8tw==
X-Gm-Message-State: AOAM532AcFpKQZaNYEXutLEe5JK4sSmXxyPNM+6v5hAuZFFg+mp2JoXx
        K8vfVDJk2yr5ieOQW21fkVLS6A==
X-Google-Smtp-Source: ABdhPJy5kA2bDswapKLTPk58+azM7iLRGYx3AlsNSjo24hpISBt38pcm4YK3DCruzOF4KH/z+vz8Wg==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr4720062wme.0.1595349755167;
        Tue, 21 Jul 2020 09:42:35 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com
Subject: [PATCH 27/40] scsi: qla4xxx: ql4_isr: Repair function documentation headers
Date:   Tue, 21 Jul 2020 17:41:35 +0100
Message-Id: <20200721164148.2617584-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one formatting issue, one misspelling and three missing
descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla4xxx/ql4_isr.c:588: warning: Excess function parameter 'ret' description in 'qla4_83xx_loopback_in_progress'
 drivers/scsi/qla4xxx/ql4_isr.c:661: warning: Function parameter or member 'mbox_status' not described in 'qla4xxx_isr_decode_mailbox'
 drivers/scsi/qla4xxx/ql4_isr.c:661: warning: Excess function parameter 'mailbox_status' description in 'qla4xxx_isr_decode_mailbox'
 drivers/scsi/qla4xxx/ql4_isr.c:1053: warning: Function parameter or member 'intr_status' not described in 'qla4_82xx_interrupt_service_routine'
 drivers/scsi/qla4xxx/ql4_isr.c:1078: warning: Function parameter or member 'intr_status' not described in 'qla4xxx_interrupt_service_routine'

Cc: QLogic-Storage-Upstream@qlogic.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla4xxx/ql4_isr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_isr.c b/drivers/scsi/qla4xxx/ql4_isr.c
index d2cd33d8d67fc..ade5eafdf81e8 100644
--- a/drivers/scsi/qla4xxx/ql4_isr.c
+++ b/drivers/scsi/qla4xxx/ql4_isr.c
@@ -582,7 +582,7 @@ void qla4xxx_process_response_queue(struct scsi_qla_host *ha)
 /**
  * qla4_83xx_loopback_in_progress: Is loopback in progress?
  * @ha: Pointer to host adapter structure.
- * @ret: 1 = loopback in progress, 0 = loopback not in progress
+ * returns: 1 = loopback in progress, 0 = loopback not in progress
  **/
 static int qla4_83xx_loopback_in_progress(struct scsi_qla_host *ha)
 {
@@ -651,7 +651,7 @@ static void qla4xxx_default_router_changed(struct scsi_qla_host *ha,
 /**
  * qla4xxx_isr_decode_mailbox - decodes mailbox status
  * @ha: Pointer to host adapter structure.
- * @mailbox_status: Mailbox status.
+ * @mbox_status: Mailbox status.
  *
  * This routine decodes the mailbox status during the ISR.
  * Hardware_lock locked upon entry. runs in interrupt context.
@@ -1044,6 +1044,7 @@ void qla4_83xx_interrupt_service_routine(struct scsi_qla_host *ha,
 /**
  * qla4_82xx_interrupt_service_routine - isr
  * @ha: pointer to host adapter structure.
+ * @intr_status: Local interrupt status/type.
  *
  * This is the main interrupt service routine.
  * hardware_lock locked upon entry. runs in interrupt context.
@@ -1069,6 +1070,7 @@ void qla4_82xx_interrupt_service_routine(struct scsi_qla_host *ha,
 /**
  * qla4xxx_interrupt_service_routine - isr
  * @ha: pointer to host adapter structure.
+ * @intr_status: Local interrupt status/type.
  *
  * This is the main interrupt service routine.
  * hardware_lock locked upon entry. runs in interrupt context.
-- 
2.25.1

