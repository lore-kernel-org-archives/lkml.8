Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FD4C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC3521707
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LABNHxPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgD1TxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:53:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728559AbgD1TxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588103592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JD+gHvkJvespyjIlkjyjMoB5DMAouYrS8n21jslAx0=;
        b=LABNHxPVs6eRXtE/aC8BdXz91Oae9IaTD7mb0Z/VtmmuuxH0qhe4RW2t9IKTch5SlqOujn
        eC9+0AZNkQ8VDPSaJILDJtq3QcISRhwYEiY8E4uEErIMI++IC6Y2awsMbhtEEUeiLhqKYB
        y58n/yAgbNgOvIZRGUfabCvT/U4yFDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Byye7za3NwWBNI5jgT_TdA-1; Tue, 28 Apr 2020 15:53:07 -0400
X-MC-Unique: Byye7za3NwWBNI5jgT_TdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD85E108BD17;
        Tue, 28 Apr 2020 19:53:05 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA1071C950;
        Tue, 28 Apr 2020 19:53:04 +0000 (UTC)
Date:   Tue, 28 Apr 2020 14:53:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v2 01/14] objtool: Allow branches within the same
 alternative.
Message-ID: <20200428195301.szkrjfvrjahsbuhb@treble>
References: <20200428191101.886208539@infradead.org>
 <20200428191659.438842526@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428191659.438842526@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:11:02PM +0200, Peter Zijlstra wrote:
> From: Alexandre Chartre <alexandre.chartre@oracle.com>
> 
> Currently objtool prevents any branch to an alternative. While preventing
> branching from the outside to the middle of an alternative makes perfect
> sense, branching within the same alternative should be allowed. To do so,
> identify each alternative and check that a branch to an alternative comes
> from the same alternative.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200414103618.12657-3-alexandre.chartre@oracle.com

I still don't like this patch, other than the "alt_group =
alt_group_next_index++" thing as a prerequisite for the next patch.

Instead of all this, let's just get rid of the 

  "don't know how to handle branch to middle of alternative instruction group"

warning, which I think we decided is useless and not worth the effort
anyway.

> ---
>  tools/objtool/check.c |   26 ++++++++++++++++++++------
>  tools/objtool/check.h |    3 ++-
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -770,7 +770,9 @@ static int handle_group_alt(struct objto
>  			    struct instruction *orig_insn,
>  			    struct instruction **new_insn)
>  {
> +	static unsigned int alt_group_next_index = 1;
>  	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
> +	unsigned int alt_group = alt_group_next_index++;
>  	unsigned long dest_off;
>  
>  	last_orig_insn = NULL;
> @@ -779,7 +781,7 @@ static int handle_group_alt(struct objto
>  		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
>  			break;
>  
> -		insn->alt_group = true;
> +		insn->alt_group = alt_group;
>  		last_orig_insn = insn;
>  	}
>  
> @@ -813,6 +815,7 @@ static int handle_group_alt(struct objto
>  	}
>  
>  	last_new_insn = NULL;
> +	alt_group = alt_group_next_index++;
>  	insn = *new_insn;
>  	sec_for_each_insn_from(file, insn) {
>  		if (insn->offset >= special_alt->new_off + special_alt->new_len)
> @@ -822,6 +825,7 @@ static int handle_group_alt(struct objto
>  
>  		insn->ignore = orig_insn->ignore_alts;
>  		insn->func = orig_insn->func;
> +		insn->alt_group = alt_group;
>  
>  		/*
>  		 * Since alternative replacement code is copy/pasted by the
> @@ -2163,6 +2167,15 @@ static int validate_return(struct symbol
>  	return 0;
>  }
>  
> +static bool is_branch_to_alternative(struct instruction *from,
> +				     struct instruction *to)
> +{
> +	if (!from || !to->alt_group || !list_empty(&to->alts))
> +		return false;
> +
> +	return (from->alt_group != to->alt_group);
> +}
> +
>  /*
>   * Follow the branch starting at the given instruction, and recursively follow
>   * any other branches (jumps).  Meanwhile, track the frame pointer state at
> @@ -2170,6 +2183,7 @@ static int validate_return(struct symbol
>   * tools/objtool/Documentation/stack-validation.txt.
>   */
>  static int validate_branch(struct objtool_file *file, struct symbol *func,
> +			   struct instruction *from,
>  			   struct instruction *insn, struct insn_state state)
>  {
>  	struct alternative *alt;
> @@ -2180,7 +2194,7 @@ static int validate_branch(struct objtoo
>  
>  	sec = insn->sec;
>  
> -	if (insn->alt_group && list_empty(&insn->alts)) {
> +	if (is_branch_to_alternative(from, insn)) {
>  		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
>  			  sec, insn->offset);
>  		return 1;
> @@ -2227,7 +2241,7 @@ static int validate_branch(struct objtoo
>  				if (alt->skip_orig)
>  					skip_orig = true;
>  
> -				ret = validate_branch(file, func, alt->insn, state);
> +				ret = validate_branch(file, func, NULL, alt->insn, state);
>  				if (ret) {
>  					if (backtrace)
>  						BT_FUNC("(alt)", insn);
> @@ -2271,7 +2285,7 @@ static int validate_branch(struct objtoo
>  
>  			} else if (insn->jump_dest) {
>  				ret = validate_branch(file, func,
> -						      insn->jump_dest, state);
> +						      insn, insn->jump_dest, state);
>  				if (ret) {
>  					if (backtrace)
>  						BT_FUNC("(branch)", insn);
> @@ -2402,7 +2416,7 @@ static int validate_unwind_hints(struct
>  
>  	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
>  		if (insn->hint && !insn->visited) {
> -			ret = validate_branch(file, insn->func, insn, state);
> +			ret = validate_branch(file, insn->func, NULL, insn, state);
>  			if (ret && backtrace)
>  				BT_FUNC("<=== (hint)", insn);
>  			warnings += ret;
> @@ -2543,7 +2557,7 @@ static int validate_symbol(struct objtoo
>  
>  	state->uaccess = sym->uaccess_safe;
>  
> -	ret = validate_branch(file, insn->func, insn, *state);
> +	ret = validate_branch(file, insn->func, NULL, insn, *state);
>  	if (ret && backtrace)
>  		BT_FUNC("<=== (sym)", insn);
>  	return ret;
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -30,12 +30,13 @@ struct instruction {
>  	unsigned int len;
>  	enum insn_type type;
>  	unsigned long immediate;
> -	bool alt_group, dead_end, ignore, ignore_alts;
> +	bool dead_end, ignore, ignore_alts;
>  	bool hint;
>  	bool retpoline_safe;
>  	s8 instr;
>  	u8 visited;
>  	u8 ret_offset;
> +	int alt_group;
>  	struct symbol *call_dest;
>  	struct instruction *jump_dest;
>  	struct instruction *first_jump_src;
> 
> 

-- 
Josh

