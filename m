Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1603C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C141E2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu09evga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgHBO7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHBO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:59:05 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D10BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 07:59:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c16so15672839ejx.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yyL8IQ3p0GjDt22ZLGpFc90FrUfjHizo61odNCdZDrY=;
        b=fu09evgatNAsy2nfTcEuGvs7voJG4NaA9XiThklVNg/cS6NMqFCAqnDO7DBWNwriuy
         7ORnLTD+lBZimH5ZeKf+EBPTupqxyUo3fCShctlmDn4odx3eMHHCuq3FAhJSLvZ3HxH3
         MXP1t1/NjLC1EPbdhrMqSm2rh1pD8gO3eahdSZ3up1akhjz/BZrIY/wwM6YdaEUKXOts
         9CidCBuNTzx/Ie4LY1hQH8sHXcMC8DZhxOqedqQ1pDCWjpClYF8J5mZvjRSXvJsib3XM
         xytcbqBW9R/pChCY7THaybMbJiDDoGko8C5wWMyc+Ij1454DpwwBopFgyG/+rr1uqGsh
         171w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yyL8IQ3p0GjDt22ZLGpFc90FrUfjHizo61odNCdZDrY=;
        b=tZnkSThopnzVq5wXfoRjhuvMz1Twr9UCzTC1nI8KB7tB4CdFcUT6Ma7HB0kz23hNNR
         Vdnk83ZXK0JidSmCX70aN0yrKrYPs+hbO+DRSR4pjLkJKQ/Px9jeDmxFLIRGe+4E8MMX
         aLtQNYjjDqLZxeAe/Ihtr8tG/JkiL3lgfBIJlVFt670yR4hPMa0vdRqXNLGB/1VzI3rd
         OKgtcNd8RiHlbFYOeAZxtsXEllbT+N9g0qCysFBhl1DFt5fFu7k6bhHV3+7LpEu4Y9GS
         cToE4YnWKtfJ9Ry22Ino6YaBOjLFReI7644lbbOrt3ZAY1LOjTlso6ApCvSXJ1KPhQp7
         Pp7g==
X-Gm-Message-State: AOAM532gQ0HOeCYFdaBbf6e+5bnLv8XMApA5XhGgh2uibO9ySjVpCudE
        oh78a0AeBxli6r2qVMS5jEY=
X-Google-Smtp-Source: ABdhPJzRpAja7Xak7zQvGrymyc5+JcmUJ893bw4Qsq5P6SCV/KWHpaHkmO4P26EJYDBK3WYnBkQRTg==
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr12422509ejn.542.1596380343249;
        Sun, 02 Aug 2020 07:59:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1821:5abb:6d82:a3:751a:a9fb])
        by smtp.gmail.com with ESMTPSA id p21sm7843855edr.59.2020.08.02.07.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:59:02 -0700 (PDT)
From:   Mohammed Rushad <mohammedrushad@gmail.com>
To:     gregkh@linuxfoundation.org, gustavoars@kernel.org,
        yuehaibing@huawei.com, dan.carpenter@oracle.com,
        colin.king@canonical.com, usuraj35@gmail.com,
        darshandv10@gmail.com, john.oldman@polehill.co.uk
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8192e: fix indent coding style issue in rtllib_tx.c
Date:   Sun,  2 Aug 2020 20:28:59 +0530
Message-Id: <20200802145859.14143-1-mohammedrushad@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to the rtllib_tx.c file that fixes fixes an improper
indent found by the checkpatch.pl tool

Signed-off-by: Mohammed Rushad <mohammedrushad@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 79d7ad7c0a4a..e0d79daca24a 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -859,7 +859,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			if (ieee->seq_ctrl[0] == 0xFFF)
 				ieee->seq_ctrl[0] = 0;
 			else
-					ieee->seq_ctrl[0]++;
+				ieee->seq_ctrl[0]++;
 		}
 	} else {
 		if (unlikely(skb->len < sizeof(struct rtllib_hdr_3addr))) {
-- 
2.17.1

