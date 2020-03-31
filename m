Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CFA20772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646211;
	bh=+2Yc5/72cHKArA4R+dzFgQDsJ7e4GYHSq8Ld72MC4zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AGIBx4SZfAko4CxNznbqcfYBMlB7xs8+pULrh8Y9XIe6/Wf+vdLlM8XveJv8RIWlL
	 DJ5IjbiOTwgFBWZJVt2VuLEimUwXLStRtJlnTCbFrwTNvZrQPwc1mtup5EbtL19S4e
	 /WoUFEqQ7iwblVD36PHdAx50hqJWEJrMl2An6h+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgCaJQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731535AbgCaJQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:16:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63499208E0;
        Tue, 31 Mar 2020 09:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646205;
        bh=+2Yc5/72cHKArA4R+dzFgQDsJ7e4GYHSq8Ld72MC4zE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZfDjhq0ou7HT/dys4JzQib4oCBqVINZg2Eiwg8shCF2yWZj7YpctxigC1+5RJczr
         wTchjwL8nVFCbVwnaGRA/mhVVOMK1FsFEBN9xwEFeEuext5zcbC4/fjvkUOkDwDPeb
         OTJ3Vccbp0rMnbHCnnSp6it49T3N4uBrBS15BQU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.4 116/155] xfrm: fix uctx len check in verify_sec_ctx_len
Date:   Tue, 31 Mar 2020 10:59:16 +0200
Message-Id: <20200331085431.490001424@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

commit 171d449a028573b2f0acdc7f31ecbb045391b320 upstream.

It's not sufficient to do 'uctx->len != (sizeof(struct xfrm_user_sec_ctx) +
uctx->ctx_len)' check only, as uctx->len may be greater than nla_len(rt),
in which case it will cause slab-out-of-bounds when accessing uctx->ctx_str
later.

This patch is to fix it by return -EINVAL when uctx->len > nla_len(rt).

Fixes: df71837d5024 ("[LSM-IPSec]: Security association restriction.")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_user.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -110,7 +110,8 @@ static inline int verify_sec_ctx_len(str
 		return 0;
 
 	uctx = nla_data(rt);
-	if (uctx->len != (sizeof(struct xfrm_user_sec_ctx) + uctx->ctx_len))
+	if (uctx->len > nla_len(rt) ||
+	    uctx->len != (sizeof(struct xfrm_user_sec_ctx) + uctx->ctx_len))
 		return -EINVAL;
 
 	return 0;


