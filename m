Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4929C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13DF20409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845689;
	bh=uFdWLIgjpzmshCtxR4Ka3GpzLU0OPRdAVw6evjzpn7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u3+1lfh7yslEWMbEi5pyT0NqjfxJhnXM/l8pxfaHBdIEwsPz10FGXnZ/fK+qY2eiS
	 kYxpeI/GOPam00rbkki2IAswyBKLWfxeM5cbVr/3exF6jXnmAiHmr81ujPvQH9hD5r
	 gXDS1qTZMNwvLG2+3rycBNQuVRlKSFVcjWk+5C6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgCJNII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbgCJNID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:08:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 449D42071B;
        Tue, 10 Mar 2020 13:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845682;
        bh=uFdWLIgjpzmshCtxR4Ka3GpzLU0OPRdAVw6evjzpn7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHEVTGRUXAk0DX9g5AwDEs+hfRAP0qpqTZ+Hs98eVQqelaz8Y1Pxws+XK8qcmCr4V
         pr0u6DIdd92WcBJ8C7fFTYia+DQlcfMKp5UpwqWKYzvFYXqdgpdUDG0N5zBD6MBBcq
         BlX7yLIlaxb4/nAD3v5xd99DzoTsgRBBcaoF6MdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yang <richardw.yang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 063/126] mm/huge_memory.c: use head to check huge zero page
Date:   Tue, 10 Mar 2020 13:41:24 +0100
Message-Id: <20200310124208.135241459@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richardw.yang@linux.intel.com>

commit cb829624867b5ab10bc6a7036d183b1b82bfe9f8 upstream.

The page could be a tail page, if this is the case, this BUG_ON will
never be triggered.

Link: http://lkml.kernel.org/r/20200110032610.26499-1-richardw.yang@linux.intel.com
Fixes: e9b61f19858a ("thp: reintroduce split_huge_page()")

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2561,7 +2561,7 @@ int split_huge_page_to_list(struct page
 	unsigned long flags;
 	pgoff_t end;
 
-	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
+	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 


