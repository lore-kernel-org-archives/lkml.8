Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ACFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062762077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865100;
	bh=3nooC2UunGL8B2T106tkeTkCAOGTWVThgtaw3AM+Pds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aGQj2gfNkmVgyewaxA0ILaEBHmVzbzJMvQbdRaoPA9Q3x6LoncZx7mT+LStwon8Ua
	 mO+h50wA6dvjL4GclkbjgxLOwz26qGizPDhQ4uSHaFjLgHWbvbFtWOFurbr7FnAMq8
	 KA5Ss562RCA4dnev5ZmGxJIBKYUCSz1bGVNmafq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391447AbgAXLY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391123AbgAXLY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:24:56 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66271206D4;
        Fri, 24 Jan 2020 11:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865096;
        bh=3nooC2UunGL8B2T106tkeTkCAOGTWVThgtaw3AM+Pds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEU7UplIkyJCQACHNXC3qUyqrc9AMwHJUq+oF6R5F2DeswdEwB+TpjDuUS1eUHRi4
         eEl/g/6/8aFCAfG0JoP2oEyXON7SwRSDMk3xHzi7PJpqpJv1kbaB3/CMs/KtkG5sOg
         Oq7WQy82YCfllCzf9+0DiRyAzvokiCF4YqFt+dpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 429/639] qed: iWARP - fix uninitialized callback
Date:   Fri, 24 Jan 2020 10:29:59 +0100
Message-Id: <20200124093140.761410114@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@marvell.com>

[ Upstream commit 43cf40d93fadbb0d3edf0942a4612f8ff67478a1 ]

Fix uninitialized variable warning by static checker.

Fixes: ae3488ff37dc ("qed: Add ll2 connection for processing unaligned MPA packets")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index c77babd0ef952..39787bb885c86 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -2641,6 +2641,7 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 	cbs.rx_release_cb = qed_iwarp_ll2_rel_rx_pkt;
 	cbs.tx_comp_cb = qed_iwarp_ll2_comp_tx_pkt;
 	cbs.tx_release_cb = qed_iwarp_ll2_rel_tx_pkt;
+	cbs.slowpath_cb = NULL;
 	cbs.cookie = p_hwfn;
 
 	memset(&data, 0, sizeof(data));
-- 
2.20.1



