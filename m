Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C15C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274D220767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5SnBLxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgHYMuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:50:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728586AbgHYMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598359672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLpiPZxsqM3g0W5LjWpYmN4ZvZtyTkOjbomSMgIs/1o=;
        b=h5SnBLxYbk3OBTFoWNbIb/HlkOcuvNgH+zQsNLjDxz3SXTx4x2QeFrPZeikW65Btroivym
        tYZiOiLZ6zJ9y86mfWmgNwb9jDFyu/XMUvzhHaSA7sSDWvxQFHwSJgIK38lGR+6VKCm0IP
        NsDsX36I3qbzXI00Zk3NCsAqHAfVmsU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-1-yPINjzP5yOm7j4D7PUTg-1; Tue, 25 Aug 2020 08:47:50 -0400
X-MC-Unique: 1-yPINjzP5yOm7j4D7PUTg-1
Received: by mail-wm1-f69.google.com with SMTP id g79so419799wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLpiPZxsqM3g0W5LjWpYmN4ZvZtyTkOjbomSMgIs/1o=;
        b=WtUymr1rRQYt2x534peQ82KozAu1UnP/QE5WsP5PZ8acLgqk2Z6RR8l1KjqegEXSIl
         CQn3mCjyoDXNkpwRkpc9zHg9EclOLXLtr+F6yEzv0sRP7wW5FkynWUoTRH3whatB+6DZ
         RbCnkX0JNpNGZFU+oVeE3eCKtbUP+tke0tqxmr59OXvHsZ3CoE6thyr5aUQ8Mmae+D2x
         YfYrVuU/mRx4HG5OeL41NvNhyJc7CgreX8cKjiMv76XGb8vLfexLVfy811B5uWaY6p3K
         sLwdqYAjUu82ps8KDQ6v7AFhCcpa/04UlPq3xNA6gJW7HTZshTAIkjDyBC5BShKi5Por
         KfTg==
X-Gm-Message-State: AOAM533p9dEIf9E6oA+qEzMtLN5CBJ8N9tGOK9zlxcReCibfnslMcOIw
        V2trgf64h+TGL8EBIMyZi08j5YHcQeustJuXYiHrRr0PRo29sFsWNozqzwvAoJGflgXzNRB8Kgm
        Op/q+7r1M1xqbQLxUk36BHVZ3
X-Received: by 2002:a5d:4c83:: with SMTP id z3mr10752479wrs.359.1598359668897;
        Tue, 25 Aug 2020 05:47:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5IWslteQWtM63O6QJ6FmCHlzFwS4rya6A3uEqVde/ijAKZQN6jjfkV80riZasUytYvoGcWA==
X-Received: by 2002:a5d:4c83:: with SMTP id z3mr10752468wrs.359.1598359668686;
        Tue, 25 Aug 2020 05:47:48 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u6sm27469306wrn.95.2020.08.25.05.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:47:47 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        benh@kernel.crashing.org, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v4 3/4] objtool: orc: Skip setting orc_entry for non-text sections
Date:   Tue, 25 Aug 2020 13:47:41 +0100
Message-Id: <20200825124742.29782-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200825124742.29782-1-jthierry@redhat.com>
References: <20200825124742.29782-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orc generation is only done for text sections, but some instructions
can be found in non-text sections (e.g. .discard.text sections).

Skip setting their orc sections since their whole sections will be
skipped for orc generation.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/orc_gen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 968f55e6dd94..66fd56c33303 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -18,6 +18,9 @@ int create_orc(struct objtool_file *file)
 		struct cfi_reg *cfa = &insn->cfi.cfa;
 		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
 
+		if (!insn->sec->text)
+			continue;
+
 		orc->end = insn->cfi.end;
 
 		if (cfa->base == CFI_UNDEFINED) {
-- 
2.21.3

