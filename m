Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E324220771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581911;
	bh=qViuOa0tFAuzGHOi+ZLjbhAYpuI3NFwXYEk9AAsSz0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P1MhrshXuJSMAp6kg0u/b7Ole2NRfNDixxNu7peQbLdh20kqM7SYN6OIzZxrDxykS
	 Gb51my2IzFYU4s7Eo6WJgijCZ3fDqwy+kSs/7RsTVaA14ZuZpEVTdN1zECqGCMD1iY
	 kUMd5xU75Z1T/4F0KfApaZOrbAq05EByXu8sUXMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405275AbgFSPvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390114AbgFSPXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C12321841;
        Fri, 19 Jun 2020 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580221;
        bh=qViuOa0tFAuzGHOi+ZLjbhAYpuI3NFwXYEk9AAsSz0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5RI3Ca10qwjb5emS0co++8qMSpun46VLSDEfU8c3pZUzbedfU35oszQh/3ZSW25X
         uRWnkRIIyMV9RPWhdDIXjn2BEu7XYo8lfJuISgRZhpBaapM5/IFh64VlGr2uQ3yQGr
         h5KDWCQSRJ0+qypzo7xpfpR/x/r/f4v5ABJDsJK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <Mario.limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 167/376] platform/x86: intel-vbtn: Also handle tablet-mode switch on "Detachable" and "Portable" chassis-types
Date:   Fri, 19 Jun 2020 16:31:25 +0200
Message-Id: <20200619141718.227464841@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 500fae82e12c..4921fc15dc6c 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -158,12 +158,22 @@ static void detect_tablet_mode(struct platform_device *device)
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



