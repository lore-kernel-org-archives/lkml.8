Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121AFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D769C2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8Frfs00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFKVz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFKVzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:55:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4138C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+D9mFCAnJgtDS6+KSuSp9KevNloc9SQBHaGYlbUhzxw=; b=e8Frfs00IgsoISCL466iUeylVG
        LE8eTack0LgJO8TxkyecTWPER3qIBmjii3hRdEx+90pn4cLu4WK84K9a9IMfpTce1QdJaRmmZxIjl
        gWKjNOU0EBlpkJXoLps1+vOqhjMNGlhTJb/fhXplxUocDfesnHevRuoArCO5KZXhO49JGakluIadL
        YoNeZbP09nIOBrNBCKinveqVpR8fMNcLH+vDVmFI7vTm9G42Q/kHXCDcFYonSXOgn36kP1mnIJjem
        PoPlTyMdHVeVX8/SZr9+kWup0SKdH/N3eBGRGWHWyxE82X8mXb7EEgy19TjgezR3T/0LuDhjAb3N6
        Cy6N0xVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjVAi-0001nI-WD; Thu, 11 Jun 2020 21:55:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 755FB984C19; Thu, 11 Jun 2020 23:55:38 +0200 (CEST)
Date:   Thu, 11 Jun 2020 23:55:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200611215538.GE4496@worktop.programming.kicks-ass.net>
References: <20200605082839.226418-1-elver@google.com>
 <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
 <20200605120352.GJ3976@hirez.programming.kicks-ass.net>
 <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
 <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com>
 <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
 <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608110108.GB2497@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 01:01:08PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 08, 2020 at 09:57:39AM +0200, Dmitry Vyukov wrote:
> 
> > As a crazy idea: is it possible to employ objtool (linker script?) to
> > rewrite all coverage calls to nops in the noinstr section? Or relocate
> > to nop function?
> > What we are trying to do is very static, it _should_ have been done
> > during build. We don't have means in existing _compilers_ to do this,
> > but maybe we could do it elsewhere during build?...
> 
> Let me try and figure out how to make objtool actually rewrite code.

The below is quite horrific but seems to sorta work.


It turns this:

  12:   e8 00 00 00 00          callq  17 <lockdep_hardirqs_on+0x17>
                        13: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4

Into this:

  12:   90                      nop
  13:   90                      nop
                        13: R_X86_64_NONE       __sanitizer_cov_trace_pc-0x4
  14:   90                      nop
  15:   90                      nop
  16:   90                      nop


I'll have to dig around a little more to see if I can't get rid of the
relocation entirely. Also, I need to steal better arch_nop_insn() from
the kernel :-)

---
 tools/objtool/arch.h            |  2 ++
 tools/objtool/arch/x86/decode.c | 24 ++++++++++++++++++++++
 tools/objtool/check.c           | 15 +++++++++++++-
 tools/objtool/elf.c             | 45 ++++++++++++++++++++++++++++++++++++++++-
 tools/objtool/elf.h             | 11 ++++++++--
 5 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index eda15a5a285e..3c5967748abb 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -84,4 +84,6 @@ unsigned long arch_jump_destination(struct instruction *insn);

 unsigned long arch_dest_rela_offset(int addend);

+const char *arch_nop_insn(int len);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 4b504fc90bbb..b615c32e21db 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -565,3 +565,27 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->regs[16].base = CFI_CFA;
 	state->regs[16].offset = -8;
 }
+
+const char *arch_nop_insn(int len)
+{
+	static const char insn[16] = {
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+		0x90,
+	};
+
+	return insn;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5fbb90a80d23..487b4dc3d122 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -765,6 +765,17 @@ static int add_call_destinations(struct objtool_file *file)
 		} else
 			insn->call_dest = rela->sym;

+		if (insn->sec->noinstr &&
+		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+			if (rela)
+				elf_write_rela(file->elf, rela);
+
+			elf_write_insn(file->elf, insn->sec,
+				       insn->offset, insn->len,
+				       arch_nop_insn(insn->len));
+			insn->type = INSN_NOP;
+		}
+
 		/*
 		 * Whatever stack impact regular CALLs have, should be undone
 		 * by the RETURN of the called function.
@@ -2802,11 +2813,13 @@ int check(const char *_objname, bool orc)
 		if (ret < 0)
 			goto out;

+	}
+
+	if (file.elf->changed) {
 		ret = elf_write(file.elf);
 		if (ret < 0)
 			goto out;
 	}
-
 out:
 	if (ret < 0) {
 		/*
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 84225679f96d..705582729374 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -525,6 +525,7 @@ static int read_relas(struct elf *elf)
 				return -1;
 			}

+			rela->idx = i;
 			rela->type = GELF_R_TYPE(rela->rela.r_info);
 			rela->addend = rela->rela.r_addend;
 			rela->offset = rela->rela.r_offset;
@@ -713,6 +714,8 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));

+	elf->changed = true;
+
 	return sec;
 }

@@ -779,7 +782,43 @@ int elf_rebuild_rela_section(struct section *sec)
 	return 0;
 }

-int elf_write(const struct elf *elf)
+int elf_write_insn(struct elf *elf, struct section *sec,
+		   unsigned long offset, unsigned int len,
+		   const char *insn)
+{
+	Elf_Data *data = sec->data;
+
+	if (data->d_type != ELF_T_BYTE || data->d_off) {
+		printf("ponies\n");
+		return -1;
+	}
+
+	memcpy(sec->data->d_buf + offset, insn, len);
+
+	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
+
+	sec->changed = true;
+	elf->changed = true;
+
+	return 0;
+}
+
+int elf_write_rela(struct elf *elf, struct rela *rela)
+{
+	struct section *sec = rela->sec;
+
+	rela->rela.r_info = 0;
+	rela->rela.r_addend = 0;
+
+	gelf_update_rela(sec->data, rela->idx, &rela->rela);
+
+	sec->changed = true;
+	elf->changed = true;
+
+	return 0;
+}
+
+int elf_write(struct elf *elf)
 {
 	struct section *sec;
 	Elf_Scn *s;
@@ -796,6 +835,8 @@ int elf_write(const struct elf *elf)
 				WARN_ELF("gelf_update_shdr");
 				return -1;
 			}
+
+			sec->changed = false;
 		}
 	}

@@ -808,6 +849,8 @@ int elf_write(const struct elf *elf)
 		return -1;
 	}

+	elf->changed = false;
+
 	return 0;
 }

diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index f4fe1d6ea392..4a3fe4f455c5 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -64,9 +64,10 @@ struct rela {
 	GElf_Rela rela;
 	struct section *sec;
 	struct symbol *sym;
-	unsigned int type;
 	unsigned long offset;
+	unsigned int type;
 	int addend;
+	int idx;
 	bool jump_table_start;
 };

@@ -76,6 +77,7 @@ struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	int fd;
+	bool changed;
 	char *name;
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
@@ -118,7 +120,7 @@ struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 void elf_add_rela(struct elf *elf, struct rela *rela);
-int elf_write(const struct elf *elf);
+int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);

 struct section *find_section_by_name(const struct elf *elf, const char *name);
@@ -132,6 +134,11 @@ struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 int elf_rebuild_rela_section(struct section *sec);

+int elf_write_rela(struct elf *elf, struct rela *rela);
+int elf_write_insn(struct elf *elf, struct section *sec,
+		   unsigned long offset, unsigned int len,
+		   const char *insn);
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)


