Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6805FC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DC12067D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272646;
	bh=AQZv439aPs3a3pzVfoFsckJvPrDHpgNa6VOlnBmXrqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ygzMZRcvzrAysMWMJ8Cm3vZ5sL9QRBdl1550hPkrHGfra5HOKCWDzTRA5AxF79ZeI
	 dEsgNcZXYY97OXJz73aOeTsu/1NJnA++iZXDvuPKjKIqZuY+/HioZM6NtxKz6xUp2J
	 BkLpRoYVgDGsOf1xOR9jxGqXCKzbuSNuBTFwzGCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbgBUIKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgBUIKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:10:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFD820578;
        Fri, 21 Feb 2020 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272640;
        bh=AQZv439aPs3a3pzVfoFsckJvPrDHpgNa6VOlnBmXrqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1XG7gshdvbg1LZ1bW73IIv2w4ta4bHjOJ3DqBD3dyowl+Br1aiHe/LKC2WAbwqjx
         W6a64BUSzxbLZXt5A+Wh7JowaiOLLlhCChrcn5gJ88KmAYjnjByftT43HNEq0JjwP7
         DhGfjmYaXjpJBjjgpnJKo8urMFsCJwJ3IwFQ5Wuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Ekstrand <jason@jlekstrand.net>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 184/344] ACPI: button: Add DMI quirk for Razer Blade Stealth 13 late 2019 lid switch
Date:   Fri, 21 Feb 2020 08:39:43 +0100
Message-Id: <20200221072405.733307500@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



