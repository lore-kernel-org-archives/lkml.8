Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3E8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5E421556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580355;
	bh=WbypKLIbtcVOwzPyhZ4KFwIQhQ7w3yZw6d1nuMf9yqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WwRLBumJHL9LidBy4kuGpUX6bdLYSk/6M4x8QKzgRxmtw5ZDB5Xisy9gOqN4bW6b5
	 wwunOunSmr6GklZLW+B2HTybX+gHNcgJ/0W7MLasjyu/uafodVIXx7DwH0XIyurjgI
	 PtdMYTtHMf7IybcHYwJCId8G4m0FQug7OhNKElnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393472AbgFSPZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393131AbgFSPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C882158C;
        Fri, 19 Jun 2020 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580190;
        bh=WbypKLIbtcVOwzPyhZ4KFwIQhQ7w3yZw6d1nuMf9yqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6ilzuTfkf2AfTX2QFgCIHoYuEKg5y/tz6ZYWrgTERAYfE14zJgL84MLHcP6YYNDc
         QskIWtwZV8LRn0K2WwNT03g70rjV6eiulpKXPUAgrm41J/pvphrXBvBCbADLkl1PdR
         Xc+o/BZ3VThp8LfWwTn7hJmPclv1NozA9ad1+rQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>,
        Devulapally Shiva Krishna <shiva@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 157/376] Crypto/chcr: fix for ccm(aes) failed test
Date:   Fri, 19 Jun 2020 16:31:15 +0200
Message-Id: <20200619141717.754197512@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
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
index 446fb896ee6d..6c2cd36048ea 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2925,7 +2925,7 @@ static void fill_sec_cpl_for_aead(struct cpl_tx_sec_pdu *sec_cpl,
 	unsigned int mac_mode = CHCR_SCMD_AUTH_MODE_CBCMAC;
 	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 	unsigned int ccm_xtra;
-	unsigned char tag_offset = 0, auth_offset = 0;
+	unsigned int tag_offset = 0, auth_offset = 0;
 	unsigned int assoclen;
 
 	if (get_aead_subtype(tfm) == CRYPTO_ALG_SUB_TYPE_AEAD_RFC4309)
-- 
2.25.1



