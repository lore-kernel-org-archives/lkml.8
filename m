Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6353C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C83206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201766;
	bh=xA+l6yP73ifLFVlAz9wZfD4T/1XC+Ndg4kgXYC9vli8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zO/q2J3pfEMWZEdjIAqPjpTZt47TPaWCNBjUfGl3UbU22LjsxiCqBsuV6yY6iFHkF
	 jL+UbE4upDy4h2F9MgL9eR1SyoFacdtO2bfe4940eMYB+QXI4A/1AizOSDCQMJYlHx
	 k7eVvMtQoA7/qbJdhGVCMI9hBV1J29vDX008enOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437396AbgAPTJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387901AbgAPRAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33F12081E;
        Thu, 16 Jan 2020 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194046;
        bh=xA+l6yP73ifLFVlAz9wZfD4T/1XC+Ndg4kgXYC9vli8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fny+5s2xOHRVmWEXV1Wd6Kb324UrpLmoCPaxFOZSRvpDEkmlv+28hDea+kIaRSpEn
         G0nCxYs7pe3a2ysAUieFOMOZ3hzKESyhSsdPEakKlwLpbOo3KIwL1owe7rYrPVaNmy
         8Pfb1J4hHGlm/3vQce9ezFfXyp9W7IpwPLSBGe8A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 162/671] net/smc: original socket family in inet_sock_diag
Date:   Thu, 16 Jan 2020 11:51:11 -0500
Message-Id: <20200116165940.10720-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

[ Upstream commit 232dc8ef647658a5352da807d9e994e0e03b43cd ]

Commit ed75986f4aae ("net/smc: ipv6 support for smc_diag.c") changed the
value of the diag_family field. The idea was to indicate the family of
the IP address in the inet_diag_sockid field. But the change makes it
impossible to distinguish an inet_sock_diag response message from SMC
sock_diag response. This patch restores the original behaviour and sends
AF_SMC as value of the diag_family field.

Fixes: ed75986f4aae ("net/smc: ipv6 support for smc_diag.c")
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_diag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index dbf64a93d68a..371b4cf31fcd 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -38,6 +38,7 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 {
 	struct smc_sock *smc = smc_sk(sk);
 
+	r->diag_family = sk->sk_family;
 	if (!smc->clcsock)
 		return;
 	r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
@@ -45,14 +46,12 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 	r->id.idiag_if = smc->clcsock->sk->sk_bound_dev_if;
 	sock_diag_save_cookie(sk, r->id.idiag_cookie);
 	if (sk->sk_protocol == SMCPROTO_SMC) {
-		r->diag_family = PF_INET;
 		memset(&r->id.idiag_src, 0, sizeof(r->id.idiag_src));
 		memset(&r->id.idiag_dst, 0, sizeof(r->id.idiag_dst));
 		r->id.idiag_src[0] = smc->clcsock->sk->sk_rcv_saddr;
 		r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (sk->sk_protocol == SMCPROTO_SMC6) {
-		r->diag_family = PF_INET6;
 		memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_saddr,
 		       sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
 		memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
-- 
2.20.1

