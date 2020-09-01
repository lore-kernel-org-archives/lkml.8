Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1499C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924782071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980091;
	bh=6U3tpnVDynBvNo+gSnrFfnNkeZUzIxS3spDzXru5xkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlVn/zX14419U5yqzokUVIZcUTuZGCRopV/izDqBkiA/dep/GtWeK6MlDA40h7v2J
	 aNeUAng1dRzD97XVGu1DO/Q41O12j2UoQFTdiM6R00kiRQT8TOsuEt+tbVHvL3Amw6
	 bv7VU6BMiNA/D5KGHbylDD/mbmEcEIWYXBB+BSdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgIARIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbgIAPSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:18:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907D1206EB;
        Tue,  1 Sep 2020 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973490;
        bh=6U3tpnVDynBvNo+gSnrFfnNkeZUzIxS3spDzXru5xkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvP5HychZ4rJUsfBkxsNMZEHS6qChIRCZHqF5qGLpppkcGo5Jm8X86MnTe6JD1bnQ
         XvbQz2Hg1baP6+mZ6QB8AQmupOVKPpoz35T170Xi1zOTUTRM6JMEUCWYxLHIXuU91J
         3EMT4lb1sXbhDC3XP8eKBG//cK4EVsLXNb8OD3Sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 02/91] net: Fix potential wrong skb->protocol in skb_vlan_untag()
Date:   Tue,  1 Sep 2020 17:09:36 +0200
Message-Id: <20200901150928.238578130@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
References: <20200901150928.096174795@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit 55eff0eb7460c3d50716ed9eccf22257b046ca92 ]

We may access the two bytes after vlan_hdr in vlan_set_encap_proto(). So
we should pull VLAN_HLEN + sizeof(unsigned short) in skb_vlan_untag() or
we may access the wrong data.

Fixes: 0d5501c1c828 ("net: Always untag vlan-tagged traffic on input.")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5053,8 +5053,8 @@ struct sk_buff *skb_vlan_untag(struct sk
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
 		goto err_free;
-
-	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN)))
+	/* We may access the two bytes after vlan_hdr in vlan_set_encap_proto(). */
+	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN + sizeof(unsigned short))))
 		goto err_free;
 
 	vhdr = (struct vlan_hdr *)skb->data;


