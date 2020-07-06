Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79858C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B52120720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmBVebwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgGFNfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgGFNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9EAC08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so29667470wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSBmUEMtRAkmV+CU8DDs33V6Fj7L3lkyKFBYAuPbnWo=;
        b=LmBVebwTpb3hcf8Ha93SPa2Exe83aigE3ZaCUunazh7JTvq3EWJEWpqGePjMgFSTjb
         48vX7pAPemaRg1gLv34mqX7sXrAi3nrEJ9sw6OthtRsStvw4ItfWxnkvnggDsy34E5w9
         WqaT5ePM1xzwUTGIf+o6kze7UQ0iHA8TpdfyoA1ZsJFnmAtVIBK+7EYZrAfk4G5wpN3X
         DAZteStJ5xgL7d1H4sT7JSE2FDseqOLiRfTspauoOJoTD/bnthzve1DhYXa8UH4/DtPU
         ZUosrpWbfoqcwxEE3GUSHibRfFB/Wq9aZfcqyMgKtusOkeJUIQXfa9x+iX+fjUXlR0QD
         mQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSBmUEMtRAkmV+CU8DDs33V6Fj7L3lkyKFBYAuPbnWo=;
        b=MwEyZjILWwKjZT0TqnGTZm0wNWfh5011zydMFf5xS49f6Nvr/xA+iveySeQJlAo1uE
         DrwD/HM8dw1/gEwl94SKuuCjTQtk7yOJedIoGJHNVCARWzSuJ9nscMkxE379NwVrWi56
         L7WbuDZkPJ9+RRUc1u1lHPXgNxYZ3GUEFYOpZm2hrX6hSSyL6mJq9ll0+/EfBIUGmOWo
         Jy/asvp3aYC+Qd8D2Nrtu/ueE9fZGHiFsh9zuRbXgnIWYxyNhtwjBVc5CG/3D/KOBrtJ
         XMH69YDw8JUgp0nO6PwhrCotAzx/PUNJNhSH/dpWGLFeNbeDVQKNyBAnT8K4vNYXs4fw
         wv+Q==
X-Gm-Message-State: AOAM5316Wh9HE0CF1CDgqF4Tm+SEwS9orLDNI4N5/qWl0hUDKfKhUPuS
        vjiAy3bGnMCd6oMVXCLuifGTDA==
X-Google-Smtp-Source: ABdhPJwZleEIJJnG0EATdvDaGTM4S+5gihL8GAeq5hVd5bhEGIlxo/v6c7sPofOnyiwJwZX1XOuX0g==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr47371295wmc.145.1594042442456;
        Mon, 06 Jul 2020 06:34:02 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        LAPIS Semiconductor <tomoya-linux@dsn.lapis-semi.com>
