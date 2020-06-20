Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED71C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9407E22BEA
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592615323;
	bh=R7DEl1i5DHqfvffOoBsF0oTwiT8GHdBiHp5N18EJxhU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MTujxHeb1GneOfMtnGlQFbymNvT8psaKEcR16fdvmi6K5kOfaJpGLBtJm+/S5RoXm
	 pKJKGPkjFXVmnEzVxRWHi3rNgOLF/U5qbLYF1jXajqQMgAU6nBq9U4iEloc8B2QsIP
	 8+hhrnKZm1A4ytjIPMGl46SXceFNfXJsau0ejCj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgFTBIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbgFTBIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:08:41 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A0322B51;
        Sat, 20 Jun 2020 01:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592615321;
        bh=R7DEl1i5DHqfvffOoBsF0oTwiT8GHdBiHp5N18EJxhU=;
        h=Date:From:To:Cc:Subject:From;
        b=wkzaJEhxoVhT9pDss5CSE7QvIJmmDQuwpB2eSfavy4Nc+t2+c7lya16GP4DOYPyKB
         miM8Ne3ZwTlmHqfF7WqNfbWgQMjigiAJcp04ulY+75/negUHxsDGbMDKtOK6U2kaEG
         FpmMOkqFJgOhflOUD8CE/iReF4yf4TZvYE4brFtY=
Date:   Fri, 19 Jun 2020 20:14:06 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] sparc64: viohs: Use struct_size() helper
Message-ID: <20200620011406.GA3260@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
variable _len_.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/sparc/kernel/viohs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index 7db5aabe9708..e27afd233bf5 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -428,7 +428,7 @@ static int process_dreg_info(struct vio_driver_state *vio,
 			     struct vio_dring_register *pkt)
 {
 	struct vio_dring_state *dr;
-	int i, len;
+	int i;
 
 	viodbg(HS, "GOT DRING_REG INFO ident[%llx] "
 	       "ndesc[%u] dsz[%u] opt[0x%x] ncookies[%u]\n",
@@ -482,9 +482,7 @@ static int process_dreg_info(struct vio_driver_state *vio,
 	       pkt->num_descr, pkt->descr_size, pkt->options,
 	       pkt->num_cookies);
 
-	len = (sizeof(*pkt) +
-	       (dr->ncookies * sizeof(struct ldc_trans_cookie)));
-	if (send_ctrl(vio, &pkt->tag, len) < 0)
+	if (send_ctrl(vio, &pkt->tag, struct_size(pkt, cookies, dr->ncookies)) < 0)
 		goto send_nack;
 
 	vio->dr_state |= VIO_DR_STATE_RXREG;
-- 
2.27.0

