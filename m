Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77324C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1B8206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+Msdqeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgBTQbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728909AbgBTQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CcQ3+IAeYTGH9do6IO2FxfgSZnvINmGfGHXGlbg3PU=;
        b=L+MsdqegttqMdquJhFPjl63u+SsXRnB9eLxx2+MWdKU8/lMVH5cqjpL0K61o7nOJ2FX1ek
        eSgsd3Qw3GOqc+aOtDQuI/xKIc9sWoVf+fltwqog1A2hJfeQ8qFd/Zp6rRiBMJ8tcVFKqh
        wdp7iwKY8nRZd/LXlIjI3FC4qNepHQI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-xEyoUCFFOHiRoS0tUO5y-A-1; Thu, 20 Feb 2020 11:31:32 -0500
X-MC-Unique: xEyoUCFFOHiRoS0tUO5y-A-1
Received: by mail-qk1-f197.google.com with SMTP id q123so3126039qkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CcQ3+IAeYTGH9do6IO2FxfgSZnvINmGfGHXGlbg3PU=;
        b=r0LfnnAzKkAS+LEQ/nXd9X5Ivs8+2FZgy85N4mEuetsIFyJQNfVJPm8qShpnuenjPw
         75O0eKcYZ2LT+7iYf8LiM5lMZBBEe1qTncL+TSSDea5fGr9LVJlsn7LA3ZUy1uVmcANC
         mhFe7MW1gMoxxF1IwcUGNK24SOhCctzJpEdiWA5LgChcLgm40VaMn/RxfFbcwryk0dv8
         o7FeOwTlRfOYI7+LEPhGkbTIMpItc3q6fc8Mo1VAW5HARv+Hyu7VWWwCwJjTN4xN03i7
         JQWGWTZHoz4PbRkO4h3BFkKj2qkTUPdmEn+HxQuc6WaOL36B8HkDZ1E968LlwBKVM42q
         ma/w==
X-Gm-Message-State: APjAAAXau8YWH3Bdwh2TDmAw+oiG09fhOjcbxB78kQEvSR6ti2E0aB2B
        0zxBpN7rXNs81eP6BGCKpyslz7d6LU2CJayo1ZyTr/fAsgEkUZgKsesREcSXl5ovCvlHe2z391W
        pc3dC45JolZI6mMmA/V8IWTGZ
X-Received: by 2002:a05:6214:450:: with SMTP id cc16mr26379230qvb.175.1582216291755;
        Thu, 20 Feb 2020 08:31:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyx1wLJHNN7bX0JIiwvsibPAVG4lfhOifN1KcvsGrtR3sMPF4XG8/cMRjTEzqSZIM61UByx4Q==
X-Received: by 2002:a05:6214:450:: with SMTP id cc16mr26379203qvb.175.1582216291482;
        Thu, 20 Feb 2020 08:31:31 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:30 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v6 09/19] userfaultfd: wp: add pmd_swp_*uffd_wp() helpers
Date:   Thu, 20 Feb 2020 11:31:02 -0500
Message-Id: <20200220163112.11409-10-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding these missing helpers for uffd-wp operations with pmd
swap/migration entries.

Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h     | 15 +++++++++++++++
 include/asm-generic/pgtable_uffd.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 74f16d7e5b47..75a04ac97ef2 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1427,6 +1427,21 @@ static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
 {
 	return pte_clear_flags(pte, _PAGE_SWP_UFFD_WP);
 }
+
+static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_SWP_UFFD_WP);
+}
+
+static inline int pmd_swp_uffd_wp(pmd_t pmd)
+{
+	return pmd_flags(pmd) & _PAGE_SWP_UFFD_WP;
+}
+
+static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
+{
+	return pmd_clear_flags(pmd, _PAGE_SWP_UFFD_WP);
+}
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
 #define PKRU_AD_BIT 0x1
diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
index 643d1bf559c2..828966d4c281 100644
--- a/include/asm-generic/pgtable_uffd.h
+++ b/include/asm-generic/pgtable_uffd.h
@@ -46,6 +46,21 @@ static __always_inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
 {
 	return pte;
 }
+
+static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
+{
+	return pmd;
+}
+
+static inline int pmd_swp_uffd_wp(pmd_t pmd)
+{
+	return 0;
+}
+
+static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
+{
+	return pmd;
+}
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
 #endif /* _ASM_GENERIC_PGTABLE_UFFD_H */
-- 
2.24.1

