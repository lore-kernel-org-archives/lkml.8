Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1771CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C0020738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iXWOUX/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgEUTya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:54:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B30C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:54:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci23so3704813pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MFKpA6aTlCGxhXsiKhqezltCMxhN/Qwxr7U8Pw6kgeE=;
        b=iXWOUX/nBq5cX3Kx6HaPVvP+vqyI+jHk547Ivd0Uwev8axS4rIdUQniFWZfRqgdydR
         f5DKr3OPVXSZ4/+RbIy6zOLyY2X6fRST/GvxrwxHJXDyT0tQlaldUeDVWlgIjPMvjNol
         w9GRKhH1UAFj+N+JnCcyO07szC8R9hrpI2dBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MFKpA6aTlCGxhXsiKhqezltCMxhN/Qwxr7U8Pw6kgeE=;
        b=igU3a99vdeLbAf6XkG83hh1iLr8qVKzVB+3yPPnlK24wUWVCYMsFIwd4yNw4NzirXJ
         sKFJa+hprlCpjooQHDYzI6SDtBftCefqyOLdwWWmDX8RgOB3FIHPwXiHEP/rAWK0h7Kx
         S2S1oB7Elwe2rK8fLi4g68ZqfFgq47nrESqpF7X/0Y8GIoe4PeHaGDMEjZOoq289nUwP
         sS/1/JPcBtGip8E9H89WWoWYTtDN89i8ICiPe3TgXlANjRQv34iCTNP4sWQcKuutbfhO
         UKWiwQyNODFmsD5xeGG+4R0Pq27vS7DdEBF9oWaN+02zD6DQ4wkY77/LVLKhCCNeEJfk
         F74w==
X-Gm-Message-State: AOAM532MkVuGnfrGKgk1JcGYo9F+l9O7m6EbRp63DaLkWDAQd8lNT0Sg
        4IzV3242OSl+9NBxlzjwlwj1nQ==
X-Google-Smtp-Source: ABdhPJxRpmG+HTLAsvOr4x77aZJd41DYQoj9UQfxQ+CPvdIZBXXhFFxl6qdSaOMSgXXGYthGjMLSow==
X-Received: by 2002:a17:90a:264c:: with SMTP id l70mr223791pje.18.1590090869094;
        Thu, 21 May 2020 12:54:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q25sm5310797pff.69.2020.05.21.12.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 12:54:28 -0700 (PDT)
Date:   Thu, 21 May 2020 12:54:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 6/9] x86/tools: Add relative relocs for randomized
 functions
Message-ID: <202005211248.481426AD6C@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
 <20200521165641.15940-7-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521165641.15940-7-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 09:56:37AM -0700, Kristen Carlson Accardi wrote:
> When reordering functions, the relative offsets for relocs that
> are either in the randomized sections, or refer to the randomized
> sections will need to be adjusted. Add code to detect whether a
> reloc satisifies these cases, and if so, add them to the appropriate
> reloc list.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>

I'm just down to bikeshedding here (see below).

> ---
>  arch/x86/boot/compressed/Makefile |  7 +++-
>  arch/x86/tools/relocs.c           | 55 ++++++++++++++++++++++++-------
>  arch/x86/tools/relocs.h           |  4 +--
>  arch/x86/tools/relocs_common.c    | 15 ++++++---
>  4 files changed, 62 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 5f7c262bcc99..3a5a004498de 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -117,6 +117,11 @@ $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>  	$(call if_changed,check-and-link-vmlinux)
>  
>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
> +
> +ifdef CONFIG_FG_KASLR
> +	RELOCS_ARGS += --fg-kaslr
> +endif
> +
>  $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
> @@ -124,7 +129,7 @@ targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relo
>  
>  CMD_RELOCS = arch/x86/tools/relocs
>  quiet_cmd_relocs = RELOCS  $@
> -      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
> +      cmd_relocs = $(CMD_RELOCS) $(RELOCS_ARGS) $< > $@;$(CMD_RELOCS) $(RELOCS_ARGS) --abs-relocs $<
>  $(obj)/vmlinux.relocs: vmlinux FORCE
>  	$(call if_changed,relocs)
>  
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index a00dc133f109..bf51ff1854ff 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -42,6 +42,8 @@ struct section {
>  };
>  static struct section *secs;
>  
> +static int fg_kaslr;

