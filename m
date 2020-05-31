Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D913C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E62207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTsNxywe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgEaHPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgEaHPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:15:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0AC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 00:15:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p21so2031673pgm.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ux7WUcgWZimk6zm8mqRWJU5+TgqCpZUYOAeG6vLMXrg=;
        b=qTsNxywe68ZI/fz9ywvs8SvNYEGP6hCyiYMHw4H/up9vXWrOr9BO57k/U0oQrZHXFE
         hl7jg0BxW4qfz3g6fF1GheNAKv9Fx7O648M0mIxWBAtFS77HzFjQudfRCv6P+F/aM6tF
         qENHSb+XztaNpHjDD0/vFzIO/nN1MpOlPhk7+sbn5e1dpOA0Dg/XXBUfOsSGZb+dN0kC
         xIOoG3RcP7lKSjmcmBSuYP+eul7MrkOr7XYa3XZ/UIk3K4u7cnIsOYxzS+yhwCKcUq7b
         ZmvScUTVTdPn/431M+mlzNaqvip4u/C1qlK0aeUHHSX+DUNg3oJFwqsBVqJ2ys7xJakp
         JI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ux7WUcgWZimk6zm8mqRWJU5+TgqCpZUYOAeG6vLMXrg=;
        b=th9kzIIGRbTcGXh5a2BDU6qJtP0JYBMM0zdtXs/RUkXCiMhDdFaknU5mA6APq9CSV/
         GiUc0j3p4cKSvELcKm2pxqOxu3S0sQEcSNBMJT4HnTNuz3lL5pkjXAYZ5rgSFFEm7LDf
         JLEN4lt9y0hKZIQIzyO3GPa5Hluk3wnI2FQ39VCMgVJxEukjDXl9baQHZr3nD4l+7eym
         hkqEVi90luLMjk1UTnyhZK+t5SaVsyhzcpe3io306eLKuNRviZAvY6EQGtY26YFKlN4M
         U+HxIvWCDEyYDgBxRiqThxzuPoBGOen/TeCvEkEYq1dVFnYRhZCJOtn6Y66o54hfPpeD
         o1Rg==
X-Gm-Message-State: AOAM531y7gpHYsZtsV5naHsmHQMtrwJ/rk7THLVcCX/fCGAAtqIka/ix
        aaVuLs70bf3ho78icUl+GfQ=
X-Google-Smtp-Source: ABdhPJx1j6Ob8NR+KMVwnkpfmsxyNVDmQks6gE8lWHM4X0A71Zoh/5T0aKRIqSr+NIWhJeOqfgGeAw==
X-Received: by 2002:a63:c109:: with SMTP id w9mr8591855pgf.203.1590909312419;
        Sun, 31 May 2020 00:15:12 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.225.191])
        by smtp.gmail.com with ESMTPSA id m2sm3925943pjk.52.2020.05.31.00.15.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 00:15:11 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: gasket: Convert get_user_pages*() --> pin_user_pages*()
Date:   Sun, 31 May 2020 12:53:11 +0530
Message-Id: <1590909791-3871-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
	https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>

---
Hi,

I'm compile tested this, but unable to run-time test, so any testing
help is much appriciated.

 drivers/staging/gasket/gasket_page_table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index f6d7157..d712ad4 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -449,7 +449,7 @@ static bool gasket_release_page(struct page *page)
 
 	if (!PageReserved(page))
 		SetPageDirty(page);
-	put_page(page);
+	unpin_user_page(page);
 
 	return true;
 }
@@ -486,12 +486,12 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 			ptes[i].dma_addr = pg_tbl->coherent_pages[0].paddr +
 					   off + i * PAGE_SIZE;
 		} else {
-			ret = get_user_pages_fast(page_addr - offset, 1,
+			ret = pin_user_pages_fast(page_addr - offset, 1,
 						  FOLL_WRITE, &page);
 
 			if (ret <= 0) {
 				dev_err(pg_tbl->device,
-					"get user pages failed for addr=0x%lx, offset=0x%lx [ret=%d]\n",
+					"pin user pages failed for addr=0x%lx, offset=0x%lx [ret=%d]\n",
 					page_addr, offset, ret);
 				return ret ? ret : -ENOMEM;
 			}
-- 
1.9.1

