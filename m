Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3779EC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0807E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgAJUXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:23:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44778 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgAJUXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:23:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id n8so1345642qvg.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Al+dBZuEeOwUodYRlK1LAwsBq5Yu4UdaZv+8ZEmtXWk=;
        b=ratLs9Z6ZHZFb0CwyYkkXp8+X+PuU03iibwscmBxQgnWBedjVCsLwz7yBGKgPODoCf
         7mNVi1A4AceRI3u1dt5+fzkgeQhonLWHx36lhoBI+NOLW2gND+1Sr8F/zCFTi8GIqn2A
         uQqkfurn9OHwvSxN7dsBwTuYor3htKfRtg+LjxxahynlkylnsEWwRLiHk1QvP+B57vWH
         P4OZ84ogCHtr08ui7llGOOc2iqiCd/Db15w845RltvehO1XihJfu7ULzqYzjIjDw3xSh
         faY7bsYfrsnISw1bRVT+n/6xvnDAOjIEyeSvmnxRwxA4lJOe3v+hunBFfDGeMyqmIbVh
         QaHA==
X-Gm-Message-State: APjAAAV8yRVkNB0ml7IpJnHEdKDv1Kv9d9UWiVX/OkEWB6zzt6XQXQAt
        ej+GqxA6LCGIVpSTi5wpY9s=
X-Google-Smtp-Source: APXvYqyklzeQxVpmw8qD2hNmrWwflye/hysF9ez8/JpAtQjHjygM+355pp+pnfgPZ3gKpybqy0chqA==
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr4592163qvb.107.1578687830913;
        Fri, 10 Jan 2020 12:23:50 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q2sm1383814qkm.5.2020.01.10.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 12:23:50 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve to S_REL
Date:   Fri, 10 Jan 2020 15:23:49 -0500
Message-Id: <20200110202349.1881840-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pre-2.23 binutils makes symbols defined outside sections absolute, so
these two symbols break the build on old linkers.

Fixes: b907693883fd ("x86/vmlinux: Actually use _etext for the end of the text segment")
Fixes: c603a309cc75 ("x86/mm: Identify the end of the kernel area to be reserved")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/tools/relocs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..0a6146d6414f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -78,6 +78,8 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"__end_rodata_hpage_align|"
 #endif
 	"__vvar_page|"
+	"_etext|"
+	"__end_of_kernel_reserve|"
 	"_end)$"
 };
 
-- 
2.24.1

