Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1513CC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19B520752
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623202;
	bh=rsOWAzkzs6JQ9c5lYp5MDkBJ+aQDIqWSJysq3FgoU/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7QL7Llvjcc3K7LaiGmLJlE9u0S5wqh+i9Pfm2uAQd0TmrsiGrolKbdXk0xs6LHUG
	 m4auifWJWWCteLQruVXijF66dr5EwIQ8a0cBlFHGAOnDJZP8ey3Cq+BdxgqnG1nLOV
	 usNnEaJGVGcp9qKrsbiLc3ACNuquQ1pTC+Vxu+d0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCSNGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgCSNGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:06:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF7F20752;
        Thu, 19 Mar 2020 13:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623198;
        bh=rsOWAzkzs6JQ9c5lYp5MDkBJ+aQDIqWSJysq3FgoU/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h54rN88e+6sR4ZUyEwwH0XDfbz7xpdLjZhBsAyoH/R9X3XCpK5EhWmIC/dEYKMeDa
         BGZ9SwNVOcyy5lMeLXcFRAiIRpToqjvYpvkHrZ4TR53n4JsWQbsYxE8k3sjhiSOdq/
         MzWEzPbZVOm4yo0Z3wljeLIlgp7/oRtKWyc1/QUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 14/93] ipvlan: egress mcast packets are not exceptional
Date:   Thu, 19 Mar 2020 13:59:18 +0100
Message-Id: <20200319123929.405636412@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit cccc200fcaf04cff4342036a72e51d6adf6c98c1 upstream.

Currently, if IPv6 is enabled on top of an ipvlan device in l3
mode, the following warning message:

 Dropped {multi|broad}cast of type= [86dd]

is emitted every time that a RS is generated and dmseg is soon
filled with irrelevant messages. Replace pr_warn with pr_debug,
to preserve debuggability, without scaring the sysadmin.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ipvlan/ipvlan_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -432,8 +432,8 @@ static int ipvlan_process_outbound(struc
 
 	/* In this mode we dont care about multicast and broadcast traffic */
 	if (is_multicast_ether_addr(ethh->h_dest)) {
-		pr_warn_ratelimited("Dropped {multi|broad}cast of type= [%x]\n",
-				    ntohs(skb->protocol));
+		pr_debug_ratelimited("Dropped {multi|broad}cast of type=[%x]\n",
+				     ntohs(skb->protocol));
 		kfree_skb(skb);
 		goto out;
 	}


