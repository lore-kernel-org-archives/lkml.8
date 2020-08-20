Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B779BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950D822CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924943;
	bh=07OtW7d5134FkJsRUqn7e/OAUYC/AtgYEEoc7+iC8Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nbogwdEovCA6f2gq5FCZ4u6B2PlBIzCXCyHAEZhbpjCfBvdO1rdmePWSgya95KN/v
	 Rd8FuCblQ7piOceAmTNQ4pY+WfjSmJRZ+dfW3Uzn3T/zVoosq3hWfDbHj3EeBS0wug
	 AtuAR1Xzl+Nfkk0nl1TfXe1YRke1Vr8S8ptsHb9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgHTMCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgHTJ7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:59:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6E82067C;
        Thu, 20 Aug 2020 09:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917594;
        bh=07OtW7d5134FkJsRUqn7e/OAUYC/AtgYEEoc7+iC8Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uj311MKkTnZP1Ie+CVbw9aJo28UtwQWTT7p51lKq/5nF7b4z+80BmAUT3opwwM21n
         WJbofSOjfbaWONgBl6K65fXG82ezhhc5DGMpA9Z8F7wNCrsc6uPhmr/2vSQtMmzr8t
         qB9b3oCT0HonGH3W7fsBt4M4iiCHQc2rKAGMhvvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 086/212] m68k: mac: Fix IOP status/control register writes
Date:   Thu, 20 Aug 2020 11:20:59 +0200
Message-Id: <20200820091606.692314497@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 931fc82a6aaf4e2e4a5490addaa6a090d78c24a7 ]

When writing values to the IOP status/control register make sure those
values do not have any extraneous bits that will clear interrupt flags.

To place the SCC IOP into bypass mode would be desirable but this is not
achieved by writing IOP_DMAINACTIVE | IOP_RUN | IOP_AUTOINC | IOP_BYPASS
to the control register. Drop this ineffective register write.

Remove the flawed and unused iop_bypass() function. Make use of the
unused iop_stop() function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Cc: Joshua Thompson <funaho@jurai.org>
Link: https://lore.kernel.org/r/09bcb7359a1719a18b551ee515da3c4c3cf709e6.1590880333.git.fthain@telegraphics.com.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/mac/iop.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 8209a74fbdebc..cb516cacc819b 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -173,7 +173,7 @@ static __inline__ void iop_writeb(volatile struct mac_iop *iop, __u16 addr, __u8
 
 static __inline__ void iop_stop(volatile struct mac_iop *iop)
 {
-	iop->status_ctrl &= ~IOP_RUN;
+	iop->status_ctrl = IOP_AUTOINC;
 }
 
 static __inline__ void iop_start(volatile struct mac_iop *iop)
@@ -181,14 +181,9 @@ static __inline__ void iop_start(volatile struct mac_iop *iop)
 	iop->status_ctrl = IOP_RUN | IOP_AUTOINC;
 }
 
-static __inline__ void iop_bypass(volatile struct mac_iop *iop)
-{
-	iop->status_ctrl |= IOP_BYPASS;
-}
-
 static __inline__ void iop_interrupt(volatile struct mac_iop *iop)
 {
-	iop->status_ctrl |= IOP_IRQ;
+	iop->status_ctrl = IOP_IRQ | IOP_RUN | IOP_AUTOINC;
 }
 
 static int iop_alive(volatile struct mac_iop *iop)
@@ -239,7 +234,6 @@ void __init iop_preinit(void)
 		} else {
 			iop_base[IOP_NUM_SCC] = (struct mac_iop *) SCC_IOP_BASE_QUADRA;
 		}
-		iop_base[IOP_NUM_SCC]->status_ctrl = 0x87;
 		iop_scc_present = 1;
 	} else {
 		iop_base[IOP_NUM_SCC] = NULL;
@@ -251,7 +245,7 @@ void __init iop_preinit(void)
 		} else {
 			iop_base[IOP_NUM_ISM] = (struct mac_iop *) ISM_IOP_BASE_QUADRA;
 		}
-		iop_base[IOP_NUM_ISM]->status_ctrl = 0;
+		iop_stop(iop_base[IOP_NUM_ISM]);
 		iop_ism_present = 1;
 	} else {
 		iop_base[IOP_NUM_ISM] = NULL;
-- 
2.25.1



