Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4FCC11D43
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B2124656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XX9lUbWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgBTGXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45316 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so1117734pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaPPmscQlj+AWtUQR/y2B7lA/cfvOcnI8Mj4BnPit3k=;
        b=XX9lUbWn/5B4I76NggdGaUA6Melm3yonu6fb13Fdexg0pZNNaY94FRS6DIyXajJj07
         RYmQlj0RVtamoa+XMQdMOX3n2i8aixjoz+MGanaZt2EFZXSkB86rsBbBn5ICCDVhpOAB
         LUaTnpYKyh+JMXKa1Tiq9K5f9ONx1WXPeb6aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaPPmscQlj+AWtUQR/y2B7lA/cfvOcnI8Mj4BnPit3k=;
        b=he+MYlZA5re1hVdWk/YjLiRSK4qRSKF/pW9DbCHfPvMgnAqmPRFEwmkthvJ73Y4XQT
         Iq5x0Ognjmftqkk9hWQ3Hy7ptZvGlv2f+pf/m0+6DI2704UW/AnCLlUYYx3ZGzi0OWSN
         wJigmyxxNrxhExKRqd1tnr354Ve/o9hDNOMIvsa6iTUa+HcBHIG3eMjADxozLs1w955z
         yX4rr6kDn99IauhCaZUyg30eRiSDnZ33dEWfa3Y/d7u1RJbm62VbgaITNfYByd331U3c
         nmOjZ3XYae0BixOwOQHZj6mzvtmywHwTaYQTsjQUewI2ddX/gCiebvKzq7Enrx7owGuj
         warQ==
X-Gm-Message-State: APjAAAXgbb3PzLBOEAV6Zw/O7qnCaK7EYtYacaSzeZdfRdOQD1Co2lyi
        q6A2ofzDU8u9vMvSCe7SBr5zCg==
X-Google-Smtp-Source: APXvYqybrzR1Jcrl6AnW0y34px7XVuRxCPT/1UBHhOW7jjsgahCA8Jzlgc4CZWtHz4pVpWmXY+h9Mw==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr29543202plc.108.1582179795261;
        Wed, 19 Feb 2020 22:23:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b186sm1260017pgc.46.2020.02.19.22.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:14 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] shmem: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:12 -0800
Message-Id: <20200220062312.69165-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

mm/shmem.c: In function ‘shmem_getpage_gfp’:
mm/shmem.c:1816:10: warning: statement will never be executed [-Wswitch-unreachable]
 1816 |   loff_t i_size;
      |          ^~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/shmem.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c8f7540ef048..8aca8275181f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1813,17 +1813,20 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		goto alloc_huge;
 	switch (sbinfo->huge) {
-		loff_t i_size;
-		pgoff_t off;
 	case SHMEM_HUGE_NEVER:
 		goto alloc_nohuge;
-	case SHMEM_HUGE_WITHIN_SIZE:
+	case SHMEM_HUGE_WITHIN_SIZE: {
+		loff_t i_size;
+		pgoff_t off;
+
 		off = round_up(index, HPAGE_PMD_NR);
 		i_size = round_up(i_size_read(inode), PAGE_SIZE);
 		if (i_size >= HPAGE_PMD_SIZE &&
 		    i_size >> PAGE_SHIFT >= off)
 			goto alloc_huge;
-		/* fallthrough */
+
+		fallthrough;
+	}
 	case SHMEM_HUGE_ADVISE:
 		if (sgp_huge == SGP_HUGE)
 			goto alloc_huge;

