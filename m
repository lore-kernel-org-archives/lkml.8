Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B166EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6772067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnIF3NKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgGBOsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgGBOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81391C08C5DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so15822848wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A68m/4vXtRoEt+tCUl/deoA+S6NQ0dzD0za0e2IsKFc=;
        b=MnIF3NKMeHllD9bTiFG/UBWre8WcWJwn5Gs+iOqWaPWWVSs3Fmue2tnex/eI8nRqPE
         XQauSD7JfNVMRzo5iKgnr8oq0f8dcrGaXVQgT+wgmvxBBPLfRQpEcxBSpsifs7sxW9TI
         y7LrKuy/z5fGS7KaetA8KIHoBZ1xNWSKfbioR04TI5jOLFjaaMAUV6foseYp2OYdkRM4
         1Z0jBQW5Nt733Tztd5Mv871YZPC7G+E2gk7GlaK964bTvoaRTTMT0v5Op/LxtOUhhyPI
         eeWnTopVRGYVBugAlMM1Yaopc5tKTEPkusEWAxPsCNUFafsAbuPDdUnPwlEpVSXqMaMZ
         sQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A68m/4vXtRoEt+tCUl/deoA+S6NQ0dzD0za0e2IsKFc=;
        b=R0awdzFMzLAzhOGKhyrJj2fNX+rMb0aev+QkfxMFUOWRbEFO7dX7W5GRequuMElZk1
         AalqVAA42fb4s36hMg0L3iZ4HxyM7hmkLZw7V1zUwX9OYf8AjD8dMgwzSnCTlnnC4pwr
         CrsVblnt+deD7gk7nYOfN/9YKtWYmXImE4j5bPtfMAxQ3ByBerTCh2mHVbkFqFb5k6he
         N3m2TfWi5cPYrbp4KXvqWbdk+u/BuHnWq+pFDlB0ZJXvz6AyjYQMptlJLi9oDKUNIPjT
         iYKnmgQpFcLFMQKs92VwLEpdyz+WNtDOLPr8gxdxVmGi9FTbOnE/CcEdsGcrdliWdO12
         TapQ==
X-Gm-Message-State: AOAM531tPDW478XfQ7Xb86iwqh9itFChEVOc7DCO3bmuoQPKKUnRA4e2
        mg5LreVlDqVIVWNe+lqEwn+UGZtR+e4=
X-Google-Smtp-Source: ABdhPJw/XS4Q1S0GGevj+ph6k6w1go7mzC+xGwxs/OouigSO7U4rDiQ8fCZ+aBU/5fV4s1OKUk6Idg==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr32283737wmk.77.1593701208260;
        Thu, 02 Jul 2020 07:46:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 13/30] usb: cdns3: core: Fix incorrect formatting and misspelled function arg docs
Date:   Thu,  2 Jul 2020 15:46:08 +0100
Message-Id: <20200702144625.2533530-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 misspellings and 1 incorrect format used in this file's
kerneldoc function headers.  Fixing them squashes the following W=1
kernel build warnings:

 drivers/usb/cdns3/gadget.c:653: warning: Function parameter or member 'priv_ep' not described in 'cdns3_wa2_descmissing_packet'
 drivers/usb/cdns3/gadget.c:653: warning: Excess function parameter 'priv_dev' description in 'cdns3_wa2_descmissing_packet'
 drivers/usb/cdns3/gadget.c:1088: warning: Function parameter or member 'request' not described in 'cdns3_ep_run_transfer'
 drivers/usb/cdns3/gadget.c:2574: warning: Function parameter or member 'priv_ep' not described in '__cdns3_gadget_ep_set_halt'
 drivers/usb/cdns3/gadget.c:2574: warning: Excess function parameter 'ep' description in '__cdns3_gadget_ep_set_halt'
 drivers/usb/cdns3/gadget.c:2595: warning: Function parameter or member 'priv_ep' not described in '__cdns3_gadget_ep_clear_halt'
 drivers/usb/cdns3/gadget.c:2595: warning: Excess function parameter 'ep' description in '__cdns3_gadget_ep_clear_halt'
 drivers/usb/cdns3/gadget.c:2898: warning: Function parameter or member 'priv_dev' not described in 'cdns3_init_eps'
 drivers/usb/cdns3/gadget.c:2898: warning: Excess function parameter 'cdns3' description in 'cdns3_init_eps'
 drivers/usb/cdns3/gadget.c:3210: warning: Function parameter or member 'cdns' not described in 'cdns3_gadget_init'

Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/cdns3/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 19bbb5b7e6b6c..59e5e213a99bb 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -282,7 +282,7 @@ static int cdns3_idle_init(struct cdns3 *cdns)
 
 /**
  * cdns3_hw_role_switch - switch roles based on HW state
- * @cdns3: controller
+ * @cdns: controller
  */
 int cdns3_hw_role_switch(struct cdns3 *cdns)
 {
@@ -320,7 +320,7 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
 /**
  * cdsn3_role_get - get current role of controller.
  *
- * @dev: Pointer to device structure
+ * @sw: pointer to USB role switch structure
  *
  * Returns role
  */
@@ -334,8 +334,8 @@ static enum usb_role cdns3_role_get(struct usb_role_switch *sw)
 /**
  * cdns3_role_set - set current role of controller.
  *
- * @dev: pointer to device object
- * @role - the previous role
+ * @sw: pointer to USB role switch structure
+ * @role: the previous role
  * Handles below events:
  * - Role switch for dual-role devices
  * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices
-- 
2.25.1

