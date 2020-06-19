Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CB3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0013020720
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbgFSObF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:31:05 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36519 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFSObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:31:03 -0400
Received: by mail-qv1-f65.google.com with SMTP id x16so4540253qvr.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EJ2H/fVddiAPK6hXHAtQLifLDsxa0nRqV7Ub9F0/6dA=;
        b=BzvkDu2m1ekzExLNWtg8GFpN1K72nnVMOjw3cC9rvR+v1X0nY4aYeTQlYMMounSg2M
         my+9E1t6SCQjfdVPqeN2TxuF0m53+/L0Fpe2i0tD/Vk5rcAxIkSQfpcKDKpy+kfP2Heb
         stgkwSJe0if/ORJdjvAcEY3V1ltjJG5+cxOKrqPvrOJRDa4x+v9Qwy3ZpdzSWh5GG68N
         c9UlUKtOHzCgVS+xyUCSGoSYvr/W77Gq0vKsrybKsm3EnLAOxWJt6VGLu5WNa3BFRQHZ
         VaSVn52674XeFdUFDzUB7L8dm+D8eZt7ODgxU1Bh6YhA3YbKXHIp3DVKMD3AllIolZJd
         9AIQ==
X-Gm-Message-State: AOAM532i+i3gUth0N8zjEBTN4mgSYx7BbfLXH+RDFm0d7/aGrverwT2p
        DCzarUDLZh8lwr2GUyzx20Uf8NA=
X-Google-Smtp-Source: ABdhPJzcp62d0u37b3F1PLhEb1DX16D3sr8ZkLqMrAJ65xtkR6qmdSiVLa9KtI9kCGPkQ1Wjb+pSIw==
X-Received: by 2002:a0c:efcf:: with SMTP id a15mr9180329qvt.108.1592577061579;
        Fri, 19 Jun 2020 07:31:01 -0700 (PDT)
Received: from bill-the-cat.local (2606-a000-1401-8080-8c25-1271-b281-e614.inf6.spectrum.com. [2606:a000:1401:8080:8c25:1271:b281:e614])
        by smtp.gmail.com with ESMTPSA id u1sm6271677qkj.5.2020.06.19.07.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 07:31:00 -0700 (PDT)
From:   Tom Rini <trini@konsulko.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Ronald G . Minnich" <rminnich@gmail.com>
Subject: [PATCH] initrd: Remove erroneous comment
Date:   Fri, 19 Jun 2020 10:30:56 -0400
Message-Id: <20200619143056.24538-1-trini@konsulko.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures have been passing the location of an initrd via the
initrd= option since their inception.  Remove the comment as it's both
wrong and unrelated to the commit that introduced it.

Fixes: 694cfd87b0c8 ("x86/setup: Add an initrdmem= option to specify initrd physical address")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Ronald G. Minnich <rminnich@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
For a bit more context, I assume there's been some confusion between
"initrd" being a keyword in things like extlinux.conf and also that for
quite a long time now initrd information is passed via device tree and
not the command line on relevant architectures.  But it's still true
that it's been a valid command line option to the kernel since the 90s.
It's just the case that in 2018 the code was consolidated from under
arch/ and in to this file.
---
 init/do_mounts_initrd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d72beda824aa..53314d7da4be 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -45,11 +45,6 @@ static int __init early_initrdmem(char *p)
 }
 early_param("initrdmem", early_initrdmem);
 
-/*
- * This is here as the initrd keyword has been in use since 11/2018
- * on ARM, PowerPC, and MIPS.
- * It should not be; it is reserved for bootloaders.
- */
 static int __init early_initrd(char *p)
 {
 	return early_initrdmem(p);
-- 
2.17.1

