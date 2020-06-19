Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDFF20776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579497;
	bh=gswEMTj0QRf98GeeTYMxIjqSnB5PKKOYuz4dzsRh3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nCUdIGEgoMYdeLnrmHhT8UplW2c6vu5aX2XFsBJpGC1MU9F8afO5HKd6eYQbRLGs2
	 SDZQejJanX3t9jJjLKBZhfUu2sDy6vpDcxIaFk3mfM65B7mXcJbS0jDgFmUGdTtoyj
	 rPEqWf161d8YGpsGbdJK+Q+0payW67AIN3PBYyAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392123AbgFSPLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389466AbgFSPLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:11:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D403D20776;
        Fri, 19 Jun 2020 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579481;
        bh=gswEMTj0QRf98GeeTYMxIjqSnB5PKKOYuz4dzsRh3k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXB1ikoLBJ9RU7w6Wyqbeim+g94tfx375ZtdJ9uhwS8T20e6aGLRFwDrLlSyL7zVl
         JbRvo1h+rNGgjToCnCH3H0Txp9BmsMFNSNuiLWuDP5skrFonmpkns6sP2hM/21Tmwe
         2V1cwNmFmQYZZnajoQDpaJpQv8dBkWS4a3mI1pqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nickolai Kozachenko <daemongloom@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 150/261] platform/x86: intel-hid: Add a quirk to support HP Spectre X2 (2015)
Date:   Fri, 19 Jun 2020 16:32:41 +0200
Message-Id: <20200619141657.060438904@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



