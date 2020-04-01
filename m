Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C3C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B5E2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759629;
	bh=8q0E75SswCauUcK8zeWPsh4/aT5TVsT5CHn0afrTtZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PA8T8/PpYzRsNwJuceq3GTxzIqEl+JhbQT6zI+WvfNZ0KH94NBtxE7fsj9m+qnTRX
	 2siTSAW/KH4QiSLyRFv7Wmmj3wcnLcinrnhDD+MI5wHQysWl5W/Vw0g8MNoh3E7NfV
	 IeEXN0DI5VAmt34TIEkn94ofeP1ejjo4lC/53GqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbgDAQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389579AbgDAQrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:47:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728ED20714;
        Wed,  1 Apr 2020 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759622;
        bh=8q0E75SswCauUcK8zeWPsh4/aT5TVsT5CHn0afrTtZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJFfUSG0F8h7QlGwkOwYifwnEstt4ULIpfJqjvBtOPlF3MywHSxhmrjbc69oSetwN
         cSuZI55Ott/W3BJiZHUtnX85T6FaLkeqnOE5m3NJ6gwPQRhVCnVszf43s9cSSk2GhL
         Q2JcPFAGxR8Oz6y/4sBtw4N5Wxw7jkr8nLyqrQ70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 138/148] platform/x86: pmc_atom: Add Lex 2I385SW to critclk_systems DMI table
Date:   Wed,  1 Apr 2020 18:18:50 +0200
Message-Id: <20200401161605.470703801@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georg Müller <georgmueller@gmx.net>

commit 95b31e35239e5e1689e3d965d692a313c71bd8ab upstream.

The Lex 2I385SW board has two Intel I211 ethernet controllers. Without
this patch, only the first port is usable. The second port fails to
start with the following message:

    igb: probe of 0000:02:00.0 failed with error -2

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Tested-by: Georg Müller <georgmueller@gmx.net>
Signed-off-by: Georg Müller <georgmueller@gmx.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/pmc_atom.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -445,6 +445,14 @@ static const struct dmi_system_id critcl
 	},
 	{
 		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Lex 2I385SW",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2I385SW"),
+		},
+	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
 		.ident = "Beckhoff CB3163",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),


