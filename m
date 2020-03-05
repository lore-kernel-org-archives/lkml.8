Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C90C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5046F21744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428568;
	bh=+IjVORKh/seQrNgXksEThu2KTYNq7FzrhANnMv4hTSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h8Iumpu6pRmJ0m2QyiBUU33Tc+ByqnP/t21SEf/m8wo/AZOPv/9Wv2UeloOlZ2Nrk
	 OXhaqH8+MsqVt7KoQHI7MXoZdqvbH4UPkHiYmFEEktZj8UFFLiRnbQL1H70SdU8VjU
	 P4DtRCRLmTunmwgkGyMD8cPulvZN30FxqJg6/rrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgCERQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:16:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgCERPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:15:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D73207FD;
        Thu,  5 Mar 2020 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428550;
        bh=+IjVORKh/seQrNgXksEThu2KTYNq7FzrhANnMv4hTSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjWZh83p8ECxs0eeyQ+/ebza+jXCHl/w4cl6gwYyCB74PY+mt8vGxaO+cInY14Tmb
         WBL2iRQi8gRCztFnD9noHma4lUwjNzjivZ8/QboCZd2jUItX5aQZef4oqHlLOMvPuY
         nyKKb/2HsJx90E+updnHXLFL1FNc364172K4FftM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/19] HID: i2c-hid: add Trekstor Surfbook E11B to descriptor override
Date:   Thu,  5 Mar 2020 12:15:28 -0500
Message-Id: <20200305171540.30250-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171540.30250-1-sashal@kernel.org>
References: <20200305171540.30250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit be0aba826c4a6ba5929def1962a90d6127871969 ]

The Surfbook E11B uses the SIPODEV SP1064 touchpad, which does not supply
descriptors, so it has to be added to the override list.

BugLink: https://bugs.launchpad.net/bugs/1858299
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 10af8585c820d..95052373a8282 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -341,6 +341,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "Trekstor SURFBOOK E11B",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "SURFBOOK E11B"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{
 		.ident = "Direkt-Tek DTLAPY116-2",
 		.matches = {
-- 
2.20.1

