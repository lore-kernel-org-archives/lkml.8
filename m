Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C544AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E456205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMx+Zs92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEOU4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:56:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbgEOU4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589576178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XclJikw/kSVnStKK/hg+PLzsRFUWexrJPtiigEia7po=;
        b=DMx+Zs92+oPf1Vu3awZjJNT/FqjtUSu6oXOOb3OEhstlJRcWQ8M7o+pTJqCZ1vlQfeT4IM
        cw1/dnfzc6lgqQ6q/2XD8MkWLKJG60mOo6X8sAmUA6oXL3jcyzRZZu9Yn3XrW1eTPAv5SW
        b9dwRL0AUAERfL4rh6hhUadB/tjYRpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-gMF37x8lM1WhTl_uO5SNFw-1; Fri, 15 May 2020 16:56:14 -0400
X-MC-Unique: gMF37x8lM1WhTl_uO5SNFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DDF3107BEF6;
        Fri, 15 May 2020 20:56:13 +0000 (UTC)
Received: from treble (ovpn-117-151.rdu2.redhat.com [10.10.117.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 604671001920;
        Fri, 15 May 2020 20:56:12 +0000 (UTC)
Date:   Fri, 15 May 2020 15:56:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200515205610.fmdimt7wbafypuqc@treble>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:35:12AM -0700, Matt Helsley wrote:
> +struct insn_state {
> +	struct cfi_reg cfa;
> +	struct cfi_reg regs[CFI_NUM_REGS];
> +	int stack_size;
> +	unsigned char type;
> +	bool bp_scratch;
> +	bool drap, end, uaccess, df;
> +	bool noinstr;
> +	s8 instr;
> +	unsigned int uaccess_stack;
> +	int drap_reg, drap_offset;
> +	struct cfi_reg vals[CFI_NUM_REGS];
> +};
> +
> +struct instruction {
> +	struct list_head list;
> +	struct hlist_node hash;
> +	struct section *sec;
> +	unsigned long offset;
> +	unsigned int len;
> +	enum insn_type type;
> +	unsigned long immediate;
> +	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> +	bool retpoline_safe;
> +	s8 instr;
> +	u8 visited;
> +	struct symbol *call_dest;
> +	struct instruction *jump_dest;
> +	struct instruction *first_jump_src;
> +	struct rela *jump_table;
> +	struct list_head alts;
> +	struct symbol *func;
> +	struct stack_op stack_op;
> +	struct insn_state state;
> +	struct orc_entry orc;
> +};

Why were these moved to arch.h?  They're not necessarily arch-specific,
but rather "check"-specific, so I think they still belong in check.h, if
possible.

-- 
Josh

