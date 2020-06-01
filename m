Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB83C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D872073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035452;
	bh=jHgf50/mZjy0DkDrZt3S3+Rq2eSwGH05OBduwjQNTrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZrPUZfwHlYxkl0Fu02C+pdtAsnEApJMePgu1/oIBzdfUE+0VsTSoWrAURWN3+W4Pc
	 pMg1lH7QAAyQ9MIA/wdhvodMUkGoFoImcUgAwdCrOWPEDf47ZJvvN1edlrQ7oUkNmO
	 BOufBNErHC7awQYaDGearhSH1aeLMpYALQXvxcMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgFASRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731822AbgFASRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:17:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91E42065C;
        Mon,  1 Jun 2020 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035442;
        bh=jHgf50/mZjy0DkDrZt3S3+Rq2eSwGH05OBduwjQNTrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdcOWfAuPkXryiYQEOgcDl4jXtHA0JuTQ9mwBX8rrQVlf4e10fDaPxXyuwyzpQA/S
         OsiNgKKbueIxnInRg8BJQelB5yUwprCkF7xFKjnsUtYZdmyGMkduOWu4L0bjSWVHHK
         Jt8bHsPUJWZQpI3rc95Sk04oqtIIj3fWOxnoCAuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 160/177] bnxt_en: Fix accumulation of bp->net_stats_prev.
Date:   Mon,  1 Jun 2020 19:54:58 +0200
Message-Id: <20200601174101.615642264@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

commit b8056e8434b037fdab08158fea99ed7bc8ef3a74 upstream.

We have logic to maintain network counters across resets by storing
the counters in bp->net_stats_prev before reset.  But not all resets
will clear the counters.  Certain resets that don't need to change
the number of rings do not clear the counters.  The current logic
accumulates the counters before all resets, causing big jumps in
the counters after some resets, such as ethtool -G.

Fix it by only accumulating the counters during reset if the irq_re_init
parameter is set.  The parameter signifies that all rings and interrupts
will be reset and that means that the counters will also be reset.

Reported-by: Vijayendra Suman <vijayendra.suman@oracle.com>
Fixes: b8875ca356f1 ("bnxt_en: Save ring statistics before reset.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9324,7 +9324,7 @@ static void __bnxt_close_nic(struct bnxt
 	bnxt_free_skbs(bp);
 
 	/* Save ring stats before shutdown */
-	if (bp->bnapi)
+	if (bp->bnapi && irq_re_init)
 		bnxt_get_ring_stats(bp, &bp->net_stats_prev);
 	if (irq_re_init) {
 		bnxt_free_irq(bp);


