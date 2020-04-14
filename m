Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE2DC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FD320678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agU7ZzuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440613AbgDNPjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:39:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37735 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2440068AbgDNPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586878562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPH5+ERTs+09agveZvUKPS3T0LNadgD1vvjpPSHRMOk=;
        b=agU7ZzuZAb8JlDz1wMei8QlQM17YNRWDCXlfuJdrn/CA03tri9xHh4B255PeXxDnItg8DB
        C82aDdDRZSwx7oBT15gCV5izSyGTNf/mjWyY8g2A6qJf6kfluGslzmAZsPw8Jt8zBhJma+
        K3lbzJetU30iDkA9Lav4V1isCVsQn1w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Yv9hBWK8NIeNwhiKoLyXpg-1; Tue, 14 Apr 2020 11:36:00 -0400
X-MC-Unique: Yv9hBWK8NIeNwhiKoLyXpg-1
Received: by mail-wm1-f69.google.com with SMTP id h6so3953439wmi.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cPH5+ERTs+09agveZvUKPS3T0LNadgD1vvjpPSHRMOk=;
        b=H8MtYtUd+xsY9rJTnlf5wYcYZeYm4yNXH0V7aZjgwDRp78J93govO7fC8uZxpSw8Qj
         GcyZTv4mLpZ2BUwejSoJzGuLC9Cs3URjYKL2XFd49kAyNEW2vYEdEf5iA5hN1M+8C3Kv
         wjj8Vg4Np2sYFaNsjndDtYqMGcgzjJhVTs+0VwuOU7/D9vY/BN+j1qLcZO+wlHw0wFxc
         g+WvPd47A3YKvQXS4yP9yWiJsJQb0x7AtWtFC8Izr73iMsD7XMImV1gIlszqMNjBpQG3
         esPIlfyNguk71ma4NVnWiNqoKw/HpZ47n0FZr4Fe9K/ytS0xLETeA+785qvVlnsmxzIq
         b40g==
X-Gm-Message-State: AGi0PuYLarAYzR+hY7fxikaUa81bN0UcmNevAugWaOrGX0xG0k5BGsXJ
        pgdRkugW5EgoDmzDxBx8HQYxp0RXgAncmi1QxD51N3dmb1PxBOgIlnCh/MGxMZlVSGhGiHswa43
        dSPLR3ELNkBZF744WPyPcE7gb
X-Received: by 2002:adf:f750:: with SMTP id z16mr23291338wrp.115.1586878559032;
        Tue, 14 Apr 2020 08:35:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoniegJxHYMyoZLd5dDpKD7ZZrUgyD86JBP3xaxzjiUIITTjt93IGq3VzsNHu1ZpW3jtXn+w==
X-Received: by 2002:adf:f750:: with SMTP id z16mr23291323wrp.115.1586878558774;
        Tue, 14 Apr 2020 08:35:58 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id q143sm20179957wme.31.2020.04.14.08.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 08:35:58 -0700 (PDT)
Subject: Re: [PATCH V3 6/9] objtool: Report inconsistent stack changes in
 alternative
To:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-7-alexandre.chartre@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <bc4bfade-6080-72da-5181-b97cd21076ff@redhat.com>
Date:   Tue, 14 Apr 2020 16:35:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414103618.12657-7-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 4/14/20 11:36 AM, Alexandre Chartre wrote:
> To allow a valid stack unwinding, an alternative should have code
> where the same stack changes happens at the same places as in the
> original code. Add a check in objtool to validate that stack changes
> in alternative are effectively consitent with the original code.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>   tools/objtool/check.c | 155 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 155 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0574ce8e232d..9488a9c7be24 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2724,6 +2724,156 @@ static int validate_reachable_instructions(struct objtool_file *file)
>   	return 0;
>   }
>   
> +static int validate_alternative_state(struct objtool_file *file,
> +				      struct instruction *first,
> +				      struct instruction *prev,
> +				      struct instruction *current,
> +				      bool include_current)
> +{
> +	struct instruction *alt_insn, *alt_first;
> +	unsigned long roff_prev, roff_curr, roff;
> +	int count, err = 0, err_alt, alt_num;
> +	struct alternative *alt;
> +	const char *err_str;
> +
> +	/*
> +	 * Check that instructions in alternatives between the corresponding
> +	 * previous and current instructions, have the same stack state.
> +	 */
> +
> +	/* use relative offset to find corresponding alt instructions */
> +	roff_prev = prev->offset - first->offset;
> +	roff_curr = current->offset - first->offset;
> +	alt_num = 0;
> +
> +	list_for_each_entry(alt, &first->alts, list) {
> +		if (!alt->insn->alt_group)
> +			continue;
> +
> +		alt_num++;
> +		alt_first = alt->insn;
> +		count = 0;
> +		err_alt = 0;

Unless I'm missing something, err_alt is wither 1 or 0, so perhaps a 
boolean would be more appropriate.

> +
> +		for (alt_insn = alt_first;
> +		     alt_insn && alt_insn->alt_group == alt_first->alt_group;
> +		     alt_insn = next_insn_same_sec(file, alt_insn)) {
> +
> +			roff = alt_insn->offset - alt_first->offset;
> +			if (roff < roff_prev)
> +				continue;
> +
> +			if (roff > roff_curr ||
> +			    (roff == roff_curr && !include_current))
> +				break;
> +
> +			count++;
> +			/*
> +			 * The first instruction we check must be aligned with
> +			 * the corresponding "prev" instruction because stack
> +			 * change should happen at the same offset.
> +			 */
> +			if (count == 1 && roff != roff_prev) {
> +				err_str = "misaligned alternative state change";
> +				err_alt++;
> +			}
> +
> +			if (!err_alt && memcmp(&prev->state, &alt_insn->state,
> +					       sizeof(struct insn_state))) {

In insn_state_match(), not the whole of the insn_state is taken into 
account. In particular, uaccess_stack, uaccess, df and end are not 
compared. Also, stack_size (but maybe that should be included in 
insn_state_match() ) and vals are not checked.

Is there a reason we'd check those for alternatives but not in the 
normal case? And does your alternative validation work with uaccess check?

> +				err_str = "invalid alternative state";
> +				err_alt++;
> +			}
> +
> +			/*
> +			 * On error, report the error and stop checking
> +			 * this alternative but continue checking other
> +			 * alternatives.
> +			 */
> +			if (err_alt) {
> +				if (!err) {
> +					WARN_FUNC("error in alternative",
> +						  first->sec, first->offset);
> +				}
> +				WARN_FUNC("in alternative %d",
> +					  alt_first->sec, alt_first->offset,
> +					  alt_num);
> +				WARN_FUNC("%s", alt_insn->sec, alt_insn->offset,
> +					  err_str);
> +
> +				err += err_alt;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int validate_alternative(struct objtool_file *file)
> +{
> +	struct instruction *first, *prev, *next, *insn;
> +	bool in_alternative;
> +	int err;
> +
> +	err = 0;
> +	first = prev = NULL;
> +	in_alternative = false;
> +	for_each_insn(file, insn) {
> +		if (insn->ignore || !insn->alt_group || insn->ignore_alts)
> +			continue;
> +
> +		if (!in_alternative) {
> +			if (list_empty(&insn->alts))
> +				continue;
> +
> +			/*
> +			 * Setup variables to start the processing of a
> +			 * new alternative.
> +			 */
> +			first = insn;
> +			prev = insn;
> +			err = 0;
> +			in_alternative = true;
> +
> +		} else if (!err && memcmp(&prev->state, &insn->state,
> +					  sizeof(struct insn_state))) {
> +			/*
> +			 * The stack state has changed and no error was
> +			 * reported for this alternative. Check that the
> +			 * stack state is the same in all alternatives
> +			 * between the last check and up to this instruction.
> +			 *
> +			 * Once we have an error, stop checking the
> +			 * alternative because once the stack state is
> +			 * inconsistent, it will likely be inconsistent
> +			 * for other instructions as well.
> +			 */
> +			err = validate_alternative_state(file, first,
> +							 prev, insn, false);
> +			prev = insn;
> +		}
> +
> +		/*
> +		 * If the next instruction is in the same alternative then
> +		 * continue with processing this alternative. Otherwise
> +		 * that's the end of this alternative so check there is no
> +		 * stack state changes in remaining instructions (if no
> +		 * error was reported yet).
> +		 */
> +		next = list_next_entry(insn, list);
> +		if (next && !next->ignore &&
> +		    next->alt_group == first->alt_group)
> +			continue;
> +
> +		if (!err)
> +			err = validate_alternative_state(file, first,
> +							 prev, insn, true);
> +		in_alternative = false;
> +	}
> +
> +	return 0;
> +}
> +
>   static struct objtool_file file;
>   
>   int check(const char *_objname, bool orc)
> @@ -2769,6 +2919,11 @@ int check(const char *_objname, bool orc)
>   		goto out;
>   	warnings += ret;
>   
> +	ret = validate_alternative(&file);
> +	if (ret < 0)
> +		goto out;
> +	warnings += ret;
> +
>   	if (!warnings) {
>   		ret = validate_reachable_instructions(&file);
>   		if (ret < 0)
> 

Cheers,

-- 
Julien Thierry

