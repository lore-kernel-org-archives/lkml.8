Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9354C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC0A2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPMywPtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgAMKUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:20:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60491 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgAMKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578910821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9b6t3nrFthuT+clwEzkYFFr2C6WgvCiJj3wXim9dnJ8=;
        b=DPMywPtlxFjdzFfjJGbTUhDiLGtOlB7iGXXnRZOXo8/xDO+1pfEMeG4XLw9JOBDHqGQ+zF
        vpPxZE8x5O16UpJQnGRwQSoKpp1dFqrllp/xFJUlZrtpQXZT8LFnzFvdrtJAXiuk/wnyVV
        BMF1khgd3cYLnRRsoYWsVyrBzNG0Z/4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-M9im3kHWN-OYybPEQci-_Q-1; Mon, 13 Jan 2020 05:20:18 -0500
X-MC-Unique: M9im3kHWN-OYybPEQci-_Q-1
Received: by mail-wm1-f69.google.com with SMTP id m133so1219441wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9b6t3nrFthuT+clwEzkYFFr2C6WgvCiJj3wXim9dnJ8=;
        b=hyFnRMn055OSVDjWxC9V7T0pIYzmSeg031XB76PY0Z55O6G9MLQIryy3Dh4qPz2i1f
         C8MYMN8hxpj3teP5qW8kNjINQuTsjHOee2+DVpOC0ZSyH17xArUyQdzRIVrV0ba5qBp6
         G7CMFvopf/Aiy6SBP0FrSUvt/KFQbFk5TLkU0ZxX0P8SFbNT/dCMbB0+K3QPD2rL/noa
         Nu3weRwVUxZ4o+5aiguL5WaqGa+76lPINObMtJ+6mTRBQykPxbNxNdZrjDfLCiVd8sjb
         vMovTJLWHVa99wk6OE7D5N3+MMQzYPdXJEmIsTAhtmic3CikHh+Tbv5JZw4kJYP9BJx+
         4gyA==
X-Gm-Message-State: APjAAAVpZB1A9FVinBk7NxZfRz7aO+zraMZAcaKawojAmQs2dzEIe8C6
        7Zz+V/OXvFSPpCmM8w4hRFhdr52FV6p72bTqOS8V1floMRzXiDNfF0UkfArp5TavCWiHpnMfOni
        aZedGUtg8QzBBerEgkj7NNKW5
X-Received: by 2002:a5d:6284:: with SMTP id k4mr17401081wru.398.1578910817485;
        Mon, 13 Jan 2020 02:20:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/3sZwKnGufJX+Iq7HNuXEFlwnipNGd9n2lT6CXWdDIZIKmf01k0FO6pbo7HJF6BuMtL62Rw==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr17401061wru.398.1578910817265;
        Mon, 13 Jan 2020 02:20:17 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id 25sm13439981wmi.32.2020.01.13.02.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 02:20:16 -0800 (PST)
Subject: Re: [RFC v5 14/57] objtool: Do not look for STT_NOTYPE symbols
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-15-jthierry@redhat.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <6c555096-3f20-0ae5-d04a-20eb30ebf7c7@redhat.com>
Date:   Mon, 13 Jan 2020 10:20:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200109160300.26150-15-jthierry@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/20 4:02 PM, Julien Thierry wrote:
> ELF symbols can have type STT_NOTYPE which have no standard semantics.
> 
> Arm64 objects will contain STT_NOTYPE symbols at the beginning of each
> section which aren't of any use to generic objtool code. Those symbols
> unfortunately overlap with the first function of the section.
> 
> Skip symbols with type STT_NOTYPE when looking up symbols.
> 

Turns out some x86 callable objects have STT_NOTYPE (in the current case 
error_entry in arch/x86/entry/entry_64.S, and it seems to be the case 
for all asm symbols annotated with SYM_CODE_START_LOCAL).

A solution that works both for x86 and arm64 is that if the symbol has 
STT_NOTYPE, continue looking for another symbol at the same offset. If 
none is available, return the STT_NOTYPE symbol.

I'll fix that in next iteration.

> Suggested-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>   tools/objtool/elf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index edba4745f25a..c6ac0b771b73 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -62,7 +62,8 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
>   	struct symbol *sym;
>   
>   	list_for_each_entry(sym, &sec->symbol_list, list)
> -		if (sym->type != STT_SECTION &&
> +		if (sym->type != STT_NOTYPE &&
> +		    sym->type != STT_SECTION &&
>   		    sym->offset == offset)
>   			return sym;
>   
> 

-- 
Julien Thierry

