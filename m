Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEBAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 21:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B2021D7D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 21:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei3+4eUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgB2VlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 16:41:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40632 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2VlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 16:41:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id c23so4801510lfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6uy93UxgHpUDpR9Xr7xOhmfEHcxRhT77RQRFOSS/Ayo=;
        b=ei3+4eUi1I/cTlQjIc27NVqUqXgeWkP9L6Jta5Z5va+asPyUqRNa95neDp7GXeB1Ep
         /upc7Kq3R0CGgZJfTGh46fQhWWWAZY1VrIy74ViGrjQ5e0ivM4j8Dw9Q4qX/caIuGAXT
         Pr9Y0lUBXj7nduyUqCuEAKm3U081Mj62nrRh4WvXQmcV/DdeedgbdBNyifFuAleagq7s
         4yKzf5RC2D42gHRt0WuUsze0PT3w44ZHgUwXMhsnHtMh5+1YtBMS8332soUMByTJfxFq
         woa1qxesG0HdH4SdfEPyMnjMVCrUI1IaXZX7sanyRt6aWYRh8GpGdkhycgKZHBSI8HYu
         BhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6uy93UxgHpUDpR9Xr7xOhmfEHcxRhT77RQRFOSS/Ayo=;
        b=B9aRyPPby7zlsUWalrWQ7cJexcOTMInFxJiO4PbgAupV0p0ifPEizzku1VA7esutjk
         MorH/jlXkxONl5Kq6M17wOLtqMxccFfWQkQWobTgXhfve9GQeuAu6Tr+ACOEmlfEab9r
         zQHsoLbzQzf5uf1wMQrZ9uMiN/LxVxSJanXz4lgW43C+fnFgUSyn7edPElGW6glBywsV
         XFWxBYKL8X7dJAXzI2r1mRn1tdeZgzeNh1OZhnWwZo87Lbdu98AU12aflA/VzPoFU6aa
         PrmcBLbadRqDHd+YfeHM/E9WVfE+V7LCWmFg9ByZS6Lnw1ZtJ8YUvnY60r63uiti2Gkv
         DZhw==
X-Gm-Message-State: ANhLgQ0Z7z4iRFPpAJ+Q1cXdj6h1oecjzoblKnH9p0oZbjZ3PSfWx2TE
        UqzNzsv2sM1vYAK17p5YIws+wvKSUPw=
X-Google-Smtp-Source: ADFU+vvbPTQ7oOlwmxID5YGVvq1OYiYYJSvhJQexKefXGy2lg1QXrlfSUNGVmoVc/cx+MBGi9C2oCw==
X-Received: by 2002:ac2:4307:: with SMTP id l7mr6033407lfh.37.1583012475035;
        Sat, 29 Feb 2020 13:41:15 -0800 (PST)
Received: from localhost.localdomain (188.146.100.83.nat.umts.dynamic.t-mobile.pl. [188.146.100.83])
        by smtp.gmail.com with ESMTPSA id i67sm7976242lfd.38.2020.02.29.13.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 13:41:14 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/vmscan.c: Clean code by removing unnecessary assignment
Date:   Sat, 29 Feb 2020 22:40:22 +0100
Message-Id: <20200229214022.11853-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously 0 was assigned to variable 'lruvec_size',
but the variable was never read later.
So the assignment can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/vmscan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f14c8c6069a6..a605ff36f126 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2427,10 +2427,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		case SCAN_FILE:
 		case SCAN_ANON:
 			/* Scan one type exclusively */
-			if ((scan_balance == SCAN_FILE) != file) {
-				lruvec_size = 0;
+			if ((scan_balance == SCAN_FILE) != file)
 				scan = 0;
-			}
 			break;
 		default:
 			/* Look ma, no brain */
-- 
2.17.1

