Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65533C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371A820756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtNYdkcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgEOSj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:39:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726227AbgEOSjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589567962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ae5IsI5Gq09ucJ06wLT+05gALxLoRNh+3pNF1BKfirQ=;
        b=EtNYdkcDdlPkyWnT6GCLg4OSFTTaTFcAHzW3jqJamZ/wVs7XRoELtZwiPZ6s+oyUC7Ee0O
        zmoPlnRFmM5VzZpxhxiL5inBvyXjBVqPvsYVBiDiaQNsJoQUPZTV/WKt885KkUz1QzKncX
        WJQWXyh7N040vIqxLGipyRuc/SRd88U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-xrGZdO8tN42K8SGR0VtgQQ-1; Fri, 15 May 2020 14:39:20 -0400
X-MC-Unique: xrGZdO8tN42K8SGR0VtgQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37122EC1A1;
        Fri, 15 May 2020 18:39:19 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-194.ams2.redhat.com [10.36.113.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE2C45C1D6;
        Fri, 15 May 2020 18:39:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel-vbtn: Only blacklist SW_TABLET_MODE on the 9 / "Laptop" chasis-type
Date:   Fri, 15 May 2020 20:39:16 +0200
Message-Id: <20200515183916.82919-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Stream x360 11-p000nd no longer report SW_TABLET_MODE state / events
with recent kernels. This model reports a chassis-type of 10 / "Notebook"
which is not on the recently introduced chassis-type whitelist

Commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
switch on 2-in-1's") added a chassis-type whitelist and only listed 31 /
"Convertible" as being capable of generating valid SW_TABLET_MOD events.

Commit 1fac39fd0316 ("platform/x86: intel-vbtn: Also handle tablet-mode
switch on "Detachable" and "Portable" chassis-types") extended the
whitelist with chassis-types 8 / "Portable" and 32 / "Detachable".

And now we need to exten the whitelist again with 10 / "Notebook"...

The issue original fixed by the whitelist is really a ACPI DSDT bug on
the Dell XPS 9360 where it has a VGBS which reports it is in tablet mode
even though it is not a 2-in-1 at all, but a regular laptop.

So since this is a workaround for a DSDT issue on that specific model,
instead of extending the whitelist over and over again, lets switch to
a blacklist and only blacklist the chassis-type of the model for which
the chassis-type check was added.

Note this also fixes the current version of the code no longer checking
if dmi_get_system_info(DMI_CHASSIS_TYPE) returns NULL.

Fixes: 1fac39fd0316 ("platform/x86: intel-vbtn: Also handle tablet-mode switch on "Detachable" and "Portable" chassis-types")
Cc: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note I can even see there being 2-in-1s using intel-vbtn to report
SW_TABLET_MODE with a chassis-type of 9. So maybe we should make the
quirk / blacklist stricter by combining it with a
dmi_name_in_vendors("Dell") check ?
---
 drivers/platform/x86/intel-vbtn.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index ef92c1c3adbd..0487b606a274 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -170,21 +170,18 @@ static bool intel_vbtn_has_buttons(acpi_handle handle)
 static bool intel_vbtn_has_switches(acpi_handle handle)
 {
 	const char *chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
-	unsigned long chassis_type_int;
 	unsigned long long vgbs;
 	acpi_status status;
 
-	if (kstrtoul(chassis_type, 10, &chassis_type_int))
-		return false;
-
-	switch (chassis_type_int) {
-	case  8: /* Portable */
-	case 31: /* Convertible */
-	case 32: /* Detachable */
-		break;
-	default:
+	/*
+	 * Some normal laptops have a VGBS method despite being non-convertible
+	 * and their VGBS method always returns 0, causing detect_tablet_mode()
+	 * to report SW_TABLET_MODE=1 to userspace, which causes issues.
+	 * These laptops have a DMI chassis_type of 9 ("Laptop"), do not report
+	 * switches on any devices with a DMI chassis_type of 9.
+	 */
+	if (chassis_type && strcmp(chassis_type, "9") == 0)
 		return false;
-	}
 
 	status = acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
 	return ACPI_SUCCESS(status);
-- 
2.26.0

