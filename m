Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE025C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB77421527
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577602;
	bh=yXPXmqd0skqNRuHYxSY4peEgUT8O2Dy/r0sZbu6ByaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xBYF/1s/AkJdwsClgwiXKJgaeGUl5yJ9E+EU1YyW34kE+Ru4ccAbphyQ48hx6kCib
	 sAydtFXyX5XZwkV4rvFTTcPaVtzjifM68M9UwlKjxrc+DrF2rr+lhfjL9d3Mzat/lE
	 buDDy2/HN8S9u9u0xGHlGlzyZ1GZuONnVOwEzkbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbgFSOkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbgFSOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:39:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F019208B8;
        Fri, 19 Jun 2020 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577595;
        bh=yXPXmqd0skqNRuHYxSY4peEgUT8O2Dy/r0sZbu6ByaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSuSOstKwQb3CufkHrhKsbwGASBTdK/fDBDKNu3PGep0AtNE4Vq9+Ke8Y7zjGLmFz
         l7CTfALBj9QhYhMl1yCmca/cU47w+QAxqJ7PQAPOsz4VvsUrgaaBm5d+UWbrBNIu2T
         MlPhSTfAIOWV8XM3NawesSvtdiongaMq/zw9gGmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hill Ma <maahiuzeon@gmail.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.9 012/128] x86/reboot/quirks: Add MacBook6,1 reboot quirk
Date:   Fri, 19 Jun 2020 16:31:46 +0200
Message-Id: <20200619141620.793530387@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
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
@@ -198,6 +198,14 @@ static struct dmi_system_id __initdata r
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