I find the shifting name for fg_kaslr, fgkaslr, and global fg_kaslr
confusing. I think it would call this one "fgkaslr_mode" to indicate
that it does control the mode of how the later functions behave.

> +
>  static const char * const sym_regex_kernel[S_NSYMTYPES] = {
>  /*
>   * Following symbols have been audited. There values are constant and do
> @@ -351,8 +353,8 @@ static int sym_index(Elf_Sym *sym)
>  		return sym->st_shndx;
>  
>  	/* calculate offset of sym from head of table. */
> -	offset = (unsigned long) sym - (unsigned long) symtab;
> -	index = offset/sizeof(*sym);
> +	offset = (unsigned long)sym - (unsigned long)symtab;
> +	index = offset / sizeof(*sym);
>  
>  	return elf32_to_cpu(xsymtab[index]);
>  }
> @@ -500,22 +502,22 @@ static void read_symtabs(FILE *fp)
>  			sec->xsymtab = malloc(sec->shdr.sh_size);
>  			if (!sec->xsymtab) {
>  				die("malloc of %d bytes for xsymtab failed\n",
> -					sec->shdr.sh_size);
> +				    sec->shdr.sh_size);
>  			}
>  			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
>  				die("Seek to %d failed: %s\n",
> -					sec->shdr.sh_offset, strerror(errno));
> +				    sec->shdr.sh_offset, strerror(errno));
>  			}
>  			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp)
> -					!= sec->shdr.sh_size) {
> +			    != sec->shdr.sh_size) {
>  				die("Cannot read extended symbol table: %s\n",
> -					strerror(errno));
> +				    strerror(errno));
>  			}
>  			shxsymtabndx = i;
>  			continue;
>  
>  		case SHT_SYMTAB:
> -			num_syms = sec->shdr.sh_size/sizeof(Elf_Sym);
> +			num_syms = sec->shdr.sh_size / sizeof(Elf_Sym);
>  
>  			sec->symtab = malloc(sec->shdr.sh_size);
>  			if (!sec->symtab) {

I would mention these whitespace/readability cleanups in the commit log.

> @@ -818,6 +820,32 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
>  		strncmp(symname, "init_per_cpu_", 13);
>  }
>  
> +static int is_function_section(struct section *sec)
> +{
> +	const char *name;
> +
> +	if (!fg_kaslr)
> +		return 0;
> +
> +	name = sec_name(sec->shdr.sh_info);
> +
> +	return(!strncmp(name, ".text.", 6));
> +}
> +
> +static int is_randomized_sym(ElfW(Sym) *sym)
> +{
> +	const char *name;
> +
> +	if (!fg_kaslr)
> +		return 0;
> +
> +	if (sym->st_shndx > shnum)
> +		return 0;
> +
> +	name = sec_name(sym_index(sym));
> +	return(!strncmp(name, ".text.", 6));
> +}
> +
>  static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
>  		      const char *symname)
>  {
> @@ -842,13 +870,17 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
>  	case R_X86_64_PC32:
>  	case R_X86_64_PLT32:
>  		/*
> -		 * PC relative relocations don't need to be adjusted unless
> -		 * referencing a percpu symbol.
> +		 * we need to keep pc relative relocations for sections which
> +		 * might be randomized, and for the percpu section.
> +		 * We also need to keep relocations for any offset which might
> +		 * reference an address in a section which has been randomized.
>  		 *
>  		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
>  		 */
> -		if (is_percpu_sym(sym, symname))
> +		if (is_function_section(sec) || is_randomized_sym(sym) ||
> +		    is_percpu_sym(sym, symname))
>  			add_reloc(&relocs32neg, offset);
> +
>  		break;
>  
>  	case R_X86_64_PC64:
> @@ -1158,8 +1190,9 @@ static void print_reloc_info(void)
>  
>  void process(FILE *fp, int use_real_mode, int as_text,
>  	     int show_absolute_syms, int show_absolute_relocs,
> -	     int show_reloc_info)
> +	     int show_reloc_info, int fgkaslr)
>  {
> +	fg_kaslr = fgkaslr;

Then this becomes a bit more readable:

	fgkaslr_mode = fgkaslr;

>  	regex_init(use_real_mode);
>  	read_ehdr(fp);
>  	read_shdrs(fp);
> diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
> index 43c83c0fd22c..05504052c846 100644
> --- a/arch/x86/tools/relocs.h
> +++ b/arch/x86/tools/relocs.h
> @@ -31,8 +31,8 @@ enum symtype {
>  
>  void process_32(FILE *fp, int use_real_mode, int as_text,
>  		int show_absolute_syms, int show_absolute_relocs,
> -		int show_reloc_info);
> +		int show_reloc_info, int fg_kaslr);
>  void process_64(FILE *fp, int use_real_mode, int as_text,
>  		int show_absolute_syms, int show_absolute_relocs,
> -		int show_reloc_info);
> +		int show_reloc_info, int fg_kaslr);

