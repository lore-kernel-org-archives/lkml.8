Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BA820773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577638;
	bh=9m+nedHFamROTEbfxZl0O8S6WBufhsoEggKhtJGuz4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GExIiNguoHt9+nB/hvoN17R+yOYb+vT5dS1LTQNqqXO6NG2XGGtEpxxH6hxifpQzf
	 4DKle6LpdFkkwLyrG6KKtf76Rgfs9ZJol5RPvJLucK+OGfOVhtr4L/uxnwVvcBcmPQ
	 TWT7563NESorhXrYsLoVbb7iEuiEffej6Jkh6vng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgFSOkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbgFSOkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:40:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABCED20A8B;
        Fri, 19 Jun 2020 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577625;
        bh=9m+nedHFamROTEbfxZl0O8S6WBufhsoEggKhtJGuz4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7rgyq+ksGPWpZSyiQX4D5eT018Kl1i+12pkY3tmppHdAH74VbvpbdsO/XedhrsvO
         tVvxKf1hpjsELW2wv2B2N1Web0+d9i0HYNZ9DChkvX1hbZKVAjlOBzmlnLWV4+UmHH
         SUdda3FhEvSY6/WksAFdLpwOAyTdMRI5qt+vrDuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Kang Yin <cantona@cantona.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 4.9 004/128] crypto: talitos - fix ECB and CBC algs ivsize
Date:   Fri, 19 Jun 2020 16:31:38 +0200
Message-Id: <20200619141620.369942370@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Kang Yin <cantona@cantona.net>

commit e1de42fdfc6a ("crypto: talitos - fix ECB algs ivsize")
wrongly modified CBC algs ivsize instead of ECB aggs ivsize.

This restore the CBC algs original ivsize of removes ECB's ones.

Fixes: e1de42fdfc6a ("crypto: talitos - fix ECB algs ivsize")
Signed-off-by: Su Kang Yin <cantona@cantona.net>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2636,7 +2636,6 @@ static struct talitos_alg_template drive
 			.cra_ablkcipher = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
-				.ivsize = AES_BLOCK_SIZE,
 			}
 		},
 		.desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
@@ -2670,6 +2669,7 @@ static struct talitos_alg_template drive
 			.cra_ablkcipher = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
+				.ivsize = AES_BLOCK_SIZE,
 				.setkey = ablkcipher_aes_setkey,
 			}
 		},


