Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F3C21527
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658063;
	bh=E/7HYZcFWCYad9Xsm1E7dzZCby4y08/7lx/4/FuHRzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SQ9SsWAdXWClz1gaqCs9qGwn9bTpt9Ot0kP5+4XqOlPuDe3sVNNdbsPuqsBQ8dHHa
	 f3T+6AkLKGXxNjQSiZfSt+lRJ25Gm2O0X7AKIeWmjOPtodoHUYOd2otcKxe3RFM/YX
	 OClHhXsUZr1djByWg8PQ78BoZytNi804mYfYBDJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgFHXOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbgFHXLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E9E21532;
        Mon,  8 Jun 2020 23:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657910;
        bh=E/7HYZcFWCYad9Xsm1E7dzZCby4y08/7lx/4/FuHRzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Cwaw5297o3l5zl1pNqnLFW+vs5zOxT5vTMD9kQ2aowD3YQnRZa6nA5LSoiEwVBJV
         IFqXS9n1xbsQVRdOstfyZWDMUUx7Uj8mx+UBM1/H1DZGKoONiKm/95r8VUldNcgjLH
         Vp3TZnFudi7LaeOuL9uO4VzXrxa1YChA5IfLJ+sQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mario Limonciello <Mario.limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 262/274] platform/x86: intel-vbtn: Only blacklist SW_TABLET_MODE on the 9 / "Laptop" chasis-type
Date:   Mon,  8 Jun 2020 19:05:55 -0400
Message-Id: <20200608230607.3361041-262-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit cfae58ed681c5fe0185db843013ecc71cd265ebf ]

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
Reviewed-by: Mario Limonciello <Mario.limonciello@dell.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-vbtn.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 4921fc15dc6c..a05b80955dcd 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -158,21 +158,18 @@ static void detect_tablet_mode(struct platform_device *device)
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
2.25.1

