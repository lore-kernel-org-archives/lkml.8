Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF5EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25EE208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645734;
	bh=An0gNQn7YMvXnKeG9BQYZZh6VW6cJv6Egsntd0dEeoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PC242eW0f6xs1FfaPs270LzHQ6cFRUwTyb8d4uNx//1vOUbaBXM9ok6rySIJlDSoA
	 SUR01/gDtO+cBIfJ9yi1J4Oud+9+H484YELrl6tLRYhcVA5+nq8cvJSX5gj7jz02CE
	 VxtBIyfGmMyIwPs+mGpcuepd11l7RhJzz1Qyg558=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgCaJIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731393AbgCaJIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F5D8208E0;
        Tue, 31 Mar 2020 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645728;
        bh=An0gNQn7YMvXnKeG9BQYZZh6VW6cJv6Egsntd0dEeoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEs9q1QiX3rVlzSwo+hWBP/nNXtA2K/KHGKwn11KS70Cf59UNatbWN1HBev1gilrS
         8R/NwA+p5aRWSP9ClH6E4DPCHDh64GG0zCQp60wuawHYZZWVLEEAMrpnrP0UaW3iqy
         LQVtKmk0lgedDcgBVOtztK+lWFMtDLbtE43JR3RY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.5 145/170] vti6: Fix memory leak of skb if input policy check fails
Date:   Tue, 31 Mar 2020 10:59:19 +0200
Message-Id: <20200331085438.755549356@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Torsten Hilbrich <torsten.hilbrich@secunet.com>

commit 2a9de3af21aa8c31cd68b0b39330d69f8c1e59df upstream.

The vti6_rcv function performs some tests on the retrieved tunnel
including checking the IP protocol, the XFRM input policy, the
source and destination address.

In all but one places the skb is released in the error case. When
the input policy check fails the network packet is leaked.

Using the same goto-label discard in this case to fix this problem.

Fixes: ed1efb2aefbb ("ipv6: Add support for IPsec virtual tunnel interfaces")
Signed-off-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/ip6_vti.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -311,7 +311,7 @@ static int vti6_rcv(struct sk_buff *skb)
 
 		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
 			rcu_read_unlock();
-			return 0;
+			goto discard;
 		}
 
 		ipv6h = ipv6_hdr(skb);


