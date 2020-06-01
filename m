Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A2EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B09207D0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035031;
	bh=jMoiX+JGTBCMU7QJU91KJpkrlSuZHrgN8R4EYldhycg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tmZItOAe2xYsgNHlzCSQn5ldKCO5BEGi6wJ/DLag9VZ6AvdUUVx+kl3jBk/DmCa0+
	 R5oA1KZc/i2q105qt25EDUIZDq6b9TzXB8HdNb1yO7Ld14JCrpRZjVUD6oe1MgdRL1
	 rzhr/jORd+XXPZg44RGdeOz7lIaiTpHPdp3R7ZxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgFASKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730966AbgFASKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:10:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C800A2077D;
        Mon,  1 Jun 2020 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035013;
        bh=jMoiX+JGTBCMU7QJU91KJpkrlSuZHrgN8R4EYldhycg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIJGtJ8A0xhUzNsiwKPGMfZtGY1+MoJfcjRjCtK13Bg8YsL6lw0uBaIjzQvTb9BwL
         /G0bLdaqNFoJagFKamzEoyLTBiVxHj7tMS2AzKEWul+oHGe58UtN0QjlHrEBs98Twp
         8+v5R8fqLS17cKGWG0/HMPQHYuQU2N1oLO9IxQfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.4 114/142] xfrm: remove the xfrm_state_put call becofe going to out_reset
Date:   Mon,  1 Jun 2020 19:54:32 +0200
Message-Id: <20200601174049.692855504@linuxfoundation.org>
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

commit db87668ad1e4917cfe04e217307ba6ed9390716e upstream.

This xfrm_state_put call in esp4/6_gro_receive() will cause
double put for state, as in out_reset path secpath_reset()
will put all states set in skb sec_path.

So fix it by simply remove the xfrm_state_put call.

Fixes: 6ed69184ed9c ("xfrm: Reset secpath in xfrm failure")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/esp4_offload.c |    4 +---
 net/ipv6/esp6_offload.c |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -63,10 +63,8 @@ static struct sk_buff *esp4_gro_receive(
 		sp->olen++;
 
 		xo = xfrm_offload(skb);
-		if (!xo) {
-			xfrm_state_put(x);
+		if (!xo)
 			goto out_reset;
-		}
 	}
 
 	xo->flags |= XFRM_GRO;
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -85,10 +85,8 @@ static struct sk_buff *esp6_gro_receive(
 		sp->olen++;
 
 		xo = xfrm_offload(skb);
-		if (!xo) {
-			xfrm_state_put(x);
+		if (!xo)
 			goto out_reset;
-		}
 	}
 
 	xo->flags |= XFRM_GRO;


