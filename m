Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94185C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF582088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbgE0Pxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:53:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388176AbgE0Pxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:53:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 40CE3AEAF;
        Wed, 27 May 2020 15:53:44 +0000 (UTC)
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86/mm: keep __default_kernel_pte_mask in sync with
 __supported_pte_mask
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <321effdb-06d5-6b63-e94c-64f83f771024@suse.com>
Date:   Wed, 27 May 2020 17:53:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both masks get applied in the process of e.g. set_fixmap() - the former
through use of PAGE_KERNEL, the latter by use of massage_pgprot(). Hence
forever since the introduction of the former there was a time window
(between x86_configure_nx() and the syncing of the two in
probe_page_size_mask(), as called from init_mem_mapping()) where fixmap
mappings would get established without NX set. For a 32-bit kernel
running in PV mode under Xen this meant a W+X mapping (and associated
warning) for its shared info page mapping established in
xen_pv_init_platform().

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/mm/setup_nx.c
+++ b/arch/x86/mm/setup_nx.c
@@ -33,10 +33,13 @@ early_param("noexec", noexec_setup);
 
 void x86_configure_nx(void)
 {
-	if (boot_cpu_has(X86_FEATURE_NX) && !disable_nx)
+	if (boot_cpu_has(X86_FEATURE_NX) && !disable_nx) {
 		__supported_pte_mask |= _PAGE_NX;
-	else
+		__default_kernel_pte_mask |= _PAGE_NX;
+	} else {
 		__supported_pte_mask &= ~_PAGE_NX;
+		__default_kernel_pte_mask &= ~_PAGE_NX;
+	}
 }
 
 void __init x86_report_nx(void)
