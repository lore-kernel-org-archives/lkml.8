Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F10C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749542186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578859;
	bh=1oK27HoEFJF1QmKyJidF9LZ7dDibAQb3VONl+MODBtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=olW52JPrp5dKyB3TESNK2InVaTY7HiQ4ElHgq0RonokLAn4ZBAz/fhvvESRPmI6Ei
	 zjFuvS1ozPV419ZvJ0brUzcHV/VerIG6hErZp7xalRDkn4BhdL7gDUQwb++uiE4dl0
	 CeJnUQUtFuDEpGD4o9Jg4K63zpdTIGxx0tDb+Yko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbgFSPA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389822AbgFSPAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:00:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83FB7206DB;
        Fri, 19 Jun 2020 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578819;
        bh=1oK27HoEFJF1QmKyJidF9LZ7dDibAQb3VONl+MODBtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mb1SY0mtKeGc0MmFNdPz6U4PR7DYzVfBZjP4f7uP6VvzeqO7Gj6q4HuI5FoQHBeWO
         oVU3xVU225sr/1sW9JMv8OBT1+R2sqc2WF8oQrzHK9L5gtDRMDXhvf7dUqwWKtYnJI
         +fB7VpW+I/gu7bh1xRDbqW5B3GLlePU/F+8w0a90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 169/267] x86/mm: Stop printing BRK addresses
Date:   Fri, 19 Jun 2020 16:32:34 +0200
Message-Id: <20200619141656.905524362@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

[ Upstream commit 67d631b7c05eff955ccff4139327f0f92a5117e5 ]

This currently leaks kernel physical addresses into userspace.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/20200229231120.1147527-1-nivedita@alum.mit.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index fb5f29c60019..b1dba0987565 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -120,8 +120,6 @@ __ref void *alloc_low_pages(unsigned int num)
 	} else {
 		pfn = pgt_buf_end;
 		pgt_buf_end += num;
-		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
-			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
 	}
 
 	for (i = 0; i < num; i++) {
-- 
2.25.1



