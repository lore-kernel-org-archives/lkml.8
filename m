Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABC1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FBA206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Dwcsd4m+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgFKP6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgFKP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:58:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD0C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:58:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k2so2388776pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmMY+MRX2wFNr8xH7Gjjy3WCjLNZOMBrX6oRooxRsyg=;
        b=Dwcsd4m+00R3mg5s04yD789hqMz8Z/ZYf9KeIlCkPSk9rHdho67fUWC8GIhjHTBy4C
         Wf1SHNNcuvtEIX37QR7LEo5o0MTkclIw9YH+b79ZOxR493utSFR6IYIQ5zAN9Yba7Cb9
         hZCHhddcMqE6/kitQAqNxfiG/hHhGKyf5tsU29c0LCt8hTI7SSRdr32abFjFtnZCj4J7
         TNpLymm7x52Uf+rbQEKxkCptyWyuQYkC2m/naag126EfUztdUFclB/pwMijOQZWYv5aW
         SnuBeoomtckzp01yaljaHr6QXk+osmmtek9IcrDrV5sF/k99EiAngMrkSuxrh82H3BUf
         UfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmMY+MRX2wFNr8xH7Gjjy3WCjLNZOMBrX6oRooxRsyg=;
        b=HxaZKwiV4BuLXVwEtKnNOp5WlATIR6XkbY9suUEkC/hLd+VpwSV6xDJcnpxIwzkpK/
         FXE3qs6HsCsCLQJNuJ4PIf2ZjyiT+JdcenX3qk7UUCfi1Gd/fL8YQ13HvmtPt8lK9VMw
         VAYm4R5yICnovOPRXctIMQkiTPCbHS0nSPrz3ED5ESaCLjHCePWj0veEr6QX7uiVyF5d
         aBW84AxCSVQkkv5neARLACSBRnkEahqJ1SUzIl92gPP7EGI5tAMMY36Kc+aMFr6eJEHi
         QlzdCgvarN6VJ9drl0ozoUl+bQ8D4gl2zyl1unhWJ4xQCYZykpqa7ZgFagHu+iks7R2o
         cdIQ==
X-Gm-Message-State: AOAM532vGMZAQvGCjfBMR4BXTz2rCMqG3y/mi0IS6yKBHOmgge2RXImN
        C68yAMRwHaLKikvV/6psHZDvSQMSAaA=
X-Google-Smtp-Source: ABdhPJx135n/L8uDgvZxsYAMgqqYKHRKnMrr+Pc6mDxL6NpxQa4sy25j9Jeu9J8cgQ6IAhO+DfyVqg==
X-Received: by 2002:a17:90a:e288:: with SMTP id d8mr9137569pjz.173.1591891096359;
        Thu, 11 Jun 2020 08:58:16 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id i67sm3489801pfb.82.2020.06.11.08.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:58:15 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Chiawei Wang <chiaweiwang@google.com>,
        Mark Salyzyn <salyzyn@android.com>, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] lib/vdso: use CLOCK_REALTIME_COARSE for time()
Date:   Thu, 11 Jun 2020 08:57:50 -0700
Message-Id: <20200611155804.65204-1-salyzyn@android.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chiawei Wang <chiaweiwang@google.com>

CLOCK_REALTIME in vdso data won't be updated if
__arch_use_vsyscall() returns false. It will let time()
return an incorrect time value. Since time() is designed
to return the seconds since the Epoch, using
CLOCK_REALTIME_COARSE can still fulfill the request and
never fails.

Signed-off-by: Chiawei Wang <chiaweiwang@google.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org # 5.4+
---
 lib/vdso/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a2909af4b924..7ea22096cbe2 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -324,7 +324,7 @@ __cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 		vd = __arch_get_timens_vdso_data();
 
-	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE].sec);
 
 	if (time)
 		*time = t;
-- 
2.27.0.278.ge193c7cf3a9-goog

