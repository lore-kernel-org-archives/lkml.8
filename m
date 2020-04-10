Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17198C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F120C20769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgDJTjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:39:04 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:28742 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbgDJTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:39:03 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:38:59 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 3966DB2C9B;
        Fri, 10 Apr 2020 15:39:03 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 29/36] objtool: mcount: Reduce usage of _size wrapper
Date:   Fri, 10 Apr 2020 12:35:52 -0700
Message-ID: <395fa2069e8280d57c1509bdbac9eafb1c6badf9.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use loc_size, which will be passed in from outside the wrapper, rather
than the _size wrapper since the location size is determined outside
the wrapper anyway.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 9ce2d74df89a..353c7d082631 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -72,6 +72,7 @@ static int append_func(uint_t const *const mloc0,
 			uint_t const *const mlocp,
 			Elf_Rel const *const mrel0,
 			Elf_Rel const *const mrelp,
+			unsigned int const loc_size,
 			unsigned int const rel_entsize,
 			unsigned int const symsec_sh_link)
 {
@@ -83,14 +84,14 @@ static int append_func(uint_t const *const mloc0,
 	unsigned const old_shnum = lf->ehdr.e_shnum;
 
 	/* add section: __mcount_loc */
-	sec = elf_create_section(lf, mc_name + (sizeof(Elf_Rela) == rel_entsize) + strlen(".rel"), _size, mlocp - mloc0);
+	sec = elf_create_section(lf, mc_name + (sizeof(Elf_Rela) == rel_entsize) + strlen(".rel"), loc_size, mlocp - mloc0);
 	if (!sec)
 		return -1;
 
 	// created sec->sh.sh_size = (void *)mlocp - (void *)mloc0;
 	sec->sh.sh_link = 0;/* TODO objtool uses this? */
 	sec->sh.sh_info = 0;/* TODO objtool uses this? */
-	sec->sh.sh_addralign = _size;
+	sec->sh.sh_addralign = loc_size;
 	// created sec->sh.sh_entsize = _size;
 
 	// assert sec->data->d_size == (void *)mlocp - (void *)mloc0
@@ -109,7 +110,7 @@ static int append_func(uint_t const *const mloc0,
 	sec->sh.sh_flags = 0;
 	sec->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
 	sec->sh.sh_info = old_shnum;
-	sec->sh.sh_addralign = _size;
+	sec->sh.sh_addralign = loc_size;
 
 	// assert sec->data->d_size == (void *)mrelp - (void *)mrel0
 	memcpy(sec->data->d_buf, mrel0, sec->data->d_size);
@@ -231,7 +232,7 @@ static int do_func(unsigned const reltype)
 	}
 	if (!result && mloc0 != mlocp)
 		result = append_func(mloc0, mlocp, mrel0, mrelp,
-				     rel_entsize, symsec_sh_link);
+				     _size, rel_entsize, symsec_sh_link);
 out:
 	free(mrel0);
 	free(mloc0);
-- 
2.20.1

