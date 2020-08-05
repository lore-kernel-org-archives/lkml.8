Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C7AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E52722D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHEQwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgHEQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:38 -0400
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614ADC034606;
        Wed,  5 Aug 2020 05:40:10 -0700 (PDT)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id 19DFB10D018; Wed,  5 Aug 2020 14:25:27 +0200 (CEST)
Received: from localhost (200116b828fb3e0270a11fb9006029e2.dip.versatel-1u1.de [IPv6:2001:16b8:28fb:3e02:70a1:1fb9:60:29e2])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id 241C910D014;
        Wed,  5 Aug 2020 14:25:24 +0200 (CEST)
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: tls: add compat for get/setsockopt
Date:   Wed,  5 Aug 2020 14:25:02 +0200
Message-Id: <20200805122501.4856-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compat_{s,g}etsockopt for TLS are not implemented, the TLS layer will
never be called on a system where CONFIG_COMPAT is enabled and userspace
is 32bit. Implement both to support CONFIG_COMPAT.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 net/tls/tls_main.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index ec10041c6b7d..92c5893fe692 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -450,6 +450,18 @@ static int tls_getsockopt(struct sock *sk, int level, int optname,
 	return do_tls_getsockopt(sk, optname, optval, optlen);
 }
 
+static int tls_compat_getsockopt(struct sock *sk, int level, int optname,
+				 char __user *optval, int __user *optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+
+	if (level != SOL_TLS)
+		return ctx->sk_proto->compat_getsockopt(sk, level, optname,
+							optval, optlen);
+
+	return do_tls_getsockopt(sk, optname, optval, optlen);
+}
+
 static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
 				  unsigned int optlen, int tx)
 {
@@ -611,6 +623,18 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 	return do_tls_setsockopt(sk, optname, optval, optlen);
 }
 
+static int tls_compat_setsockopt(struct sock *sk, int level, int optname,
+				 char __user *optval, unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+
+	if (level != SOL_TLS)
+		return ctx->sk_proto->compat_setsockopt(sk, level, optname,
+							optval, optlen);
+
+	return do_tls_setsockopt(sk, optname, optval, optlen);
+}
+
 struct tls_context *tls_ctx_create(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -660,6 +684,10 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_BASE][TLS_BASE].setsockopt	= tls_setsockopt;
 	prot[TLS_BASE][TLS_BASE].getsockopt	= tls_getsockopt;
 	prot[TLS_BASE][TLS_BASE].close		= tls_sk_proto_close;
+#ifdef CONFIG_COMPAT
+	prot[TLS_BASE][TLS_BASE].compat_setsockopt	= tls_compat_setsockopt;
+	prot[TLS_BASE][TLS_BASE].compat_getsockopt	= tls_compat_getsockopt;
+#endif
 
 	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
 	prot[TLS_SW][TLS_BASE].sendmsg		= tls_sw_sendmsg;
-- 
2.27.0

