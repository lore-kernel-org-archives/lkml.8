Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AFDC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA076206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkF8YlBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgBKHxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 02:53:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27312 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727178AbgBKHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 02:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581407600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h89ncAILXDd64G8Hr1cFUyQNlpOw8eh03nIRn217iv4=;
        b=AkF8YlBWsLii3LPQDIN6aTjSHB5IhUiPNPYlLSJ7URXKUIKefwjYUEHVS1G2x/4v6Ag9tW
        74qj+qrd7ifcSjZVl1bE+SzD000yLlosy82gOaGDddxIfzjUhG8QYNdpT07czqvgt8Inet
        7fSKWSbaC2w3Ug/y7UbH00ppnqYvC1w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-cOSXjYFUO3SM6oWNqjS6vg-1; Tue, 11 Feb 2020 02:53:19 -0500
X-MC-Unique: cOSXjYFUO3SM6oWNqjS6vg-1
Received: by mail-wm1-f69.google.com with SMTP id s25so986488wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 23:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h89ncAILXDd64G8Hr1cFUyQNlpOw8eh03nIRn217iv4=;
        b=Gwe15RvJPoaS+7w5GI7w7FBMEZKXDzBwe84A4TuvVeO4Gti7E1XLpt3v9nMzjvwMzl
         zkdnDAe8InX8+TkBJRlnGDcbvKaE3Fdd43dS3JZ7KedQoARo4aS5FV7f+icQr3fdWxg7
         nrJUM3+tqpXpkbUXT1q5Q86D2NUuaVTzWJpmigKqgToVWYZaOLxgmdtbXli5uZy/Lf31
         EIVXBy/TzxLD/CqUQXZpplXh6C63oal+/1FjxAvDc/yOCVCffPz6hV3Y9/yqcOpND7nZ
         4SS7+zks34ghPt4kmMJ8u5QWQlmhsvpe1E6LeNVCK9JdCL0qPpfghksZ5+kwqbjXoy2i
         DqLw==
X-Gm-Message-State: APjAAAWcfymfD9QskEhk7lnKKFWlWw2/c3gI+i2+q0/y9ko5iRa9mTyz
        l16D3nX74rdNZl44UWgBl+vrbGoO5vezqlORS080UIBpjAXobMtMk2s7VRV+ls93t84LH1ZLGg7
        WKmsZ6tgddgxZilerAL3MR2Ln
X-Received: by 2002:a1c:f008:: with SMTP id a8mr3934912wmb.81.1581407597914;
        Mon, 10 Feb 2020 23:53:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQyFyhVvz9Z/OiKSdVIox1vpIS3JXX42hJELYO3hfzHcFDioRGc+pv5wQ4f+IDr3DDY29Agg==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr3934881wmb.81.1581407597649;
        Mon, 10 Feb 2020 23:53:17 -0800 (PST)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id p26sm2511460wmc.24.2020.02.10.23.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 23:53:17 -0800 (PST)
Subject: Re: [PATCH 2/3] objtool: Add is_static_jump() helper
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1581359535.git.jpoimboe@redhat.com>
 <9b8b438df918276315e4765c60d2587f3c7ad698.1581359535.git.jpoimboe@redhat.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <e582e4d4-32b1-260d-96d6-69267455788d@redhat.com>
Date:   Tue, 11 Feb 2020 07:52:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9b8b438df918276315e4765c60d2587f3c7ad698.1581359535.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 6:32 PM, Josh Poimboeuf wrote:
> There are several places where objtool tests for a non-dynamic (aka
> direct) jump.  Move the check to a helper function.
> 

Makes sense.

> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Julien Thierry <jthierry@redhat.com>

> ---
>   tools/objtool/check.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 61d2d1877fd2..5ea2ce7ed8a3 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -97,14 +97,19 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
>   	for (insn = next_insn_same_sec(file, insn); insn;		\
>   	     insn = next_insn_same_sec(file, insn))
>   
> +static bool is_static_jump(struct instruction *insn)
> +{
> +	return insn->type == INSN_JUMP_CONDITIONAL ||
> +	       insn->type == INSN_JUMP_UNCONDITIONAL;
> +}
> +
>   static bool is_sibling_call(struct instruction *insn)
>   {
>   	/* An indirect jump is either a sibling call or a jump to a table. */
>   	if (insn->type == INSN_JUMP_DYNAMIC)
>   		return list_empty(&insn->alts);
>   
> -	if (insn->type != INSN_JUMP_CONDITIONAL &&
> -	    insn->type != INSN_JUMP_UNCONDITIONAL)
> +	if (!is_static_jump(insn))
>   		return false;
>   
>   	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
> @@ -571,8 +576,7 @@ static int add_jump_destinations(struct objtool_file *file)
>   	unsigned long dest_off;
>   
>   	for_each_insn(file, insn) {
> -		if (insn->type != INSN_JUMP_CONDITIONAL &&
> -		    insn->type != INSN_JUMP_UNCONDITIONAL)
> +		if (!is_static_jump(insn))
>   			continue;
>   
>   		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
> @@ -782,8 +786,7 @@ static int handle_group_alt(struct objtool_file *file,
>   		insn->ignore = orig_insn->ignore_alts;
>   		insn->func = orig_insn->func;
>   
> -		if (insn->type != INSN_JUMP_CONDITIONAL &&
> -		    insn->type != INSN_JUMP_UNCONDITIONAL)
> +		if (!is_static_jump(insn))
>   			continue;
>   
>   		if (!insn->immediate)
> 

-- 
Julien Thierry

