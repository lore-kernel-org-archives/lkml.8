Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDC9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA1820659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659616;
	bh=gswEMTj0QRf98GeeTYMxIjqSnB5PKKOYuz4dzsRh3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NVQeAAdLcCFprs2w5jCe4+oMAA6SCILLrBJd6KzWrBWJRz0mni7d1bYDlvS6fKUeN
	 bQc4Cc9lkljNFqmqjFFcPKDHahwcDXEIOjte2lMl+XuB8LC+Td8V+NhGycz/Q+X/2d
	 P+yK+ZWHchlsBBL+nKz0ClfKIVFnzXpI8l3r9Gic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgFHX2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731300AbgFHXWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:22:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC6C20814;
        Mon,  8 Jun 2020 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658542;
        bh=gswEMTj0QRf98GeeTYMxIjqSnB5PKKOYuz4dzsRh3k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTC8el83EkxfYNnAhGdE4N1MR8TufB+sDmGf2HQA6ws89uFKoMU8zLCmNymW3LVPB
         pEQdLvCx1xXrKWZ93XbCLHKD3nBydONOJguTmRHYXzdI3woaLJ3EbddRUfW+x83wiy
         WvJb3cL48dRqvFPz5TsZtGnk5i7zkfzgGrPX13ko=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nickolai Kozachenko <daemongloom@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 164/175] platform/x86: intel-hid: Add a quirk to support HP Spectre X2 (2015)
Date:   Mon,  8 Jun 2020 19:18:37 -0400
Message-Id: <20200608231848.3366970-164-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nickolai Kozachenko <daemongloom@gmail.com>

[ Upstream commit 8fe63eb757ac6e661a384cc760792080bdc738dc ]

HEBC method reports capabilities of 5 button array but HP Spectre X2 (2015)
does not have this control method (the same was for Wacom MobileStudio Pro).
Expand previous DMI quirk by Alex Hung to also enable 5 button array
for this system.

Signed-off-by: Nickolai Kozachenko <daemongloom@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index ef6d4bd77b1a..7a506c1d0113 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -77,6 +77,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Wacom MobileStudio Pro 16"),
 		},
 	},
+	{
+		.ident = "HP Spectre x2 (2015)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x2 Detachable"),
+		},
+	},
 	{ }
 };
 
-- 
2.25.1

