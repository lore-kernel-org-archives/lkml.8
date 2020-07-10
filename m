Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA85C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7468F20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGJWb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgGJWb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:31:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B33F206F4;
        Fri, 10 Jul 2020 22:31:57 +0000 (UTC)
Date:   Fri, 10 Jul 2020 18:31:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 10/17] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20200710183155.05eae629@oasis.local.home>
In-Reply-To: <20200710134336.739394269@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.739394269@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/hashtable.h>
>  #include <linux/kernel.h>
> +#include <linux/static_call_types.h>
>  
>  #define FAKE_JUMP_OFFSET -1
>  
> @@ -433,6 +434,99 @@ static int add_dead_ends(struct objtool_
>  	return 0;
>  }
>  
> +static int create_static_call_sections(struct objtool_file *file)
> +{
> +	struct section *sec, *reloc_sec;
> +	struct reloc *reloc;
> +	struct static_call_site *site;
> +	struct instruction *insn;
> +	struct symbol *key_sym;
> +	char *key_name, *tmp;
> +	int idx;
> +
> +	sec = find_section_by_name(file->elf, ".static_call_sites");
> +	if (sec) {
> +		INIT_LIST_HEAD(&file->static_call_list);
> +		WARN("file already has .static_call_sites section, skipping");
> +		return 0;
> +	}
> +
> +	if (list_empty(&file->static_call_list))
> +		return 0;
> +
> +	idx = 0;
> +	list_for_each_entry(insn, &file->static_call_list, static_call_node)
> +		idx++;
> +
> +	sec = elf_create_section(file->elf, ".static_call_sites", SHF_WRITE,
> +				 sizeof(struct static_call_site), idx);
> +	if (!sec)
> +		return -1;
> +
> +	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
> +	if (!reloc_sec)
> +		return -1;
> +
> +	idx = 0;
> +	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
> +
> +		site = (struct static_call_site *)sec->data->d_buf + idx;
> +		memset(site, 0, sizeof(struct static_call_site));
> +
> +		/* populate reloc for 'addr' */
> +		reloc = malloc(sizeof(*reloc));
> +		if (!reloc) {
> +			perror("malloc");
> +			return -1;
> +		}
> +		memset(reloc, 0, sizeof(*reloc));
> +		reloc->sym = insn->sec->sym;
> +		reloc->addend = insn->offset;
> +		reloc->type = R_X86_64_PC32;
> +		reloc->offset = idx * sizeof(struct static_call_site);
> +		reloc->sec = reloc_sec;
> +		elf_add_reloc(file->elf, reloc);
> +
> +		/* find key symbol */
> +		key_name = strdup(insn->call_dest->name);

Should check for failed allocation of strdup().

> +		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
> +			    strlen(STATIC_CALL_TRAMP_PREFIX_STR))) {
> +			WARN("static_call: trampoline name malformed: %s", key_name);
> +			return -1;
> +		}
> +		tmp = key_name + STATIC_CALL_TRAMP_PREFIX_LEN - STATIC_CALL_KEY_PREFIX_LEN;
> +		memcpy(tmp, STATIC_CALL_KEY_PREFIX_STR, STATIC_CALL_KEY_PREFIX_LEN);
> +
> +		key_sym = find_symbol_by_name(file->elf, tmp);
> +		if (!key_sym) {
> +			WARN("static_call: can't find static_call_key symbol: %s", tmp);
> +			return -1;
> +		}
> +		free(key_name);
> +
> +		/* populate reloc for 'key' */
> +		reloc = malloc(sizeof(*reloc));
> +		if (!reloc) {
> +			perror("malloc");
> +			return -1;
> +		}
> +		memset(reloc, 0, sizeof(*reloc));
> +		reloc->sym = key_sym;
> +		reloc->addend = 0;
> +		reloc->type = R_X86_64_PC32;

How easy would this be for other architectures to implement this? That
is how much of this function is x86 specific?


-- Steve

> +		reloc->offset = idx * sizeof(struct static_call_site) + 4;
> +		reloc->sec = reloc_sec;
> +		elf_add_reloc(file->elf, reloc);
> +
> +		idx++;
> +	}
> +
> +	if (elf_rebuild_reloc_section(file->elf, reloc_sec))
> +		return -1;
> +
> +	return 0;
> +}
> +
