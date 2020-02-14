Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BFCC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044322082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701468;
	bh=AQZv439aPs3a3pzVfoFsckJvPrDHpgNa6VOlnBmXrqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/fU2Tte4+K5wUS8VHgRAaaxWpnkxDy1BER3gIdmbomdXfDtSuYHVNdt+4Tknn40H
	 dtYBZEpqaEG7fUi0omRkGyBflw+XZxsjonAYtpqD/XvLoJ9G64IBVXZf9YVHv0J8DR
	 iNP7TSElg5ymIG5VOme7JKDj6HYwPDzRBbEF8BdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392563AbgBNRbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390246AbgBNQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:07:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BEFD2067D;
        Fri, 14 Feb 2020 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696435;
        bh=AQZv439aPs3a3pzVfoFsckJvPrDHpgNa6VOlnBmXrqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKLLBDHxdzk4Pi34XzG6E1WWvnHpDjcbI9Yl0gmA+S3y3+na5yVM16JI0usyK6dP0
         3iDrtTB3v+NwfUauYxBK3rIcuzzkgqMTnr9vohnLMet+H3OiSo3F71C5r65JqYdhem
         vzQ6JxnWfiBP1mdX6pgVfPMPtZ8yrtgQ9sNarotA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Ekstrand <jason@jlekstrand.net>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 252/459] ACPI: button: Add DMI quirk for Razer Blade Stealth 13 late 2019 lid switch
Date:   Fri, 14 Feb 2020 10:58:22 -0500
Message-Id: <20200214160149.11681-252-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Ekstrand <jason@jlekstrand.net>

[ Upstream commit 0528904926aab19bffb2068879aa44db166c6d5f ]

Running evemu-record on the lid switch event shows that the lid reports
the first "close" but then never reports an "open".  This causes systemd
to continuously re-suspend the laptop every 30s.  Resetting the _LID to
"open" fixes the issue.

Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index ce93a355bd1c8..985afc62da82a 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -89,6 +89,17 @@ static const struct dmi_system_id lid_blacklst[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Razer Blade Stealth 13 late 2019, notification of the LID device
+		 * only happens on close, not on open and _LID always returns closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Razer Blade Stealth 13 Late 2019"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 
-- 
2.20.1

