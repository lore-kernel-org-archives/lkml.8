Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F7C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3328B20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099660;
	bh=N/8ImIDdPOEXmtj/+HjjuFy7WgAl9RTHoLobDrIcL0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PUCLPMyn4QEzxXFCXVs7ZJjr+P5Mz1YmpbUcJz0mjXtEraQ6Ba0XWZwRv5x3bFH1R
	 WeAMxX5wKpi+idEvRmnMmWSbEKA5TeAXBXDEiwxWrvoqNQ8WW3Y0qXZcPyLh3Sc7Fm
	 h7VaSC5D+h1bXmQUPGmzcKeNOKfQvrJIhecl+ypw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgD1Sl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731035AbgD1Slv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:41:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7AFB20575;
        Tue, 28 Apr 2020 18:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099310;
        bh=N/8ImIDdPOEXmtj/+HjjuFy7WgAl9RTHoLobDrIcL0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGsRFRLMwrjq4gYOA3qdrf4mAkbDktDZCWDfR2Y186gqm65nG3CroZquhqVsnlmfn
         FKMxtOOF2CzPkYJUB2UFQH7cf0Tmc4nTKKp685WbxRYSRHalTi6MApamRONA22+j2J
         eKMZ+i6QMhLQlTvkuQSAA7c6xLJpLV2sx52WPFiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 065/168] net: netrom: Fix potential nr_neigh refcnt leak in nr_add_node
Date:   Tue, 28 Apr 2020 20:23:59 +0200
Message-Id: <20200428182240.157722691@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit d03f228470a8c0a22b774d1f8d47071e0de4f6dd ]

nr_add_node() invokes nr_neigh_get_dev(), which returns a local
reference of the nr_neigh object to "nr_neigh" with increased refcnt.

When nr_add_node() returns, "nr_neigh" becomes invalid, so the refcount
should be decreased to keep refcount balanced.

The issue happens in one normal path of nr_add_node(), which forgets to
decrease the refcnt increased by nr_neigh_get_dev() and causes a refcnt
leak. It should decrease the refcnt before the function returns like
other normal paths do.

Fix this issue by calling nr_neigh_put() before the nr_add_node()
returns.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netrom/nr_route.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -208,6 +208,7 @@ static int __must_check nr_add_node(ax25
 		/* refcount initialized at 1 */
 		spin_unlock_bh(&nr_node_list_lock);
 
+		nr_neigh_put(nr_neigh);
 		return 0;
 	}
 	nr_node_lock(nr_node);


