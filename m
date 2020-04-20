Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5DBC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17B12075A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387525;
	bh=zdaV98C4qGP4BiZi+UEicnipIKDAQoW3KWA80HZLGKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XPfa+/tpBBFcBt5PEeVOyNU2IvYWo3nHM44sevpgNL4eV7OhFSPKgebKgCFzMBU4Q
	 BjVgoLGf+yrvGdDwfN8TBWOT/5y8fbvA389RIkKhBHtW1+10lR8JMfS9vKkXlcz0xb
	 iNOvBras6A2jlKn9mMNJCRvOBwS1d+3qKO2Rhlns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgDTMmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgDTMmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:42:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA54B2070B;
        Mon, 20 Apr 2020 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386558;
        bh=zdaV98C4qGP4BiZi+UEicnipIKDAQoW3KWA80HZLGKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxP+n9Goi/escYbbMs7wxbldoKT7CtKMlEdgndGfVd2XqM9XH+dC/Lo92gtc/W6/E
         RiJDDtis5rzLM61nX/XMNgOUQC1Cth8FqwFyqYGe7IQQKNxvJlUM4AH3uQRDbibFQ8
         gvY6GY3AeQQYFpXvqpku094KD6zJhRUhxj2dLKWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.5 45/65] arm64: vdso: dont free unallocated pages
Date:   Mon, 20 Apr 2020 14:38:49 +0200
Message-Id: <20200420121516.462780732@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

commit 9cc3d0c6915aee5140f8335d41bbc3ff1b79aa4e upstream.

The aarch32_vdso_pages[] array never has entries allocated in the C_VVAR
or C_VDSO slots, and as the array is zero initialized these contain
NULL.

However in __aarch32_alloc_vdso_pages() when
aarch32_alloc_kuser_vdso_page() fails we attempt to free the page whose
struct page is at NULL, which is obviously nonsensical.

This patch removes the erroneous page freeing.

Fixes: 7c1deeeb0130 ("arm64: compat: VDSO setup for compat layer")
Cc: <stable@vger.kernel.org> # 5.3.x-
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/vdso.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -260,18 +260,7 @@ static int __aarch32_alloc_vdso_pages(vo
 	if (ret)
 		return ret;
 
-	ret = aarch32_alloc_kuser_vdso_page();
-	if (ret) {
-		unsigned long c_vvar =
-			(unsigned long)page_to_virt(aarch32_vdso_pages[C_VVAR]);
-		unsigned long c_vdso =
-			(unsigned long)page_to_virt(aarch32_vdso_pages[C_VDSO]);
-
-		free_page(c_vvar);
-		free_page(c_vdso);
-	}
-
-	return ret;
+	return aarch32_alloc_kuser_vdso_page();
 }
 #else
 static int __aarch32_alloc_vdso_pages(void)


