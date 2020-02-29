Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7271DC3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2B6246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adMOLuCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgB2NPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:15:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50246 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2NPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:15:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so6422475wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=StjHIE38vB9VkgRe5PBuA02+GIccOjh9WWY3dcYX1eA=;
        b=adMOLuCh06HYJjXSThzhaz1rU+fuueacqGN6n9pXhCp5nvsESAVrSbFoBx/0UHeH3K
         0SQ2yRT9USWF1odw949iBSRHEED2wf0BmydNR87cqP6eP5Bvw+LxtkpzvrNFiEEMv/u5
         oB4CyYYrx0x64hZpgPOADZ0/erRjqiKWPyNgiVVhf+56z4iTSTeknJnZJG236n+9mP5t
         lTjDCiBgq1+PWdOMkriAoASal+hWEan5YzTFGMC80Ov7CzKk5znRE32xqB/89xHK8dXL
         cce8Ib3TGvsApG9WFJ+cw95QojcAFgbWHv6TT68EVDFiTpv3Gnxcaoo1I/x8f0hBU5ac
         3Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=StjHIE38vB9VkgRe5PBuA02+GIccOjh9WWY3dcYX1eA=;
        b=BTned06rO0+urWoWVmNoV/RJTPIEYuIp8XvYoEBYDH+G5qvrM0DOHaEKwI+5pHek5f
         VVruBBxhPUNlULk/aMFe+Le9SU89JEHOAcv98jeSOW7xeSxQbVLGcnMsJfIPOKvYppMQ
         AaYbpgMfwtwAI68vL7acPCVqqydgxIm5Fr8mIuDPvrNuonhHCHdDvN7V8/66qhaKLYE0
         dpXXXLTmpwdbUinS1lD0GLAhChurMG4+p7Dm6W2E79uShWaT3N46FZlRJmOLQFX9YVw7
         uouCuSa69Jfezzb11xif/TL1i89xdEyJGvq7X5wXiiJtZnnDwB0tYsubWqjiMTDwqW4d
         LbPw==
X-Gm-Message-State: APjAAAUkNkRTzRXUOA2MIwYaazTGVXC4Xy8avI54BwYCcT1d32iWfrXj
        ea9L+/UHQqTT2aZhvAzEig0=
X-Google-Smtp-Source: APXvYqwid96ZnU/kQzW9Q6WbNv3G7eYYzbUuU01TLOjfXlMXmXHcKC0x2TQQy3YRbQbUsrZlRlpRnA==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr9803679wmj.17.1582982147118;
        Sat, 29 Feb 2020 05:15:47 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t187sm6702694wmt.25.2020.02.29.05.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 05:15:46 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/swapfile.c: simplify the scan loop in scan_swap_map_slots()
Date:   Sat, 29 Feb 2020 13:15:37 +0000
Message-Id: <20200229131537.3475-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit c60aa176c6de8 ("swapfile: swap allocation cycle if
nonrot"), swap allocation is cyclic. Current approach is done with two
separate loop on the upper and lower half. This looks a little
redundant.

From another point of view, the loop iterates [lowest_bit, highest_bit]
range starting with (offset + 1) but except scan_base. So we can
simplify the loop with condition (next_offset() != scan_base) by
introducing next_offset() which makes sure offset fit in that range
with correct order.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Hugh Dickins <hughd@google.com>
---
 mm/swapfile.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 95024f9b691a..42c5c2010bfc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -729,6 +729,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	}
 }
 
+static unsigned long next_offset(struct swap_info_struct *si,
+				 unsigned long *offset)
+{
+	if (++(*offset) > si->highest_bit)
+		*offset = si->lowest_bit;
+	return *offset;
+}
+
 static int scan_swap_map_slots(struct swap_info_struct *si,
 			       unsigned char usage, int nr,
 			       swp_entry_t slots[])
@@ -883,7 +891,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 
 scan:
 	spin_unlock(&si->lock);
-	while (++offset <= si->highest_bit) {
+	while (next_offset(si, &offset) != scan_base) {
 		if (!si->swap_map[offset]) {
 			spin_lock(&si->lock);
 			goto checks;
@@ -897,22 +905,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 			latency_ration = LATENCY_LIMIT;
 		}
 	}
-	offset = si->lowest_bit;
-	while (offset < scan_base) {
-		if (!si->swap_map[offset]) {
-			spin_lock(&si->lock);
-			goto checks;
-		}
-		if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
-			spin_lock(&si->lock);
-			goto checks;
-		}
-		if (unlikely(--latency_ration < 0)) {
-			cond_resched();
-			latency_ration = LATENCY_LIMIT;
-		}
-		offset++;
-	}
 	spin_lock(&si->lock);
 
 no_page:
-- 
2.23.0

