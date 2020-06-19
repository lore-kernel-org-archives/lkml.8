Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCC52168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583815;
	bh=WI3HQ8lMCRznQ3o12AJnapm9JrQWYpgFcNojPlKXQAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xBdxiHgJpKaBMD91sLRAHbQ2dqgTDuNAXHl5xo4U96Moaa/ZHisUbMZMQq7h9pZSq
	 B90xEJMPxzKIJASyC6GIm+PHxuKVg4gJ23kTuFWA7V5KkoQSNJ3aqEV6oRQZyIg44a
	 k5qi8b0iccG5v7Vyo44qsMj1OrY0bmSHdHgirB+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394766AbgFSQXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389201AbgFSO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:59:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD3F21919;
        Fri, 19 Jun 2020 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578754;
        bh=WI3HQ8lMCRznQ3o12AJnapm9JrQWYpgFcNojPlKXQAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRLOxnE7HxK2xiIJMsjM6OGuN8Qc1V7YTBkb2MMjjQRzOS3RKG19TBmIDJsv+ubbl
         xFjeyUQxTTxsdEtSfOzaChqbZdijIyD3YllfxdOfoalZJYuTbsIfpixKwgM6jnw7XL
         GrPpGpMjC6E5hElyj15TaAXOMDtLfTIvKp52+Jk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>,
        Devulapally Shiva Krishna <shiva@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 143/267] Crypto/chcr: fix for ccm(aes) failed test
Date:   Fri, 19 Jun 2020 16:32:08 +0200
Message-Id: <20200619141655.687313359@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Devulapally Shiva Krishna <shiva@chelsio.com>

[ Upstream commit 10b0c75d7bc19606fa9a62c8ab9180e95c0e0385 ]

The ccm(aes) test fails when req->assoclen > ~240bytes.

The problem is the value assigned to auth_offset is wrong.
As auth_offset is unsigned char, it can take max value as 255.
So fix it by making it unsigned int.

Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
Signed-off-by: Devulapally Shiva Krishna <shiva@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/chelsio/chcr_algo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index c435f89f34e3..9b3c259f081d 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2764,7 +2764,7 @@ static void fill_sec_cpl_for_aead(struct cpl_tx_sec_pdu *sec_cpl,
 	unsigned int mac_mode = CHCR_SCMD_AUTH_MODE_CBCMAC;
 	unsigned int c_id = a_ctx(tfm)->dev->rx_channel_id;
 	unsigned int ccm_xtra;
-	unsigned char tag_offset = 0, auth_offset = 0;
+	unsigned int tag_offset = 0, auth_offset = 0;
 	unsigned int assoclen;
 
 	if (get_aead_subtype(tfm) == CRYPTO_ALG_SUB_TYPE_AEAD_RFC4309)
-- 
2.25.1



