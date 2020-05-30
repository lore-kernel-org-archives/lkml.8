Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E52C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13B520723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=excello.cz header.i=@excello.cz header.b="kTp6lb94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgE3MqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgE3Mp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 08:45:59 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 May 2020 05:45:58 PDT
Received: from out2.virusfree.cz (out2.virusfree.cz [IPv6:2001:67c:1591::e2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB79C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 05:45:58 -0700 (PDT)
Received: (qmail 32270 invoked from network); 30 May 2020 14:39:16 +0200
Received: from out2.virusfree.cz by out2.virusfree.cz
 (VF-Scanner: Clear:RC:0(2001:67c:1591::6):SC:0(-1.9/5.0):CC:0:;
 processed in 1.4 s); 30 May 2020 12:39:16 +0000
X-VF-Scanner-Mail-From: pv@excello.cz
X-VF-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-VF-Scanner-ID: 20200530123915.393418.32250.out2.virusfree.cz.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=excello.cz; h=
        date:message-id:from:to:subject:reply-to; q=dns/txt; s=default;
         t=1590842355; bh=+cmoAgN64utf1iVzaq1leTggaBShX1Ug7Yc1zpv/o2M=; b=
        kTp6lb94U5wWlyFroBSaEd36Pn6ESUo4OOnsMT8LL0eHxyGpwxEDGLk4kStEOwOv
        gQAOiIglYH3WrnRTiI1X7fGNwTG1JDG64DP62JUb6ncB/9Kl4pb+hxjqHgVVB1ue
        3qhgErcOVt81/+q7sdPdvXJpjjJ9xU60tDP7Bhhkw24=
Received: from posta.excello.cz (2001:67c:1591::6)
  by out2.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 30 May 2020 14:39:15 +0200
Received: from arkam (ip-86-49-32-164.net.upcbroadband.cz [86.49.32.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by posta.excello.cz (Postfix) with ESMTPSA id 9266C9D7484;
        Sat, 30 May 2020 14:39:14 +0200 (CEST)
Date:   Sat, 30 May 2020 14:39:12 +0200
From:   Petr =?utf-8?B?VmFuxJtr?= <pv@excello.cz>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Petr =?utf-8?B?VmFuxJtr?= <pv@excello.cz>
Subject: [PATCH net-next v2] xfrm: introduce oseq-may-wrap flag
Message-ID: <20200530123912.GA7476@arkam>
References: <20200525154633.GB22403@atlantis>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525154633.GB22403@atlantis>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC 4303 in section 3.3.3 suggests to disable anti-replay for manually
distributed ICVs in which case the sender does not need to monitor or
reset the counter. However, the sender still increments the counter and
when it reaches the maximum value, the counter rolls over back to zero.

This patch introduces new extra_flag XFRM_SA_XFLAG_OSEQ_MAY_WRAP which
allows sequence number to cycle in outbound packets if set. This flag is
used only in legacy and bmp code, because esn should not be negotiated
if anti-replay is disabled (see note in 3.3.3 section).

Signed-off-by: Petr Vaněk <pv@excello.cz>
---
 include/uapi/linux/xfrm.h |  1 +
 net/xfrm/xfrm_replay.c    | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 5f3b9fec7b5f..b701244334b5 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -387,6 +387,7 @@ struct xfrm_usersa_info {
 };
 
 #define XFRM_SA_XFLAG_DONT_ENCAP_DSCP	1
+#define XFRM_SA_XFLAG_OSEQ_MAY_WRAP	2
 
 struct xfrm_usersa_id {
 	xfrm_address_t			daddr;
diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index 98943f8d01aa..c6a4338a0d08 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -89,7 +89,8 @@ static int xfrm_replay_overflow(struct xfrm_state *x, struct sk_buff *skb)
 	if (x->type->flags & XFRM_TYPE_REPLAY_PROT) {
 		XFRM_SKB_CB(skb)->seq.output.low = ++x->replay.oseq;
 		XFRM_SKB_CB(skb)->seq.output.hi = 0;
-		if (unlikely(x->replay.oseq == 0)) {
+		if (unlikely(x->replay.oseq == 0) &&
+		    !(x->props.extra_flags & XFRM_SA_XFLAG_OSEQ_MAY_WRAP)) {
 			x->replay.oseq--;
 			xfrm_audit_state_replay_overflow(x, skb);
 			err = -EOVERFLOW;
@@ -168,7 +169,8 @@ static int xfrm_replay_overflow_bmp(struct xfrm_state *x, struct sk_buff *skb)
 	if (x->type->flags & XFRM_TYPE_REPLAY_PROT) {
 		XFRM_SKB_CB(skb)->seq.output.low = ++replay_esn->oseq;
 		XFRM_SKB_CB(skb)->seq.output.hi = 0;
-		if (unlikely(replay_esn->oseq == 0)) {
+		if (unlikely(replay_esn->oseq == 0) &&
+		    !(x->props.extra_flags & XFRM_SA_XFLAG_OSEQ_MAY_WRAP)) {
 			replay_esn->oseq--;
 			xfrm_audit_state_replay_overflow(x, skb);
 			err = -EOVERFLOW;
@@ -572,7 +574,8 @@ static int xfrm_replay_overflow_offload(struct xfrm_state *x, struct sk_buff *sk
 
 		XFRM_SKB_CB(skb)->seq.output.hi = 0;
 		xo->seq.hi = 0;
-		if (unlikely(oseq < x->replay.oseq)) {
+		if (unlikely(oseq < x->replay.oseq) &&
+		    !(x->props.extra_flags & XFRM_SA_XFLAG_OSEQ_MAY_WRAP)) {
 			xfrm_audit_state_replay_overflow(x, skb);
 			err = -EOVERFLOW;
 
@@ -611,7 +614,8 @@ static int xfrm_replay_overflow_offload_bmp(struct xfrm_state *x, struct sk_buff
 
 		XFRM_SKB_CB(skb)->seq.output.hi = 0;
 		xo->seq.hi = 0;
-		if (unlikely(oseq < replay_esn->oseq)) {
+		if (unlikely(oseq < replay_esn->oseq) &&
+		    !(x->props.extra_flags & XFRM_SA_XFLAG_OSEQ_MAY_WRAP)) {
 			xfrm_audit_state_replay_overflow(x, skb);
 			err = -EOVERFLOW;
 
-- 
2.26.2

