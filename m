Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9547C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E502075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TirSesHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgG3JmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:42:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729321AbgG3JmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLpiPZxsqM3g0W5LjWpYmN4ZvZtyTkOjbomSMgIs/1o=;
        b=TirSesHkImB0do+RKiOCtp9L9cujGquzvQBfpR4Ou7pgRxlOLMvJyTNzVs8t9DtL6CBl7d
        VY8kA60JnlwGNXhgGsMb9VwY+pd758+LhcM66jZxC3Krd04Sniot0PrOSo+h+6zuT1/wIf
        zjEd5NfNE6pNbH9biZjp5i2UVou8Df4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-mzGCyttxPOWhmRpEJ_7ulg-1; Thu, 30 Jul 2020 05:41:57 -0400
X-MC-Unique: mzGCyttxPOWhmRpEJ_7ulg-1
Received: by mail-wm1-f69.google.com with SMTP id s12so1293484wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLpiPZxsqM3g0W5LjWpYmN4ZvZtyTkOjbomSMgIs/1o=;
        b=cN/n5WCW/k6PAl8GFMKVaqQ9ydXYD79rLV49hO+q89V9SO/Z4LkSMAI5Qzt8yjN5gJ
         p9i+80u36q28a/vdxprWxMbqSYL3iDdi05fLYNYPdiU46b0XScFHapc+kT9amkISB4Fn
         HfLfbHXOjNrCHck1yaI/OGsP0LaDidt13EDdR8FfaQqcqHZNMQ65489h+ApvD30hn74B
         24gzaom1VcuknglZ2F1GxpZNdVKiTt1Act7lttaz3HtZURkwOA74y+azHRafYz3xi0yP
         3D/ulHjv29bi+d5h25T23CZ/YfwJnA8DkUSB4uuzunsTZEhqkGOhF1OtAjy0raKJDfE4
         hr+g==
X-Gm-Message-State: AOAM533S0ZbK/CcsuKUnjvzo5tnnRI6D7fvmmVG+/3mZ5NMt50ei4Q5C
        q5D9wr9qiCp1vrJaG8fQtMJelTD0+036ClxfvH7MdFQ0FVo+kgM+YMi/X0LOv9UvP9ncOh9z89P
        DJ45KFKU6XjGbwgzzHXomaxlp
X-Received: by 2002:a5d:5647:: with SMTP id j7mr1928872wrw.242.1596102111505;
        Thu, 30 Jul 2020 02:41:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwG9y1uzCmbWUZ2xlGUoI+g3Y9a2+zIZ3CuBlFt86XecTIYIard2UmPWpIVxNi/Ux7ezaoBw==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr1928860wrw.242.1596102111358;
        Thu, 30 Jul 2020 02:41:51 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w2sm10984807wre.5.2020.07.30.02.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:41:50 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 3/4] objtool: orc: Skip setting orc_entry for non-text sections
Date:   Thu, 30 Jul 2020 10:41:42 +0100
Message-Id: <20200730094143.27494-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094143.27494-1-jthierry@redhat.com>
References: <20200730094143.27494-1-jthierry@redhat.com>
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

