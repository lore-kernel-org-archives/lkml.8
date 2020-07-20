Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C873FC4345B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B4122CE3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259803;
	bh=CysoPQXyyeinrWy/LrdwTgb8/9D4sNEHlCT6YBq27Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xAX/Ww4b3PENVQojgis9/gxd10FEhCyPy59pjd3Zz5db4Lhu1iInh+cPl5OBc8+25
	 2bqJ6QRS+q0XgXsmXbRmGRwfQX8FFDhdbtb380+i1sOKS40u3QvpqKVIim3RUoFFCl
	 6QVXL9yCUFn5nkOCLvuGvaBYMVIkh+kW0ir+60bE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgGTPnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgGTPnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:43:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF78120773;
        Mon, 20 Jul 2020 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259795;
        bh=CysoPQXyyeinrWy/LrdwTgb8/9D4sNEHlCT6YBq27Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Blm7qv2U3CTz5Qcw1xLYfgwQaLkHvC/WwyCiuyB7yHIBFXXMlBx1oEaFTTMoRutZi
         0yKpDC7Jllb9RJJfm9jvba6ca5MhbnT7FnPFOS4sAgKl85wfZQxxSYxiknF54CnlLF
         oCOPF69mPgOZjvwAQ2ilKgyUcGYqILr1M51Ma/as=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Doug Anderson <dianders@chromium.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.9 65/86] usb: dwc2: Fix shutdown callback in platform
Date:   Mon, 20 Jul 2020 17:37:01 +0200
Message-Id: <20200720152756.440677520@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>

commit 4fdf228cdf6925af45a2066d403821e0977bfddb upstream.

To avoid lot of interrupts from dwc2 core, which can be asserted in
specific conditions need to disable interrupts on HW level instead of
disable IRQs on Kernel level, because of IRQ can be shared between
drivers.

Cc: stable@vger.kernel.org
Fixes: a40a00318c7fc ("usb: dwc2: add shutdown callback to platform variant")
Tested-by: Frank Mori Hess <fmh6jj@gmail.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Frank Mori Hess <fmh6jj@gmail.com>
Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/platform.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -507,7 +507,8 @@ static void dwc2_driver_shutdown(struct
 {
 	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
 
-	disable_irq(hsotg->irq);
+	dwc2_disable_global_interrupts(hsotg);
+	synchronize_irq(hsotg->irq);
 }
 
 static const struct of_device_id dwc2_of_match_table[] = {


