Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED55206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOs3VcdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbgDBMDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:03:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34715 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387970AbgDBMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585829017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfESRpDFOBpYvyaYe9OQ6VKOjwSLnUlR1qO4lZ2nWm4=;
        b=TOs3VcdLoeHPUHYs30Jk0xx6CJtgMU4HUEcpnSGdVICxGSBLUnw711oAICUwE8NOVabrVN
        g0mW9nzt6ignu4umNUmpluLopPaA0oYmsMfXNBpdxLfXK2WP8fyddXJQ7iEhAba0CaUh7Y
        n2rRLEDi577m/005Y4n691uizWoeF9k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-OMTJu6FkOz2uPRbRbnzA9A-1; Thu, 02 Apr 2020 08:03:33 -0400
X-MC-Unique: OMTJu6FkOz2uPRbRbnzA9A-1
Received: by mail-wr1-f71.google.com with SMTP id c8so1365113wru.20
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GfESRpDFOBpYvyaYe9OQ6VKOjwSLnUlR1qO4lZ2nWm4=;
        b=U1t81MXGjyLNlwhPEKghrR7uvaU5eVpU2AfnKiJCq0YrvveJ5SxLP8MKi+5xzNRw6g
         TO2nKXgLrHwa14UhkjjcWsu18XtjuohhvRGu/TYjIhQZd6fbSy2lV3VNEMo64cP1qJ2W
         O7JP8K74ihj4FvBqNnNEszHyrVsiVAYUGBP/8wkUihbY3bNDVjgwQzBK5kNL81zpJkF4
         uQ7ojN6il5C3ncV0lyrlxsMB+hARFQxUCMpfc0/NRep9j+wsvmmp/UoZQKeTOyvtgG1Q
         xpFUA1eQdMqOKRTNWt9TwpLF3b9QSsp4qJ99aZBY7pf2PPK6WzGKSHoqHMqDYozldJ2n
         cqiw==
X-Gm-Message-State: AGi0PuYvasdBmJH8St+SJb3tsN+eMB4Z+UXzHueR/S3RNeUI7rOmvaoM
        1/VB5sZwGcCjeRfeo8vdh6OE876B2FM9Cahtrn+FU9SYzcvRok8MPCZms1wpOJh1NhQt35SgilJ
        CAt82NiqYOWaN0um95TVL75S5
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr3180216wrs.20.1585829012688;
        Thu, 02 Apr 2020 05:03:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypKjFCVpshRyElyqpXfObjBocHX5FjAeDjNAq8junXcIE7ZT0ZQNyNjpzxh0S4V1pdgJG6Ir4A==
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr3180191wrs.20.1585829012358;
        Thu, 02 Apr 2020 05:03:32 -0700 (PDT)
Received: from [192.168.1.27] (lfbn-lyo-1-134-107.w86-202.abo.wanadoo.fr. [86.202.218.107])
        by smtp.gmail.com with ESMTPSA id q9sm7704675wrp.84.2020.04.02.05.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 05:03:31 -0700 (PDT)
Subject: Re: [PATCH 2/7] objtool: Allow branches within the same alternative.
To:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-3-alexandre.chartre@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <50e8a5d8-7cb4-f25c-9657-eb11038bd0b5@redhat.com>
Date:   Thu, 2 Apr 2020 13:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402082220.808-3-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

I ran into the same issue for the arm64 work:
https://lkml.org/lkml/2020/1/9/656

Your solution seems nicer however.

On 4/2/20 9:22 AM, Alexandre Chartre wrote:
> Currently objtool prevents any branch to an alternative. While preventing
> branching from the outside to the middle of an alternative makes perfect
> sense, branching within the same alternative should be allowed. To do so,
> identify each alternative and check that a branch to an alternative comes
> from the same alternative.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>   tools/objtool/check.c | 19 +++++++++++++------
>   tools/objtool/check.h |  3 ++-
>   2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 708562fb89e1..214809ac2776 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -712,7 +712,9 @@ static int handle_group_alt(struct objtool_file *file,
>   			    struct instruction *orig_insn,
>   			    struct instruction **new_insn)
>   {
> +	static unsigned int alt_group_next_index = 1;
>   	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
> +	unsigned int alt_group = alt_group_next_index++;
>   	unsigned long dest_off;
>   
>   	last_orig_insn = NULL;
> @@ -721,7 +723,7 @@ static int handle_group_alt(struct objtool_file *file,
>   		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
>   			break;
>   
> -		insn->alt_group = true;
> +		insn->alt_group = alt_group;
>   		last_orig_insn = insn;
>   	}
>   
> @@ -1942,6 +1944,7 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
>    * tools/objtool/Documentation/stack-validation.txt.
>    */
>   static int validate_branch(struct objtool_file *file, struct symbol *func,
> +			   struct instruction *from,

Maybe instead of passing a new instruction pointer, just the alt_group 
could be passed? 0 Meaning it was not in an alt group.

>   			   struct instruction *first, struct insn_state state)
>   {
>   	struct alternative *alt;
> @@ -1953,7 +1956,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   	insn = first;
>   	sec = insn->sec;
>   
> -	if (insn->alt_group && list_empty(&insn->alts)) {
> +	if (insn->alt_group &&
> +	    (!from || from->alt_group != insn->alt_group) &&
> +	    list_empty(&insn->alts)) {

This would become

	if (insn->alt_group != alt_group && list_empty(&insn->alts))

And the recursive validate_branch() calls would just take 
insn->alt_group as parameter (and the calls in validate_functions() and 
validate_unwind_hints() would take 0).

Any opinions on that?

>   		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
>   			  sec, insn->offset);
>   		return 1;
> @@ -2035,7 +2040,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   				if (alt->skip_orig)
>   					skip_orig = true;
>   
> -				ret = validate_branch(file, func, alt->insn, state);
> +				ret = validate_branch(file, func,
> +						      NULL, alt->insn, state);
>   				if (ret) {
>   					if (backtrace)
>   						BT_FUNC("(alt)", insn);
> @@ -2105,7 +2111,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   					return ret;
>   
>   			} else if (insn->jump_dest) {
> -				ret = validate_branch(file, func,
> +				ret = validate_branch(file, func, insn,
>   						      insn->jump_dest, state);
>   				if (ret) {
>   					if (backtrace)
> @@ -2236,7 +2242,8 @@ static int validate_unwind_hints(struct objtool_file *file)
>   
>   	for_each_insn(file, insn) {
>   		if (insn->hint && !insn->visited) {
> -			ret = validate_branch(file, insn->func, insn, state);
> +			ret = validate_branch(file, insn->func,
> +					      NULL, insn, state);
>   			if (ret && backtrace)
>   				BT_FUNC("<=== (hint)", insn);
>   			warnings += ret;
> @@ -2377,7 +2384,7 @@ static int validate_functions(struct objtool_file *file)
>   
>   			state.uaccess = func->uaccess_safe;
>   
> -			ret = validate_branch(file, func, insn, state);
> +			ret = validate_branch(file, func, NULL, insn, state);
>   			if (ret && backtrace)
>   				BT_FUNC("<=== (func)", insn);
>   			warnings += ret;
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index 6d875ca6fce0..cffb23d81782 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -33,7 +33,8 @@ struct instruction {
>   	unsigned int len;
>   	enum insn_type type;
>   	unsigned long immediate;
> -	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> +	unsigned int alt_group;
> +	bool dead_end, ignore, hint, save, restore, ignore_alts;
>   	bool retpoline_safe;
>   	u8 visited;
>   	struct symbol *call_dest;
> 

Cheers,

-- 
Julien Thierry

