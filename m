Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE0C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F20D20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758581;
	bh=fEOfjW17+p7tuKZR1T8zISnvVUvOVly8NRPy3Gac6Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wUrttA7HGq58MLNR6Q4RNVY0UoBGvucG6XxJiA1aGdsPkHOYIpYrLhmKsO4ZsVRL0
	 UOeOApLezsiGIPC3JTtPF42y9GleFyhFdEv3Cu7KftktFypatI+x5c9y6BNZkAx4oH
	 y9nMpLmhjy11u/OlqbbrXJYgT/ZaH9Ycol/X+U0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbgDAQ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388192AbgDAQ3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:29:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A799B21655;
        Wed,  1 Apr 2020 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758575;
        bh=fEOfjW17+p7tuKZR1T8zISnvVUvOVly8NRPy3Gac6Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1LWbwZc1KYCUhN9T80ivgn/Pm7yXjZfzMQH5g3QuGLt3BXhLQ2On60FRZ4EyKC0z
         p/nac9JKw6kx0JowIKm37PgdEcgOidqNRIATfauLgGh8uNeIsiGCYvYdWVkRhpDzsU
         +J8qwDj3kCFrQn8YUJqjLGUbGOPHSw6P8KN3ke90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Chen <scott@labau.com.tw>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 12/91] USB: serial: pl2303: add device-id for HP LD381
Date:   Wed,  1 Apr 2020 18:17:08 +0200
Message-Id: <20200401161517.405670810@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Chen <scott@labau.com.tw>

commit cecc113c1af0dd41ccf265c1fdb84dbd05e63423 upstream.

Add a device id for HP LD381 Display
LD381:   03f0:0f7f

Signed-off-by: Scott Chen <scott@labau.com.tw>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -88,6 +88,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(SUPERIAL_VENDOR_ID, SUPERIAL_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220TA_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LD381_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM220_PRODUCT_ID) },
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -128,6 +128,7 @@
 #define HP_LM920_PRODUCT_ID	0x026b
 #define HP_TD620_PRODUCT_ID	0x0956
 #define HP_LD960_PRODUCT_ID	0x0b39
+#define HP_LD381_PRODUCT_ID	0x0f7f
 #define HP_LCM220_PRODUCT_ID	0x3139
 #define HP_LCM960_PRODUCT_ID	0x3239
 #define HP_LD220_PRODUCT_ID	0x3524


