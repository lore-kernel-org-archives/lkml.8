Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3268C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7CC24653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271671;
	bh=+rAfQc5HdLOMIL4uUKimOeM2WHF8AZu9IucVD2BUBUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NcmAVHxDcrzP8DrP5w6wy4ZaGfdb2avVjn775fZmhJlCAOZJMU6qIsIhA12tR1+v5
	 2NzW3VxwrM2xST4JFhpnww4l72Cvs1lMz0s9IHFhFMQPUdT+O3e+1ixDviF1NDcNic
	 UOh7codHP1X6FTUXUaBl2VIe0SQwkyqkmlBxpiE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgBUHya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbgBUHy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:54:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513C020578;
        Fri, 21 Feb 2020 07:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271667;
        bh=+rAfQc5HdLOMIL4uUKimOeM2WHF8AZu9IucVD2BUBUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCidh2rVIpu4tCyUA+/gNU0rUuPQTH+LtJFd01CsU2JpLisL2vOZPsQwZvZwpMNgV
         +MFoqbZbaW2c7pP8qogR37Ny8+v+DbB+kHld9CjfB9isAhZEMqT9vzdALFfT+XvRUR
         gdIbtx7npnElhC87li1DAeRNq+bsGNdz7xdU+ggM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Li RongQing <lirongqing@baidu.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 253/399] bpf: Return -EBADRQC for invalid map type in __bpf_tx_xdp_map
Date:   Fri, 21 Feb 2020 08:39:38 +0100
Message-Id: <20200221072427.015149476@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
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
index 538f6a735a19f..f797b1599c92f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3543,7 +3543,7 @@ static int __bpf_tx_xdp_map(struct net_device *dev_rx, void *fwd,
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



