Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BF020842
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663523;
	bh=VW46B+ei0NsG89h3+DTKJ1cC++KE1d0wIR0QtbLgOmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MoQCXn9M57+UqfmXRw3nZCsGPHbp0jK/x7k4INmMXbSCZtdMZjS1muJpWycz7gaOJ
	 FUCYWHV9VfFA9q7yyUf4bo8fzlpsmCdZvx4falY9GanzQwRwLGIIiZL48sWlhYBphT
	 hlYV35FZ8liIdmFOBpSnaziyS4Gmtm9jcsPI52LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbgFIApW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgFHXLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FFC212CC;
        Mon,  8 Jun 2020 23:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657909;
        bh=VW46B+ei0NsG89h3+DTKJ1cC++KE1d0wIR0QtbLgOmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XSo1qGLjue8HRya73WN2HuxugFQ/ZMf8uFPKV5vzXYT5H+478jqWETW86N+c4cjBD
         bJQnDTEPb0yuoE/JFwuamSdo2XvQl4cVMGGesombS+hNTokteWbYh1H1ZCw9c1kyca
         0kFxlM2/4wYaWKPNfKeW8CYR2sfQouk0JQlCt8eE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nickolai Kozachenko <daemongloom@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 261/274] platform/x86: intel-hid: Add a quirk to support HP Spectre X2 (2015)
Date:   Mon,  8 Jun 2020 19:05:54 -0400
Message-Id: <20200608230607.3361041-261-sashal@kernel.org>
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
index cc7dd4d87cce..9ee79b74311c 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -79,6 +79,13 @@ static const struct dmi_system_id button_array_table[] = {
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