I think the prototype and declaration should have matching names:
fgkaslr in "process" and fg_kaslr here. I suggest just calling it
fgkaslr in all.

>  #endif /* RELOCS_H */
> diff --git a/arch/x86/tools/relocs_common.c b/arch/x86/tools/relocs_common.c
> index 6634352a20bc..1407db72367a 100644
> --- a/arch/x86/tools/relocs_common.c
> +++ b/arch/x86/tools/relocs_common.c
> @@ -12,14 +12,14 @@ void die(char *fmt, ...)
>  
>  static void usage(void)
>  {
> -	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode]" \
> -	    " vmlinux\n");
> +	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode|" \
> +	    "--fg-kaslr] vmlinux\n");
>  }
>  
>  int main(int argc, char **argv)
>  {
>  	int show_absolute_syms, show_absolute_relocs, show_reloc_info;
> -	int as_text, use_real_mode;
> +	int as_text, use_real_mode, fg_kaslr;

And I think I'd call this one fgkaslr_opt to show it comes from the opt
parsing.

>  	const char *fname;
>  	FILE *fp;
>  	int i;
> @@ -30,6 +30,7 @@ int main(int argc, char **argv)
>  	show_reloc_info = 0;
>  	as_text = 0;
>  	use_real_mode = 0;
> +	fg_kaslr = 0;
>  	fname = NULL;
>  	for (i = 1; i < argc; i++) {
>  		char *arg = argv[i];
> @@ -54,6 +55,10 @@ int main(int argc, char **argv)
>  				use_real_mode = 1;
>  				continue;
>  			}
> +			if (strcmp(arg, "--fg-kaslr") == 0) {
> +				fg_kaslr = 1;
> +				continue;
> +			}
>  		}
>  		else if (!fname) {
>  			fname = arg;
> @@ -75,11 +80,11 @@ int main(int argc, char **argv)
>  	if (e_ident[EI_CLASS] == ELFCLASS64)
>  		process_64(fp, use_real_mode, as_text,
>  			   show_absolute_syms, show_absolute_relocs,
> -			   show_reloc_info);
> +			   show_reloc_info, fg_kaslr);
>  	else
>  		process_32(fp, use_real_mode, as_text,
>  			   show_absolute_syms, show_absolute_relocs,
> -			   show_reloc_info);
> +			   show_reloc_info, fg_kaslr);
>  	fclose(fp);
>  	return 0;
>  }
> -- 
> 2.20.1
> 

With these changes, yeah, I think it's good to go.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
