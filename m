Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DFFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7338C20890
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659427;
	bh=twAD9/480OimOKhD5kT8bjO05961osbe1gNSuQvw97U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wxqBMgswENLhP8TrVqPr8Rd2Y0XKc42YteZ0T5JGve1x7ztlT60EWF1o/cvDC3+3i
	 BFXTliE8aK4eVvCO08mnHCG1vPbnnDyH1vsgORYou7wESMWRa+pNnKevNWOevk7SXr
	 P0FLVFhUwyYFlS6CEyqRvOV8UmPdrvFAcadmkIKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgFHX37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731565AbgFHXYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC1A920C09;
        Mon,  8 Jun 2020 23:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658642;
        bh=twAD9/480OimOKhD5kT8bjO05961osbe1gNSuQvw97U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/AvoqCnJdkce224/0MJSTdpy8PsAwGVImF548Wo7HOx+hrnUHk6xoB+E47Km2Tjf
         2uiLGyOlqbwlcfAT+uHy+tok/ibmmRbNqqD6ZJihf7H6s3TJgI1niVaXzMkgDnXdPG
         Z02BmnZW2uHnclyNj923xzPdx5MKSjhe89fzCFbI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 063/106] platform/x86: intel-vbtn: Use acpi_evaluate_integer()
Date:   Mon,  8 Jun 2020 19:21:55 -0400
Message-Id: <20200608232238.3368589-63-sashal@kernel.org>
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

[ Upstream commit 18937875a231d831c309716d6d8fc358f8381881 ]

Use acpi_evaluate_integer() instead of open-coding it.

This is a preparation patch for adding a intel_vbtn_has_switches()
helper function.

Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-vbtn.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index a0d0cecff55f..0bcfa20dd614 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -118,28 +118,21 @@ static void detect_tablet_mode(struct platform_device *device)
 	const char *chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
 	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
-	struct acpi_buffer vgbs_output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
+	unsigned long long vgbs;
 	acpi_status status;
 	int m;
 
 	if (!(chassis_type && strcmp(chassis_type, "31") == 0))
-		goto out;
+		return;
 
-	status = acpi_evaluate_object(handle, "VGBS", NULL, &vgbs_output);
+	status = acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
 	if (ACPI_FAILURE(status))
-		goto out;
-
-	obj = vgbs_output.pointer;
-	if (!(obj && obj->type == ACPI_TYPE_INTEGER))
-		goto out;
+		return;
 
-	m = !(obj->integer.value & TABLET_MODE_FLAG);
+	m = !(vgbs & TABLET_MODE_FLAG);
 	input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
-	m = (obj->integer.value & DOCK_MODE_FLAG) ? 1 : 0;
+	m = (vgbs & DOCK_MODE_FLAG) ? 1 : 0;
 	input_report_switch(priv->input_dev, SW_DOCK, m);
-out:
-	kfree(vgbs_output.pointer);
 }
 
 static int intel_vbtn_probe(struct platform_device *device)
-- 
2.25.1

