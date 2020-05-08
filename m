Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4007FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBBD2495A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941501;
	bh=Lxrqk0639GIY5+sYCjtar44CTjoi4LVfNTlKaP/Wz8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0pn80mDx79lQxo1j92K2ADzcsdEpQatojJ8k0FFa8h6kBuOg2HBr1EpD7edGTr7vs
	 OHd6ETKL8bfGubgJbSomocdCpATjxDNUL9zgVVdLEdh9e2pbmIyTacsMMVpKIghKuU
	 I5iNckDt/3DwwtUCqvfRU3PaL6+xdAy0Ye+4osso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgEHMiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgEHMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:38:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A446E21473;
        Fri,  8 May 2020 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941489;
        bh=Lxrqk0639GIY5+sYCjtar44CTjoi4LVfNTlKaP/Wz8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YaenskBzTNKPCnfeYQ2+xjPO6iEPw0C7vtAwFUwsZUBL8gP2hw6W+fL7808RXeVhi
         j8yqYbnnoUlmPyJvXnTvG8+LJAZrKunGu7zUIGpuv9lFoIcQGXs6x7bklFEESMTJuT
         Phi3ZeL/pxX6eXV11gN+EYJh1+wzErnNcGz7Sn9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 051/312] netfilter: nfnetlink: use original skbuff when acking batches
Date:   Fri,  8 May 2020 14:30:42 +0200
Message-Id: <20200508123128.141293657@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 7c7bdf35991bb8f7cfaeaf22ea3a2f2d1967c166 upstream.

Since bd678e09dc17 ("netfilter: nfnetlink: fix splat due to incorrect
socket memory accounting in skbuff clones"), we don't manually attach
the sk to the skbuff clone anymore, so we have to use the original
skbuff from netlink_ack() which needs to access the sk pointer.

Fixes: bd678e09dc17 ("netfilter: nfnetlink: fix splat due to incorrect socket memory accounting in skbuff clones")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nfnetlink.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -309,14 +309,14 @@ replay:
 #endif
 		{
 			nfnl_unlock(subsys_id);
-			netlink_ack(skb, nlh, -EOPNOTSUPP);
+			netlink_ack(oskb, nlh, -EOPNOTSUPP);
 			return kfree_skb(skb);
 		}
 	}
 
 	if (!ss->commit || !ss->abort) {
 		nfnl_unlock(subsys_id);
-		netlink_ack(skb, nlh, -EOPNOTSUPP);
+		netlink_ack(oskb, nlh, -EOPNOTSUPP);
 		return kfree_skb(skb);
 	}
 
@@ -406,7 +406,7 @@ ack:
 				 * pointing to the batch header.
 				 */
 				nfnl_err_reset(&err_list);
-				netlink_ack(skb, nlmsg_hdr(oskb), -ENOMEM);
+				netlink_ack(oskb, nlmsg_hdr(oskb), -ENOMEM);
 				status |= NFNL_BATCH_FAILURE;
 				goto done;
 			}


