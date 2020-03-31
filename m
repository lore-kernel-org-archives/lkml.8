Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ED0C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F0A20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO7zOLCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgCaWQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:16:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41024 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgCaWQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:16:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so28128620wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=95Z+TZZn0HPFjO2HrghxVOqovmQHbw7OTxMyAmZ3sRc=;
        b=MO7zOLCiY86xDx8sq7kkM0P89eOedea3TzJqzFOD0hxMsJZqrmy6kNehnSZP8djWlt
         0v1sSJ2OUtq1Tj1tKhOUcxWxieoJU/IKAeNW38DxUrAqavHzqLYN5PxlgCjo9oLoPnJG
         X2Na2fz/qcW885PSD+yRiO2uIvLiabu6I3ubjFkcXpHEf335YamKTH7FiI8aS/sBY4Hj
         jA6EECRQ/lIy/+tREutY3F/43eMa2EITWUC/P2eVlxzwqTwfKBt/FSYHDkDbiQCL7dCw
         8DgEgKv/qJzvvEOa8zxmZi7x7Tzxp+vYdVgvZb8vjyJpSSrQzVoDuyvj6grdBDwmPKoQ
         ZUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=95Z+TZZn0HPFjO2HrghxVOqovmQHbw7OTxMyAmZ3sRc=;
        b=PwjUoAnUH7rDoPSe6zfTfGz2VITcU0G/82M5wpllo1wU3IZCgwbZ6S4oVKwxa2Jl1G
         RqUu4xpQ9n5jB3A8HSoM5J7PzAicx2gHoOzcrSuRFnC+eR3gtfsioSWfNPyVAqBkPLAm
         ySkKgiaR5eq5ox9/IPsyUm44eE8c4UDBwlYUPO+42etKBLB2ZSU4Pma5w/oNU8Psbpnp
         5R/yfZzJDLjs+0bTNXApavyKXOSXGb/+qLOpO1fMU+qEqZuq+IRwflcHCOE9HTW9gJ8c
         MwJr1vil/W8+ZxeZHs45yD2aECrl32bgJL0ymkCDRgPdRkOTdEIasDSt7zSjykVXOzhi
         kf+A==
X-Gm-Message-State: ANhLgQ2EZ94q7YzE2rbbZEpbaldnsNJ5yIv7Bc6yosMN9vZUIW7OdRME
        V/NyUDDa5w4rUMF5N9lOYqI=
X-Google-Smtp-Source: ADFU+vtLFAEZp/8iVqmCJlpi/mOzRDbXPYHUteroc5yB3gS1Tp2FLocJfmvboaklFU8cPpQoz2Sd3w==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr22219457wrm.26.1585692962713;
        Tue, 31 Mar 2020 15:16:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id x16sm155681wrn.71.2020.03.31.15.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 15:16:02 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm/vmscan.c: use update_lru_size() in update_lru_sizes()
Date:   Tue, 31 Mar 2020 22:15:50 +0000
Message-Id: <20200331221550.1011-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already defined the helper update_lru_size().

Let's use this to reduce code duplication.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/vmscan.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f92858e5c2e3..a4fdf3dc8887 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1603,10 +1603,7 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
 		if (!nr_zone_taken[zid])
 			continue;
 
-		__update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);
-#ifdef CONFIG_MEMCG
-		mem_cgroup_update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);
-#endif
+		update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);
 	}
 
 }
-- 
2.23.0

