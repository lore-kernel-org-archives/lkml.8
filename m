Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90901C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E45820A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577979;
	bh=9m+nedHFamROTEbfxZl0O8S6WBufhsoEggKhtJGuz4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JZB3fmv3sz25VhvdamOtw8hQKGhwctdmKWsFG2VNWWhpmJMJbaaRLEVMB1ziHmTmO
	 oV8nLlgOS7WJHcuCuT3BHkjh9fZAA8EAgVbZyEh/sd9VFi/sc2nTP1rIOhcXrRPC5H
	 keGyFAPFa3zAcIUHZLeZIFW2QFlf/Y0eaD0uUHn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgFSOqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388412AbgFSOqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:46:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B601F2168B;
        Fri, 19 Jun 2020 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577970;
        bh=9m+nedHFamROTEbfxZl0O8S6WBufhsoEggKhtJGuz4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2O9pLpRPSzADPYAn47DKJBHv9L/bhbL0D1B/s1Jmmoc+lKdUA3vlcRwHWknTyYJsg
         glDG/R2onXOvZ9Gyan43iEkRBxX/Z3g4ysJd29MYdtsl2Cr5S4SxHqPBfolckNkYzN
         l7THI61JMtqXSd4oOvXnnym2hgmiBZn06BuZqePw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Kang Yin <cantona@cantona.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 4.14 009/190] crypto: talitos - fix ECB and CBC algs ivsize
Date:   Fri, 19 Jun 2020 16:30:54 +0200
Message-Id: <20200619141633.935484791@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
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


