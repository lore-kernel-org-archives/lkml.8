Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37066C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BE72074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="R6iixU7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgDTSdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDTSdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:33:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE7C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k18so4264544pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8+QEr6nEc3XkBp5IsOTLoBUYx1ezfM2tLTr0o8bZf4=;
        b=R6iixU7Tw7k/m27XZlp/ylDYNZUIZOR2YIvh8oBtu6bT6aSUzRdGt8DL9kg0gICkkV
         OmMqFta5jVgVqCdbDSu5pkIWAhiTyCfc1ICOFVh+pnmexPOtuEZPI8mFw+pdr/O+Nvp9
         r/+oZAMHD03TORbrtz+ROegmy24J6D8d7tdQbWXAUcZLylHFReyveADwm/sDPQODcPEI
         ON350vxcgjMMhVDotXxKx/9aB+WsHSC2iR7bJARYTgHLLr5U5dZXZX6CyhlsWV99oAGJ
         szT768w5vizo399e06Zp16cMp4dVIN48AunZo3C4lrp0FAmUhEpyrnEngNTVBBgep7VD
         OgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8+QEr6nEc3XkBp5IsOTLoBUYx1ezfM2tLTr0o8bZf4=;
        b=AKYji6EHFURWfTbSVTqdtn2rub18eShtKqt7q/hLnbzXR3hfmPE5iFuQ1+zVd/rP/y
         7c0Xlron2OD4SBZ/9WFUQkjSaZBa/oSuVZJ5hbACJdzZtNuI+8Azz8jjkAh4JHEHeaFV
         g55QNKCn8mDHfa9HNRRdeP6s14zuTNoHiJ1c2ceIlS3lyE5lNAVdyFDpNqzc2hE0L2sX
         uALozkyNCwOG+D6PFs/ukU17xQQyhY4mR6+RG74ZOH5O7yQ7GRK14pW8Gn1c7nouIRUf
         ASjXcWI1i5tXracFYsWFU+4Aa/rxyfb30PQ/3vwU0c6sSXS/2efAuzWKowUybPJPsPWQ
         x/TA==
X-Gm-Message-State: AGi0PuaUr9RHwIVQu7I+k+Qhkgt+VookiraSpxA29t4VrLID9IKIIsjo
        NZDaLkFpDhE/zN1fh27wQA5twuRafIrGAQ==
X-Google-Smtp-Source: APiQypJz614uV8iKNNoHchO9WxCPYm5upLuQokJI8MHagYt6bvHUYrC9LbwbI7VhGx4KCr02Xdy/XQ==
X-Received: by 2002:a17:90b:4c84:: with SMTP id my4mr840255pjb.3.1587407590227;
        Mon, 20 Apr 2020 11:33:10 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l185sm172536pfl.104.2020.04.20.11.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:33:09 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCH 2/3] x86/vdso2c: Convert iterator to unsigned
Date:   Mon, 20 Apr 2020 19:32:54 +0100
Message-Id: <20200420183256.660371-3-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420183256.660371-1-dima@arista.com>
References: <20200420183256.660371-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i and j are used everywhere with unsigned types.
Cleanup and prettify the code a bit.

Introduce syms_nr for readability and as a preparation for allocating an
array of vDSO entries that will be needed for creating two vdso .so's:
one for host tasks and another for processes inside time namespace.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index a20b134de2a8..80be339ee93e 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -13,7 +13,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long load_size = -1;  /* Work around bogus warning */
 	unsigned long mapping_size;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
-	int i;
+	unsigned int i, syms_nr;
 	unsigned long j;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
 		*alt_sec = NULL;
@@ -86,11 +86,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	strtab_hdr = raw_addr + GET_LE(&hdr->e_shoff) +
 		GET_LE(&hdr->e_shentsize) * GET_LE(&symtab_hdr->sh_link);
 
+	syms_nr = GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
 	/* Walk the symbol table */
-	for (i = 0;
-	     i < GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
-	     i++) {
-		int k;
+	for (i = 0; i < syms_nr; i++) {
+		unsigned int k;
 		ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
 			GET_LE(&symtab_hdr->sh_entsize) * i;
 		const char *sym_name = raw_addr +
-- 
2.26.0

