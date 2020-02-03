Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DBFC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6525921775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748029;
	bh=Avn94gxtxckZq6vTCzX9QzDJp9U91PaWoJX8xu25P7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Re3ZGNHFRFdDITsr7199WIDT7HUhiIhgN9fjUrnRZPlHsvXblD1kiBIlw657CEZeX
	 5kYQSqkgrKyJMOlhReuMnLld9kjux2P9Tmv5qeFcZ4oxHE4GUZ3VFazvxPOyKd/I22
	 clbVHrF8KiD2lnpXlgRoqS1mUhSDGBuG+8/sjcZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgBCQk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730666AbgBCQgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:36:23 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95B1720CC7;
        Mon,  3 Feb 2020 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747783;
        bh=Avn94gxtxckZq6vTCzX9QzDJp9U91PaWoJX8xu25P7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwgEOPK1cKO1L/Nqn/cJlkjqBgLyeY6fNiwqtoLOj87SwRgRa7e4m/EbavTJ6SZPJ
         7W6Ko2cqOvDRBSReEqSkkxwBWRgMjxPStIfE+GQqupupt7cZxnOpKdjhHusSoQqBrl
         FKog9ASzdIA0Fe6EP21ElCjLp0OlQnYQXADF0j4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 69/90] xfrm: interface: do not confirm neighbor when do pmtu update
Date:   Mon,  3 Feb 2020 16:20:12 +0000
Message-Id: <20200203161925.873480341@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Wang <vulab@iscas.ac.cn>

[ Upstream commit 8aaea2b0428b6aad7c7e22d3fddc31a78bb1d724 ]

When do IPv6 tunnel PMTU update and calls __ip6_rt_update_pmtu() in the end,
we should not call dst_confirm_neigh() as there is no two-way communication.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
index a3db19d93fc5b..4d5627e274fe3 100644
--- a/net/xfrm/xfrm_interface.c
+++ b/net/xfrm/xfrm_interface.c
@@ -294,7 +294,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 
 	mtu = dst_mtu(dst);
 	if (!skb->ignore_df && skb->len > mtu) {
-		skb_dst_update_pmtu(skb, mtu);
+		skb_dst_update_pmtu_no_confirm(skb, mtu);
 
 		if (skb->protocol == htons(ETH_P_IPV6)) {
 			if (mtu < IPV6_MIN_MTU)
-- 
2.20.1



