Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF7C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FD420866
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578739111;
	bh=t0N1ByeMceaz4tEkzMRi0NbLTc3xWbHmeA+gCrPDEMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bsGmCmT1qiPgG8aSHoRlKZ4qBdHGcjBXKjWNTusRjLjJYRPRIIfN11cJLq098ZnvC
	 fz6xJq5KXuHMs4k6AmdUfwLCLzFzqyNcusX1IZ46Ta92lPvEgEPnTmFGspNMRNf4Fn
	 vptTRYWLMAG5GjtrTrM+Q1LE0G8iMxsjfkeGdy9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgAKKi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbgAKKi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:38:27 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715BD20848;
        Sat, 11 Jan 2020 10:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578739107;
        bh=t0N1ByeMceaz4tEkzMRi0NbLTc3xWbHmeA+gCrPDEMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywgRI4fa+Q7gzUbf6R7EY/SP9IWWmxkLISfXpBzwkjdjvDVvnwcQb91RQWHBfsKFZ
         CBpF+Xu8k6L0eDLtjyCpM8KzVVYtLxCwf/M8W+Ch30trboCj8mN/mVFeL2M8IVPzHn
         CmLyPrOHyjSSrM/j/HPuoBfzqxC6zU8+GDl0O3vY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Chan Shu Tak, Alex" <alexchan@task.com.hk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 38/62] llc2: Fix return statement of llc_stat_ev_rx_null_dsap_xid_c (and _test_c)
Date:   Sat, 11 Jan 2020 10:50:20 +0100
Message-Id: <20200111094847.539840585@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094837.425430968@linuxfoundation.org>
References: <20200111094837.425430968@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chan Shu Tak, Alex <alexchan@task.com.hk>

[ Upstream commit af1c0e4e00f3cc76cb136ebf2e2c04e8b6446285 ]

When a frame with NULL DSAP is received, llc_station_rcv is called.
In turn, llc_stat_ev_rx_null_dsap_xid_c is called to check if it is a NULL
XID frame. The return statement of llc_stat_ev_rx_null_dsap_xid_c returns 1
when the incoming frame is not a NULL XID frame and 0 otherwise. Hence, a
NULL XID response is returned unexpectedly, e.g. when the incoming frame is
a NULL TEST command.

To fix the error, simply remove the conditional operator.

A similar error in llc_stat_ev_rx_null_dsap_test_c is also fixed.

Signed-off-by: Chan Shu Tak, Alex <alexchan@task.com.hk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/llc/llc_station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index 204a8351efff..c29170e767a8 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -32,7 +32,7 @@ static int llc_stat_ev_rx_null_dsap_xid_c(struct sk_buff *skb)
 	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
 	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
 	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_XID &&
-	       !pdu->dsap ? 0 : 1;			/* NULL DSAP value */
+	       !pdu->dsap;				/* NULL DSAP value */
 }
 
 static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
@@ -42,7 +42,7 @@ static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
 	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
 	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
 	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_TEST &&
-	       !pdu->dsap ? 0 : 1;			/* NULL DSAP */
+	       !pdu->dsap;				/* NULL DSAP */
 }
 
 static int llc_station_ac_send_xid_r(struct sk_buff *skb)
-- 
2.20.1



