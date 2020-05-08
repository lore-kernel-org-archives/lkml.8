Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E29C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB7321473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941912;
	bh=3zx6t6ksHsLerlaxE/RXly0ozGNWWQAB+vLwy+3XEFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lPeBYTiwDsbuRw2S+Avpv7zzC1PidwkhC0OKBqU4CIZzEabwTH00NJGrcXPEN1NCk
	 SfwQq5LBthO7KrJPw565fW4ooClia/oZEyHlBS2PgyWNdbnR4fRecMKVWf1qUKboyc
	 YMEuhrgLOPQtrtaJHk0fiBOyAHd6JHIEAgm9s7+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgEHMpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbgEHMpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:45:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7478321473;
        Fri,  8 May 2020 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941899;
        bh=3zx6t6ksHsLerlaxE/RXly0ozGNWWQAB+vLwy+3XEFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W46uS15TE6z9xtxX+MqGchqkDa8rqm4eViF+cm4bfnD9xg+283i43doJ7XliGc1+0
         V55tFHccHmsrfq9kWaI1aFBsoWKTbxfCzm43PtW4PWBqqCu7CkczU7UsZKEBKa1Ql7
         Hr5hpsLJMgKI2jtmW5hxQa6vKlSIf0A/sPljdh5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 216/312] net/mlx4_core: Fix the resource-type enum in res tracker to conform to FW spec
Date:   Fri,  8 May 2020 14:33:27 +0200
Message-Id: <20200508123139.629407998@linuxfoundation.org>
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

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit aa0c08feae8161b945520ada753d0dfe62b14fe7 upstream.

The resource type enum in the resource tracker was incorrect.
RES_EQ was put in the position of RES_NPORT_ID (a FC resource).

Since the remaining resources maintain their current values,
and RES_EQ is not passed from slaves to the hypervisor in any
FW command, this change affects only the hypervisor.
Therefore, there is no backwards-compatibility issue.

Fixes: 623ed84b1f95 ("mlx4_core: initial header-file changes for SRIOV support")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx4/mlx4.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -143,9 +143,10 @@ enum mlx4_resource {
 	RES_MTT,
 	RES_MAC,
 	RES_VLAN,
-	RES_EQ,
+	RES_NPORT_ID,
 	RES_COUNTER,
 	RES_FS_RULE,
+	RES_EQ,
 	MLX4_NUM_OF_RESOURCE_TYPE
 };
 


