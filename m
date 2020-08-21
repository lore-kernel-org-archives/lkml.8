Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E1DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5EB20702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="M+3DnEIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgHUQzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:55:37 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:59238 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgHUQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AA7lGGivbZPmA7QrszqepmyBkBD8US4csbOn6MBTBkc=; b=M+3DnEIY52DM4oipnTQr3NNJcV
        FgbEhUerDYX8J9c0Ls4XZJeK6sVb7DbqcKp1pkWdngNi/flaV2rUot5vuZ+DVhHf/6nVApGrMBiHm
        nI+jB2uIOz6ROax+QCt2XecNbj1Yst4ne0P3GO5pi68UdMVDxeXm0TsW2+BdAZUGyENw=;
Received: from lfbn-mar-1-577-251.w109-208.abo.wanadoo.fr ([109.208.123.251] helo=xps9380.mn.codeweavers.com)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1k9AHo-0003jO-6H; Fri, 21 Aug 2020 11:53:06 -0500
From:   Remi Bernon <rbernon@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     Remi Bernon <rbernon@codeweavers.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: [PATCH v3 2/3] perf symbols: Try reading the symbol table with libbfd
Date:   Fri, 21 Aug 2020 18:52:37 +0200
Message-Id: <20200821165238.1340315-2-rbernon@codeweavers.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821165238.1340315-1-rbernon@codeweavers.com>
References: <20200821165238.1340315-1-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wine generates PE binaries for its code modules and also generates
debug files in PE or PDB formats, which perf cannot parse either.

Trying to read symbols on non-ELF binaries with libbfd, when supported,
makes it possible for perf to report symbols and annotations for Windows
applications running under Wine.

Because libbfd doesn't provide symbol size (probably because of some
backends not supporting it), we compute it by first sorting the symbols
by addresses and then considering that they are sequential in a given
section.

Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jacek Caban <jacek@codeweavers.com>
---

v3: Also include local and weak bfd symbols and mark them as such, only
    global symbols were previously reported, and that caused a very
    imprecise address to symbol resolution.

 tools/perf/util/symbol.c | 140 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/symbol.h |   4 ++
 2 files changed, 144 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1f5fcb828a21..55023d301eb9 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1525,6 +1525,138 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 	return -1;
 }
 
+#ifdef HAVE_LIBBFD_SUPPORT
+#define PACKAGE 'perf'
+#include <bfd.h>
+
+static int bfd_symbols__cmpvalue(const void *a, const void *b)
+{
+	const asymbol *as = *(const asymbol **)a, *bs = *(const asymbol **)b;
+
+	if (bfd_asymbol_value(as) != bfd_asymbol_value(bs))
+		return bfd_asymbol_value(as) - bfd_asymbol_value(bs);
+
+	return bfd_asymbol_name(as)[0] - bfd_asymbol_name(bs)[0];
+}
+
+static int bfd2elf_binding(asymbol *symbol)
+{
+	if (symbol->flags & BSF_WEAK)
+		return STB_WEAK;
+	if (symbol->flags & BSF_GLOBAL)
+		return STB_GLOBAL;
+	if (symbol->flags & BSF_LOCAL)
+		return STB_LOCAL;
+	return -1;
+}
+
+int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
+{
+	int err = -1;
+	long symbols_size, symbols_count;
+	asection *section;
+	asymbol **symbols, *sym;
+	struct symbol *symbol;
+	bfd *abfd;
+	u_int i;
+	u64 start, len;
+
+	abfd = bfd_openr(dso->long_name, NULL);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
+			  dso->long_name);
+		goto out_close;
+	}
+
+	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
+		goto out_close;
+
+	section = bfd_get_section_by_name(abfd, ".text");
+	if (section)
+		dso->text_offset = section->vma - section->filepos;
+
+	bfd_close(abfd);
+
+	abfd = bfd_openr(debugfile, NULL);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
+			  debugfile);
+		goto out_close;
+	}
+
+	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
+		goto out_close;
+
+	symbols_size = bfd_get_symtab_upper_bound(abfd);
+	if (symbols_size == 0) {
+		bfd_close(abfd);
+		return 0;
+	}
+
+	if (symbols_size < 0)
+		goto out_close;
+
+	symbols = malloc(symbols_size);
+	if (!symbols)
+		goto out_close;
+
+	symbols_count = bfd_canonicalize_symtab(abfd, symbols);
+	if (symbols_count < 0)
+		goto out_free;
+
+	qsort(symbols, symbols_count, sizeof(asymbol *), bfd_symbols__cmpvalue);
+
+#ifdef bfd_get_section
+#define bfd_asymbol_section bfd_get_section
+#endif
+	for (i = 0; i < symbols_count; ++i) {
+		sym = symbols[i];
+		section = bfd_asymbol_section(sym);
+		if (bfd2elf_binding(sym) < 0)
+			continue;
+
+		while (i + 1 < symbols_count &&
+		       bfd_asymbol_section(symbols[i + 1]) == section &&
+		       bfd2elf_binding(symbols[i + 1]) < 0)
+			i++;
+
+		if (i + 1 < symbols_count &&
+		    bfd_asymbol_section(symbols[i + 1]) == section)
+			len = symbols[i + 1]->value - sym->value;
+		else
+			len = section->size - sym->value;
+
+		start = bfd_asymbol_value(sym) - dso->text_offset;
+		symbol = symbol__new(start, len, bfd2elf_binding(sym), STT_FUNC,
+				     bfd_asymbol_name(sym));
+		if (!symbol)
+			goto out_free;
+
+		symbols__insert(&dso->symbols, symbol);
+	}
+#ifdef bfd_get_section
+#undef bfd_asymbol_section
+#endif
+
+	symbols__fixup_end(&dso->symbols);
+	symbols__fixup_duplicate(&dso->symbols);
+	dso->adjust_symbols = 1;
+
+	err = 0;
+out_free:
+	free(symbols);
+out_close:
+	bfd_close(abfd);
+	return err;
+}
+#endif
+
 static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 					   enum dso_binary_type type)
 {
@@ -1698,6 +1830,7 @@ int dso__load(struct dso *dso, struct map *map)
 		bool next_slot = false;
 		bool is_reg;
 		bool nsexit;
+		int bfdrc = -1;
 		int sirc = -1;
 
 		enum dso_binary_type symtab_type = binary_type_symtab[i];
@@ -1716,12 +1849,19 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_exit(&nsc);
 
 		is_reg = is_regular_file(name);
+#ifdef HAVE_LIBBFD_SUPPORT
 		if (is_reg)
+			bfdrc = dso__load_bfd_symbols(dso, name);
+#endif
+		if (is_reg && bfdrc < 0)
 			sirc = symsrc__init(ss, dso, name, symtab_type);
 
 		if (nsexit)
 			nsinfo__mountns_enter(dso->nsinfo, &nsc);
 
+		if (bfdrc == 0)
+			break;
+
 		if (!is_reg || sirc < 0)
 			continue;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index ff4f4c47e148..11fe71f46d14 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -175,6 +175,10 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 
 struct symsrc;
 
+#ifdef HAVE_LIBBFD_SUPPORT
+int dso__load_bfd_symbols(struct dso *dso, const char *debugfile);
+#endif
+
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule);
 int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
-- 
2.28.0

