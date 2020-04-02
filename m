Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70D7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD47C20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0H7/o+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbgDBMx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:53:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51161 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387580AbgDBMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585832034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42pzLWIJUxN/RPJi5X2VMq+xSfBaEpwkLRUnGS91eDg=;
        b=d0H7/o+bet7m6rGJfihom6GHUxXqH2vi+yJlR+nU66qWZyN9yCezS/A4rHrBEzTHti9jVY
        Cj91Q4ptx3lxxNFu+EolUohLm/OYLiUEngDHELI2jJGngIwvRzxcTLhmCl8Lg2dub5VH5M
        zu+oORHtGWNjCQx/5uB4RKxk46/PDtE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-eIp2g71qOjOyvvbNMuyfoQ-1; Thu, 02 Apr 2020 08:53:53 -0400
X-MC-Unique: eIp2g71qOjOyvvbNMuyfoQ-1
Received: by mail-wr1-f72.google.com with SMTP id q14so1433769wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42pzLWIJUxN/RPJi5X2VMq+xSfBaEpwkLRUnGS91eDg=;
        b=EMUOmchzYsbBeDN5HOygRocfkah1YcVnhc9JEpB7fJxND/fZXVJDWV02SX0KQoZt53
         HV0fxYHsPPjSrII+pHUwnc3TW0Qt8KAgeZeeDCpJeHy+aSadrxblvibpc+sorDmFHzxX
         gXEZDIOJeyO9n6ICa3dcCRpPZGLGEDmU+gi2gVknZNbvCB+nRrSJMR7wrJH+yuGy1hQe
         0flWItZNqtcXk9z9HGJU4jTJfXiPg67494QzM0i4TWi2xLYkbSZtk0wYlN2Vwe0BXn2K
         3O3nLkmF/KOA3m+1s8Z1cDqN8Fxn4kl39rATDJqbfzIkIIrpytV3PjL3HEbP+e8UFsoB
         YlIg==
X-Gm-Message-State: AGi0PuZU8Tz7aZ5HKQNA/BucoMY+IUmJ+aZK6rDLZi+RJCXyjJ24iavE
        wWkMEy1Owb8Yui4Wda82IEGB6uLSUXY+mMiQkut4IDO2oqLI5V2kOyc5fQKpqsVVCXP2dMn3zyz
        lZOPEA2VA0Q66Hhk++rfbGKIx
X-Received: by 2002:a1c:5401:: with SMTP id i1mr3443659wmb.172.1585832031940;
        Thu, 02 Apr 2020 05:53:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypK3P7X3pIQnwqrxs8wrhbG234OTB4HDC8KFqpb7pQg9NcJCk7MXbKXpQdINCmHIlYsVFcvYag==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr3443642wmb.172.1585832031718;
        Thu, 02 Apr 2020 05:53:51 -0700 (PDT)
Received: from [192.168.1.27] (lfbn-lyo-1-134-107.w86-202.abo.wanadoo.fr. [86.202.218.107])
        by smtp.gmail.com with ESMTPSA id 9sm6802824wmm.6.2020.04.02.05.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 05:53:50 -0700 (PDT)
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
To:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <db508586-258a-0616-d649-e76e95df9611@redhat.com>
Date:   Thu, 2 Apr 2020 13:53:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402082220.808-4-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

I ran into the limitation of intra-function call for the arm64 support 
but didn't take the time to make a clean patch to support them properly.

Nice to see you've gone through that work :) .

