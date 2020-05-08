Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6DC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D559C206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944012;
	bh=Vt1E6h/8teG4la10Aa3CVwgcn7EGyQmMix7SnCqlbhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHCNW19MPwpf3+UwRPp5ohFmta98xjtMwaZAJRTcTT1p2QJ8F/9CWK2F2bZgYXY+U
	 tVckPK2nm9TBLO8UGqYUvcVlG9o0BmqmjbZA2VyrJWCRRpOHfawyMlj+jjeaDeWWu+
	 cqFhLGP2OhUE19rpx+Aynd5QIpvQj0d5iuLoMzTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgEHNUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728785AbgEHMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:41:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD0721835;
        Fri,  8 May 2020 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941667;
        bh=Vt1E6h/8teG4la10Aa3CVwgcn7EGyQmMix7SnCqlbhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EO44OASlGEMo1nrLY/Gx2KuRZ69UZzk6JIuy5b7eiAhTbvIB6Hl//KjkfGWMhaXZQ
         NysiCySniG8nI42Gr8OgZIL6ukEPYVQIeW9gPXTPCDeMEchgzralw9s2szZj1urPLZ
         KHWtcoDxHXiBYBrI2ySgHv0wnacOdq7OzqoKj7/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Krause <minipli@googlemail.com>,
        Thomas Graf <tgraf@suug.ch>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.4 124/312] xfrm_user: propagate sec ctx allocation errors
Date:   Fri,  8 May 2020 14:31:55 +0200
Message-Id: <20200508123133.193869720@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Krause <minipli@googlemail.com>

commit 2f30ea5090cbc57ea573cdc66421264b3de3fb0a upstream.

When we fail to attach the security context in xfrm_state_construct()
we'll return 0 as error value which, in turn, will wrongly claim success
to userland when, in fact, we won't be adding / updating the XFRM state.

This is a regression introduced by commit fd21150a0fe1 ("[XFRM] netlink:
Inline attach_encap_tmpl(), attach_sec_ctx(), and attach_one_addr()").

Fix it by propagating the error returned by security_xfrm_state_alloc()
in this case.

Fixes: fd21150a0fe1 ("[XFRM] netlink: Inline attach_encap_tmpl()...")
Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Thomas Graf <tgraf@suug.ch>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_user.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -609,9 +609,12 @@ static struct xfrm_state *xfrm_state_con
 	if (err)
 		goto error;
 
-	if (attrs[XFRMA_SEC_CTX] &&
-	    security_xfrm_state_alloc(x, nla_data(attrs[XFRMA_SEC_CTX])))
-		goto error;
+	if (attrs[XFRMA_SEC_CTX]) {
+		err = security_xfrm_state_alloc(x,
+						nla_data(attrs[XFRMA_SEC_CTX]));
+		if (err)
+			goto error;
+	}
 
 	if ((err = xfrm_alloc_replay_state_esn(&x->replay_esn, &x->preplay_esn,
 					       attrs[XFRMA_REPLAY_ESN_VAL])))


