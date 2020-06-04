Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC64C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C36206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591303655;
	bh=hiaAwzVJpy/i3MeljSqcM9obMWOSjJ3c+lKfTDL8uyE=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=DgLqKT5JDunetgMX3TGtRDyv63qPBmsJoSO9WSMp7lhOS9X5BIdPNh+pY+kzIxAiZ
	 nUmDFPH64UnLSSQxzdFvQXA+DFqM5WvEjrnRQBZ/L/eCvCNo06mD+JradgK0KnHD5y
	 v8SMtv4tfcHN2UI0zfO2OTKxJnJMJ9aZr3TIOkl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgFDUre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbgFDUrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:47:09 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA709207DA;
        Thu,  4 Jun 2020 20:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591303628;
        bh=hiaAwzVJpy/i3MeljSqcM9obMWOSjJ3c+lKfTDL8uyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhV7RxA8GX9MoTK4ZG6J9tIq7e2p7UqyXeS26Cq7GRNHqnA+k1OIinwApPFMmoiD5
         KR6789jyQJGyD+quNG06HUc0dDUP7j/0/PLQ+F9x/6ZHIgzrIhnv40np+2gPagzPzb
         eKHlc429B83MFWMkI/c6H8qtid4d9fmyaceo05n0=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jgwlW-0004Ah-Qv; Thu, 04 Jun 2020 22:47:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Revert "media: atomisp: add Asus Transform T101HA ACPI vars"
Date:   Thu,  4 Jun 2020 22:47:03 +0200
Message-Id: <c44ba22c548fece250d147edf748daf5c2589b12.1591303518.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591303518.git.mchehab+huawei@kernel.org>
References: <cover.1591303518.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the EFI _DSM table is parsed by the driver, we don't
need a DMI match anymore for Asus Transform T101HA.

This reverts commit 0a76fd8e8d202dcaabc714850205d5d75c9b8271.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../media/atomisp/pci/atomisp_gmin_platform.c    | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index 5f34b2be5153..cb02806274d1 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -328,15 +328,6 @@ static struct gmin_cfg_var i8880_vars[] = {
 	{},
 };
 
-static struct gmin_cfg_var asus_vars[] = {
-	{"OVTI2680:00_CsiPort", "1"},
-	{"OVTI2680:00_CsiLanes", "1"},
-	{"OVTI2680:00_CsiFmt", "15"},
-	{"OVTI2680:00_CsiBayer", "0"},
-	{"OVTI2680:00_CamClk", "1"},
-	{},
-};
-
 static const struct dmi_system_id gmin_vars[] = {
 	{
 		.ident = "BYT-T FFD8",
@@ -374,13 +365,6 @@ static const struct dmi_system_id gmin_vars[] = {
 		},
 		.driver_data = i8880_vars,
 	},
-	{
-		.ident = "T101HA",
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "T101HA"),
-		},
-		.driver_data = asus_vars,
-	},
 	{}
 };
 
-- 
2.26.2

