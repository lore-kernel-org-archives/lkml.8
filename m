Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD14C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF1420809
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFad0crV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbgFWS3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:29:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45487 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733167AbgFWS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:29:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B17E95C01A3;
        Tue, 23 Jun 2020 14:29:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 23 Jun 2020 14:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hlgaL1
        NEO6xj2Ypa1GBlVdJgYpsHyIzrnmu8tausCVQ=; b=eFad0crV0Hv2oBBwB54k5g
        6p6Qia0c8wK7cN7kvsJxLyL4rc2Xok9d63ZBKnCfwjH1ZCFmZuEq7/O0h3UeVdy3
        hyZ1WYYjEv5aU9s+SkbxAaz193s92jVUQ7TMCUpGs/lAtvobVdN+XCrfxeKBYsjW
        vV7qKKF3W8Gwp+GkLhnw5/9gviTlag6Nv/fzQMNkfurd0I/na0Olg7yWiXBsXlqI
        KN8Ga9Or2s4XcmiLpzEUJUDN4BiB05QXy9hzU28SoG1APcfX6uhpLExTGXQmTXTo
        Ps0+CWPqrI2Nujg9+Ym8poOu0cQTpgjQrFYXKCz6IzPSAuLqsIz3ZZRUIfi9tg/Q
        ==
X-ME-Sender: <xms:EkryXjQCFcpXmJRUxsNaoG39y3XeCr-6SnH2nJsX0VNSxh3q1Cqr7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekhedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnheptdffkeekfeduffevgeeujeffjefhte
    fgueeugfevtdeiheduueeukefhudehleetnecukfhppeejledrudekfedrieehrdekjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:EkryXkzE0lKCFcmL98ZnkqHa3_SItO1OGwHbR-mzZPzo73WrEx7LfA>
    <xmx:EkryXo00inXET_qEul7oD5ldoAeyzunwpzlEH0gBYZQwq8AQUWmYcQ>
    <xmx:EkryXjB67jNaTZl7atNw9Y25sy6mo8TI7D_TG-G1lmJzFt4Z4Dn0rg>
    <xmx:EkryXoab6GPYocTJe7YUS3FmRRsvPMHg58tUJudHCPIAhw2vZAFk7A>
Received: from localhost (bzq-79-183-65-87.red.bezeqint.net [79.183.65.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B70D3280060;
        Tue, 23 Jun 2020 14:29:37 -0400 (EDT)
Date:   Tue, 23 Jun 2020 21:29:34 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, idosch@mellanox.com, jiri@mellanox.com
Subject: Re: [PATCH net-next] mlxsw: spectrum_dcb: Fix a spelling typo in
 spectrum_dcb.c
Message-ID: <20200623182934.GA69146@shredder>
References: <20200623141301.168413-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623141301.168413-1-standby24x7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:13:01PM +0900, Masanari Iida wrote:
> This patch fixes a spelling typo in spectrum_dcb.c
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
