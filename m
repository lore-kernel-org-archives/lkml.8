Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2132C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD2E214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="XRvtOoWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgEFP3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:29:03 -0400
Received: from smtp1.axis.com ([195.60.68.17]:6271 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbgEFPZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2609; q=dns/txt; s=axis-central1;
  t=1588778746; x=1620314746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3zZXkaxPHeAY/TBjlQEWSHvqpGeNBw93CZThIyniZI=;
  b=XRvtOoWqiUGjx2fxhoYGQDrVY+QjYJH036nBkt8RcCYe7vYSFmrw2xkW
   XdEaK/G6/5ijMZQwswN6skClUW2MqXijWGCdMdj9RoGFIX7XR2cp71R1L
   BlEJqSEK+FCCbfqZeXRB39gQX6IDgP/jnncxJRdZsS/yQlKuhxP5KyUf3
   9oX/lsTQXxZWIyi1KW5qU+hPaAs2Lz7Mjvf95X8anMbX66j39Eb8PNdif
   5Pev5cLVewSVOba4yZpqThHpZ5eLey5wgQjz2Y8I9e8xIGb18l6PMnBT9
   EZV/jhSKzB5/1sqj0EP9lwUtHrEDIY04pNFzn2q+fQ2tsvjJOZ9Z2A67b
   w==;
IronPort-SDR: J8buDQ1P7x0El2fjyKL8g2YP8RC//BKjDSHr2nfNC3kJ4pY+gEB8kkY7IuGWzKvemotBhBO/wj
 BKVIeO0yfqDHt3Y78bC94BJDQVXowDJgFUGKO//+MmbGuSNPPuPLU/GfbWco/INACk9vK3kGgj
 7sNYuD9aHKC9oTn8X0XMn9h53dLwbntWmrLfxKCcqDLp0YCoLjYaCp/evAUije215ZohFxuCgN
 aLLy+BwideKkwZ/1ynFaour1kzp7qJhhJjvepVjgaAnfY0jr/sP1zS8lW+YlYDjDBAncgpzBBs
 bOU=
X-IronPort-AV: E=Sophos;i="5.73,359,1583190000"; 
   d="scan'208";a="8454940"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <linux@armlinux.org.uk>, <jeyu@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/2] module: allow arch overrides for .init section names
Date:   Wed, 6 May 2020 17:25:32 +0200
Message-ID: <20200506152533.31286-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM stores unwind information for .init.text in sections named
.ARM.extab.init.text and .ARM.exidx.init.text.  Since those aren't
currently recognized as init sections, they're allocated along with the
core section, and relocation fails if the core and the init section are
allocated from different regions and can't reach other.

  final section addresses:
        ...
        0x7f800000 .init.text
        ..
        0xcbb54078 .ARM.exidx.init.text
        ..

 section 16 reloc 0 sym '': relocation 42 out of range (0xcbb54078 ->
 0x7f800000)

Allow architectures to override the section name so that ARM can fix
this.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 include/linux/moduleloader.h | 2 ++
 kernel/module.c              | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index ca92aea8a6bd..07d079085f11 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -29,6 +29,8 @@ void *module_alloc(unsigned long size);
 /* Free memory returned from module_alloc. */
 void module_memfree(void *module_region);
 
+bool module_init_section(const char *name);
+
 /* Determines if the section name is an exit section (that is only used during
  * module unloading)
  */
diff --git a/kernel/module.c b/kernel/module.c
index 33569a01d6e1..a5f2b4e1ef53 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2370,6 +2370,11 @@ static long get_offset(struct module *mod, unsigned int *size,
 	return ret;
 }
 
+bool __weak module_init_section(const char *name)
+{
+	return strstarts(name, ".init");
+}
+
 /* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
    might -- code, read-only data, read-write data, small data.  Tally
    sizes, and place the offsets into sh_entsize fields: high bit means it
@@ -2400,7 +2405,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
-			    || strstarts(sname, ".init"))
+			    || module_init_section(sname))
 				continue;
 			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
 			pr_debug("\t%s\n", sname);
@@ -2433,7 +2438,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
-			    || !strstarts(sname, ".init"))
+			    || !module_init_section(sname))
 				continue;
 			s->sh_entsize = (get_offset(mod, &mod->init_layout.size, s, i)
 					 | INIT_OFFSET_MASK);
-- 
2.25.1

