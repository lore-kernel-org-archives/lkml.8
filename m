Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE101C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9EB20E65
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659011;
	bh=18KOcZajMmpY2rbqPpuMqji5HUMM1Fd6BXCK/THQZIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nStQyqwHr0wtv+tGbCh80QUISk8DmCY9+b4IhRtx2V+DOATHceyS0hQu+1wmrspLN
	 pGFFJgYQjTrRJoSvBWJ3zpGyMpIDzWujXDpbDQl63ZfNlc/BHKq9RU1JMVmbOnUvPc
	 3GG1pcIeTol6fFjS2D+q6vB7kbyDjOTejG6+/y2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbgFHXaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbgFHXYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B862208A7;
        Mon,  8 Jun 2020 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658645;
        bh=18KOcZajMmpY2rbqPpuMqji5HUMM1Fd6BXCK/THQZIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oa/EHkx4YDrGiUZe81MhRypY6XfXGgNkKEth0CugrfamV+MIIBvj2Hjzac6B++3Gu
         hCHRyk/js3pX5elNDp8xQAqRksnTyp0eUjY5kippRx7my8fGusskVC2yudjRb9Dmtk
         Gexud4pDmTU78rEDEA0rnLiyqRC+nHd81qV1Eslg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <Mario.limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 066/106] platform/x86: intel-vbtn: Also handle tablet-mode switch on "Detachable" and "Portable" chassis-types
Date:   Mon,  8 Jun 2020 19:21:58 -0400
Message-Id: <20200608232238.3368589-66-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1fac39fd0316b19c3e57a182524332332d1643ce ]

Commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
switch on 2-in-1's") added a DMI chassis-type check to avoid accidentally
reporting SW_TABLET_MODE = 1 to userspace on laptops.

Some devices with a detachable keyboard and using the intel-vbnt (INT33D6)
interface to report if they are in tablet mode (keyboard detached) or not,
report 32 / "Detachable" as chassis-type, e.g. the HP Pavilion X2 series.

Other devices with a detachable keyboard and using the intel-vbnt (INT33D6)
interface to report SW_TABLET_MODE, report 8 / "Portable" as chassis-type.
The Dell Venue 11 Pro 7130 is an example of this.

Extend the DMI chassis-type check to also accept Portables and Detachables
so that the intel-vbtn driver will report SW_TABLET_MODE on these devices.

Note the chassis-type check was originally added to avoid a false-positive
tablet-mode report on the Dell XPS 9360 laptop. To the best of my knowledge
that laptop is using a chassis-type of 9 / "Laptop", so after this commit
we still ignore the tablet-switch for that chassis-type.

Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mario Limonciello <Mario.limonciello@dell.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-vbtn.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 23cda7aa96cd..5f8120d12859 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -157,12 +157,22 @@ static void detect_tablet_mode(struct platform_device *device)
 static bool intel_vbtn_has_switches(acpi_handle handle)
 {
 	const char *chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
+	unsigned long chassis_type_int;
 	unsigned long long vgbs;
 	acpi_status status;
 
-	if (!(chassis_type && strcmp(chassis_type, "31") == 0))
+	if (kstrtoul(chassis_type, 10, &chassis_type_int))
 		return false;
 
+	switch (chassis_type_int) {
+	case  8: /* Portable */
+	case 31: /* Convertible */
+	case 32: /* Detachable */
+		break;
+	default:
+		return false;
+	}
+
 	status = acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
 	return ACPI_SUCCESS(status);
 }
-- 
2.25.1

