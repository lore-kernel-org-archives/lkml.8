Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056ACC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F1E20787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624626;
	bh=/98MuITwOSq4tZEdVhja0zhJ4lPj5NSon7dTlGb3f2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JiFsSz6/JEkk9vhWIoHVQbmRhveS6PQTEaRPZJsh+BJ6uMEbWaH857QAaAgycdgA1
	 iOl0l5EtexO64rWUP8sMH4DKhPHw57Ts/caXuu/O5FmAZd7rYPTr6LR76u09arjbjI
	 1OKT4wDHunZRmBywBGXO67mNelFEAahnUnMzpLcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgCSNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbgCSNV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:21:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62239206D7;
        Thu, 19 Mar 2020 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624086;
        bh=/98MuITwOSq4tZEdVhja0zhJ4lPj5NSon7dTlGb3f2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7bXWkSv09orU+7a6yPZDNSdZONVL5cdYO3ycS18snFD5XYJ+OYLGntrxbZi+wOJ1
         b2uEo7cwFXaWuh3brGq1axeCcnRRnU0funHy43ffo9r0Pxk8FRjxfOXkcFUcB7Y2TR
         Dvy97fLxEeeHNi0fXjATr92OBOrepcPLdG9dIQEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/48] wimax: i2400: Fix memory leak in i2400m_op_rfkill_sw_toggle
Date:   Thu, 19 Mar 2020 14:04:15 +0100
Message-Id: <20200319123913.359101629@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123902.941451241@linuxfoundation.org>
References: <20200319123902.941451241@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 6f3ef5c25cc762687a7341c18cbea5af54461407 ]

In the implementation of i2400m_op_rfkill_sw_toggle() the allocated
buffer for cmd should be released before returning. The
documentation for i2400m_msg_to_dev() says when it returns the buffer
can be reused. Meaning cmd should be released in either case. Move
kfree(cmd) before return to be reached by all execution paths.

Fixes: 2507e6ab7a9a ("wimax: i2400: fix memory leak")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wimax/i2400m/op-rfkill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/op-rfkill.c b/drivers/net/wimax/i2400m/op-rfkill.c
index 7c92e8ace9c2f..dc6fe93ce71f6 100644
--- a/drivers/net/wimax/i2400m/op-rfkill.c
+++ b/drivers/net/wimax/i2400m/op-rfkill.c
@@ -142,12 +142,12 @@ int i2400m_op_rfkill_sw_toggle(struct wimax_dev *wimax_dev,
 			"%d\n", result);
 	result = 0;
 error_cmd:
-	kfree(cmd);
 	kfree_skb(ack_skb);
 error_msg_to_dev:
 error_alloc:
 	d_fnend(4, dev, "(wimax_dev %p state %d) = %d\n",
 		wimax_dev, state, result);
+	kfree(cmd);
 	return result;
 }
 
-- 
2.20.1



