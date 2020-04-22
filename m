Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F85C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005D32073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551566;
	bh=MFoXzUo4HUhOTCG0G7ix3BHbTupMCL7ylAjiMzgDUIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7hmp/7lOOlclmCC/3FDrAhf+9r5MKtKQFrJ/M95rVWBcJSeyyW6/G2/o50bJ6AB2
	 T57h1xTrXVcsKOdyT+AX8/uRmndgYG/VCIud1TLyonbbUpZcWO0k54rwi7dEChLtPK
	 RnGfsDmOjcORgRgaIVVzo2T0XCoT5bec+bl50pHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbgDVKcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgDVKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:32:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95F6C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:32:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so1714010wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFpDohVto6uoX2W5waXoFiYKAl66JhA2t9807XRdebY=;
        b=EdbkPJ/O0A0k7r8wauBMXkp+DnjaU8ddUlf8SmCT5SrTCtg4GNejvIplMfrlFAO/nq
         wvcrTLIsX0DHs8oad9NEX4HusoTtMNaaUCXlY5O60+ke1j4MWRMgaeFKACnVFVz5k0Hl
         TArGwLLIP7qJTodpQOdsfXvXyUt24kXZYyXeaLXu/+A7ngWyr1NG0JQ6gCEQLvzUrfOv
         B8kmWmdiHxueSi268qMFP135RvKbJGi2nV9U8lIoWyioM6+L8Zv5kEvfiwBZdDsz1ZMn
         UAWPQOEHcuOV/Vnium8B4MBJfRAFBXYnHO1P9aHInanjA29t4SsBA0zzW3SMKU9cJmXv
         EyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wFpDohVto6uoX2W5waXoFiYKAl66JhA2t9807XRdebY=;
        b=mtnLxepL57tYheogizqvmnXerxewuqZxo5+DsQl1J8Vi5390VjVFquxTGipidodzq0
         LZsWVyARd9RL23sTIVq6vVK4xAJh6jb0hja+vHT8Iu9No3H3VjXrEyyMczZCuKhvo6y7
         Ed1mImsp83QV6PGTiLYbN/eeR8mU5vEyw7mUDeMBFKovjllT26as/mW7o945TLpbiypK
         zNQTkgD0pRFoSitqwY5kBQlknwJ23QauN1xGeNnJAwGJ6Bkkj2YHpjPiiUzsFfxJKwTQ
         QWygCYn7l02E5vzgkyhEbebyJShqY04yvB8C71in/DKjae7fPm1266K3JsPsEE4S1UR9
         vYCA==
X-Gm-Message-State: AGi0PuZqKRA9HRHbo21ZBLmjugL2Oj8S5vb1loPMbcj/JCjL2k+Hmsba
        ayr9TUskJrCewNd4igevTxS308NE
X-Google-Smtp-Source: APiQypKjpmidtYWIkJFXst2NibuJDHyTXYUM4IG5dOQELWJ7w3a1ZSaE/t0BX1WEAqevD1w9dzkpjA==
X-Received: by 2002:a1c:b38b:: with SMTP id c133mr9561157wmf.24.1587551544425;
        Wed, 22 Apr 2020 03:32:24 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s12sm6891603wmc.7.2020.04.22.03.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:32:23 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/3] objtool: Rename elf_read() to elf_open_read()
Date:   Wed, 22 Apr 2020 12:32:04 +0200
Message-Id: <20200422103205.61900-3-mingo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422103205.61900-1-mingo@kernel.org>
References: <20200422103205.61900-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct elf *' handling is an open/close paradigm, make sure the naming
matches that:

   elf_open_read()
   elf_write()
   elf_close()

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 2 +-
 tools/objtool/elf.c   | 2 +-
 tools/objtool/elf.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f2a84271e807..12e2aea42bb2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2614,7 +2614,7 @@ int check(const char *_objname, bool orc)
 
 	objname = _objname;
 
-	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
 		return 1;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index fab5534c3365..453b723c89d5 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -542,7 +542,7 @@ static int read_relas(struct elf *elf)
 	return 0;
 }
 
-struct elf *elf_read(const char *name, int flags)
+struct elf *elf_open_read(const char *name, int flags)
 {
 	struct elf *elf;
 	Elf_Cmd cmd;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index a55bcde9f1b1..5e76ac38cf99 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -113,7 +113,7 @@ static inline u32 rela_hash(struct rela *rela)
 	return sec_offset_hash(rela->sec, rela->offset);
 }
 
-struct elf *elf_read(const char *name, int flags);
+struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 void elf_add_rela(struct elf *elf, struct rela *rela);
-- 
2.20.1

