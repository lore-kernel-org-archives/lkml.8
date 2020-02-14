Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98535222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703185;
	bh=+rAfQc5HdLOMIL4uUKimOeM2WHF8AZu9IucVD2BUBUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQQ77JUNMjVbgWN91MEMu7vcuz+77yG6CnUjZVuMegtqbKAUL3f6ieWD3Ug47Lo4T
	 fCFwNg3rxrOW8WwO2f4/BvCG9caJERh3VYiac6bFuKEvmkBm2Y7ZwOG7cU1S9zvm5f
	 0nF48d+Xo3oye8fw9Nbq5J+/O79U7hU4e1t8U7Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgBNP4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387829AbgBNP4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C9A2086A;
        Fri, 14 Feb 2020 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695789;
        bh=+rAfQc5HdLOMIL4uUKimOeM2WHF8AZu9IucVD2BUBUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQI8Rl6wWJw6gfhFBcel1MDafq2XSvoFHzujpw4A4dDMj5K1JoECLRNYFGK2ALvNG
         oowlmBGFH425QQDtdK78Qd9uovKdUG9r8OEWmqa/ErO7aZNX439jU1c5m2pNgT1i/y
         nEaW9MOI3Xoha9RdqSTGgI8bLUPrkesjb2XcgnQA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 352/542] bpf: Return -EBADRQC for invalid map type in __bpf_tx_xdp_map
Date:   Fri, 14 Feb 2020 10:45:44 -0500
Message-Id: <20200214154854.6746-352-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

