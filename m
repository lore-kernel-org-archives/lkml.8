Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778E9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4893220663
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4OxfvCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbgEZLzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:55:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389011AbgEZLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590494152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dcHb9rId3LSWGcaShxrawIsywqEkkwASdvRerLVoJI4=;
        b=h4OxfvCSQqhkBhVHPnd6DKXNPQJjU2a9hbPgkVGFx+aHUrqYDhSlJVnoq4dRXicsLw2oQq
        cEak0a3EZU03ugbdJdu5D2MCmop6TL8N2SCYONOI+zPgvY85GrXwt9mA+rIIzvxyv9Ag4F
        /rCL3EqmoIkyWIKec/45iJYdEK+W+Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-__oP2Sm_OIe7HEDv48sWDg-1; Tue, 26 May 2020 07:55:51 -0400
X-MC-Unique: __oP2Sm_OIe7HEDv48sWDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BFEE1005510;
        Tue, 26 May 2020 11:55:49 +0000 (UTC)
Received: from krava (unknown [10.40.195.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id 368AE5C1BB;
        Tue, 26 May 2020 11:55:48 +0000 (UTC)
Date:   Tue, 26 May 2020 13:55:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jvmti: remove redundant jitdump line table entries
Message-ID: <20200526115547.GF333164@krava>
References: <20200522065330.34872-1-nick.gasson@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522065330.34872-1-nick.gasson@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 02:53:30PM +0800, Nick Gasson wrote:
> For each PC/BCI pair in the JVMTI compiler inlining record table, the
> jitdump plugin emits debug line table entries for every source line in
> the method preceding that BCI. Instead only emit one source line per
> PC/BCI pair. Reported by Ian Rogers. This reduces the .dump size for
> SPECjbb from ~230MB to ~40MB.
> 
> Also fix an error in the DWARF line table state machine where addresses
> are incorrectly offset by -0x40 (GEN_ELF_TEXT_OFFSET). This can be seen
> with `objdump -S` on the ELF files after perf inject.

hi,
I can't apply this on latest Arnaldo's perf/core:

patching file jvmti/libjvmti.c
Hunk #1 FAILED at 32.
Hunk #2 succeeded at 67 (offset -4 lines).
Hunk #3 FAILED at 85.
Hunk #4 succeeded at 114 (offset -7 lines).

jirka

> 
> Signed-off-by: Nick Gasson <nick.gasson@arm.com>
> ---
>  tools/perf/jvmti/libjvmti.c    | 73 +++++++++++++---------------------
>  tools/perf/util/genelf_debug.c |  4 +-
>  2 files changed, 30 insertions(+), 47 deletions(-)
> 
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index a9a056d68416..398e4ba6498d 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -32,38 +32,41 @@ static void print_error(jvmtiEnv *jvmti, const char *msg, jvmtiError ret)
>  
>  #ifdef HAVE_JVMTI_CMLR
>  static jvmtiError
> -do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
> -		    jvmti_line_info_t *tab, jint *nr)
> +do_get_line_number(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
> +		   jvmti_line_info_t *tab)
>  {
> -	jint i, lines = 0;
> -	jint nr_lines = 0;
> +	jint i, nr_lines = 0;
>  	jvmtiLineNumberEntry *loc_tab = NULL;
>  	jvmtiError ret;
> +	jint src_line = -1;
>  
>  	ret = (*jvmti)->GetLineNumberTable(jvmti, m, &nr_lines, &loc_tab);
>  	if (ret == JVMTI_ERROR_ABSENT_INFORMATION || ret == JVMTI_ERROR_NATIVE_METHOD) {
>  		/* No debug information for this method */
> -		*nr = 0;
> -		return JVMTI_ERROR_NONE;
> +		return ret;
>  	} else if (ret != JVMTI_ERROR_NONE) {
>  		print_error(jvmti, "GetLineNumberTable", ret);
>  		return ret;
>  	}
>  
> -	for (i = 0; i < nr_lines; i++) {
> -		if (loc_tab[i].start_location < bci) {
> -			tab[lines].pc = (unsigned long)pc;
> -			tab[lines].line_number = loc_tab[i].line_number;
> -			tab[lines].discrim = 0; /* not yet used */
> -			tab[lines].methodID = m;
> -			lines++;
> -		} else {
> -			break;
> -		}
> +	for (i = 0; i < nr_lines && loc_tab[i].start_location <= bci; i++) {
> +		src_line = i;
> +	}
> +
> +	if (src_line != -1) {
> +		tab->pc = (unsigned long)pc;
> +		tab->line_number = loc_tab[src_line].line_number;
> +		tab->discrim = 0; /* not yet used */
> +		tab->methodID = m;
> +
> +		ret = JVMTI_ERROR_NONE;
> +	} else {
> +		ret = JVMTI_ERROR_ABSENT_INFORMATION;
>  	}
> +
>  	(*jvmti)->Deallocate(jvmti, (unsigned char *)loc_tab);
> -	*nr = lines;
> -	return JVMTI_ERROR_NONE;
> +
> +	return ret;
>  }
>  
>  static jvmtiError
> @@ -71,9 +74,8 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>  {
>  	const jvmtiCompiledMethodLoadRecordHeader *hdr;
>  	jvmtiCompiledMethodLoadInlineRecord *rec;
> -	jvmtiLineNumberEntry *lne = NULL;
>  	PCStackInfo *c;
> -	jint nr, ret;
> +	jint ret;
>  	int nr_total = 0;
>  	int i, lines_total = 0;
>  
> @@ -86,24 +88,7 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>  	for (hdr = compile_info; hdr != NULL; hdr = hdr->next) {
>  		if (hdr->kind == JVMTI_CMLR_INLINE_INFO) {
>  			rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
> -			for (i = 0; i < rec->numpcs; i++) {
> -				c = rec->pcinfo + i;
> -				nr = 0;
> -				/*
> -				 * unfortunately, need a tab to get the number of lines!
> -				 */
> -				ret = (*jvmti)->GetLineNumberTable(jvmti, c->methods[0], &nr, &lne);
> -				if (ret == JVMTI_ERROR_NONE) {
> -					/* free what was allocated for nothing */
> -					(*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
> -					nr_total += (int)nr;
> -				} else if (ret == JVMTI_ERROR_ABSENT_INFORMATION
> -					   || ret == JVMTI_ERROR_NATIVE_METHOD) {
> -					/* No debug information for this method */
> -				} else {
> -					print_error(jvmti, "GetLineNumberTable", ret);
> -				}
> -			}
> +			nr_total += rec->numpcs;
>  		}
>  	}
>  
> @@ -122,14 +107,12 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>  			rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
>  			for (i = 0; i < rec->numpcs; i++) {
>  				c = rec->pcinfo + i;
> -				nr = 0;
> -				ret = do_get_line_numbers(jvmti, c->pc,
> -							  c->methods[0],
> -							  c->bcis[0],
> -							  *tab + lines_total,
> -							  &nr);
> +				ret = do_get_line_number(jvmti, c->pc,
> +							 c->methods[0],
> +							 c->bcis[0],
> +							 *tab + lines_total);
>  				if (ret == JVMTI_ERROR_NONE)
> -					lines_total += nr;
> +					lines_total++;
>  			}
>  		}
>  	}
> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
> index 30e9f618f6cd..dd40683bd4c0 100644
> --- a/tools/perf/util/genelf_debug.c
> +++ b/tools/perf/util/genelf_debug.c
> @@ -342,7 +342,7 @@ static void emit_lineno_info(struct buffer_ext *be,
>  	 */
>  
>  	/* start state of the state machine we take care of */
> -	unsigned long last_vma = code_addr;
> +	unsigned long last_vma = 0;
>  	char const  *cur_filename = NULL;
>  	unsigned long cur_file_idx = 0;
>  	int last_line = 1;
> @@ -473,7 +473,7 @@ jit_process_debug_info(uint64_t code_addr,
>  		ent = debug_entry_next(ent);
>  	}
>  	add_compilation_unit(di, buffer_ext_size(dl));
> -	add_debug_line(dl, debug, nr_debug_entries, 0);
> +	add_debug_line(dl, debug, nr_debug_entries, GEN_ELF_TEXT_OFFSET);
>  	add_debug_abbrev(da);
>  	if (0) buffer_ext_dump(da, "abbrev");
>  
> -- 
> 2.26.2
> 

