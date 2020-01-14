Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A592EC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710B6207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578997166;
	bh=E0EEgmJfg0TLopBj4W64EXLVTA4Z/uD24x8keHioWrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2wi9HjxEeNVbAGgW8lEwfzPbwOP7/cRexoXIKIw4iaVoKKVmZgPoomtlyoXxDKJSe
	 g3f1Mw5TnhqbL5aVAJcwbGBjet3iebgvYZhndcPccrVhAbdtkVIIMetfoNVS/L2CZ6
	 4sT8jlx0lq5/617Yqu7r9/2G0w5+xz9XKxHaUR7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgANKF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbgANKFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:05:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4435024679;
        Tue, 14 Jan 2020 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996352;
        bh=E0EEgmJfg0TLopBj4W64EXLVTA4Z/uD24x8keHioWrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMkXq7NAKmunGEMJg0JUFaRNOO+w+aQ+o8XJ6drEt6T1YEL6B1Z/MZHFdbfDkcVmH
         zebossA4GFlSrauhPtR8fqDguPUIX1eFEeecKDui5V+kdxx0DEbqVg8608OSBkh1lu
         rUroUB0em1eLgkKhH1vfOQV19C/9lHAXxZtm2is0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.4 43/78] usb: ohci-da8xx: ensure error return on variable error is set
Date:   Tue, 14 Jan 2020 11:01:17 +0100
Message-Id: <20200114094359.349034019@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit ba9b40810bb43e6bf73b395012b98633c03f7f59 upstream.

Currently when an error occurs when calling devm_gpiod_get_optional or
calling gpiod_to_irq it causes an uninitialized error return in variable
'error' to be returned.  Fix this by ensuring the error variable is set
from da8xx_ohci->oc_gpio and oc_irq.

Thanks to Dan Carpenter for spotting the uninitialized error in the
gpiod_to_irq failure case.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20200107123901.101190-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/ohci-da8xx.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -415,13 +415,17 @@ static int ohci_da8xx_probe(struct platf
 	}
 
 	da8xx_ohci->oc_gpio = devm_gpiod_get_optional(dev, "oc", GPIOD_IN);
-	if (IS_ERR(da8xx_ohci->oc_gpio))
+	if (IS_ERR(da8xx_ohci->oc_gpio)) {
+		error = PTR_ERR(da8xx_ohci->oc_gpio);
 		goto err;
+	}
 
 	if (da8xx_ohci->oc_gpio) {
 		oc_irq = gpiod_to_irq(da8xx_ohci->oc_gpio);
-		if (oc_irq < 0)
+		if (oc_irq < 0) {
+			error = oc_irq;
 			goto err;
+		}
 
 		error = devm_request_threaded_irq(dev, oc_irq, NULL,
 				ohci_da8xx_oc_thread, IRQF_TRIGGER_RISING |


