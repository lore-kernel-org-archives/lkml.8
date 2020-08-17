Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124BFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6DD205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597681682;
	bh=PEIF5s5bOK0Rz4QWL+fmZFTs5nPWRTg7RKyh87EV3ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GtxfxCgAgTMMWYgP6HmY5cd3NnXm+/8CSDKt2HF4weSW1nWPJT7Q3v1osgmS5ntDd
	 JiRMF7OfKruDEJ7aAEEFMssMajcivNKcTR9mFVnREAKq5QFqhpd5fsGX9RbvjjBFSs
	 vascPXiaQk82UtLtEytLFYLmKrhWVows9Q8Q6YvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgHQQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387852AbgHQPw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:52:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0ACC20657;
        Mon, 17 Aug 2020 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679546;
        bh=PEIF5s5bOK0Rz4QWL+fmZFTs5nPWRTg7RKyh87EV3ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emh8DWd4nElDY3ZfzHjxudNBEhXX1kPgoUKFrDyk0bH/YyyvoKixUhjULD5PRNLqC
         JiE87NVT7k2WBPbBRxLASzI/5W90gDodFZ+5lEW8ZhLtSzTemWGffDREvg+Ng+CEoe
         klpaGhd72uDnt6zbz3H+H7XSs3hBquWUQf95NRmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 249/393] macintosh/via-macii: Access autopoll_devs when inside lock
Date:   Mon, 17 Aug 2020 17:14:59 +0200
Message-Id: <20200817143831.699880711@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 59ea38f6b3af5636edf541768a1ed721eeaca99e ]

The interrupt handler should be excluded when accessing the autopoll_devs
variable.

Fixes: d95fd5fce88f0 ("m68k: Mac II ADB fixes") # v5.0+
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/5952dd8a9bc9de90f1acc4790c51dd42b4c98065.1593318192.git.fthain@telegraphics.com.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/macintosh/via-macii.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index ac824d7b2dcfc..6aa903529570d 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -270,15 +270,12 @@ static int macii_autopoll(int devs)
 	unsigned long flags;
 	int err = 0;
 
+	local_irq_save(flags);
+
 	/* bit 1 == device 1, and so on. */
 	autopoll_devs = devs & 0xFFFE;
 
-	if (!autopoll_devs)
-		return 0;
-
-	local_irq_save(flags);
-
-	if (current_req == NULL) {
+	if (autopoll_devs && !current_req) {
 		/* Send a Talk Reg 0. The controller will repeatedly transmit
 		 * this as long as it is idle.
 		 */
-- 
2.25.1



