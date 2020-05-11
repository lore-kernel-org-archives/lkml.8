Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E8BC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFE52075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="YkqJNsob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgEKLsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:48:10 -0400
Received: from smtp2.axis.com ([195.60.68.18]:31161 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgEKLsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2683; q=dns/txt; s=axis-central1;
  t=1589197687; x=1620733687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nJ1qTOy5LEl+3ghrdE6ayVo+QTlImTiM42UK10R/CO0=;
  b=YkqJNsobfGQ2J8y3QSAWjnq2d8D1eHYGoZhuunPo/gdtHmxQtBr21s2h
   xtL9ZdeKUfW8qAAshPCApSMQAK/B1z+eSlUENdDZoWIKf4ilR9FFT5Aqh
   nvWY4MpY1VPB4kAfV8Snq/bakWmrWrBLUCH8BAowJ7HVNSW5g6zYzn/3B
   o0b2qNYyvgtQlryzKIFnT2r7TRLYZB5ZekCi2Q8SENGoBzg0f2V8kygyM
   lNzi+sOcEa6Op0prqbhvGwooZAov/nbhHruIf4/+Sb2Xn9ZRKB9mc3BZG
   UlGbkRtPBe0EW0vZq8rVTHR659wSGOO1ELk/P8NwgxcFi+DyGDBH12IUu
   A==;
IronPort-SDR: eWZuRw32j5JYJgOi5OmGwaaj8bk7KszfEuOPpxP4bH8Wi8itNv+fizjpxYs2CA1SNITyHvwDyy
 qF5XgZsbtYDgaXmRoOUZPIQjDvnmgDdVFNOj+YUImbRBZMNyhpfwCzvty6IclSGzLL0wn4Ylkg
 NMSpihDcfR3G7ROq4TYzqOCAX+eMijiP9tOhd2iSgF4dLKYOfzCfwuCXkzHJvihLExksYRL8+y
 icIrmdn+FfpXtULH6nfG6NJs0t6kxPaR7E/bKSLsZ87dQvssdR9LdF0N5Ld/GlMxn9zZsK4lbm
 7jI=
X-IronPort-AV: E=Sophos;i="5.73,379,1583190000"; 
   d="scan'208";a="8358766"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <linux@armlinux.org.uk>, <jeyu@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 1/2] module: allow arch overrides for .init section names
Date:   Mon, 11 May 2020 13:48:02 +0200
Message-ID: <20200511114803.4475-1-vincent.whitchurch@axis.com>
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
v2: Add comment and move module_init_section() next to module_exit_section().

 include/linux/moduleloader.h | 5 +++++
 kernel/module.c              | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index ca92aea8a6bd..4fa67a8b2265 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -29,6 +29,11 @@ void *module_alloc(unsigned long size);
 /* Free memory returned from module_alloc. */
 void module_memfree(void *module_region);
 
+/* Determines if the section name is an init section (that is only used during
+ * module loading).
+ */
+bool module_init_section(const char *name);
+
 /* Determines if the section name is an exit section (that is only used during
  * module unloading)
  */
diff --git a/kernel/module.c b/kernel/module.c
index 33569a01d6e1..84d0c455fb44 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2400,7 +2400,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
-			    || strstarts(sname, ".init"))
+			    || module_init_section(sname))
 				continue;
 			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
 			pr_debug("\t%s\n", sname);
@@ -2433,7 +2433,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
-			    || !strstarts(sname, ".init"))
+			    || !module_init_section(sname))
 				continue;
 			s->sh_entsize = (get_offset(mod, &mod->init_layout.size, s, i)
 					 | INIT_OFFSET_MASK);
@@ -2768,6 +2768,11 @@ void * __weak module_alloc(unsigned long size)
 	return vmalloc_exec(size);
 }
 
+bool __weak module_init_section(const char *name)
+{
+	return strstarts(name, ".init");
+}
+
 bool __weak module_exit_section(const char *name)
 {
 	return strstarts(name, ".exit");
-- 
2.25.1

