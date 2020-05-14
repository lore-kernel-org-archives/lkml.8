Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F88C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D38206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482438;
	bh=xeJ2ECU7Qx48Ub97ytePlggsxZwFe2Tx3MOdswpDz1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0NLkDTttcQlZZRBrzhH6SIqtrZ6ML7YG8tByAcnuPAEiQCpuBhpf/KfOUIz9tzsjB
	 TINTqKqxG/eMU/5vTX+nRqTwiPW7qb0f9DMKib8kk7pFSqTRpmOgGXG1srokD9yGp6
	 +MK4JKottqbyBPlr6C0OdX0d9e1XBABot39p2muI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgENSx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbgENSxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:53:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525E4206A5;
        Thu, 14 May 2020 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482426;
        bh=xeJ2ECU7Qx48Ub97ytePlggsxZwFe2Tx3MOdswpDz1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1fuO2CkkwWp/d6jdjqxULTSKnEOHDdqYOmWPP4Z7ukUPXUgqcoEwoqNUu6bnVhuE
         P0q+yJkQHYcQqczgdNlEjFGoGfD0nCcMz0OnHe5J6wNvXfSJgSzAyh43XcfAsk3GOj
         bzogSWu+3D0FJHRvn/avkHS0Dn+OP/06cGjRA7h4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshiyuki Kurauchi <ahochauwaaaaa@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 28/49] gtp: set NLM_F_MULTI flag in gtp_genl_dump_pdp()
Date:   Thu, 14 May 2020 14:52:49 -0400
Message-Id: <20200514185311.20294-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 3a53d222bfcc1..d89ec99abcd63 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1172,11 +1172,11 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
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
@@ -1230,8 +1230,8 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	err = gtp_genl_fill_info(skb2, NETLINK_CB(skb).portid,
-				 info->snd_seq, info->nlhdr->nlmsg_type, pctx);
+	err = gtp_genl_fill_info(skb2, NETLINK_CB(skb).portid, info->snd_seq,
+				 0, info->nlhdr->nlmsg_type, pctx);
 	if (err < 0)
 		goto err_unlock_free;
 
@@ -1274,6 +1274,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 				    gtp_genl_fill_info(skb,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq,
+					    NLM_F_MULTI,
 					    cb->nlh->nlmsg_type, pctx)) {
 					cb->args[0] = i;
 					cb->args[1] = j;
-- 
2.20.1

