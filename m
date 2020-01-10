Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FF3C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08EA20673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgAJVuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:50:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33820 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgAJVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:50:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so3404098qkk.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yd/lLsT7icDuGqQpjwyX63E0NMrcZyQjQZJbpo+AeNc=;
        b=gSZS01dohqmOuBuAVW/pk3gdiw4mUYaA8ioLliu6bn4g/FGYXgIzKwiOflCJ1jf/rb
         hYXy3XX9smSbJ3c7ZSWLV5WPW6YPJjKawiqfWukeGV8e0Q8sLcISYXG99AaT3gbozOjb
         nEvYivyQmI+t434RedMinW9NVvlvSxFDxvfLKkNzlwf69P1J/azVQoonlzYYzygJMfuk
         Mv/EDxPtXHbE4HAuydcYAxAPZV0KSUsyGyzeVJB8PaeOuOofxrvQsv3u6iywDTXGtSj6
         /sTQTce5kMCLCQ+hjCciiFPPvjQ5XgSrqeqQZ2xIlSOPtKaM7HIp40AtlQe/EoHcScYO
         bG1g==
X-Gm-Message-State: APjAAAWeZZXo58yNITl5nbewKRbfo1SSNHdY8E+5vvdxWxtJJZy20El4
        dVVI9xQL9DQzZ8+VWu+Ct0I=
X-Google-Smtp-Source: APXvYqzoK9yZ/jJSbSvdwutn178o2VIaLLtd2RbGVxMnUmR2tnr8qtruddwZDD8YqJrn/gpKD9ewYw==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr5372345qkf.162.1578693007471;
        Fri, 10 Jan 2020 13:50:07 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s20sm1452428qkg.131.2020.01.10.13.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:50:06 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: [PATCH v2] x86/tools/relocs: Add _etext and __end_of_kernel_reserve to S_REL
Date:   Fri, 10 Jan 2020 16:50:05 -0500
Message-Id: <20200110215005.2164353-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110205028.GA2012059@rani.riverdale.lan>
References: <20200110205028.GA2012059@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to binutiles-2.23, ld treats the location counter as absolute if
used outside an output section definition. From version 2.23 onwards,
the location counter is treated as relative to an adjacent output
section (usually the previous one, unless there isn't one or the
location counter has been assigned to previously, in which case the next
one).

The result is that a symbol definition in the linker script, such as
	_etext = .;
that appears outside an output section definition makes _etext an
absolute symbol prior to binutils-2.23 and a relative symbol from
version 2.23 onwards. So when using a 2.21 or 2.22 vintage linker, the
build fails with
	Invalid absolute R_X86_64_32S relocation: _etext
for x86-64, and a similar message with R_386_32 for x86-32.

Fix this by adding these symbols to S_REL to tell the relocs tool that
these should always be treated as relative symbols needing relocation.

Fixes: b907693883fd ("x86/vmlinux: Actually use _etext for the end of the text segment")
Fixes: c603a309cc75 ("x86/mm: Identify the end of the kernel area to be reserved")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
v2: Added a more detailed commit message

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

