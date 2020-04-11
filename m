Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D131E2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="g0u24Shj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDKQJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 12:09:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51454 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgDKQJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:09:35 -0400
Received: from zn.tnic (p200300EC2F1EE2004DDA4FC6A7F1C076.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:e200:4dda:4fc6:a7f1:c076])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28E3A1EC06D9;
        Sat, 11 Apr 2020 18:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586621374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=qm/3nlJuwIj0hv0o26e3JxUbSvRk5X7to6T2hRUsu40=;
        b=g0u24ShjV8WWPtOwQlGtrSaDFCRYf0GizwjbmZJfgZ4U3tlLwZ6zEMO/Nnxh+rrPjK/ld5
        BE6MU4b7eOAHxBu5al4Pu6H3fjoJYfLoKqpWMw18zAIptu6gysAvg66yuVM0nm000yYjux
        B4YfdpKtjJxHsio+6BV3lYurrsOTWrM=
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM: SVM: Fix build error due to missing release_pages() include
Date:   Sat, 11 Apr 2020 18:09:27 +0200
Message-Id: <20200411160927.27954-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fix:

  arch/x86/kvm/svm/sev.c: In function ‘sev_pin_memory’:
  arch/x86/kvm/svm/sev.c:360:3: error: implicit declaration of function ‘release_pages’;\
	  did you mean ‘reclaim_pages’? [-Werror=implicit-function-declaration]
    360 |   release_pages(pages, npinned);
        |   ^~~~~~~~~~~~~
        |   reclaim_pages

because svm.c includes pagemap.h but the carved out sev.c needs it too.
Triggered by a randconfig build.

Fixes: eaf78265a4ab ("KVM: SVM: Move SEV code to separate file")
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kvm/svm/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0e3fc311d7da..0208ab2179d5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/highmem.h>
 #include <linux/psp-sev.h>
+#include <linux/pagemap.h>
 #include <linux/swap.h>
 
 #include "x86.h"
-- 
2.21.0

