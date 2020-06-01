Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EACBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB5B206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037385;
	bh=E822T5QpBT7X0I1eitipKvMkQ76AZqAMHHLjv+LBFk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tVXLsGhZptcs1uCePaO3ojziJaXacrhvPvE0idkEbJK4M61JS2y7FCDmCCiIb4tB8
	 5jArWNbpM+5z/FyrUmhV83qi8SD99KRfwHZIJAPzvKx8ZWH/+/ZrDmg/mSI29C0KZO
	 MYl41xKH9vhKyCDPXboXtLjm0uICwvnneX3N//PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgFAStl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbgFASGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:06:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3992B20872;
        Mon,  1 Jun 2020 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034806;
        bh=E822T5QpBT7X0I1eitipKvMkQ76AZqAMHHLjv+LBFk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=058mlDUTFw/iWu8C3xntDIb+AMrwJ4kT+mLtIQvtzuStt/jyKsPoCyN83bV6rqNCA
         tzowbIjmptaRcE6C7bT4dOtAgRFGsBOLgsWkilsWSq4QnQ1tq7qY8yY+j7q2ujKgKB
         bxq/xa8ZBN/VVuaa+VmhBVIB5ohxsYTT9O5xoYAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 008/142] net: ipip: fix wrong address family in init error path
Date:   Mon,  1 Jun 2020 19:52:46 +0200
Message-Id: <20200601174038.894455900@linuxfoundation.org>
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

From: Vadim Fedorenko <vfedorenko@novek.ru>

[ Upstream commit 57ebc8f08504f176eb0f25b3e0fde517dec61a4f ]

In case of error with MPLS support the code is misusing AF_INET
instead of AF_MPLS.

Fixes: 1b69e7e6c4da ("ipip: support MPLS over IPv4")
Signed-off-by: Vadim Fedorenko <vfedorenko@novek.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -698,7 +698,7 @@ out:
 
 rtnl_link_failed:
 #if IS_ENABLED(CONFIG_MPLS)
-	xfrm4_tunnel_deregister(&mplsip_handler, AF_INET);
+	xfrm4_tunnel_deregister(&mplsip_handler, AF_MPLS);
 xfrm_tunnel_mplsip_failed:
 
 #endif


