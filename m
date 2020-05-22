Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BCFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0CD204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgEVSak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgEVSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:30:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09018C05BD43;
        Fri, 22 May 2020 11:30:21 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcCR0-0002m7-OV; Fri, 22 May 2020 20:30:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 260831C0095;
        Fri, 22 May 2020 20:30:18 +0200 (CEST)
Date:   Fri, 22 May 2020 18:30:18 -0000
From:   "tip-bot2 for Heinrich Schuchardt" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Avoid returning uninitialized data
 from setup_graphics()
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200426194946.112768-1-xypron.glpk@gmx.de>
References: <20200426194946.112768-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Message-ID: <159017221803.17951.10197779349789381116.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     081d5150845ba3fa49151a2f55d3cc03b0987509
Gitweb:        https://git.kernel.org/tip/081d5150845ba3fa49151a2f55d3cc03b0987509
Author:        Heinrich Schuchardt <xypron.glpk@gmx.de>
AuthorDate:    Sun, 26 Apr 2020 21:49:46 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 30 Apr 2020 23:26:30 +02:00

efi/libstub: Avoid returning uninitialized data from setup_graphics()

Currently, setup_graphics() ignores the return value of efi_setup_gop(). As
AllocatePool() does not zero out memory, the screen information table will
contain uninitialized data in this case.

We should free the screen information table if efi_setup_gop() returns an
error code.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Link: https://lore.kernel.org/r/20200426194946.112768-1-xypron.glpk@gmx.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 99a5cde..48161b1 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -60,7 +60,11 @@ static struct screen_info *setup_graphics(void)
 		si = alloc_screen_info();
 		if (!si)
 			return NULL;
-		efi_setup_gop(si, &gop_proto, size);
+		status = efi_setup_gop(si, &gop_proto, size);
+		if (status != EFI_SUCCESS) {
+			free_screen_info(si);
+			return NULL;
+		}
 	}
 	return si;
 }
