Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49823C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BBF2465D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273316;
	bh=Y7jB+ZV6za5sKFnujUyx0EMJDwQuK6xqKOM5vsnZ9L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cg9KAQBvyfaORiS3yKZim2FqzofDrSUOcITzvxXxHt6n1HKlXvkCVX+KY5NFKpJ6M
	 zAtBqfw3ihkMxRg7s72afHPLDDMyFx+jguuN9snizTybip7BoN7mF3cN3gtc6PBzP9
	 3yGnLGKwJReyzhPIF6xC61weLGSN0wv+Evc7fDYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbgBUIVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731304AbgBUIVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:21:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E935B222C4;
        Fri, 21 Feb 2020 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273308;
        bh=Y7jB+ZV6za5sKFnujUyx0EMJDwQuK6xqKOM5vsnZ9L8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhHN1oEAuXCAiE1rA2hF5Mwk1i1YeghQ41iAyCLdHnbIOqzu8p3HDPqI1aNnZ8tpz
         6+MSC5MYGURsDloRyraF18xWFKG/MX2KptLXi7eygxxBFOY9mLVZzszh9YaT8eoNIe
         K5X6cEqUWxQ1nN1dKW77uLQZutZHnP0cyc9MDXqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Li RongQing <lirongqing@baidu.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 121/191] bpf: Return -EBADRQC for invalid map type in __bpf_tx_xdp_map
Date:   Fri, 21 Feb 2020 08:41:34 +0100
Message-Id: <20200221072305.382868842@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 0a29275b6300f39f78a87f2038bbfe5bdbaeca47 ]

A negative value should be returned if map->map_type is invalid
although that is impossible now, but if we run into such situation
in future, then xdpbuff could be leaked.

Daniel Borkmann suggested:

-EBADRQC should be returned to stay consistent with generic XDP
for the tracepoint output and not to be confused with -EOPNOTSUPP
from other locations like dev_map_enqueue() when ndo_xdp_xmit is
missing and such.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/1578618277-18085-1-git-send-email-lirongqing@baidu.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9daf1a4118b51..40b3af05c883c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3207,7 +3207,7 @@ static int __bpf_tx_xdp_map(struct net_device *dev_rx, void *fwd,
 		return err;
 	}
 	default:
-		break;
+		return -EBADRQC;
 	}
 	return 0;
 }
-- 
2.20.1



