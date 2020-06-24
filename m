Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3AAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A711F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="DXAh2wXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbgFXKbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:31:21 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:45062 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390426AbgFXKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MhilK+5yFBA9gA1Z99SmE0wSieum1HedI7jJOXoMoVI=; b=DXAh2wXGYMmrVa/8kJ7KQBm2Yx
        16nW+edFkp6kBVQ6hOd36MGXVPkJHHZexl+ZXrmQ9sUdJ98vCWSBqQwGNNzj3lYc4FgrpeBiDS/2l
        GCTk4rtOeQ0rtKB4MK3zIT8zsDy+X2it0zgDeQC4QAcj5ufQGkYJakm6vAppnJhiPpR4=;
Received: from lfbn-mar-1-578-97.w109-208.abo.wanadoo.fr ([109.208.124.97] helo=xps9380.mn.codeweavers.com)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1jo2gT-0007lh-3O; Wed, 24 Jun 2020 05:31:15 -0500
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
Subject: [PATCH 2/3] perf symbols: Try reading the symbol table with libbfd
Date:   Wed, 24 Jun 2020 12:30:40 +0200
Message-Id: <20200624103041.825746-2-rbernon@codeweavers.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624103041.825746-1-rbernon@codeweavers.com>
References: <20200624103041.825746-1-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wine generates PE binaries for its code modules and also generates
debug files in PE or PDB formats, which perf cannot parse either.

Trying libbfd, when supported, if the default libelf symbol parsing
failed, makes it possible to read the symbol table from any binary
format supported by it, and lets perf report symbols and annotations
for Windows applications running under Wine.

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
 tools/perf/util/symbol.c | 129 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/symbol.h |   4 ++
 2 files changed, 133 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5ddf84dcbae7..4bece3543ce4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1523,6 +1523,127 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
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
+		if (!(sym->flags & (BSF_GLOBAL)))
+			continue;
+
+		while (i + 1 < symbols_count &&
+		       bfd_asymbol_section(symbols[i + 1]) == section &&
+		       !(symbols[i + 1]->flags & BSF_GLOBAL))
+			i++;
+
+		if (i + 1 < symbols_count &&
+		    bfd_asymbol_section(symbols[i + 1]) == section)
+			len = symbols[i + 1]->value - sym->value;
+		else
+			len = section->size - sym->value;
+
+		start = bfd_asymbol_value(sym) - dso->text_offset;
+		symbol = symbol__new(start, len, STB_GLOBAL, STT_FUNC,
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
@@ -1695,6 +1816,7 @@ int dso__load(struct dso *dso, struct map *map)
 		bool next_slot = false;
 		bool is_reg;
 		bool nsexit;
+		int bfdrc = -1;
 		int sirc = -1;
 
 		enum dso_binary_type symtab_type = binary_type_symtab[i];
@@ -1713,12 +1835,19 @@ int dso__load(struct dso *dso, struct map *map)
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
2.27.0

