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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57429C2D0EE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 06:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7DA2072F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 06:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+h/l6FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgC1GGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 02:06:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54938 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC1GGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 02:06:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so13882775wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QyxtkEAHQnaf1QErBru4etFEtt1eRtjW95hNmE2s3Y4=;
        b=X+h/l6FE0bZBg5LxVz5E/0bUlMhHU9T1/Pty0E7jAPNp8YGpQmZuECTwXBC/STO4PS
         1WrNZs7bApj1wo0UThwBWVhTIjuxuPK5tqxrrvgRcrQdntAEg2wuefW1GVTP/okQ9GPO
         IZ4VN9amnTEdLd9SS4jnG0IRb0Huj/ca7GzdJtWrE5k+PnNbEqTYK+hudGZrZoJ+wCpF
         Kcpu6zPqmdYAD+t0C0HiQwD/raXAfe0yktUjhWXlmGSRSZSKGfnDtiY3VHd83D3Y7WmW
         FAV86wJ80f2wVv4fqwOBPoEazwcaKQQ31RKnd/6vt1Gs4WfTXFHi3eGhowoip9IClHf8
         Mjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QyxtkEAHQnaf1QErBru4etFEtt1eRtjW95hNmE2s3Y4=;
        b=buG9d6DxY8VR7gNHrfFoZyGXUBZ6MDz0Y5A0JIST+yUjyZkrk6KScw87lXyhNQpbXD
         mjm4SnSIz0smMbM2wHI6M85KCFBKALWbsvm7FciET0wKmIREgRCSDiwRIg4nNXG+S7PA
         I4Lr1FSJsyy5UiTEW4ys/Dwq4TSHu51/mDFZBJRGDVFKSBmVKAqZuuDXyiSoN91khjXE
         oBsDa0DDize+YItQINYl68KXHzFGxdr0b5/4KTx43nEadBbeJ0YJ9CFVg4m3todRYiLp
         Z9jYb8f5gKxG43/rB4vPslxBTNHGLhZNK7GairR/2FTVXgEZ0+y2vu1+UvWDZ5+qjpDL
         uJzA==
X-Gm-Message-State: ANhLgQ2VpRmWxa/7SH0r4fFWkhvNFPyuvOFTeJsMB46mpJEGc/3xQCtT
        Ue0bfvTCR8M2nAMUYeOgFx4=
X-Google-Smtp-Source: ADFU+vsnyZXOBaYycEjCrZ8ZHd1gj6YWTO9Um/rYrjUd4y77Fln6LQENeY2av+WepOyAUMPx416g7w==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr58664wme.88.1585375572913;
        Fri, 27 Mar 2020 23:06:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d124sm10967627wmd.37.2020.03.27.23.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 23:06:12 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/3] mm/swapfile.c: remove the unnecessary goto for SSD case
Date:   Sat, 28 Mar 2020 06:05:20 +0000
Message-Id: <20200328060520.31449-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200328060520.31449-1-richard.weiyang@gmail.com>
References: <20200328060520.31449-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can see there is redundant goto for SSD case. In these two
places, we can just let the code walk through to the correct tag instead
of explicitly jump to it.

Let's remove them for better readability.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index adf48d4b1b63..f903e5a165d5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -756,9 +756,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 
 	/* SSD algorithm */
 	if (si->cluster_info) {
-		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
-			goto checks;
-		else
+		if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
 			goto scan;
 	} else if (unlikely(!si->cluster_nr--)) {
 		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
@@ -866,8 +864,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	if (si->cluster_info) {
 		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
 			goto checks;
-		else
-			goto done;
 	} else if (si->cluster_nr && !si->swap_map[++offset]) {
 		/* non-ssd case, still more slots in cluster? */
 		--si->cluster_nr;
-- 
2.23.0

