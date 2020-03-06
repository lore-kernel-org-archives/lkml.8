Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF56C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF76B20726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cL1FKifl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCFBTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:19:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46097 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFBTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:19:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id x21so578212qto.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 17:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHNl0Ai/7sXNY9V+qcgDGSXp7Q7ONREfCWa1aDNUtes=;
        b=cL1FKiflYP40AAQZDEDq9/xzxq2lNHeO/2nToYiRfhD+xA7zN5BVRjD4Obprj9XYty
         FvCbC+U+M++96k5N6Vn+mXx2gJuDWSrDvFdXsztuotCTmpNKhxdQ5KnWxoaN7T5bhfrp
         +5VkdtZgwnmYh/Upuz+XrjON7LBkMVV9monqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHNl0Ai/7sXNY9V+qcgDGSXp7Q7ONREfCWa1aDNUtes=;
        b=cd/X27/Hr7jTxZBkoAGm3YiShjWo5KskQiF35kaODkdH39Zu5U8hf92ADTz1LiRAwB
         oE67xg+Jo/Kt/dZoKL3lGDH8kGquy0bxeSD4h2BZZNRBXn5jLsVfs3vMG0HuHD7+JPsD
         GEDP0AzkqGBPAm90OjxUTjscINEmaNDg8pGd/tG+mcYlW/+zyMd3KDWCM9mn0oosAJas
         xhxHyzUV3Nfl5DsLM9NSY1Q/kTF4KGfTwQtzHKKJHBNz6gulBBs431yy1/m1P/bNX0kq
         J3B+NtCe4fJll+9kC5ExoENkLlXhqgd6FNdVBI4WB4x80h5vKlH92HwhCd6sUnuMdQOS
         o0jg==
X-Gm-Message-State: ANhLgQ19Zm5EDjEAuKFV8JQLskxm45Zf3Ky+druVlM9R7b3DLjVk9IuK
        KyA5xcczpLHqK4odvErIxixrTiqt5ik=
X-Google-Smtp-Source: ADFU+vu222U7msucal/MgdKipZL/PTF4/n/rQCjB9Mnkuhh6jZrNm6gMfyjubO/FM+ZIxpfUdzlhFA==
X-Received: by 2002:ac8:c09:: with SMTP id k9mr918206qti.241.1583457577550;
        Thu, 05 Mar 2020 17:19:37 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j7sm4499370qkd.45.2020.03.05.17.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 17:19:37 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        surenb@google.com,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@android.com>
Subject: [RFC] ashmem: Fix ashmem shrinker nr_to_scan
Date:   Thu,  5 Mar 2020 20:19:30 -0500
Message-Id: <20200306011930.99378-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_to_scan is the number of pages to be freed however ashmem doesn't
discount nr_to_scan correctly as it frees ranges. It should be
discounting them by pages than by ranges. Correct the issue.

Cc: surenb@google.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/staging/android/ashmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 5891d0744a760..cb525ea6db98a 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -458,6 +458,8 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		lru_del(range);
 
 		freed += range_size(range);
+		sc->nr_to_scan -=  range_size(range);
+
 		mutex_unlock(&ashmem_mutex);
 		f->f_op->fallocate(f,
 				   FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
@@ -467,7 +469,7 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			wake_up_all(&ashmem_shrink_wait);
 		if (!mutex_trylock(&ashmem_mutex))
 			goto out;
-		if (--sc->nr_to_scan <= 0)
+		if (sc->nr_to_scan <= 0)
 			break;
 	}
 	mutex_unlock(&ashmem_mutex);
-- 
2.25.0.265.gbab2e86ba0-goog