Subject: [PATCH 15/32] usb: gadget: udc: pch_udc: Fix a plethora of function documentation related issues
Date:   Mon,  6 Jul 2020 14:33:24 +0100
Message-Id: <20200706133341.476881-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ranging from missing descriptions and formatting mishaps to over-documenting
of missing arguments, likely due to bitrot.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/pch_udc.c:239: warning: Function parameter or member 'request' not described in 'pch_udc_stp_dma_desc'
 drivers/usb/gadget/udc/pch_udc.c:315: warning: Function parameter or member 'irq_work_fall' not described in 'pch_vbus_gpio_data'
 drivers/usb/gadget/udc/pch_udc.c:315: warning: Function parameter or member 'irq_work_rise' not described in 'pch_vbus_gpio_data'
 drivers/usb/gadget/udc/pch_udc.c:482: warning: Function parameter or member 'ep' not described in 'pch_udc_write_csr'
 drivers/usb/gadget/udc/pch_udc.c:482: warning: Excess function parameter 'addr' description in 'pch_udc_write_csr'
 drivers/usb/gadget/udc/pch_udc.c:498: warning: Function parameter or member 'ep' not described in 'pch_udc_read_csr'
 drivers/usb/gadget/udc/pch_udc.c:498: warning: Excess function parameter 'addr' description in 'pch_udc_read_csr'
 drivers/usb/gadget/udc/pch_udc.c:662: warning: Function parameter or member 'ep_in' not described in 'pch_udc_ep_set_bufsz'
 drivers/usb/gadget/udc/pch_udc.c:977: warning: Function parameter or member 'ep' not described in 'pch_udc_ep_enable'
 drivers/usb/gadget/udc/pch_udc.c:977: warning: Function parameter or member 'cfg' not described in 'pch_udc_ep_enable'
 drivers/usb/gadget/udc/pch_udc.c:977: warning: Excess function parameter 'regs' description in 'pch_udc_ep_enable'
 drivers/usb/gadget/udc/pch_udc.c:1010: warning: Function parameter or member 'ep' not described in 'pch_udc_ep_disable'
 drivers/usb/gadget/udc/pch_udc.c:1010: warning: Excess function parameter 'regs' description in 'pch_udc_ep_disable'
 drivers/usb/gadget/udc/pch_udc.c:1030: warning: Function parameter or member 'ep' not described in 'pch_udc_wait_ep_stall'
 drivers/usb/gadget/udc/pch_udc.c:1030: warning: Excess function parameter 'dev' description in 'pch_udc_wait_ep_stall'
 drivers/usb/gadget/udc/pch_udc.c:1341: warning: Function parameter or member 'data' not described in 'pch_vbus_gpio_irq'
 drivers/usb/gadget/udc/pch_udc.c:1341: warning: Excess function parameter 'dev' description in 'pch_vbus_gpio_irq'
 drivers/usb/gadget/udc/pch_udc.c:1365: warning: Function parameter or member 'vbus_gpio_port' not described in 'pch_vbus_gpio_init'
 drivers/usb/gadget/udc/pch_udc.c:1510: warning: Function parameter or member 'dev' not described in 'pch_udc_free_dma_chain'
 drivers/usb/gadget/udc/pch_udc.c:1510: warning: Function parameter or member 'req' not described in 'pch_udc_free_dma_chain'
 drivers/usb/gadget/udc/pch_udc.c:1717: warning: Function parameter or member 'usbep' not described in 'pch_udc_pcd_ep_disable'
 drivers/usb/gadget/udc/pch_udc.c:2006: warning: Excess function parameter 'halt' description in 'pch_udc_pcd_set_wedge'
 drivers/usb/gadget/udc/pch_udc.c:2756: warning: Function parameter or member 'pdev' not described in 'pch_udc_isr'
 drivers/usb/gadget/udc/pch_udc.c:2756: warning: Excess function parameter 'dev' description in 'pch_udc_isr'
 drivers/usb/gadget/udc/pch_udc.c:2906: warning: Function parameter or member 'dev' not described in 'init_dma_pools'
 drivers/usb/gadget/udc/pch_udc.c:2906: warning: Excess function parameter 'pdev' description in 'init_dma_pools'

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: LAPIS Semiconductor <tomoya-linux@dsn.lapis-semi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/pch_udc.c | 36 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 3344fb8c41811..8afc31d94b0e4 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -229,8 +229,7 @@ struct pch_udc_data_dma_desc {
  *				 for control data
  * @status:	Status
  * @reserved:	Reserved
- * @data12:	First setup word
- * @data34:	Second setup word
+ * @request:	Control Request
  */
 struct pch_udc_stp_dma_desc {
 	u32 status;
@@ -304,8 +303,8 @@ struct pch_udc_ep {
  *					for detecting VBUS
  * @port:		gpio port number
  * @intr:		gpio interrupt number
- * @irq_work_fall	Structure for WorkQueue
- * @irq_work_rise	Structure for WorkQueue
+ * @irq_work_fall:	Structure for WorkQueue
+ * @irq_work_rise:	Structure for WorkQueue
  */
 struct pch_vbus_gpio_data {
 	int			port;
@@ -475,7 +474,7 @@ static void pch_udc_csr_busy(struct pch_udc_dev *dev)
  * pch_udc_write_csr() - Write the command and status registers.
  * @dev:	Reference to pch_udc_dev structure
  * @val:	value to be written to CSR register
- * @addr:	address of CSR register
+ * @ep:		end-point number
  */
 static void pch_udc_write_csr(struct pch_udc_dev *dev, unsigned long val,
 			       unsigned int ep)
@@ -490,7 +489,7 @@ static void pch_udc_write_csr(struct pch_udc_dev *dev, unsigned long val,
 /**
  * pch_udc_read_csr() - Read the command and status registers.
  * @dev:	Reference to pch_udc_dev structure
- * @addr:	address of CSR register
+ * @ep:		end-point number
  *
  * Return codes:	content of CSR register
  */
@@ -656,6 +655,7 @@ static inline void pch_udc_ep_set_trfr_type(struct pch_udc_ep *ep,
  * pch_udc_ep_set_bufsz() - Set the maximum packet size for the endpoint
  * @ep:		Reference to structure of type pch_udc_ep_regs
  * @buf_size:	The buffer word size
+ * @ep_in:	EP is IN
  */
 static void pch_udc_ep_set_bufsz(struct pch_udc_ep *ep,
 						 u32 buf_size, u32 ep_in)
@@ -968,7 +968,8 @@ static void pch_udc_ep_fifo_flush(struct pch_udc_ep *ep, int dir)
 
 /**
  * pch_udc_ep_enable() - This api enables endpoint
- * @regs:	Reference to structure pch_udc_ep_regs
+ * @ep:		reference to structure of type pch_udc_ep_regs
+ * @cfg:	current configuration information
  * @desc:	endpoint descriptor
  */
 static void pch_udc_ep_enable(struct pch_udc_ep *ep,
@@ -1004,7 +1005,7 @@ static void pch_udc_ep_enable(struct pch_udc_ep *ep,
 
 /**
  * pch_udc_ep_disable() - This api disables endpoint
- * @regs:	Reference to structure pch_udc_ep_regs
+ * @ep:		reference to structure of type pch_udc_ep_regs
  */
 static void pch_udc_ep_disable(struct pch_udc_ep *ep)
 {
@@ -1024,7 +1025,7 @@ static void pch_udc_ep_disable(struct pch_udc_ep *ep)
 
 /**
  * pch_udc_wait_ep_stall() - Wait EP stall.
- * @dev:	Reference to pch_udc_dev structure
+ * @ep:		reference to structure of type pch_udc_ep_regs
  */
 static void pch_udc_wait_ep_stall(struct pch_udc_ep *ep)
 {
@@ -1331,7 +1332,7 @@ static void pch_vbus_gpio_work_rise(struct work_struct *irq_work)
 /**
  * pch_vbus_gpio_irq() - IRQ handler for GPIO interrupt for changing VBUS
  * @irq:	Interrupt request number
- * @dev:	Reference to the device structure
+ * @data:	Reference to the device structure
  *
  * Return codes:
  *	0: Success
@@ -1354,8 +1355,8 @@ static irqreturn_t pch_vbus_gpio_irq(int irq, void *data)
 
 /**
  * pch_vbus_gpio_init() - This API initializes GPIO port detecting VBUS.
- * @dev:	Reference to the driver structure
- * @vbus_gpio	Number of GPIO port to detect gpio
+ * @dev:		Reference to the driver structure
+ * @vbus_gpio_port:	Number of GPIO port to detect gpio
  *
  * Return codes:
  *	0: Success
@@ -1499,8 +1500,8 @@ static void empty_req_queue(struct pch_udc_ep *ep)
 /**
  * pch_udc_free_dma_chain() - This function frees the DMA chain created
  *				for the request
- * @dev		Reference to the driver structure
- * @req		Reference to the request to be freed
+ * @dev:	Reference to the driver structure
+ * @req:	Reference to the request to be freed
  *
  * Return codes:
  *	0: Success
@@ -1707,7 +1708,7 @@ static int pch_udc_pcd_ep_enable(struct usb_ep *usbep,
 /**
  * pch_udc_pcd_ep_disable() - This API disables endpoint and is called
  *				from gadget driver
- * @usbep	Reference to the USB endpoint structure
+ * @usbep:	Reference to the USB endpoint structure
  *
  * Return codes:
  *	0:		Success
@@ -1996,7 +1997,6 @@ static int pch_udc_pcd_set_halt(struct usb_ep *usbep, int halt)
  * pch_udc_pcd_set_wedge() - This function Sets or clear the endpoint
  *				halt feature
  * @usbep:	Reference to the USB endpoint structure
- * @halt:	Specifies whether to set or clear the feature
  *
  * Return codes:
  *	0:			Success
@@ -2750,7 +2750,7 @@ static void pch_udc_dev_isr(struct pch_udc_dev *dev, u32 dev_intr)
 /**
  * pch_udc_isr() - This function handles interrupts from the PCH USB Device
  * @irq:	Interrupt request number
- * @dev:	Reference to the device structure
+ * @pdev:	Reference to the device structure
  */
 static irqreturn_t pch_udc_isr(int irq, void *pdev)
 {
@@ -2900,7 +2900,7 @@ static int pch_udc_pcd_init(struct pch_udc_dev *dev)
 
 /**
  * init_dma_pools() - create dma pools during initialization
- * @pdev:	reference to struct pci_dev
+ * @dev:	reference to struct pci_dev
  */
 static int init_dma_pools(struct pch_udc_dev *dev)
 {
-- 
2.25.1

