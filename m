Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B0AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FDC20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cm6y4LZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgDAID4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:03:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46662 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731850AbgDAIDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585728234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6VsagWNjkgsWtPqpkfjc3hiHgmMB2HfZJo5AqKd3BnE=;
        b=Cm6y4LZAvRRq0BLdp+du7umj4ZsrTErEqyfOAL41S48QURnwiqlKwczShKGrdC1bropCEB
        X9T++AqW0NVbiNYlt1g9+C5MsA8mntPfHPZFMadl1uO1rIOHfiWzc6JxGGNAXmR1Hx1US8
        Bi+S1uSx6Y9ZC5z2NDsO7Ys/1JQegtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-GoaCPsPpPQ2_eObd-Ud4Vg-1; Wed, 01 Apr 2020 04:03:53 -0400
X-MC-Unique: GoaCPsPpPQ2_eObd-Ud4Vg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C62DB104FB68;
        Wed,  1 Apr 2020 08:03:51 +0000 (UTC)
Received: from x1-7.localdomain.com (ovpn-114-242.ams2.redhat.com [10.36.114.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E615102BD7E;
        Wed,  1 Apr 2020 08:03:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the MP-man MPWIN895CL tablet
Date:   Wed,  1 Apr 2020 10:03:48 +0200
Message-Id: <20200401080348.5128-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the MP-man MPWIN895CL tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x8=
6/touchscreen_dmi.c
index 6ec8923dec1a..931814e62454 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -373,6 +373,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_d=
ata =3D {
 	.properties	=3D jumper_ezpad_mini3_props,
 };
=20
+static const struct property_entry mpman_mpwin895cl_props[] =3D {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 3),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 9),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-mpman-mpwin895cl.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data mpman_mpwin895cl_data =3D {
+	.acpi_name	=3D "MSSL1680:00",
+	.properties	=3D mpman_mpwin895cl_props,
+};
+
 static const struct property_entry myria_my8307_props[] =3D {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
@@ -908,6 +925,14 @@ const struct dmi_system_id touchscreen_dmi_table[] =3D=
 {
 			DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
 		},
 	},
+	{
+		/* MP Man MPWIN895CL */
+		.driver_data =3D (void *)&mpman_mpwin895cl_data,
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "MPMAN"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MPWIN8900CL"),
+		},
+	},
 	{
 		/* Myria MY8307 */
 		.driver_data =3D (void *)&myria_my8307_data,
--=20
2.26.0

