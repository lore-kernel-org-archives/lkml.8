Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D27C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC87F2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577949;
	bh=Lq0rzd8/VWyjqzu7gI6W77XhrAJW8U6FGO1gnHwgDWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/eBDocIEuZneAcl6Y8Yi/zx9Wh7Nx6OQ1lPJYQbHDX74rqbdJh23GDVpQx7GUM01
	 lkjoDYBAdBe2Tu67Aq5hqCd4OyUixqE3qWYa3cjtwRxL883BzrHpeobLm6XIuTLyoR
	 givyAvtRPyex+D7SsLbJcjJhdzX1iWxsaWNCnMI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbgFSOps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388734AbgFSOpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:45:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7120C21582;
        Fri, 19 Jun 2020 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577940;
        bh=Lq0rzd8/VWyjqzu7gI6W77XhrAJW8U6FGO1gnHwgDWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlchXEMXpySaAImBTKgpDO+POTfkn1SkbLXEhptEZhD4h14JmaXJdoFtht3uHOLtr
         tRbdHX9eKKcgqAV0ocayqiaPz4D2X28lSrzRK0BpZk9ObJy2TqA8yNom8MezwpDtap
         vF2tPz/jrQC248a+8suBhEOAk6XlIAEeUprzn5Yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hill Ma <maahiuzeon@gmail.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.14 021/190] x86/reboot/quirks: Add MacBook6,1 reboot quirk
Date:   Fri, 19 Jun 2020 16:31:06 +0200
Message-Id: <20200619141634.537389228@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hill Ma <maahiuzeon@gmail.com>

commit 140fd4ac78d385e6c8e6a5757585f6c707085f87 upstream.

On MacBook6,1 reboot would hang unless parameter reboot=pci is added.
Make it automatic.

Signed-off-by: Hill Ma <maahiuzeon@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200425200641.GA1554@cslab.localdomain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/reboot.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -197,6 +197,14 @@ static const struct dmi_system_id reboot
 			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook5"),
 		},
 	},
+	{	/* Handle problems with rebooting on Apple MacBook6,1 */
+		.callback = set_pci_reboot,
+		.ident = "Apple MacBook6,1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook6,1"),
+		},
+	},
 	{	/* Handle problems with rebooting on Apple MacBookPro5 */
 		.callback = set_pci_reboot,
 		.ident = "Apple MacBookPro5",


