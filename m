Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEBDC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6603B20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758491;
	bh=8pEuoc9ZRvj48bcsQLL6M7O0tuy0wKITKF9T6rgzzdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTZeUHDGfurQmGqXAkJWx+NjUFPQU/zZXhJpVmdpyCkTQljkG2E0g7orFkr6bvn66
	 h18qKlYjDbess7ncOJuGtCSGnKbydx7Txtj0+YH02ngOW0jYMM6JnolQabDXwd52Zo
	 vQ0WNnAT3O4gMi+IfRV4QHbFhuS/7f5i+AMl1BHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbgDAQ2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387799AbgDAQ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:28:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D79FC20BED;
        Wed,  1 Apr 2020 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758486;
        bh=8pEuoc9ZRvj48bcsQLL6M7O0tuy0wKITKF9T6rgzzdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9wV/aJYt+KxOxb3R4GFTNswF2NIpo8HWHJg2omrMIu5HkXbHl2awp/HYe819gk0S
         kos/Nps4AXReJvmeNDuJa3RFIW3eIbjxCKvvou08uNsZtuams3mjRMwVMZ5G7HB7z0
         xGWYA0+PziWp+GR1cjqiqMfqlsq6aw9klYzVKC7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 104/116] platform/x86: pmc_atom: Add Lex 2I385SW to critclk_systems DMI table
Date:   Wed,  1 Apr 2020 18:18:00 +0200
Message-Id: <20200401161555.507781485@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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
@@ -415,6 +415,14 @@ static const struct dmi_system_id critcl
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


