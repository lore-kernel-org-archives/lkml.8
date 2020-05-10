Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48111C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269932082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv47s5Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgEJMUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:20:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43773 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726863AbgEJMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589113253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g9Dn44+cFb12x40JqLl4ticSILx3WB/Lga9fyKMHGmo=;
        b=bv47s5MmodbpUzC6RqRuYyZsakP9YvaTD3MJMq51wlrjahPUJgSLog7+I0KtZn2MkBuM2P
        hCv+J7CFzZHeUEIGsOjK9UYpjy7dB2V2w9axu1usxVAErLgo/f5HMvKcVigmEN/6OqU15i
        vCCuZiIdYEPQ2arv4dXB6eWEublswcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-iHbUSThTNuaV1H9awFwoKw-1; Sun, 10 May 2020 08:20:51 -0400
X-MC-Unique: iHbUSThTNuaV1H9awFwoKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D29E107ACCA;
        Sun, 10 May 2020 12:20:50 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-76.ams2.redhat.com [10.36.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5367C6AD10;
        Sun, 10 May 2020 12:20:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: intel-vbtn: Move detect_tablet_mode() to higher in the file
Date:   Sun, 10 May 2020 14:20:46 +0200
Message-Id: <20200510122047.123613-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch for calling detect_tablet_mode() from
intel_vbtn_input_setup() without needing a forward declaration.

Note this commit makes no functional changes, the moved block of code
is completely unchanged.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel-vbtn.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 4efc70b693a7..29984154f8e4 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -60,6 +60,24 @@ struct intel_vbtn_priv {
 	bool wakeup_mode;
 };
 
+static void detect_tablet_mode(struct platform_device *device)
+{
+	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
+	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	unsigned long long vgbs;
+	acpi_status status;
+	int m;
+
+	status = acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
+	if (ACPI_FAILURE(status))
+		return;
+
+	m = !(vgbs & TABLET_MODE_FLAG);
+	input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
+	m = (vgbs & DOCK_MODE_FLAG) ? 1 : 0;
+	input_report_switch(priv->input_dev, SW_DOCK, m);
+}
+
 static int intel_vbtn_input_setup(struct platform_device *device)
 {
 	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
@@ -138,24 +156,6 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	dev_dbg(&device->dev, "unknown event index 0x%x\n", event);
 }
 
-static void detect_tablet_mode(struct platform_device *device)
-{
-	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
-	unsigned long long vgbs;
-	acpi_status status;
-	int m;
-
-	status = acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
-	if (ACPI_FAILURE(status))
-		return;
-
-	m = !(vgbs & TABLET_MODE_FLAG);
-	input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
-	m = (vgbs & DOCK_MODE_FLAG) ? 1 : 0;
-	input_report_switch(priv->input_dev, SW_DOCK, m);
-}
-
 static bool intel_vbtn_has_buttons(acpi_handle handle)
 {
 	acpi_status status;
-- 
2.26.0

