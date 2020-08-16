Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BA9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 07:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23891206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 07:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLMRxSZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgHPHnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 03:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgHPHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 03:43:51 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C54C061756
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 00:43:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so10168858qtp.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJih6gEi4k5uorIsjoMn680bPc4jDp+ibtRNYw5Ryuk=;
        b=NLMRxSZlZz7m8LQyIA2XPGyk1aHSgCMWGKfApMWq8gUVt242Qx7KkY9NQ39mqSTZEY
         Q5zlUGJ9gzqVVsDK+LiN1m2NcKClYJ0agFo5KoIunxXJOy9fwccuxbXUAn7hJFo+1wll
         awKCIE3Xp92t+4TtaW0zEdR1bet2oZ+LSoY7pSmvPoEXqF4AizMrMu8sBwNFFa4RiLHe
         goFyoAngPrfx8syQrTtAFvANG0RZwgsiyxe4is04Y1CX5b5x/Ckhylzj2kQ2r6uruJYR
         WHDaFT1aJ+D8fkx3SyYgL/WI10LtGp3M3zus6Za9dMNH7V+Ruv1TcGwCNDt3zptGfPJ7
         NLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJih6gEi4k5uorIsjoMn680bPc4jDp+ibtRNYw5Ryuk=;
        b=U0cs+rF7DRk9oEm6L9x/6bvHYKnKbq4ClFB/yCKAzgWUxQKasOnezeLj9nyzHmH4ap
         w66hjLLN//BWZwCSx470FCmeUwco9ffE+xtAup/V5jcfb66Q7+JLn/p1TNg+kctGKAZB
         dnS+Y+QddDeWoQXS4nmaItAu8VDKE6xIjyan6BsaF64wPwZl4xz7z1XyFfgGHD8Dug6E
         abI3949WapgGobkDJHVuR7LCIjGjwWxp8tnGu4ZmQ8Z5n4KYSYm9/fj9CNMEXFYS+EVq
         ibHb9kX6NQK/D29omKHKLN2ANEhDqLhw7Xwv7Qa9NUgHRVJkfzACe0972Cy6JL6H+MQP
         6o8g==
X-Gm-Message-State: AOAM533IX9blr4a+Ln4GklwJuhk52TeE8/z7u6aH/QjWveDWyNX8+R2z
        6po1w6P0XNfbv+NXmmtq9qE=
X-Google-Smtp-Source: ABdhPJzk9MiejTLWzVsVM44PKBvRU/RboR6ryBhY3yADYppmJ+tn0tOVLVVLcdiX+BMdh3aYs/J4ow==
X-Received: by 2002:ac8:6d2f:: with SMTP id r15mr8753148qtu.281.1597563830060;
        Sun, 16 Aug 2020 00:43:50 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:4032:a79a:238d:9f7a])
        by smtp.googlemail.com with ESMTPSA id d124sm13110394qkg.65.2020.08.16.00.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 00:43:49 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     jikos@kernel.org, dsterba@suse.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH] tty: ipwireless: fix error handling
Date:   Sun, 16 Aug 2020 03:43:34 -0400
Message-Id: <20200816074334.981915-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipwireless_send_packet() can only return 0 on success and -ENOMEM on
error, the caller should check non zero for error condition

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/tty/ipwireless/network.c | 4 ++--
 drivers/tty/ipwireless/tty.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/ipwireless/network.c b/drivers/tty/ipwireless/network.c
index cf20616340a1..b6f677f4004c 100644
--- a/drivers/tty/ipwireless/network.c
+++ b/drivers/tty/ipwireless/network.c
@@ -117,7 +117,7 @@ static int ipwireless_ppp_start_xmit(struct ppp_channel *ppp_channel,
 					       skb->len,
 					       notify_packet_sent,
 					       network);
-			if (ret == -1) {
+			if (ret != 0) {
 				skb_pull(skb, 2);
 				return 0;
 			}
@@ -134,7 +134,7 @@ static int ipwireless_ppp_start_xmit(struct ppp_channel *ppp_channel,
 					       notify_packet_sent,
 					       network);
 			kfree(buf);
-			if (ret == -1)
+			if (ret != 0)
 				return 0;
 		}
 		kfree_skb(skb);
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index fad3401e604d..0230e0fd3937 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -218,7 +218,7 @@ static int ipw_write(struct tty_struct *linux_tty,
 	ret = ipwireless_send_packet(tty->hardware, IPW_CHANNEL_RAS,
 			       buf, count,
 			       ipw_write_packet_sent_callback, tty);
-	if (ret == -1) {
+	if (ret != 0) {
 		mutex_unlock(&tty->ipw_tty_mutex);
 		return 0;
 	}
-- 
2.25.1

