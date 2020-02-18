Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6AC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDB24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055843;
	bh=68U/xLqyVjRfkOsGOYbz9f1hYAYIM2awf/NeUB1Psm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ed8pYgKaOAlGA4RRPPAvIWIYmUyD9cmMwGO69ws1Mtfm5fTuYuXfx0JQ9aLgYXACL
	 O2VvSwMm5QN0zQwFf3cVXd09qgYG0NUoOlu8fVSbFWPFLLcgRGQWbp7yeGdLCyfllh
	 LFMlGlJdBiksrNlQxBxEe2b9mif3kfaTf0G2f8uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBRT5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgBRT5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:57:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA24124676;
        Tue, 18 Feb 2020 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055830;
        bh=68U/xLqyVjRfkOsGOYbz9f1hYAYIM2awf/NeUB1Psm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvWcUzBTYVLq2vDNSmPbJr/yMfonQS3shdv0PL8eDq6ZMlHbB9RlvTf7UC8dDiN/N
         yMbEU/E8kSTurs51IXjU14cXtgX/EAzPLy0Hl+s1F7nGdW7QDALqZxtGdNG1T0BTVj
         ojbAKJCJ0lde6ict7CBAZ2gOdqHSHfCMpkNPc7Uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 38/38] KVM: x86/mmu: Fix struct guest_walker arrays for 5-level paging
Date:   Tue, 18 Feb 2020 20:55:24 +0100
Message-Id: <20200218190422.917834466@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190418.536430858@linuxfoundation.org>
References: <20200218190418.536430858@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit f6ab0107a4942dbf9a5cf0cca3f37e184870a360 ]

Define PT_MAX_FULL_LEVELS as PT64_ROOT_MAX_LEVEL, i.e. 5, to fix shadow
paging for 5-level guest page tables.  PT_MAX_FULL_LEVELS is used to
size the arrays that track guest pages table information, i.e. using a
"max levels" of 4 causes KVM to access garbage beyond the end of an
array when querying state for level 5 entries.  E.g. FNAME(gpte_changed)
will read garbage and most likely return %true for a level 5 entry,
soft-hanging the guest because FNAME(fetch) will restart the guest
instead of creating SPTEs because it thinks the guest PTE has changed.

Note, KVM doesn't yet support 5-level nested EPT, so PT_MAX_FULL_LEVELS
gets to stay "4" for the PTTYPE_EPT case.

Fixes: 855feb673640 ("KVM: MMU: Add 5 level EPT & Shadow page table support.")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/paging_tmpl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 100ae4fabf170..61f10a4fd8074 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -36,7 +36,7 @@
 	#define PT_GUEST_ACCESSED_SHIFT PT_ACCESSED_SHIFT
 	#define PT_HAVE_ACCESSED_DIRTY(mmu) true
 	#ifdef CONFIG_X86_64
-	#define PT_MAX_FULL_LEVELS 4
+	#define PT_MAX_FULL_LEVELS PT64_ROOT_MAX_LEVEL
 	#define CMPXCHG cmpxchg
 	#else
 	#define CMPXCHG cmpxchg64
-- 
2.20.1



