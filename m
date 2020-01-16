Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C2C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FC220730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193804;
	bh=pIaYyaxHpbQT38MmLmafgubNEt7PRUb/LGjMRMvir50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DGDgmjAu+2DH3/wNU/1wH0q7ge8U0KtStPQMCpd+VCa2awBgfGvtjStYoZ7DHbWf7
	 99L0f8R0kiSj1i5lEY/aobtZp6tWizZtDQUpe8UiB9bLYsPwbgHYbv3N2nxKwEREjU
	 ZzxhtWT4q14ahGgqZDqLfDUcAHProqTgo+FQP++I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgAPQ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgAPQ4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:56:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10F22192A;
        Thu, 16 Jan 2020 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193798;
        bh=pIaYyaxHpbQT38MmLmafgubNEt7PRUb/LGjMRMvir50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SH5WzASer0LXJL2v6VoKeEngzlP4iYquEC+QqCgaFru1+fjx/AIOREIUqWocfHqwQ
         4+Rkwe7KF4l/16zWZF7zx1Y6sevHK0g70SuJAIHQW/kNtCWFt3yWEn1pzaW6LxrKoG
         07MmL4d2YiE8R8igACGkgtiKKRBkeo/B5TWnfazc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 067/671] ipv6: add missing tx timestamping on IPPROTO_RAW
Date:   Thu, 16 Jan 2020 11:44:58 -0500
Message-Id: <20200116165502.8838-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit fbfb2321e950918b430e7225546296b2dcadf725 ]

Raw sockets support tx timestamping, but one case is missing.

IPPROTO_RAW takes a separate packet construction path. raw_send_hdrinc
has an explicit call to sock_tx_timestamp, but rawv6_send_hdrinc does
not. Add it.

Fixes: 11878b40ed5c ("net-timestamp: SOCK_RAW and PING timestamping")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/raw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 4856d9320b28..a41156a00dd4 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -660,6 +660,8 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
+	sock_tx_timestamp(sk, sockc->tsflags, &skb_shinfo(skb)->tx_flags);
+
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
 
-- 
2.20.1

