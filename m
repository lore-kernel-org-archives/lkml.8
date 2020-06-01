Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC522068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035589;
	bh=UKca6Vmt0hmdfqCKi6/7uixcWxyqVdBAMMZHI2WyIZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMQF8XQxcDh24mXKkUwTApToFmIDxRwtH07SHN/x4k3ADZI/ihaH1y1NODAoMu88y
	 mEvexwnz9C18/zG3jszapYe+wc9DfIAldNLEybDdKMt1uJwwG7IluU82Dunddva8ja
	 IV4anE/W8kvDVLLd6hDIg671deu15DB2U/oWy40o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbgFASTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731740AbgFASQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:16:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73C22068D;
        Mon,  1 Jun 2020 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035404;
        bh=UKca6Vmt0hmdfqCKi6/7uixcWxyqVdBAMMZHI2WyIZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9Mt2+f9I5ZzcCW59oOHf+dGqxQH67nDdOrHhREEMI6b+QJGLRlfMQDbKMEKThSUM
         Q6YmQCnfObjTL72HbHtCxH2WKesO65DkNweNEEpnUNPAg9qgjAyRsMQ/jxsD38r0eX
         UBJGVdp5Fk9yqzx0U7DaNSiBUfgDf0xNKt+a16Dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.6 145/177] xfrm: do pskb_pull properly in __xfrm_transport_prep
Date:   Mon,  1 Jun 2020 19:54:43 +0200
Message-Id: <20200601174100.537402774@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

commit 06a0afcfe2f551ff755849ea2549b0d8409fd9a0 upstream.

For transport mode, when ipv6 nexthdr is set, the packet format might
be like:

    ----------------------------------------------------
    |        | dest |     |     |      |  ESP    | ESP |
    | IP6 hdr| opts.| ESP | TCP | Data | Trailer | ICV |
    ----------------------------------------------------

and in __xfrm_transport_prep():

  pskb_pull(skb, skb->mac_len + sizeof(ip6hdr) + x->props.header_len);

it will pull the data pointer to the wrong position, as it missed the
nexthdrs/dest opts.

This patch is to fix it by using:

  pskb_pull(skb, skb_transport_offset(skb) + x->props.header_len);

as we can be sure transport_header points to ESP header at that moment.

It also fixes a panic when packets with ipv6 nexthdr are sent over
esp6 transport mode:

  [  100.473845] kernel BUG at net/core/skbuff.c:4325!
  [  100.478517] RIP: 0010:__skb_to_sgvec+0x252/0x260
  [  100.494355] Call Trace:
  [  100.494829]  skb_to_sgvec+0x11/0x40
  [  100.495492]  esp6_output_tail+0x12e/0x550 [esp6]
  [  100.496358]  esp6_xmit+0x1d5/0x260 [esp6_offload]
  [  100.498029]  validate_xmit_xfrm+0x22f/0x2e0
  [  100.499604]  __dev_queue_xmit+0x589/0x910
  [  100.502928]  ip6_finish_output2+0x2a5/0x5a0
  [  100.503718]  ip6_output+0x6c/0x120
  [  100.505198]  xfrm_output_resume+0x4bf/0x530
  [  100.508683]  xfrm6_output+0x3a/0xc0
  [  100.513446]  inet6_csk_xmit+0xa1/0xf0
  [  100.517335]  tcp_sendmsg+0x27/0x40
  [  100.517977]  sock_sendmsg+0x3e/0x60
  [  100.518648]  __sys_sendto+0xee/0x160

Fixes: c35fe4106b92 ("xfrm: Add mode handlers for IPsec on layer 2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_device.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -25,12 +25,10 @@ static void __xfrm_transport_prep(struct
 	struct xfrm_offload *xo = xfrm_offload(skb);
 
 	skb_reset_mac_len(skb);
-	pskb_pull(skb, skb->mac_len + hsize + x->props.header_len);
-
-	if (xo->flags & XFRM_GSO_SEGMENT) {
-		skb_reset_transport_header(skb);
+	if (xo->flags & XFRM_GSO_SEGMENT)
 		skb->transport_header -= x->props.header_len;
-	}
+
+	pskb_pull(skb, skb_transport_offset(skb) + x->props.header_len);
 }
 
 static void __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,


