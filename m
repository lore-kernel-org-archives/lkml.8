Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC152C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B076420786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443481;
	bh=XzkKbqShnJLF7V6w/5exwpL/9fMUfvcvO0BYNigW42k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HL1wcGx/GY5FcvsoK5DS4oRVeaJXYKo2aytWz15m6jIA0kTu8Z4B+ivP2rNmXPtk2
	 j1eKx0Amd096jOq42F0ffcBd7FDclIvAk6OQ26gcQy2bhTFLPDM0dxyLqE8bzAJ1k2
	 hrZdtWoozbdPAwdrgyO6f7032ym5kyE0ChQHcLlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgHZMEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbgHZMDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86FBB20838;
        Wed, 26 Aug 2020 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443416;
        bh=XzkKbqShnJLF7V6w/5exwpL/9fMUfvcvO0BYNigW42k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4bnmQwaw0UBrIPcM13UWUe99okyVh5gdfefNDFevYAnTSSKB9JGo0IvaGHpR1iqw
         yC1eCLj7aN41BUpcsXBFv8/FD+88nmpfOpkNoGiBO97Dw2TJJtX1A0OhErQcS/rvex
         2LR4hw0MO/WluoW+T3cpldQwn2v4fuzAMFlQgICg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 02/16] net: Fix potential wrong skb->protocol in skb_vlan_untag()
Date:   Wed, 26 Aug 2020 14:02:39 +0200
Message-Id: <20200826114911.339700140@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114911.216745274@linuxfoundation.org>
References: <20200826114911.216745274@linuxfoundation.org>
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
@@ -5419,8 +5419,8 @@ struct sk_buff *skb_vlan_untag(struct sk
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
 		goto err_free;
-
-	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN)))
+	/* We may access the two bytes after vlan_hdr in vlan_set_encap_proto(). */
+	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN + sizeof(unsigned short))))
 		goto err_free;
 
 	vhdr = (struct vlan_hdr *)skb->data;


