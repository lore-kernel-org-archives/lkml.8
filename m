Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D38C2D0E8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 06:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C8C20714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 06:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv9L3cKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgC1GGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 02:06:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38438 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgC1GGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 02:06:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so14321600wrv.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 23:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WtlQPkdICdSif60EiclWGWU5XZBZP+qLNsbVEnNZNqA=;
        b=Kv9L3cKqFvmEx2bcOl2zy+8nyIsg18Cn4Gv2VNxdcuX3P2x0xh2EWcGYMXgbe26TNf
         LqipxAyjmPC18C7Zxs/jnb+k+EINirBcxEoFq7Zfk6BbK0qdArjM6V+jiVSt9F4IoaGK
         FHRlqyXJGvN1zUDY7DPKLrfC4u3/h1G63SehM4kfjqfC/Dc4Z0prJdQA4pRLQxQ4QpEn
         Cl9CXW3tXWgUcJVzrpG0rjWlbLOFF4JHAREVxWz8Rh5sqKGkC8IM/TtkRCVwanNVz0I3
         Vrs49MQK69nrpjctnWPbBeP1pWkMNjZgZ2qOtOMUOHZBTgZRu9b+u8s9IoGRdJvV/vEH
         YWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WtlQPkdICdSif60EiclWGWU5XZBZP+qLNsbVEnNZNqA=;
        b=uB/2rq3I8bRNINi68xW8bm4xn6wKVkAKm5ANMuxLzK4jNWKGUrgJiYaMpjtG7hJOjf
         WwG+Q39aMSFf9uVPHYxezdOwLyao+trSn0h2l9iRurvfVAQLt+x3Cs0JbB17aUe5Y3gs
         QJsfCt8VhbTIgp6oY4X1o4d5SrrDklAtjXA48knghx5tc5+uugW/42TlGxrR2WTA6gdB
         dgWURa8+AqnRcWcnad/VpvfVhII2A5sInPsDzJaKw5hmSjoR9w1XKlb+Qfg1Y/7ZT7lP
         qy/Jj4ev0zP5Iv0Shk/xr82yR5aPFlgzBJli1rE2TGfPerm7PFBWTFoouuR4b7RZC1ut
         XXoA==
X-Gm-Message-State: ANhLgQ3E+XJlYeu8gAzA5gTiqlekS3UClPvbnhVOxz85TH3xZOUY7+xt
        mWLVVpccr6NZfHxdldMsfRg=
X-Google-Smtp-Source: ADFU+vtc/KFk/g8A31nX3lHxrJRjKhryKYhbhqJkJetNubeeO+aN4etZLQPF1fBp4kmLr/8C6l3C3Q==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr3219727wrs.339.1585375570783;
        Fri, 27 Mar 2020 23:06:10 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w204sm11264719wma.1.2020.03.27.23.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 23:06:10 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/3] mm/swapfile.c: offset is only used when there is more slots
Date:   Sat, 28 Mar 2020 06:05:18 +0000
Message-Id: <20200328060520.31449-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200328060520.31449-1-richard.weiyang@gmail.com>
References: <20200328060520.31449-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When si->cluster_nr is zero, function would reach done and return. The
increased offset would not be used any more. This means we can move the
offset increment into the if clause.

This brings a further code cleanup possibility.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6b6e41967bf3..52afb74fc3d1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -871,11 +871,9 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		else
 			goto done;
 	}
-	/* non-ssd case */
-	++offset;
 
 	/* non-ssd case, still more slots in cluster? */
-	if (si->cluster_nr && !si->swap_map[offset]) {
+	if (si->cluster_nr && !si->swap_map[++offset]) {
 		--si->cluster_nr;
 		goto checks;
 	}
-- 
2.23.0

