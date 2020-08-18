Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2D3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92EE20639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt90pnhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHRQEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHRQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:04:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1364C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:04:31 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so15486387qtm.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JB8EfdnBuDNW3fHekM4Xs0GCzNgvaZJmFr6FyOpr2v0=;
        b=kt90pnhsyVARanjQ9njLpjrSBJ5NQfpD0etrNKhdcS8EIcHIyORlTTXv62fx4/6P8F
         NG0N3+QsMlFjdXgO0Z7wjYzJmzot9eYRdjcdOqWMPJwpLo+UhB/xuESEIPbKAxIdPzNJ
         9Mum08CkckVIRCx0SjmdPeIMUCmAmP/JJBj9XPVFsVgVUilemL5CSklA2qYsOKcLyxtV
         VRW1nNLF9ZPp7jVIMHb0/DinKg8pqGdyrkUsWKnltnuIzfpnTj2DBFf92nBgyj7/qtbb
         y2M5XVFdLvu6WDXgccYp5obPyE4kkyjeFLK/5V2Bqc0xEg3y8CkA9ZDUhxnzpIit2bZs
         GPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JB8EfdnBuDNW3fHekM4Xs0GCzNgvaZJmFr6FyOpr2v0=;
        b=kPiUYnwlhk0WiMMUOW95cm8LhqDcvYBg4EKzNmlk/aHLflthVMmlUDpdD//WCCOBel
         BpOxSVIGQR4yF+ir0p0/F0x8a5CiIm8kMwMa5/pOklpB2c5TvesEQYw+Rdf/mCutccCv
         KJtz8uDWSdKyS2cAFgKgyJwjGegDvJZBZaSZQF/VxWgCAItpGukjecI24vLCsgaaxswS
         gQRb4Sln34/H8yCQDqUuWOKOLZ4Cn92+6spRDoURZqPPaE9g9B3pJ6Zyf1vC6BNaqYl2
         fFk1K3S3VjodNIt5muMjP2jmf+2MHRZCGYp4MLyNLuyvc2Q/IRcVEX+hywPfJVQlnjQH
         RV9A==
X-Gm-Message-State: AOAM5327QjP3jcvImLMwMduRhKQj5EDbOvOM2XaaG391KChnV7KVqlFY
        ZjzM4vn6UZZKPR3QTHLEIQo=
X-Google-Smtp-Source: ABdhPJyN3RqmwVch/jVdOrb3MMghfcbvWv6DZDeEJvGVjV5qAzSgFkOtIKhqEi9jgO1lrjiwLv1eNQ==
X-Received: by 2002:aed:2986:: with SMTP id o6mr18435372qtd.105.1597766671154;
        Tue, 18 Aug 2020 09:04:31 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:f9e2:64b4:fbc4:6485])
        by smtp.googlemail.com with ESMTPSA id z17sm20732979qkj.62.2020.08.18.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:04:30 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     jikos@kernel.org, dsterba@suse.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ztong0001@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: ipwireless: fix error handling
Date:   Tue, 18 Aug 2020 12:03:58 -0400
Message-Id: <20200818160401.4736-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b360242d-f488-da51-9d47-36b2abdf90cd@kernel.org>
References: <b360242d-f488-da51-9d47-36b2abdf90cd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipwireless_send_packet() can only return 0 on success and -ENOMEM on
error, the caller should check non zero for error condition

v2: - According to Jiri's comment, I made the checking consistent with
the rest of the kernel. I also rebased the code using f684668a24ec.
Thank you Jiri!

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/tty/ipwireless/network.c | 4 ++--
 drivers/tty/ipwireless/tty.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/ipwireless/network.c b/drivers/tty/ipwireless/network.c
index cf20616340a1..fe569f6294a2 100644
--- a/drivers/tty/ipwireless/network.c
+++ b/drivers/tty/ipwireless/network.c
@@ -117,7 +117,7 @@ static int ipwireless_ppp_start_xmit(struct ppp_channel *ppp_channel,
 					       skb->len,
 					       notify_packet_sent,
 					       network);
-			if (ret == -1) {
+			if (ret < 0) {
 				skb_pull(skb, 2);
 				return 0;
 			}
@@ -134,7 +134,7 @@ static int ipwireless_ppp_start_xmit(struct ppp_channel *ppp_channel,
 					       notify_packet_sent,
 					       network);
 			kfree(buf);
-			if (ret == -1)
+			if (ret < 0)
 				return 0;
 		}
 		kfree_skb(skb);
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index fad3401e604d..23584769fc29 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -218,7 +218,7 @@ static int ipw_write(struct tty_struct *linux_tty,
 	ret = ipwireless_send_packet(tty->hardware, IPW_CHANNEL_RAS,
 			       buf, count,
 			       ipw_write_packet_sent_callback, tty);
-	if (ret == -1) {
+	if (ret < 0) {
 		mutex_unlock(&tty->ipw_tty_mutex);
 		return 0;
 	}
-- 
2.25.1

