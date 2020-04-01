Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A44C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC07F21556
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758367;
	bh=4btCm3r6OFM4VXHy3zm0hcExY2XF+cm+/dbwO1g2CeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DAtl3ijtEzZhUEVlNtzCjIG0i0nTuqq7v1Ojal3Hnsbow+fkrXHQY5/GGOQPMBaie
	 +oXhJRDEAVqwk9vL7hWla038fDFUVi6aSErXmvEtcQLKDKOp8zw9Jf/M1T64S/2OL4
	 81juVcyln3baHy7hJ1bTFJyqq01tvNZmo9agTR70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbgDAQ0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387867AbgDAQ0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:26:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35CB20BED;
        Wed,  1 Apr 2020 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758359;
        bh=4btCm3r6OFM4VXHy3zm0hcExY2XF+cm+/dbwO1g2CeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIQK70NX6De+h/kTvI01mSCGGihG9zAb9rXyGdZ49pSbNKu5MS0ve3ZWBa9oTFUdN
         5l++51KWyVZfDXYnBHkI0F9A8B+Mokv9xd0yHDE1dwrCFgVnewPUBz4vuB1+VYhnFO
         cjsQomcjSeQcHEdxBpejXmtt8+63who3vvxf49dA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raed Salem <raeds@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.19 065/116] xfrm: handle NETDEV_UNREGISTER for xfrm device
Date:   Wed,  1 Apr 2020 18:17:21 +0200
Message-Id: <20200401161551.715984732@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raed Salem <raeds@mellanox.com>

commit 03891f820c2117b19e80b370281eb924a09cf79f upstream.

This patch to handle the asynchronous unregister
device event so the device IPsec offload resources
could be cleanly released.

Fixes: e4db5b61c572 ("xfrm: policy: remove pcpu policy cache")
Signed-off-by: Raed Salem <raeds@mellanox.com>
Reviewed-by: Boris Pismenny <borisp@mellanox.com>
Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_device.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -332,6 +332,7 @@ static int xfrm_dev_event(struct notifie
 		return xfrm_dev_feat_change(dev);
 
 	case NETDEV_DOWN:
+	case NETDEV_UNREGISTER:
 		return xfrm_dev_down(dev);
 	}
 	return NOTIFY_DONE;


