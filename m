Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CDDC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF41C20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759422;
	bh=JVZ7z593ww74+XvoIIrY0sWE03rYwLNbZRMTrb7efxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tK0a03esU2mTj2Eqn+UStrYztV+8ZH1CJra1PPENiDDOpXzDzDKc670I6AoNd8Bpn
	 EZeW9XR/aEtduQ4Nh1HhlmbTCDoQZjdCogQGCvvHaFGwq/wUxRuj5P2VD1IfzKd1p+
	 p0nRPMFLbVhE+eDw05OriVySRw7y2GC1HQYbdaEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389649AbgDAQnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389493AbgDAQnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:43:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5594D2063A;
        Wed,  1 Apr 2020 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759418;
        bh=JVZ7z593ww74+XvoIIrY0sWE03rYwLNbZRMTrb7efxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klrujs3GH3J1L+ZMoEb37d1isM6nAHSkfJbL36Tfcd383kaC0LHhUCytlZlfMlVN6
         SwQApZtd34NZs2VWK4KkrTmrGwWvoJB2af/gUYu9E/4dxu6l6G9UtsC1TAiefukThy
         IOUh6TqnRMuGKv7vgij0h/jNg90+jy9dFK5ALp1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 072/148] hsr: set .netnsok flag
Date:   Wed,  1 Apr 2020 18:17:44 +0200
Message-Id: <20200401161600.359005588@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 09e91dbea0aa32be02d8877bd50490813de56b9a ]

The hsr module has been supporting the list and status command.
(HSR_C_GET_NODE_LIST and HSR_C_GET_NODE_STATUS)
These commands send node information to the user-space via generic netlink.
But, in the non-init_net namespace, these commands are not allowed
because .netnsok flag is false.
So, there is no way to get node information in the non-init_net namespace.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/hsr/hsr_netlink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -476,6 +476,7 @@ static struct genl_family hsr_genl_famil
 	.name = "HSR",
 	.version = 1,
 	.maxattr = HSR_A_MAX,
+	.netnsok = true,
 	.module = THIS_MODULE,
 	.ops = hsr_ops,
 	.n_ops = ARRAY_SIZE(hsr_ops),


