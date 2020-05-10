Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBADC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988BE214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGepYG0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgEJMYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:24:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41999 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728882AbgEJMYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589113480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1jCpyDLqlIGSqPuFPAMnszucwhMTJg1A0PnKx2QioIw=;
        b=YGepYG0ivnmKYv7hHikjJ18z9h6A5g5fOCOJ5sFIz38b5TRVs8457v82wejMsy+7xC4l9M
        EbFWAKp7gXPGtnYhqTK7WI/ulird3YDRERSCIswjQAptqjgaZPx/1uRVasCMNbqbT8cjbP
        Em//bHFloN1hfwKQKar6k8EMSGR6Szo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-QR3hjDK4P6Cf3xWbIMC9mA-1; Sun, 10 May 2020 08:24:35 -0400
X-MC-Unique: QR3hjDK4P6Cf3xWbIMC9mA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0AD5107ACCA;
        Sun, 10 May 2020 12:24:34 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-76.ams2.redhat.com [10.36.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B99C05D9C9;
        Sun, 10 May 2020 12:24:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: asus-wmi: Move asus_wmi_input_init and _exit lower in the file
Date:   Sun, 10 May 2020 14:24:30 +0200
Message-Id: <20200510122432.123751-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the asus_wmi_input_init() and asus_wmi_input_exit() functions to
below the WMI helpers, so that further patches in this patch-set can use
the WMI helpers inside asus_wmi_input_init() without needing a forward
declaration.

Note this commit makes no functional changes, the moved block of code
is completely unchanged.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/asus-wmi.c | 78 ++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e705ae66c083..25ec821dae21 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -222,45 +222,6 @@ struct asus_wmi {
 	struct asus_wmi_driver *driver;
 };
 
-/* Input **********************************************************************/
-
-static int asus_wmi_input_init(struct asus_wmi *asus)
-{
-	int err;
-
-	asus->inputdev = input_allocate_device();
-	if (!asus->inputdev)
-		return -ENOMEM;
-
-	asus->inputdev->name = asus->driver->input_name;
-	asus->inputdev->phys = asus->driver->input_phys;
-	asus->inputdev->id.bustype = BUS_HOST;
-	asus->inputdev->dev.parent = &asus->platform_device->dev;
-	set_bit(EV_REP, asus->inputdev->evbit);
-
-	err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, NULL);
-	if (err)
-		goto err_free_dev;
-
-	err = input_register_device(asus->inputdev);
-	if (err)
-		goto err_free_dev;
-
-	return 0;
-
-err_free_dev:
-	input_free_device(asus->inputdev);
-	return err;
-}
-
-static void asus_wmi_input_exit(struct asus_wmi *asus)
-{
-	if (asus->inputdev)
-		input_unregister_device(asus->inputdev);
-
-	asus->inputdev = NULL;
-}
-
 /* WMI ************************************************************************/
 
 static int asus_wmi_evaluate_method3(u32 method_id,
@@ -381,6 +342,45 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
 	return status == 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
 }
 
+/* Input **********************************************************************/
+
+static int asus_wmi_input_init(struct asus_wmi *asus)
+{
+	int err;
+
+	asus->inputdev = input_allocate_device();
+	if (!asus->inputdev)
+		return -ENOMEM;
+
+	asus->inputdev->name = asus->driver->input_name;
+	asus->inputdev->phys = asus->driver->input_phys;
+	asus->inputdev->id.bustype = BUS_HOST;
+	asus->inputdev->dev.parent = &asus->platform_device->dev;
+	set_bit(EV_REP, asus->inputdev->evbit);
+
+	err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, NULL);
+	if (err)
+		goto err_free_dev;
+
+	err = input_register_device(asus->inputdev);
+	if (err)
+		goto err_free_dev;
+
+	return 0;
+
+err_free_dev:
+	input_free_device(asus->inputdev);
+	return err;
+}
+
+static void asus_wmi_input_exit(struct asus_wmi *asus)
+{
+	if (asus->inputdev)
+		input_unregister_device(asus->inputdev);
+
+	asus->inputdev = NULL;
+}
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
-- 
2.26.0

