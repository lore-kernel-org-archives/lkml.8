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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564CC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C9A24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn8INV2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbgBNUtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:49:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40968 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbgBNUsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so12475511wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuZKU7LjmXWLYQI/wtTpyWHlvqjYehwlyKEt0Tnztc4=;
        b=fn8INV2ODKBl+bG/dtdZOpRB8nT5T8itpwEPSR0z27GWAYSVu1s+fYw6/0zv6k28a7
         tZA1dQbPfL+m+lO91btmj/u7dynyGdCwSnCvJ6+L7Wn/iOsXg9yvIeQZfugEaozwGMTO
         KNZBDqjYZRrPr750JIsMLiNvYlkEVSA84TRMO81Pt4ZsxlLYmJqsVtjCfqQem1Pgc1k1
         3wBvXxOcpBiOssy1gzPJBOv/0wJnOwPaT2qXfFT+RUHATT+PpHmZ6Ph1APJVHDn/tlez
         QUAKymRjOEDOppyFluLHU1/65qetfcs2joTiF8+4zhypXrOaqvzVmpx1LmoAg1IS/X/K
         bd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuZKU7LjmXWLYQI/wtTpyWHlvqjYehwlyKEt0Tnztc4=;
        b=ZKi7NTbX9keVH8oAy+a0GBbl3YkmPhCYsqsIb+A8MHHG6e6LaKTgPaJIFy/e7UpnCG
         0UPvoytCXyaaQu/ws1Fg6NNveYwMTlsyoA6solZIi829Jgs08b4PGXMGQj/JJ7ZR9BzD
         SbSNstY8bpx7+EH6bVHnjUZNPgXzr9507kLB6iF8FFjmWoikddOEcEHS+yFXE/a3FDcY
         Ou0HN8Jiqk605goo9Y9JWTOLQINQDv1tJuDI15OvJ9493ldzFMFzs3SgVfQLpCbkjDxK
         kxB2+lNwma5VPrbD5PVlwf1NouiGuKuq5ywFpGROmXbxSRLRwT+kqrEyHKNCGAy6FPet
         9wVA==
X-Gm-Message-State: APjAAAVT7X+H/nWrl2wzkXUl4mb/Qa9fLAEufwDUsqnBXE0vfDNsxYbP
        Mwki8OirUF0rGGbCFgeHaZ5ICNGrjWKD
X-Google-Smtp-Source: APXvYqyOibwoRxJ6OG/pfMQU/qnxDVxBoitUFSf/mkb3Z3bKbL8DjSkLBFHPpJm3dbdATypsCa8WcA==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr5775564wrt.343.1581713330706;
        Fri, 14 Feb 2020 12:48:50 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:50 -0800 (PST)
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
Subject: [PATCH 15/30] x86/xen: Add missing annotation for xen_pte_unlock()
Date:   Fri, 14 Feb 2020 20:47:26 +0000
Message-Id: <20200214204741.94112-16-jbi.octave@gmail.com>
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

Sparse reports warning at xen_pte_unlock()

warning: context imbalance in xen_pte_unlock() - unexpected unlock

The root cause is the missing annotation at xen_pte_unlock()
Add the missing __releases(ptl) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/xen/mmu_pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 352f0c80cfcf..777008f8c668 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -707,7 +707,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
 	return ptl;
 }
 
-static void xen_pte_unlock(void *v)
+static void xen_pte_unlock(void *v) __releases(ptl)
 {
 	spinlock_t *ptl = v;
 	spin_unlock(ptl);
-- 
2.24.1

