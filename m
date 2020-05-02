Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A2CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67190206F1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as4e889P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgEBSaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 14:30:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728430AbgEBSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588444210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=letQVDOo3V2j1mmTVFw1o6et9y8zvcG1xCoXp2K/63E=;
        b=as4e889PPucEyfypNvRN0Jh8Wwf3Vqm18baryWZ92N5WVAFganiSv79yukX/sYC2B2nZzA
        q15NcZapUCbsKD/51j6NG4FpBnvYyOBtryRQvvuXdhgsQkQfwA7C/0uW6CivlBeVZVRmh0
        nVctK+xyzWcyFuVtXU+gLSI393jLf9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-ubq-5E0lNFWza9zgE-YR_w-1; Sat, 02 May 2020 14:30:08 -0400
X-MC-Unique: ubq-5E0lNFWza9zgE-YR_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07EFE8005B7;
        Sat,  2 May 2020 18:30:07 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82A30600E5;
        Sat,  2 May 2020 18:30:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] platform/x86: intel-vbtn: Fix probe failure on devices with only switches
Date:   Sat,  2 May 2020 20:29:51 +0200
Message-Id: <20200502182951.114231-6-hdegoede@redhat.com>
In-Reply-To: <20200502182951.114231-1-hdegoede@redhat.com>
References: <20200502182951.114231-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some devices the INT33D6 vbtn device is only used to report
tablet-mode / docked status (switches) and there are no vbtn managed
buttons.

On these devices there is no VBDL object.

Move the VBDL check to a intel_vbtn_has_buttons() helper and only exit
from intel_vbtn_probe() with -ENODEV when there are both no buttons and
no switches. Also only report the buttons being present to userspace if
the has_buttons check has succeeded.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel-vbtn.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/int=
el-vbtn.c
index 4921fc15dc6c..4efc70b693a7 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -55,6 +55,7 @@ static const struct key_entry intel_vbtn_switchmap[] =3D=
 {
 struct intel_vbtn_priv {
 	struct key_entry keymap[KEYMAP_LEN];
 	struct input_dev *input_dev;
+	bool has_buttons;
 	bool has_switches;
 	bool wakeup_mode;
 };
@@ -64,7 +65,7 @@ static int intel_vbtn_input_setup(struct platform_devic=
e *device)
 	struct intel_vbtn_priv *priv =3D dev_get_drvdata(&device->dev);
 	int ret, keymap_len =3D 0;
=20
-	if (true) {
+	if (priv->has_buttons) {
 		memcpy(&priv->keymap[keymap_len], intel_vbtn_keymap,
 		       ARRAY_SIZE(intel_vbtn_keymap) *
 		       sizeof(struct key_entry));
@@ -155,6 +156,14 @@ static void detect_tablet_mode(struct platform_devic=
e *device)
 	input_report_switch(priv->input_dev, SW_DOCK, m);
 }
=20
+static bool intel_vbtn_has_buttons(acpi_handle handle)
+{
+	acpi_status status;
+
+	status =3D acpi_evaluate_object(handle, "VBDL", NULL, NULL);
+	return ACPI_SUCCESS(status);
+}
+
 static bool intel_vbtn_has_switches(acpi_handle handle)
 {
 	const char *chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
@@ -181,12 +190,15 @@ static bool intel_vbtn_has_switches(acpi_handle han=
dle)
 static int intel_vbtn_probe(struct platform_device *device)
 {
 	acpi_handle handle =3D ACPI_HANDLE(&device->dev);
+	bool has_buttons, has_switches;
 	struct intel_vbtn_priv *priv;
 	acpi_status status;
 	int err;
=20
-	status =3D acpi_evaluate_object(handle, "VBDL", NULL, NULL);
-	if (ACPI_FAILURE(status)) {
+	has_buttons =3D intel_vbtn_has_buttons(handle);
+	has_switches =3D intel_vbtn_has_switches(handle);
+
+	if (!has_buttons && !has_switches) {
 		dev_warn(&device->dev, "failed to read Intel Virtual Button driver\n")=
;
 		return -ENODEV;
 	}
@@ -196,7 +208,8 @@ static int intel_vbtn_probe(struct platform_device *d=
evice)
 		return -ENOMEM;
 	dev_set_drvdata(&device->dev, priv);
=20
-	priv->has_switches =3D intel_vbtn_has_switches(handle);
+	priv->has_buttons =3D has_buttons;
+	priv->has_switches =3D has_switches;
=20
 	err =3D intel_vbtn_input_setup(device);
 	if (err) {
--=20
2.26.0

