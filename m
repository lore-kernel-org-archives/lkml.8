Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7595EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACB4246B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+rSunlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB1WsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:48:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgB1WsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:48:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so5125593ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 14:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A+iUf1q8MEClAw7zFCnu1KfnBswurqalqrfaVPpzjIg=;
        b=j+rSunlKdN/kAKRGhPOnBPNtnuI4mJopAbdUyGTJVlTjTub2un8qOnqwPv0YgE327y
         aHY+108Xztjp2qF2LhuHT6nccbHZNBGB5FJzBvYjdS5l5b2lsuomSPRsrzhTJ9jo4gRd
         umBQ2OnCPDzOfVSNC9+xSQ0efZmNxy+tzDek9wGXEvZtd+CxFFw5e8JTMEMeNc5NQxEd
         ktEuCd1EhHWWONd53x+zIsL6rBEZJY3XEH6gpfymR1A5ppGZDrfG4TBxmtuIS85mN/y1
         O+DNi7nOPllLZK5Ypxu4IUVxQxzrn8lbLiHxSNUK+oFRDetF9rvKIbwASP1I4iUK0NI9
         kbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A+iUf1q8MEClAw7zFCnu1KfnBswurqalqrfaVPpzjIg=;
        b=fywPKrpl1pXP/YwMaVv5kabwhPht5M6K+bUuc2bM+3Nzm+FzIFHsweyZNqspRPEMHC
         7MPcZgEdkmx9gk4cNwk4HgwXl7s7zEuhzg0D/dDRSGJfvT7xkVklw36WSv7tW/eaAlyS
         6FJz29BE+6fhRGo7o3TrlybaGIY86c3zVu7Z+eYNgR/2kgs8+sxSUwVMQXmuTiQDElSI
         tW6W6HbqeZe+lvz+DGHAIYHwl8g0JwfnMH82DnHyRBJM/lwTv9TJtTEsX4X3n2OZSVaU
         EIuEysy3IAbx70riEH7fpleGxoyaqlY/Vi8MtSD3jHmaRSNSF2rVmlaVz1BbxWG8blt9
         g6Zg==
X-Gm-Message-State: ANhLgQ18jyYBl8BlYYW3/EUDCTmvobRmUUhcJXjJPR+1Kh9ZCw071oZX
        z4BoOlw/URBxCR18W52Luj8=
X-Google-Smtp-Source: ADFU+vuV1zQy8PJeKk+iZ5PNWS05sKhzzSQ5rg4vPdWweL9ZumRLjGymkVf+izwZf1z47RUFlXh+Hg==
X-Received: by 2002:a2e:b892:: with SMTP id r18mr4268976ljp.252.1582930084594;
        Fri, 28 Feb 2020 14:48:04 -0800 (PST)
Received: from localhost.localdomain (188.146.100.83.nat.umts.dynamic.t-mobile.pl. [188.146.100.83])
        by smtp.gmail.com with ESMTPSA id w24sm5424340ljh.26.2020.02.28.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 14:48:03 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/mm_init.c: Clean code. Use BUILD_BUG_ON when comparing compile time constant
Date:   Fri, 28 Feb 2020 23:46:17 +0100
Message-Id: <20200228224617.11343-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

MAX_ZONELISTS is compile time constant,
so it should be compared using BUILD_BUG_ON not BUG_ON.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c918388de99..7da6991d9435 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -37,7 +37,7 @@ void __init mminit_verify_zonelist(void)
 		struct zonelist *zonelist;
 		int i, listid, zoneid;
 
-		BUG_ON(MAX_ZONELISTS > 2);
+		BUILD_BUG_ON(MAX_ZONELISTS > 2);
 		for (i = 0; i < MAX_ZONELISTS * MAX_NR_ZONES; i++) {
 
 			/* Identify the zone and nodelist */
-- 
2.17.1

