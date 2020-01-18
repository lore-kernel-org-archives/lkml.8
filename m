Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A5AC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D68246A5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKkbqI9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgARRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:11:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40014 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgARRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:11:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so20731746lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 09:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d5SrJ1sdq3wtNoRSq5av6w5/jAF1iciuu5ggWH8R6/8=;
        b=FKkbqI9ZlOtCXftQeTOloFjon2Hdr/lB9zX1mB2eK8O5Y8+qc0njL9FcwecILJv1SL
         5hm1v57l2CxiBZWAN5+6RsJ4O7lt0/7kxRIMQi8PsvsMmRB/MhVxJAY9dnk0wgTTChKh
         aMYbwbyDsSgpsAJ9FS1IzKNOpr8SiL9wypNxFmH6x0Be/YXq8V26YPlfjlXN0VWApSpV
         BIwWthAqH8B4UK6p3Fg/crdlLw1c++DR/6JPMaX0bfEFSYnLCnN9icvCH0lbO2IP2k4i
         IzNrmKqQB8fMHq15CjuEEDRGMkd3hUx19hxDMGptoY5LQRoTtzTF2gd9eTUXLa/q4a6h
         0XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d5SrJ1sdq3wtNoRSq5av6w5/jAF1iciuu5ggWH8R6/8=;
        b=PlnxFRUpMrkj1uhDYdP86ehgGIAda9V3szC27ryYyIJtD7ofliX3NXgrszvhs3MIeu
         fWb/tR8tonRAny94xMO3J6CevRlIi307y9GvwlBidv3/HYmZfStz4V2BwCYPp3bihiLq
         m2bcfCkx23Lv5WBy4K/cSnWKS++byUwpRGoYd8L0CinkW/PI1R7OuPqAAC2elkOuL1Vo
         +MV6zG78Fl51hrM4W5qECcLw/2xp+kdeNGko/L6ShBpBN0wYTXx5C0/ceAhR5mAFYkQi
         UmOz0rr25l/E2dCJmSm7uhbE5jYNIn6x88J83+oDTdCELi4+lzaf5wy7ZCkMc2cnERHH
         CIVQ==
X-Gm-Message-State: APjAAAW7ovZjOadVtVHOOc878kV2ceAa2mhI4RRB64O8uIvemne/jRLo
        /WBVGEWft+g5NvmWlR4IGN2FT7q02JA=
X-Google-Smtp-Source: APXvYqwOzln5V/UyOEI4y3II8+j8Pdm+ExSFeOmdmus8zwsHCnrf3CwxhXq8OLhYIDLC1P9tcaCy3Q==
X-Received: by 2002:a19:be93:: with SMTP id o141mr8672809lff.181.1579367511800;
        Sat, 18 Jan 2020 09:11:51 -0800 (PST)
Received: from localhost.localdomain (188.146.98.213.nat.umts.dynamic.t-mobile.pl. [188.146.98.213])
        by smtp.gmail.com with ESMTPSA id u3sm13917238lfm.37.2020.01.18.09.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:11:51 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, x86@kernel.org,
        hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de
Subject: [PATCH] arch/x86/kernel/tsc_sync.c: Clean up code by removing unused assignment
Date:   Sat, 18 Jan 2020 18:11:43 +0100
Message-Id: <20200118171143.25178-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously the assignment to local variable 'now' took place before the for
loop. The loop is unconditional so it will be entered at least once. The
variable 'now' is reassigned in the loop and is not used before reassigning.
Therefore the assignment before the loop is unnecessary and can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 arch/x86/kernel/tsc_sync.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index b8acf639abd1..32a818764e03 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -233,7 +233,6 @@ static cycles_t check_tsc_warp(unsigned int timeout)
 	 * The measurement runs for 'timeout' msecs:
 	 */
 	end = start + (cycles_t) tsc_khz * timeout;
-	now = start;
 
 	for (i = 0; ; i++) {
 		/*
-- 
2.17.1

