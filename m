Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08161C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA3F222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="gv/O6tdl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pknkfcus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgBOGT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:19:58 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:54219 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbgBOGT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:19:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2C36D63BC;
        Sat, 15 Feb 2020 01:19:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 15 Feb 2020 01:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=hSouSsobAjpXD
        JaLkOFL8Uc12VDY8WT1xUChd1bBKcU=; b=gv/O6tdl9sBP7jCtfkxkDFrwgjAph
        YddeeE8QyFfunM6WNW6WDhp6dKRxJ9ZSS4ElI1PjXuTL+C1dGpnsJWCPmV6FLPTx
        oNFzQSG2JSgsxyhnT1y7RH4bj1nDWQlc6zcL02QFTQOPi6AKljAZe38I+dfWjLoU
        hS+ivdXIGEoaXFLs1iOIm74Ob6RnQB8QGBKYoUXEh0rUP5UuQI+pKWDGHP0Nu82w
        obz/2eAtLNk+jsoWvWKFfktYwuOW31JN0vnf5l8d7baNQmZUazEolpiumy/Y/mPr
        JAn6TLgkZDQBDDuVHZZoJsS+ynEtb/Qgxz9d7x9FfDpmN60PxzntCPe5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=hSouSsobAjpXDJaLkOFL8Uc12VDY8WT1xUChd1bBKcU=; b=Pknkfcus
        VEhmh2/e/67xrculb+Cf1x1qh08QQ3jqF/fTLvjLtcsA7LGP00bxKeMosbWEwoSU
        eFZdxQAfr3UDcdEYdH6aWckCN2JTMCFDKoEDQ6jxjqf8NakV4zVfjZfYqbUIbbdD
        Ye+l/eym5Ug+xN91gQM4b7+42KhQMNDQSzQ4YEUmdHRmCh2SrbdOkx6HvAMV8P/g
        jLUhL4jAJFDuF7yxfdeNE63Vc10ipmLEwn1Ml5L+CDZBtiAPKKSPOW12fAxR8EFZ
        hHMC0v/gaJsHYeyF/YqbgeduDTHNP+jhy2DjaOhpOwVKjCUCttVHeeHp9x2IsHub
        SIA0oRh82zsukA==
X-ME-Sender: <xms:io1HXllp69IbqtJ9lpATLUNQATSoDiBOkHH8zlAMmRaeX3ISPP_R6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedugdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:io1HXsinOja78dQD1nBmUXgITMcFwhP7cQgiZKK6Jbd1cgluN8IzPw>
    <xmx:io1HXigYibKXVHcRJAPs0k5iRmasKioU6BBjBalgfWKvcOGKyg2gOg>
    <xmx:io1HXqb533JF4gzO8q94uxezXd3aHn_7W_79tEZnf2i6uw4l58P57w>
    <xmx:jI1HXtqHGJCqWLrw1TUkGQnqZm7zRylMPOYJilxH_ZsXN0uoEqOalg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 061CF328005A;
        Sat, 15 Feb 2020 01:19:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] mailbox: sun6i-msgbox: Remove unneeded FIFO status check
Date:   Sat, 15 Feb 2020 00:19:53 -0600
Message-Id: <20200215061953.55300-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CABb+yY3T1cL+E6Y1tGb5cuKLSY5m_zi=VOx4AJzuX40TMOSQTw@mail.gmail.com>
References: <CABb+yY3T1cL+E6Y1tGb5cuKLSY5m_zi=VOx4AJzuX40TMOSQTw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A transmit FIFO can never be full, because the mailbox framework
waits until mbox->ops->last_tx_done() succeeds before sending the next
message. sun6i_msgbox_last_tx_done() ensures that the FIFO is empty.

Since the extra check here is unnecessary, remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/mailbox/sun6i-msgbox.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mailbox/sun6i-msgbox.c b/drivers/mailbox/sun6i-msgbox.c
index 15d6fd522dc5..ccecf2e5941d 100644
--- a/drivers/mailbox/sun6i-msgbox.c
+++ b/drivers/mailbox/sun6i-msgbox.c
@@ -106,12 +106,6 @@ static int sun6i_msgbox_send_data(struct mbox_chan *chan, void *data)
 	if (WARN_ON_ONCE(!(readl(mbox->regs + CTRL_REG(n)) & CTRL_TX(n))))
 		return 0;
 
-	/* We cannot post a new message if the FIFO is full. */
-	if (readl(mbox->regs + FIFO_STAT_REG(n)) & FIFO_STAT_MASK) {
-		mbox_dbg(mbox, "Channel %d busy sending 0x%08x\n", n, msg);
-		return -EBUSY;
-	}
-
 	writel(msg, mbox->regs + MSG_DATA_REG(n));
 	mbox_dbg(mbox, "Channel %d sent 0x%08x\n", n, msg);
 
-- 
2.24.1

