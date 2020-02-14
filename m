Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C56C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629F122314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlgwllhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbgBNUtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:49:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34625 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388369AbgBNUsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so10519986wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGVQl5tfhTgXtZcPGr0AgAgQcAWmtrINLrUVSPJZyMM=;
        b=XlgwllhOKgfzsr9S3lg1Ff1Wd7uyV74DxaYnxsTNNvOrV5deKNYHp+Cvx6C7idGDmS
         DG6hQlVKZSy5QI6PWgaZuo/ptdri2lO7Fa2VmEh7Hkst04+zyjvdZaoq+MHy8Qy/eguM
         f238TfG4UVpMk397bZ3Mh4bY/6r6YCRFA4zDE7E5eT6PU5mUF5iNbKCUgT30MgJwbPFS
         D+wouZLWmm30eehaMnaPP54fPZCN7KHGbK1fxwlAEbp6p1rk0JAlCvuu4daMVmEhpver
         bBtZmb6tF+1OyAssHqL+foYdcJf3LcCbvMBTj+45YIX5hDWPoqD2ETjAGgUfxWrH4qcS
         eu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGVQl5tfhTgXtZcPGr0AgAgQcAWmtrINLrUVSPJZyMM=;
        b=eMekI8rv0nt2xArdNPw2TOmri/F1hSoZ7z/kCTOUmwxDUR12JmAzxnjAjoZSrc9qXj
         MTwk6P55uwmALRMdLe8mgzukVPbC5MUZ5OJwrU5QfYvqIAG02JI6saQCN/wFwScR47HU
         +xcXws1wlOYsRTMJ2IKlahScgEn+To64zNVJ0J73PwogEE9jfmDvrQ4GHhvljKhTsMoj
         G5P5nkKcyCs6SPotKtMQXdbh4b1+dLqUFEN/MXXzPwaP+Oevb+gx4IUUHVNkwn18HMya
         qs8j5qleBiV/1H01zDNRtwofza1IvVvc8yhMfxysQOUQDzl1BKBCFBiOVsJDJnPr0pu8
         X11Q==
X-Gm-Message-State: APjAAAXOICp+hZevKfJg/pRbWAy5dlskrpWG3tFPTepbeQPnyEf9HWAk
        eDmnVmG9Lq7Oe7g2QTEsJ/XYfspaYG0g
X-Google-Smtp-Source: APXvYqxCWIonj6ZpkqM3+TVFvnnbQxOmoFF6Pnc+18/k25klv+xtWHpbOGzTuoRN1TgTK4pO8Bg+Pw==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr5804592wro.368.1581713329510;
        Fri, 14 Feb 2020 12:48:49 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:49 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE)
Subject: [PATCH 14/30] x86/xen: Add missing annotation for xen_pte_lock()
Date:   Fri, 14 Feb 2020 20:47:25 +0000
Message-Id: <20200214204741.94112-15-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warning at xen_pte_lock()

warning: context imbalance in xen_pte_lock() - wrong count at exit

The root cause is the missing annotation at xen_pte_lock()
Add the missing __acquires(ptl) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/xen/mmu_pv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index bbba8b17829a..352f0c80cfcf 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -695,6 +695,7 @@ static int xen_pgd_walk(struct mm_struct *mm,
 /* If we're using split pte locks, then take the page's lock and
    return a pointer to it.  Otherwise return NULL. */
 static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
+	__acquires(ptl)
 {
 	spinlock_t *ptl = NULL;
 
-- 
2.24.1

