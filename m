Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3179C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F67D208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520347;
	bh=ebGrwf6jkpO160XY52EjyzS+rqmPdZq2in3TQgM5QH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z8Z/q7o+UOMfvQcjyFYgvYiXKgogluKRNKZ8BWtru2RGXs3iiXL8dn+sF3owoRY8Z
	 hG0UzdS73HzMHro1YzbUoyLZcALMgB501h4Bt8+35QipaQekfpls0OHjGeh9pyrdGi
	 Bo3C2DmLhF55sHPRCEZ+TJiR3RErrFhosJPHUfLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392079AbgEZTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392066AbgEZTMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1201B208A7;
        Tue, 26 May 2020 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520341;
        bh=ebGrwf6jkpO160XY52EjyzS+rqmPdZq2in3TQgM5QH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVf7Phtlqgl9GUCXxeGOHLjG8cEnmkT0wiQvZsdS4yubOZS+RrC7outrXdExUlWTV
         rUFL2xDCdsVcKmDNtIYr6lbOslfGuQ6RbmnYM6f9FJ771wGCQz0dtaFTWis946boSw
         aqMUawE0iZ3F2Gc0UvDp7cEqG99qC6jxDwOZapA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshiyuki Kurauchi <ahochauwaaaaa@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 042/126] gtp: set NLM_F_MULTI flag in gtp_genl_dump_pdp()
Date:   Tue, 26 May 2020 20:52:59 +0200
Message-Id: <20200526183941.511724564@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshiyuki Kurauchi <ahochauwaaaaa@gmail.com>

[ Upstream commit 846c68f7f1ac82c797a2f1db3344a2966c0fe2e1 ]

In drivers/net/gtp.c, gtp_genl_dump_pdp() should set NLM_F_MULTI
flag since it returns multipart message.
This patch adds a new arg "flags" in gtp_genl_fill_info() so that
flags can be set by the callers.

Signed-off-by: Yoshiyuki Kurauchi <ahochauwaaaaa@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 672cd2caf2fb..21640a035d7d 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1169,11 +1169,11 @@ out_unlock:
 static struct genl_family gtp_genl_family;
 
 static int gtp_genl_fill_info(struct sk_buff *skb, u32 snd_portid, u32 snd_seq,
-			      u32 type, struct pdp_ctx *pctx)
+			      int flags, u32 type, struct pdp_ctx *pctx)
 {
 	void *genlh;
 
-	genlh = genlmsg_put(skb, snd_portid, snd_seq, &gtp_genl_family, 0,
+	genlh = genlmsg_put(skb, snd_portid, snd_seq, &gtp_genl_family, flags,
 			    type);
 	if (genlh == NULL)
 		goto nlmsg_failure;
@@ -1227,8 +1227,8 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	err = gtp_genl_fill_info(skb2, NETLINK_CB(skb).portid,
-				 info->snd_seq, info->nlhdr->nlmsg_type, pctx);
+	err = gtp_genl_fill_info(skb2, NETLINK_CB(skb).portid, info->snd_seq,
+				 0, info->nlhdr->nlmsg_type, pctx);
 	if (err < 0)
 		goto err_unlock_free;
 
@@ -1271,6 +1271,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 				    gtp_genl_fill_info(skb,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq,
+					    NLM_F_MULTI,
 					    cb->nlh->nlmsg_type, pctx)) {
 					cb->args[0] = i;
 					cb->args[1] = j;
-- 
2.25.1



