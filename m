Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C724BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57F4206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037102;
	bh=tlxiqtfrQReI1ncjMVh9fm/GnQJePtH5+QfFOr4cCYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tWVET3J4+US5vm67fF0zdXO/xDB8MBdlzY/kuC+iCqFcYuyDHGXafqDwcktpBR3aB
	 P9aZpzoVFAIyNJAceFPL831TNy7K824ko01X5rXOJvDrfthrYaQhHPsvQk+QwIfE6q
	 AKXZ8+fZlXkNTcNqPqFJDp2tMZY/icRR54FhE+H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgFASo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbgFASKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:10:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB912077D;
        Mon,  1 Jun 2020 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035008;
        bh=tlxiqtfrQReI1ncjMVh9fm/GnQJePtH5+QfFOr4cCYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7LlLjLS0/WlBPr//9ALOOovXmknPof8Q/08tbpSwABxvHkfcQank3LTIGA6BDLiP
         697qWlMZ6+52Jlaotl/TLPg/jrMxdoM/Ea5bwj3lOKnEmgVDdeT6mbUL6NIevBORTu
         Q2C5hjkQmYFa7NX41jgsKX2yx8igqITuZ7STYQPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.4 112/142] xfrm: allow to accept packets with ipv6 NEXTHDR_HOP in xfrm_input
Date:   Mon,  1 Jun 2020 19:54:30 +0200
Message-Id: <20200601174049.513408526@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

commit afcaf61be9d1dbdee5ec186d1dcc67b6b692180f upstream.

For beet mode, when it's ipv6 inner address with nexthdrs set,
the packet format might be:

    ----------------------------------------------------
    | outer  |     | dest |     |      |  ESP    | ESP |
    | IP hdr | ESP | opts.| TCP | Data | Trailer | ICV |
    ----------------------------------------------------

The nexthdr from ESP could be NEXTHDR_HOP(0), so it should
continue processing the packet when nexthdr returns 0 in
xfrm_input(). Otherwise, when ipv6 nexthdr is set, the
packet will be dropped.

I don't see any error cases that nexthdr may return 0. So
fix it by removing the check for nexthdr == 0.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -643,7 +643,7 @@ resume:
 		dev_put(skb->dev);
 
 		spin_lock(&x->lock);
-		if (nexthdr <= 0) {
+		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
 				xfrm_audit_state_icvfail(x, skb,
 							 x->type->proto);


