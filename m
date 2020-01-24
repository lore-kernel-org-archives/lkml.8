Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D64C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800F120718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865313;
	bh=wUnQPA2gWOAo9yxaNNxXMNczT1iu46ZLwMyUNv8rzAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P2xrIDIdl841j+VlALVmQDsBkF20szkL2WeNnKui1igr12GNYoskCaJ3dk5iYKJ4v
	 bbfeFuN7xvVi8ArxVHD9uYw373hYNlGqs5Hh3WG66GFniBs4qokEomms7SOyTTi3nD
	 dxYOZolhOfI2fxjXT4oQE2dVQp9arrmb1+J1Gpno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391570AbgAXL2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404066AbgAXL20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:28:26 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45CC20704;
        Fri, 24 Jan 2020 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865306;
        bh=wUnQPA2gWOAo9yxaNNxXMNczT1iu46ZLwMyUNv8rzAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3aXU26wugtIbmzmQLHvRNhahInhiuqldutZjxUtFiWsE20xzEof8e1X2t20R9nsb
         FPuXll+kmtoxli5WSJ3LIEiMi3YmPE+xJ1J0R0bO9RRIpz04bbHTwgpD1Zc1fB7NCk
         alUCf/VgoxPCgTWsrBDUnrjsGE101NuQxbBt9dLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Brandon Cazander <brandon.cazander@multapplied.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 497/639] net: fix bpf_xdp_adjust_head regression for generic-XDP
Date:   Fri, 24 Jan 2020 10:31:07 +0100
Message-Id: <20200124093151.018095250@linuxfoundation.org>
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

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 065af355470519bd184019a93ac579f22b036045 ]

When generic-XDP was moved to a later processing step by commit
458bf2f224f0 ("net: core: support XDP generic on stacked devices.")
a regression was introduced when using bpf_xdp_adjust_head.

The issue is that after this commit the skb->network_header is now
changed prior to calling generic XDP and not after. Thus, if the header
is changed by XDP (via bpf_xdp_adjust_head), then skb->network_header
also need to be updated again.  Fix by calling skb_reset_network_header().

Fixes: 458bf2f224f0 ("net: core: support XDP generic on stacked devices.")
Reported-by: Brandon Cazander <brandon.cazander@multapplied.net>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 935fe158cfaff..73ebacabfde8d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4349,12 +4349,17 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
+	/* check if bpf_xdp_adjust_head was used */
 	off = xdp->data - orig_data;
-	if (off > 0)
-		__skb_pull(skb, off);
-	else if (off < 0)
-		__skb_push(skb, -off);
-	skb->mac_header += off;
+	if (off) {
+		if (off > 0)
+			__skb_pull(skb, off);
+		else if (off < 0)
+			__skb_push(skb, -off);
+
+		skb->mac_header += off;
+		skb_reset_network_header(skb);
+	}
 
 	/* check if bpf_xdp_adjust_tail was used. it can only "shrink"
 	 * pckt.
-- 
2.20.1



