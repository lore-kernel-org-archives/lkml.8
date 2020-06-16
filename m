Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB842C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8534720656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C1BbaxJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgFPIcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:32:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD737C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QjseRY7ePwYJxBy+fzhqff7/CBSWJFymIkTnxqjIliE=; b=C1BbaxJPdFl/eQTKVsRJzm8Z4e
        j3RkSN7q0/+ytMV4qxjz8Ti0Cz398+1XYFApw1UxjuzSrLDG/BsreMfsGP19NJKlzJjtKU1hgjpS7
        BpWAvoWAabXUDvM2j1vuwv4OFc51crqDML5GNPw9RTIKRGGrjab0pReFkeuRaDUIt/h/aRfXrwsl6
        DCbtW+UYmcSYMCCMBGj0f2AYUIFIVR6pbXa3DVc2jDbMGrSkoc5JqB4zG5JUNNYeXWcKXysY0/Hmz
        7HiTtjyweivTTAgdYEf2oYmMmeIc894alYL9vK9NgZpmdHP2JOzTtOYkAnhN803B3xMP59BxzDvn1
        xyr/lX/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl71I-0000wY-BF; Tue, 16 Jun 2020 08:32:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9AF0E30018A;
        Tue, 16 Jun 2020 10:32:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 801CA2B9CA58C; Tue, 16 Jun 2020 10:32:33 +0200 (CEST)
Date:   Tue, 16 Jun 2020 10:32:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        rostedt@goodmis.org, jthierry@redhat.com, mbenes@suse.cz
Subject: Re: [RFC][PATCH 1/3] objtool: Clean up elf_write() condition
Message-ID: <20200616083233.GK2554@hirez.programming.kicks-ass.net>
References: <20200612143034.933422660@infradead.org>
 <20200612143553.953897818@infradead.org>
 <20200615183448.GD25598@rlwimi.vmware.com>
 <20200615184411.GH2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615184411.GH2531@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:44:11PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 11:34:48AM -0700, Matt Helsley wrote:
> > On Fri, Jun 12, 2020 at 04:30:35PM +0200, Peter Zijlstra wrote:
> > > With there being multiple ways to change the ELF data, let's more
> > > concisely track modification.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Would it make sense to set the relocation section's "changed" flag in
> > addition to the elf struct's changed flag in elf_rebuild_reloc_section()?
> > 
> > Right now I think the code is  assuming that it's a newly created section
> > but it would be more defensive to set it during a rebuild too I think.
> 
> Indeed, currently the code assumes (and this is so) elf_rebuild_rela_sections()
> is only called on an elf_create_reloc_section() result and thus setting
> ->changed is superfluous.
> 
> But sure, I can certainly set them there too.

Delta to the patch.

---
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2740,7 +2740,7 @@ int check(const char *_objname, bool orc
 
 	objname = _objname;
 
-	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_open_read(objname, O_RDWR);
 	if (!file.elf)
 		return 1;
 
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -849,11 +849,14 @@ static int elf_rebuild_rela_section(stru
 	return 0;
 }
 
-int elf_rebuild_reloc_section(struct section *sec)
+int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
 {
 	struct reloc *reloc;
 	int nr;
 
+	sec->changed = true;
+	elf->changed = true;
+
 	nr = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list)
 		nr++;
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -134,7 +134,7 @@ struct reloc *find_reloc_by_dest(const s
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-int elf_rebuild_reloc_section(struct section *sec);
+int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -222,7 +222,7 @@ int create_orc_sections(struct objtool_f
 		}
 	}
 
-	if (elf_rebuild_reloc_section(ip_relocsec))
+	if (elf_rebuild_reloc_section(file->elf, ip_relocsec))
 		return -1;
 
 	return 0;
