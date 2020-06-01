Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AABC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD783207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034337;
	bh=/A/eAbFYdnB8ODV/pNDI4+jBMMubhcLNCzLR43xG+to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrTe8f3xcJM2mT6Z2HV6T1TDKvRO5YPPKuQ3J8iO32DeoFAPlz5P+a3XkIAvjOFiy
	 EWr8ae7WGPxO1f9cSb9x9nUaK9mM0tuJg6sj1Pfw42IbhYtyeZkGt9jlD6mbhPBSnI
	 J2LEEUz/SGkUzMtGbq11mJ7jHkkqiNm5oU3LjrME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgFAR65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgFAR6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:58:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A797F2073B;
        Mon,  1 Jun 2020 17:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034320;
        bh=/A/eAbFYdnB8ODV/pNDI4+jBMMubhcLNCzLR43xG+to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVaGgFRbdtdJiFpIML0iJpJcof/wKgtId5HKkJl899mGPaQlMJZD3QU1xj4/vSp9W
         1ZVsEkhQ6H50zhFo5Vrnz8hYJhGKK7wKdupsV4nztjDVJycB7jaIDdYJf1fj4ygfDI
         qzdpvPYPa6BwOcn1GFmPxyCBD7TbajMhe8HbpzLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, sam <sunhaoyl@outlook.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 39/61] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
Date:   Mon,  1 Jun 2020 19:53:46 +0200
Message-Id: <20200601174018.927481596@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174010.316778377@linuxfoundation.org>
References: <20200601174010.316778377@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

[ Upstream commit 1d605416fb7175e1adf094251466caa52093b413 ]

KMSAN reported uninitialized data being written to disk when dumping
core.  As a result, several kilobytes of kmalloc memory may be written
to the core file and then read by a non-privileged user.

Reported-by: sam <sunhaoyl@outlook.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200419100848.63472-1-glider@google.com
Link: https://github.com/google/kmsan/issues/76
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e78553d51837..73cd7482c1fa 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1721,7 +1721,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size = regset->n * regset->size;
-			void *data = kmalloc(size, GFP_KERNEL);
+			void *data = kzalloc(size, GFP_KERNEL);
 			if (unlikely(!data))
 				return 0;
 			ret = regset->get(t->task, regset,
-- 
2.25.1