On 4/2/20 9:22 AM, Alexandre Chartre wrote:
> Change objtool to support intra-function calls. An intra-function call
> is represented in objtool as a push onto the stack (of the return

I have to disagree a bit with that. The push onto the stack is true on 
x86, but other architectures might not have that (arm/arm64 have a link 
register that gets set by "bl" instructions and do not modify the stack).

> address), and a jump to the destination address. That way the stack
> information is correctly updated and the call flow is still accurate.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>   tools/objtool/check.c | 73 ++++++++++++++++++++++++++++++++++++++++++-
>   tools/objtool/check.h |  1 +
>   2 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 214809ac2776..0cec91291d46 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -657,6 +657,18 @@ static int add_call_destinations(struct objtool_file *file)
>   		if (insn->type != INSN_CALL)
>   			continue;
>   
> +		if (insn->intra_function_call) {
> +			dest_off = insn->offset + insn->len + insn->immediate;
> +			insn->jump_dest = find_insn(file, insn->sec, dest_off);
> +			if (insn->jump_dest)
> +				continue;
> +
> +			WARN_FUNC("can't find call dest at %s+0x%lx",
> +				  insn->sec, insn->offset,
> +				  insn->sec->name, dest_off);
> +			return -1;
> +		}
> +
>   		rela = find_rela_by_dest_range(insn->sec, insn->offset,
>   					       insn->len);
>   		if (!rela) {
> @@ -1289,6 +1301,49 @@ static int read_retpoline_hints(struct objtool_file *file)
>   	return 0;
>   }
>   
> +static int read_intra_function_call(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct instruction *insn;
> +	struct rela *rela;
> +
> +	sec = find_section_by_name(file->elf,
> +				   ".rela.discard.intra_function_call");

I'm wondering, do we really need to annotate the intra_function_call and 
group the in a section?

Would it be a problem to consider all (static) call instructions with a 
destination that is not the start offset of a symbol to be an 
intra-function call (and set insn->intra_function_call and 
insn->jump_dest accordingly)?

Other than that the logic would stay the same.

> +	if (!sec)
> +		return 0;
> +
> +	list_for_each_entry(rela, &sec->rela_list, list) {
> +		if (rela->sym->type != STT_SECTION) {
> +			WARN("unexpected relocation symbol type in %s",
> +			     sec->name);
> +			return -1;
> +		}
> +
> +		insn = find_insn(file, rela->sym->sec, rela->addend);
> +		if (!insn) {
> +			WARN("bad .discard.intra_function_call entry");
> +			return -1;
> +		}
> +
> +		if (insn->type != INSN_CALL) {
> +			WARN_FUNC("intra_function_call not a call",
> +				  insn->sec, insn->offset);

Nit: This could be slightly confusing with INSN_CALL_DYNAMIC. Maybe just:
	"unsupported instruction for intra-function call " ?

> +			return -1;
> +		}
> +
> +		insn->intra_function_call = true;
> +		/*
> +		 * For the impact on the stack, make an intra-function
> +		 * call behaves like a push of an immediate value (the
> +		 * return address).
> +		 */
> +		insn->stack_op.src.type = OP_SRC_CONST;
> +		insn->stack_op.dest.type = OP_DEST_PUSH;

As commented above, this should be arch dependent.

> +	}
> +
> +	return 0;
> +}
> +
>   static void mark_rodata(struct objtool_file *file)
>   {
>   	struct section *sec;
> @@ -1344,6 +1399,10 @@ static int decode_sections(struct objtool_file *file)
>   	if (ret)
>   		return ret;
>   
> +	ret = read_intra_function_call(file);
> +	if (ret)
> +		return ret;
> +
>   	ret = add_call_destinations(file);
>   	if (ret)
>   		return ret;
> @@ -2092,7 +2151,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   				return ret;
>   
>   			if (!no_fp && func && !is_fentry_call(insn) &&
> -			    !has_valid_stack_frame(&state)) {
> +			    !has_valid_stack_frame(&state) &&
> +			    !insn->intra_function_call) {
>   				WARN_FUNC("call without frame pointer save/setup",
>   					  sec, insn->offset);
>   				return 1;
> @@ -2101,6 +2161,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   			if (dead_end_function(file, insn->call_dest))
>   				return 0;
>   
> +			if (insn->intra_function_call) {
> +				update_insn_state(insn, &state);
> +				ret = validate_branch(file, func, insn,
> +						      insn->jump_dest, state);
> +				if (ret) {
> +					if (backtrace)
> +						BT_FUNC("(intra-call)", insn);
> +					return ret;
> +				}
> +			}
> +
>   			break;
>   
>   		case INSN_JUMP_CONDITIONAL:
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index cffb23d81782..2bd6d2f46baa 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -35,6 +35,7 @@ struct instruction {
>   	unsigned long immediate;
>   	unsigned int alt_group;
>   	bool dead_end, ignore, hint, save, restore, ignore_alts;
> +	bool intra_function_call;
>   	bool retpoline_safe;
>   	u8 visited;
>   	struct symbol *call_dest;
> 

Thanks,

-- 
Julien Thierry

