Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6AEC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66043208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="DWWns2xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEGVoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEGVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BB4C05BD0C
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:44:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id r16so6750768edw.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YYgWnESh6GA5v0OESDXoG2vIRhhETFyg3jLhszcc4vQ=;
        b=DWWns2xvSlGzPgxMP9SaFal+La3ugXLBILgUhzIBLx1qKHh1M2kKUcWn8htwx+14hQ
         /xj8yvFubU2EGz0sN8ohxRCbR/H3S/DhR38Uk5KjH2FKMN+sfvKW+BXhbtIHNZiNwbWo
         Kz3nyrJ3wr7svHXNNNMTyUd9Nht/APxBhFKNHxGdLK2k7fBHvmWHlifcsCm8CgWLwXg9
         wtrZNFrm1eqCnjRdThbsEh9XdVQw6I+3Tzi16Enj0KuTiVTBrYd9cRYH4InFe68162kI
         2Oa9/B3B9FV6TaVEIUSkFI+iIhWgfkGWXnWtE7Mh1+sJwVXl1bhxfcxl+jjvh9ErDTrO
         sffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YYgWnESh6GA5v0OESDXoG2vIRhhETFyg3jLhszcc4vQ=;
        b=kC73VHNAGUnxDYeiDx6sngyEGIaFc2LhZOMl3XfJbiG3dM1Uxxzmg0BUyh1nCvzf3U
         HgUBCZ8df0ykDZL6HfNLUzRqCrYQZRkA3zav57bgAoG0UCH8NH4/tWeflIYNbkmMqaKB
         6xHoKmxCe6CuosAFhh1em77RmER61L/I3iRVYWAMk6FomeulzP1jGQ4WEZKa0J20AS5w
         f7enEnzlLmRjs8XW+GHfpSix0TQ07IV1xmi6kacwtl0SOBEc5UfGtV7+jcURbDBLbVKr
         o5mhAPf9H8UQlMRQV0lOpYDbJahrmVvZlGAx3OCg1EcLyUo2sVHW8xXUhknaErOGN79M
         Y41g==
X-Gm-Message-State: AGi0PuYhR/cZUcwnK8NTJSgFbXlD6APE2iLh0QOV9L/L/xG8crg29JGO
        MU/GsLat0loovDH6i2YTGEoLkA==
X-Google-Smtp-Source: APiQypLp6wHTm7EDK8AfP2PSXpgEq087c1HKWFStkQHDrDai1hobruGJfFO4+hL+A7w+Bxkg3C69lw==
X-Received: by 2002:aa7:de0b:: with SMTP id h11mr14191067edv.133.1588887867072;
        Thu, 07 May 2020 14:44:27 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:26 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [RFC PATCH V3 09/10] buffer_head.h: remove attach_page_buffers
Date:   Thu,  7 May 2020 23:43:59 +0200
Message-Id: <20200507214400.15785-10-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers have replaced attach_page_buffers with the new function
attach_page_private, so remove it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Roman Gushchin <guro@fb.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC.

 include/linux/buffer_head.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 15b765a181b8..22fb11e2d2e0 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -272,14 +272,6 @@ void buffer_init(void);
  * inline definitions
  */
 
-static inline void attach_page_buffers(struct page *page,
-		struct buffer_head *head)
-{
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)head);
-}
-
 static inline void get_bh(struct buffer_head *bh)
 {
         atomic_inc(&bh->b_count);
-- 
2.17.1

