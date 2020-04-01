Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEE0C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA56320772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759021;
	bh=gUfkbDF/PluihdK8rLT2KkIrhhv+4baYHmKQun28N90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SOvOJXRLjNg1Jbir8daJM5nDIHgj/S7LFPbHF6AUf/gAv4fVli4Ka68q36iIDLS8b
	 h13nqjrfaGvgylPsJ7F93ZAH2c+FSRZSzF7SPVIBZlDVt1A73ZliAeZ5/y2GmWphrD
	 LxnAKXJq4Vezx/zWHFwf3yJu1eNiHea1tiDfUAFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbgDAQg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388678AbgDAQgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:36:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38105206F8;
        Wed,  1 Apr 2020 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759013;
        bh=gUfkbDF/PluihdK8rLT2KkIrhhv+4baYHmKQun28N90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oO7OD/qBJbcvc1hOHknHVzqaIhUwp+nOAaw4Rc5QpoJGNx7j3cmWvVqhFs6xRm3Qj
         f+2+w8ttLqS5pAxcPLNgh5OcFnC2E2xHtNz7zLrFDD46FhFQa3w81pL35xaOmn7gk1
         jPCXK3eBwVi+3wouJKtAEhlsvLHNaFvpDoxEsuog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 049/102] hsr: set .netnsok flag
Date:   Wed,  1 Apr 2020 18:17:52 +0200
Message-Id: <20200401161542.271967081@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
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
@@ -137,6 +137,7 @@ static struct genl_family hsr_genl_famil
 	.name = "HSR",
 	.version = 1,
 	.maxattr = HSR_A_MAX,
+	.netnsok = true,
 };
 
 static const struct genl_multicast_group hsr_mcgrps[] = {


