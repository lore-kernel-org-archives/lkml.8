Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FF3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA4820899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fsq5Xvcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGCOwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:52:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbgGCOwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593787930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QudHBrdzjmVd28xDQGtC/cC/sJDo4qzGo07yY4jix9M=;
        b=Fsq5Xvcftgz0x0m+qGU2M9CJfyELSmVL7o28u4n1wW0Rdatox4cfQENWCXZELBV/9djT4g
        nwNv4QY9fL1r7KGvJqgU92jnGWxqArI2F3mBfvGSpvAnZzxxIN9vXVEuSY8qHBACEqtyGj
        Bgb9mcrxFRe+shV8dOq5dKiVesx5mbo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-MMUf7rxJMhmM72IRldFdoQ-1; Fri, 03 Jul 2020 10:52:08 -0400
X-MC-Unique: MMUf7rxJMhmM72IRldFdoQ-1
Received: by mail-qv1-f72.google.com with SMTP id bk16so20727741qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 07:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QudHBrdzjmVd28xDQGtC/cC/sJDo4qzGo07yY4jix9M=;
        b=C7FoHH7DnwciZuFehyQ516thulTG2jZCei4wV5YE68TYCyLBaT1P4+gQlsaWi7/IIJ
         dSy8MsUab8HnyY337gtkLuUxBjdtRkoHYoarvDXEDNUjtQawGOJWQm3JFvRHIVxqPNdH
         bV4wASmRXBCEBO4ZbY/A36Tgl1d8Azd5pROZHq1ibkpXROTzCTndXtRELsZJBN5JH40z
         xZXyk2DKThZ5fBZ+dCZc81caPferfWedcYE6xPesNbHM5B/OMjZLxx0SyNT6tX0n0G3l
         6WghogxMR+iWFydbDbbBKyBafm4uBj7tBWzZr77eE2mkJaD9IAmlxV1cuBdu6v0H4rVy
         pFnQ==
X-Gm-Message-State: AOAM533u/3pqu/FZiliTAdnR8Q7ProPxvswo4e2O4Rws4eUE/9/7pSQp
        y2soaGBrrGSweebfUKT4qZa46RX7mjSyMhUDObQcbMoUPwFbUPn0kwtCMRggOhltRSJvwh0WuSr
        mIS8kaQYDxbRisdLod3oFOPh5
X-Received: by 2002:ad4:4d04:: with SMTP id l4mr21914257qvl.245.1593787928512;
        Fri, 03 Jul 2020 07:52:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoimR8INGoVqP0cPifC80a9/k/bJr13oIdtOMecUm5dqLTiX5Qn1NIk9jciowiDn01prQ7HA==
X-Received: by 2002:ad4:4d04:: with SMTP id l4mr21914249qvl.245.1593787928344;
        Fri, 03 Jul 2020 07:52:08 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s46sm12708678qts.85.2020.07.03.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 07:52:07 -0700 (PDT)
From:   trix@redhat.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mm: initialize return of vm_insert_pages
Date:   Fri,  3 Jul 2020 07:52:02 -0700
Message-Id: <20200703145202.10629-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports a garbage return

In file included from mm/memory.c:84:
mm/memory.c:1612:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return err;
        ^~~~~~~~~~

The setting of err depends on a loop executing.
So initialize err.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 17a3df0f3994..41513275823b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1601,7 +1601,7 @@ int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 	return insert_pages(vma, addr, pages, num, vma->vm_page_prot);
 #else
 	unsigned long idx = 0, pgcount = *num;
-	int err;
+	int err = 0;
 
 	for (; idx < pgcount; ++idx) {
 		err = vm_insert_page(vma, addr + (PAGE_SIZE * idx), pages[idx]);
-- 
2.18.1

