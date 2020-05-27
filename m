Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951A320776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgE0F3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:29:15 -0400
Received: from foss.arm.com ([217.140.110.172]:60500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgE0F3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:29:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C86955D;
        Tue, 26 May 2020 22:29:14 -0700 (PDT)
Received: from A010555 (unknown [10.169.38.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF463F305;
        Tue, 26 May 2020 22:29:10 -0700 (PDT)
References: <20200522065330.34872-1-nick.gasson@arm.com> <20200526115547.GF333164@krava>
User-agent: mu4e 1.4.5; emacs 26.3
From:   Nick Gasson <nick.gasson@arm.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jvmti: remove redundant jitdump line table entries
In-reply-to: <20200526115547.GF333164@krava>
Date:   Wed, 27 May 2020 13:29:05 +0800
Message-ID: <xgl9367mndy6.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26/20 19:55 PM, Jiri Olsa wrote:
> On Fri, May 22, 2020 at 02:53:30PM +0800, Nick Gasson wrote:
>> For each PC/BCI pair in the JVMTI compiler inlining record table, the
>> jitdump plugin emits debug line table entries for every source line in
>> the method preceding that BCI. Instead only emit one source line per
>> PC/BCI pair. Reported by Ian Rogers. This reduces the .dump size for
>> SPECjbb from ~230MB to ~40MB.
>> 
>> Also fix an error in the DWARF line table state machine where addresses
>> are incorrectly offset by -0x40 (GEN_ELF_TEXT_OFFSET). This can be seen
>> with `objdump -S` on the ELF files after perf inject.
>
> hi,
> I can't apply this on latest Arnaldo's perf/core:
>
> patching file jvmti/libjvmti.c
> Hunk #1 FAILED at 32.
> Hunk #2 succeeded at 67 (offset -4 lines).
> Hunk #3 FAILED at 85.
> Hunk #4 succeeded at 114 (offset -7 lines).
>

Sorry I based this on my earlier patch series below but I didn't realise
that wasn't merged to perf/core yet. Could those patches be applied
first? I believe Ian added a Reviewed-by for all three.

https://lore.kernel.org/lkml/20200427061520.24905-3-nick.gasson@arm.com/T/


>
>> 
>> Signed-off-by: Nick Gasson <nick.gasson@arm.com>
>> ---
>>  tools/perf/jvmti/libjvmti.c    | 73 +++++++++++++---------------------
>>  tools/perf/util/genelf_debug.c |  4 +-
>>  2 files changed, 30 insertions(+), 47 deletions(-)
>> 
>> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
>> index a9a056d68416..398e4ba6498d 100644
>> --- a/tools/perf/jvmti/libjvmti.c
>> +++ b/tools/perf/jvmti/libjvmti.c
>> @@ -32,38 +32,41 @@ static void print_error(jvmtiEnv *jvmti, const char *msg, jvmtiError ret)
>>  
>>  #ifdef HAVE_JVMTI_CMLR
>>  static jvmtiError
>> -do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
>> -		    jvmti_line_info_t *tab, jint *nr)
>> +do_get_line_number(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
>> +		   jvmti_line_info_t *tab)
>>  {
>> -	jint i, lines = 0;
>> -	jint nr_lines = 0;
>> +	jint i, nr_lines = 0;
>>  	jvmtiLineNumberEntry *loc_tab = NULL;
>>  	jvmtiError ret;
>> +	jint src_line = -1;
>>  
>>  	ret = (*jvmti)->GetLineNumberTable(jvmti, m, &nr_lines, &loc_tab);
>>  	if (ret == JVMTI_ERROR_ABSENT_INFORMATION || ret == JVMTI_ERROR_NATIVE_METHOD) {
>>  		/* No debug information for this method */
>> -		*nr = 0;
>> -		return JVMTI_ERROR_NONE;
>> +		return ret;
>>  	} else if (ret != JVMTI_ERROR_NONE) {
>>  		print_error(jvmti, "GetLineNumberTable", ret);
>>  		return ret;
>>  	}
>>  
>> -	for (i = 0; i < nr_lines; i++) {
>> -		if (loc_tab[i].start_location < bci) {
>> -			tab[lines].pc = (unsigned long)pc;
>> -			tab[lines].line_number = loc_tab[i].line_number;
>> -			tab[lines].discrim = 0; /* not yet used */
>> -			tab[lines].methodID = m;
>> -			lines++;
>> -		} else {
>> -			break;
>> -		}
>> +	for (i = 0; i < nr_lines && loc_tab[i].start_location <= bci; i++) {
>> +		src_line = i;
>> +	}
>> +
>> +	if (src_line != -1) {
>> +		tab->pc = (unsigned long)pc;
>> +		tab->line_number = loc_tab[src_line].line_number;
>> +		tab->discrim = 0; /* not yet used */
>> +		tab->methodID = m;
>> +
>> +		ret = JVMTI_ERROR_NONE;
>> +	} else {
>> +		ret = JVMTI_ERROR_ABSENT_INFORMATION;
>>  	}
>> +
>>  	(*jvmti)->Deallocate(jvmti, (unsigned char *)loc_tab);
>> -	*nr = lines;
>> -	return JVMTI_ERROR_NONE;
>> +
>> +	return ret;
>>  }
>>  
>>  static jvmtiError
>> @@ -71,9 +74,8 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>>  {
>>  	const jvmtiCompiledMethodLoadRecordHeader *hdr;
>>  	jvmtiCompiledMethodLoadInlineRecord *rec;
>> -	jvmtiLineNumberEntry *lne = NULL;
>>  	PCStackInfo *c;
>> -	jint nr, ret;
>> +	jint ret;
>>  	int nr_total = 0;
>>  	int i, lines_total = 0;
>>  
>> @@ -86,24 +88,7 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>>  	for (hdr = compile_info; hdr != NULL; hdr = hdr->next) {
>>  		if (hdr->kind == JVMTI_CMLR_INLINE_INFO) {
>>  			rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
>> -			for (i = 0; i < rec->numpcs; i++) {
>> -				c = rec->pcinfo + i;
>> -				nr = 0;
>> -				/*
>> -				 * unfortunately, need a tab to get the number of lines!
>> -				 */
>> -				ret = (*jvmti)->GetLineNumberTable(jvmti, c->methods[0], &nr, &lne);
>> -				if (ret == JVMTI_ERROR_NONE) {
>> -					/* free what was allocated for nothing */
>> -					(*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
>> -					nr_total += (int)nr;
>> -				} else if (ret == JVMTI_ERROR_ABSENT_INFORMATION
>> -					   || ret == JVMTI_ERROR_NATIVE_METHOD) {
>> -					/* No debug information for this method */
>> -				} else {
>> -					print_error(jvmti, "GetLineNumberTable", ret);
>> -				}
>> -			}
>> +			nr_total += rec->numpcs;
>>  		}
>>  	}
>>  
>> @@ -122,14 +107,12 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>>  			rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
>>  			for (i = 0; i < rec->numpcs; i++) {
>>  				c = rec->pcinfo + i;
>> -				nr = 0;
>> -				ret = do_get_line_numbers(jvmti, c->pc,
>> -							  c->methods[0],
>> -							  c->bcis[0],
>> -							  *tab + lines_total,
>> -							  &nr);
>> +				ret = do_get_line_number(jvmti, c->pc,
>> +							 c->methods[0],
>> +							 c->bcis[0],
>> +							 *tab + lines_total);
>>  				if (ret == JVMTI_ERROR_NONE)
>> -					lines_total += nr;
>> +					lines_total++;
>>  			}
>>  		}
>>  	}
>> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
>> index 30e9f618f6cd..dd40683bd4c0 100644
>> --- a/tools/perf/util/genelf_debug.c
>> +++ b/tools/perf/util/genelf_debug.c
>> @@ -342,7 +342,7 @@ static void emit_lineno_info(struct buffer_ext *be,
>>  	 */
>>  
>>  	/* start state of the state machine we take care of */
>> -	unsigned long last_vma = code_addr;
>> +	unsigned long last_vma = 0;
>>  	char const  *cur_filename = NULL;
>>  	unsigned long cur_file_idx = 0;
>>  	int last_line = 1;
>> @@ -473,7 +473,7 @@ jit_process_debug_info(uint64_t code_addr,
>>  		ent = debug_entry_next(ent);
>>  	}
>>  	add_compilation_unit(di, buffer_ext_size(dl));
>> -	add_debug_line(dl, debug, nr_debug_entries, 0);
>> +	add_debug_line(dl, debug, nr_debug_entries, GEN_ELF_TEXT_OFFSET);
>>  	add_debug_abbrev(da);
>>  	if (0) buffer_ext_dump(da, "abbrev");
>>  
>> -- 
>> 2.26.2
>> 

