Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34087C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0305D207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgG1W56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45968 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbgG1W5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id u64so20414547qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXGK2iD82DmJ1lw/0Vk2HVFHezNuEb65G8E7AUhsQGs=;
        b=p9yFoIo6cNSE+2j+sTSmgxUpFhPd5Fsk7bwwRSSpQALanSBppfyPMeZI6gzOqA2Px5
         1XIg08mAAxPp74A7pDmSBhgLHs03pRpAw4F6FF9FwY+bg2wqdLW1gN8nd8arqjkkvDXq
         MQcGlXs+dEYbQ+qzoLOi5KGemDYKLR+2GBSnKyU7+U1MCrcYtmiOGU+afIlrcJAYS+BP
         5ugM/l8ET+6jMynGKLHTsh7mcfuslo4CNnqg8Un6VZ5NOKmMhvNz9Ng5KniIcM8S5pSp
         kKN9cu9AqZBj/zCRfL9xklhDk2brme1WMJmKhy6cGHA/1pXx6Mrx1VQ85lQsfBWl0Fzp
         A6pA==
X-Gm-Message-State: AOAM533fjpcea9Uz8+bXDx3nUhrU7pEhqYaExUIim686PhJGl0E9urFh
        D7NoD1H6BrJWOaw1/f2SihQ=
X-Google-Smtp-Source: ABdhPJwVO9n8kZFV+njG6ccGodhBebXvqO/PFjAD+4phAVrR3d7q9yoBAuj10Wpk/ET5vwvk55LcaQ==
X-Received: by 2002:a37:47d5:: with SMTP id u204mr27233714qka.487.1595977057404;
        Tue, 28 Jul 2020 15:57:37 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:36 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/21] x86/kaslr: Small cleanup of find_random_phys_addr
Date:   Tue, 28 Jul 2020 18:57:18 -0400
Message-Id: <20200728225722.67457-18-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a trivial rearrangement to do all the processing together, and only
have one call to slots_fetch_random in the source.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 4fd60eff048f..0e103d4d452e 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -812,10 +812,9 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 		return 0;
 	}
 
-	if (process_efi_entries(minimum, image_size))
-		return slots_fetch_random();
+	if (!process_efi_entries(minimum, image_size))
+		process_e820_entries(minimum, image_size);
 
-	process_e820_entries(minimum, image_size);
 	return slots_fetch_random();
 }
 
-- 
2.26.2

