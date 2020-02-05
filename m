Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79765C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5073D214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUhe3AKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBEAvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:51:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46274 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbgBEAu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:50:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so111918pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 16:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xx/Hr3yEcha35uFKz8KW9UBIGlBl9yxxGD/Ht51bCag=;
        b=JUhe3AKHAQbOZIQ0eNn+wAM8JAgL0Ssx9uCzEIYHRsMQ5X+Oxe84h0ULRtw9jnbhS1
         T+NQdyQOkUOxlnuVOeguzvRKgEJbW6YZaI9iIez/rkX5ii3l5rskS2BnkS9K9JE4o0a3
         J4etdJCQERSWNak0CGgoPvV4l8mwHAk43v7RwzNKCD32NP0SMx6/vUM+7a1roJlRB7Cq
         jdiqC1oa/paLnFZ2aC+N96AtJqgW9819DHfnYO6oOTdG6AGnz4MSQmBaGCw8ajB6Lta1
         K98FJGKB2SiFy9IAuidogj8YOG4TnlbFZ+V6jGr/RVuf9kgNKKW2yR1542rv/e/CqpRv
         o07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xx/Hr3yEcha35uFKz8KW9UBIGlBl9yxxGD/Ht51bCag=;
        b=aofkEtMYDUzEVVC/QM46oV67kgwVEyuH/iKTTgRhbAZ795cUu1UnfwoKstbs+58aHL
         ulfM1LyRLxPRGTx2LE1bnFU9Z01HaYFVq4U0qHNBF8lnRZnV7YrK9in4O0Xzw01rNFxL
         XYfLewzEPEdzE2I+xYKhpWnxfX+k8NBuQUQ+HyPlPuCBi7qfTOhXxLH8tkRs4TnRUpY4
         pLA+U8Seqget3Z81L4DcoZDYIW6gZHOxDiFj7Nq2VSb0AmB22tw7r4qbgTKyVVE0WxWD
         Cpl7GQBbYA4CaAphmCNsKvXN25H6QqCQmCtPv82kx2JL3JOuRVTETsS+aGGI7tWEtvDL
         mH0g==
X-Gm-Message-State: APjAAAUWMsu4b/pqXUZ6g3ef8ARV3HeXh2fOn3XcxR21W6XvTZ1uadIJ
        vDXLPffIQfMfcBz7YlDRcqORew==
X-Google-Smtp-Source: APXvYqzPK07gRufHI/PmLMyzBB0+GO6DbDSzvLF2bYKCZP3DpDOUeUFN2CY18edqckMlDeHNn/MkJg==
X-Received: by 2002:a17:90a:cb11:: with SMTP id z17mr2406433pjt.122.1580863857220;
        Tue, 04 Feb 2020 16:50:57 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id f81sm24626828pfa.118.2020.02.04.16.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:50:56 -0800 (PST)
Date:   Tue, 4 Feb 2020 16:50:54 -0800
From:   Fangrui Song <maskray@google.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Subject: [PATCH] powerpc/vdso32: mark __kernel_datapage_offset as
 STV_PROTECTED
Message-ID: <20200205005054.k72fuikf6rwrgfe4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PC-relative relocation (R_PPC_REL16_LO in this case) referencing a
preemptible symbol in a -shared link is not allowed.  GNU ld's powerpc
port is permissive and allows it [1], but lld will report an error after
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=ec0895f08f99515194e9fcfe1338becf6f759d38

Make the symbol protected so that it is non-preemptible but still
exported.

[1]: https://sourceware.org/bugzilla/show_bug.cgi?id=25500

Link: https://github.com/ClangBuiltLinux/linux/issues/851
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/powerpc/kernel/vdso32/datapage.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
index 217bb630f8f9..2831a8676365 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -13,7 +13,8 @@
 #include <asm/vdso_datapage.h>
 
 	.text
-	.global	__kernel_datapage_offset;
+	.global	__kernel_datapage_offset
+	.protected	__kernel_datapage_offset
 __kernel_datapage_offset:
 	.long	0
 
-- 
2.25.0.341.g760bfbb309-goog

