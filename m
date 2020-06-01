Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0339C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6105206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035312;
	bh=KlyNs6xYV4r0qSVA/sqnvpMD4awrGAD7Rgv1smJS0j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zEYB7yX+SBVy6LuToX9ETxNpAFN9PRmnwNi5yhZLppOsC1NF3P7r9kU92KAK4AE2P
	 VUY9HrHRQcWfAgIyk0QXDgxcN7SyiIMqjtthdkeWpYT8j+MAVbR7dx9R5OZgtN0cMZ
	 UfQby+ODxGVZIwCBQN4Kmcik+bzQeAwNmtkoaU5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgFASPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbgFASPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:15:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECE82065C;
        Mon,  1 Jun 2020 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035300;
        bh=KlyNs6xYV4r0qSVA/sqnvpMD4awrGAD7Rgv1smJS0j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPWU6LgdC0RkH+H3yOtPZovgw5q/Apq9dt9irDLgKor0R+SmiAKUDvWG6m1EOqu0w
         SxtuNnZ9berue7Cek9FHus6LX4CQjo1INhBoLKK+3IgEhb6OgPLlWmkjO+yUTmD4OK
         GG/GnBnvnMFZrYq/7th/V2HSPkXf4LpvyL7FTR34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 099/177] soc: mediatek: cmdq: return send msg error code
Date:   Mon,  1 Jun 2020 19:53:57 +0200
Message-Id: <20200601174056.950078404@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>

[ Upstream commit 34c4e4072603ff5c174df73b973896abb76cbb51 ]

Return error code to client if send message fail,
so that client has chance to error handling.

Fixes: 576f1b4bc802 ("soc: mediatek: Add Mediatek CMDQ helper")
Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://lore.kernel.org/r/1583664775-19382-6-git-send-email-dennis-yc.hsieh@mediatek.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index db37144ae98c..87ee9f767b7a 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -351,7 +351,9 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
 		spin_unlock_irqrestore(&client->lock, flags);
 	}
 
-	mbox_send_message(client->chan, pkt);
+	err = mbox_send_message(client->chan, pkt);
+	if (err < 0)
+		return err;
 	/* We can send next packet immediately, so just call txdone. */
 	mbox_client_txdone(client->chan, 0);
 
-- 
2.25.1



