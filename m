Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46956C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4D920722
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgE3XQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:16:30 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51084 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgE3XQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:16:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id C614B27F1F; Sat, 30 May 2020 19:16:28 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <8e35df4d193b082cb6285b1f30c949ff7e30e99e.1590880333.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880333.git.fthain@telegraphics.com.au>
References: <cover.1590880333.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 3/4] m68k/mac: Don't send uninitialized data in IOP message
 reply
Date:   Sun, 31 May 2020 09:12:13 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the message reply before calling iop_complete(). This code path is
not normally executed but should that happen let's arrange for consistent
behaviour from the IOP.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/iop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 5fc3b59ba811..8d6946edf2c8 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -449,6 +449,7 @@ static void iop_handle_recv(uint iop_num, uint chan)
 		iop_pr_debug("unclaimed message on iop_num %d chan %d\n",
 		             iop_num, chan);
 		iop_pr_debug("%*ph\n", IOP_MSG_LEN, msg->message);
+		memset(msg->reply, 0, IOP_MSG_LEN);
 		iop_complete_message(msg);
 	}
 }
-- 
2.26.2

