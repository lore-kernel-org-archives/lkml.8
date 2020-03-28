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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A989CC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E6D20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0kG5plC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgC1PPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:15:22 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55373 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1PPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 11:15:21 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so78326pjb.5;
        Sat, 28 Mar 2020 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eOZEHwyhLiVwrcvI4azx0kiz1+8s29d7yo6778qGx/E=;
        b=L0kG5plCpn8C6bTkXsLUcx1wPltxhbs7RgnTXpHANR7D05x0Adp6N8bT9lHnMjpfZK
         2GsyTaaldSFiJx3fwQoaW8MI25a/HtV2Zh3tj+U3Ily2t0MTGkhjA9B7PTJ5cufrlfOg
         0D9hKbDE6AcArLQ87CbdqStgxueddsIfsyToS88BUT0BT00g07L6LMFPYihLNJSQsoEZ
         +UO0hErTyyBRVKCW2z9aRcOcyY9Da9dfoas8SV/pQYRJvXJTfH7k/sa5Cotj1LeudRDo
         N9cDC7BVlyJYDmFxs3ztpA8DlNLf4aSaq1cMxEECyYDMjU+6VZ/w78cptvffmyJYL9Lw
         fQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eOZEHwyhLiVwrcvI4azx0kiz1+8s29d7yo6778qGx/E=;
        b=HFyVnaGNWlYufKhviYDC35ZtvtWBhCbU+ijkyXPKOxezQJdUVbtk4BUQc+6g8MFyls
         4D66Shf4JwPk2ob1jFCHBvCUzNy3baRBa7Hw80jF5zGHnXI47s1F/iqyG5CnxCGtezRZ
         DvP8A+/XYGr/61uwlZUFuFlpzoq5t2BVJws9v5kRpmyTg2csdTkxUHhAqTr+1spY9GB3
         lbkMl+9kcuT70y8zA1OsJtOqipGN0/530v1D+ifv36Sf9vZXWe7Qg1pd6fhrjznzJX+9
         tPMjXIYkm0sx6Vo0KyGjYmEh9gHll/UAPAFLXxCZocsFqYb9mWrdP1opVriD60Z5qqRr
         Od5Q==
X-Gm-Message-State: ANhLgQ1t8+5JY5vC9hQFmVR8SmvIdzR1YlTpGybgYSHLNTeI6Ay0SWi5
        5STyDQ7OwakRSp/UZhvrjaEgCqQ7
X-Google-Smtp-Source: ADFU+vsY3Swz6pp1AkymSBSWZ30YCmBoRVFPte50OMiTf78PYLBDwAaVhcAdPNjLLlPWRGwYHoESeA==
X-Received: by 2002:a17:90b:3645:: with SMTP id nh5mr5628170pjb.104.1585408519476;
        Sat, 28 Mar 2020 08:15:19 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id j21sm418221pgn.30.2020.03.28.08.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 08:15:18 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     b.zolnierkie@samsung.com
Cc:     daniel.vetter@ffwll.ch, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, daniel.thompson@linaro.org, ghalat@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] fbcon: fix null-ptr-deref in fbcon_switch
Date:   Sat, 28 Mar 2020 23:15:10 +0800
Message-Id: <20200328151511.22932-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for vc_cons[logo_shown].d, as it can be released by
vt_ioctl(VT_DISALLOCATE).

Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bb6ae995c2e5..7ee0f7b55829 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2254,7 +2254,7 @@ static int fbcon_switch(struct vc_data *vc)
 		fbcon_update_softback(vc);
 	}
 
-	if (logo_shown >= 0) {
+	if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
 		struct vc_data *conp2 = vc_cons[logo_shown].d;
 
 		if (conp2->vc_top == logo_lines
@@ -2852,7 +2852,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
 			return;
 		if (vc->vc_mode != KD_TEXT || !lines)
 			return;
-		if (logo_shown >= 0) {
+		if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
 			struct vc_data *conp2 = vc_cons[logo_shown].d;
 
 			if (conp2->vc_top == logo_lines
-- 
2.17.1

