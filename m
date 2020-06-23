Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C823C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2721A2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948128;
	bh=J8QAdJqFo59qas2Kh4rCIOp5wty6CYAC1DAaLthyu1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZoYWgd5mthe8WHNPJU49/Z+4/yD4lCPeRfOekqpXapo4Jw91faTybZA3E0ECBYNu
	 Afqpo2IAK5cWK78EaFiWlMd46qj1auwBwZ8ykACbWIsviGjQRZZNe0Scs2cpf4buyZ
	 7Ep9zJh7nIDPjf3sY/9OT2yvsqJflj7Ol/awo7c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393897AbgFWVf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388398AbgFWUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:10:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FE2206C3;
        Tue, 23 Jun 2020 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943026;
        bh=J8QAdJqFo59qas2Kh4rCIOp5wty6CYAC1DAaLthyu1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT65vGHpJt7bA4jJ24OwY58zC9YI7vLVdCWHFDSiVC1AmlZ9VkBr96z6RbEErzqhv
         h4ZgQgNK9x4zWp2u27EqI4a1JHMna9iAhSq4C1N4dbQX7Q7+J1Zhf9Irlc3u7jaQFk
         P99nrDqzaSgPfKsVtKS6sgxR/5UKJXK4A+A6hQ9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 203/477] tty: n_gsm: Fix SOF skipping
Date:   Tue, 23 Jun 2020 21:53:20 +0200
Message-Id: <20200623195417.177369978@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>

[ Upstream commit 84d6f81c1fb58b56eba81ff0a36cf31946064b40 ]

For at least some modems like the TELIT LE910, skipping SOF makes
transfers blocking indefinitely after a short amount of data
transferred.

Given the small improvement provided by skipping the SOF (just one
byte on about 100 bytes), it seems better to completely remove this
"feature" than make it optional.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20200512115323.1447922-3-gregory.clement@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_gsm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d77ed82a4840e..20b22c55547e0 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -677,7 +677,6 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 {
 	struct gsm_msg *msg, *nmsg;
 	int len;
-	int skip_sof = 0;
 
 	list_for_each_entry_safe(msg, nmsg, &gsm->tx_list, list) {
 		if (gsm->constipated && msg->addr)
@@ -699,15 +698,10 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 			print_hex_dump_bytes("gsm_data_kick: ",
 					     DUMP_PREFIX_OFFSET,
 					     gsm->txframe, len);
-
-		if (gsm->output(gsm, gsm->txframe + skip_sof,
-						len - skip_sof) < 0)
+		if (gsm->output(gsm, gsm->txframe, len) < 0)
 			break;
 		/* FIXME: Can eliminate one SOF in many more cases */
 		gsm->tx_bytes -= msg->len;
-		/* For a burst of frames skip the extra SOF within the
-		   burst */
-		skip_sof = 1;
 
 		list_del(&msg->list);
 		kfree(msg);
-- 
2.25.1



