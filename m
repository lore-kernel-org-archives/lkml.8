Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6066BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3412C2468E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686007;
	bh=F3K8sIPF1qVUOqqBY13os+2ldJ8yavS81/VW8NRxjU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MmFSIzARu0IjFlvkM6n8ejLeFPuGuR51LWBqrE5TwbSkXbf2jgyLt1K9INQgzkrRQ
	 Cxdf7JfgaazAY5xPkuZLLyHPyKII24jIpYmOqgp6iC7GSyDxAaXTcTBkhWKXQvu0sO
	 zWY990aawVJ92oGuZiXQguH7xPRPc4c/rB2SUBrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbgAVJkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733063AbgAVJkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:40:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E229F24684;
        Wed, 22 Jan 2020 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686002;
        bh=F3K8sIPF1qVUOqqBY13os+2ldJ8yavS81/VW8NRxjU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8BiAvBjl5SH3hUmKcyBV0BPjOCAEywGAZqprAWia9lSYyDv/TvguaKNzTrCOX/qP
         V2YTJLMSF8v57Elke3huiQB/3gQnLs34QVaY2PLy0GK3K2uXA/j5R2ZTP+vPEPf6Gu
         WxJiYpj8l2/1BtFhTR23TyJmfTt01xJSIExZ8u10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bharath Vedartham <linux.bhar@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 33/65] mm/huge_memory.c: make __thp_get_unmapped_area static
Date:   Wed, 22 Jan 2020 10:29:18 +0100
Message-Id: <20200122092755.561234359@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharath Vedartham <linux.bhar@gmail.com>

[ Upstream commit b3b07077b01ecbbd98efede778c195567de25b71 ]

__thp_get_unmapped_area is only used in mm/huge_memory.c.  Make it static.
Tested by building and booting the kernel.

Link: http://lkml.kernel.org/r/20190504102353.GA22525@bharath12345-Inspiron-5559
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1adc2e6c50f9..6d835535946d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -502,7 +502,7 @@ void prep_transhuge_page(struct page *page)
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
 
-unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
+static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
 		loff_t off, unsigned long flags, unsigned long size)
 {
 	unsigned long addr;
-- 
2.20.1



