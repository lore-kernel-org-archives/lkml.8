Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C1CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A450206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8GUEm92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgELREu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:04:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729271AbgELREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589303088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CULD28goGdMMpR8vAZMaK6S3zOis9WlKReUC6tq+TnY=;
        b=B8GUEm92O6r8gSNqvT1I/nmZUCCMTVeM2nW/D0WK1E+YqppP+KcXFC4i8AEgpeWxqEFskL
        JF589tEAbtJk5GefPdCex710JULUI3CtftCCtBjCcssyAjGoi3OgxWLGRI6NB5MXE1pugj
        3C248tT5l29kB5/QXtiiM17EXsPFS3U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-r6MY-MnTPy--HiJDMFGp-w-1; Tue, 12 May 2020 13:04:46 -0400
X-MC-Unique: r6MY-MnTPy--HiJDMFGp-w-1
Received: by mail-wm1-f70.google.com with SMTP id l26so1772929wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CULD28goGdMMpR8vAZMaK6S3zOis9WlKReUC6tq+TnY=;
        b=gA/t2Kj5+SBEZy2BJPxNWKDYNOZLWtd8mn35huwMpM7nTX/ePhmI37srlyLEE2pAok
         5HKePcw7o+Ec1M5aZMfxEhbN07JejQoPli2DopU0kccQRYeytTOuGRQ4iZwB4WPPGaKo
         Leb24jd6cyIjpfqRc4P770Y+vMRLZuoAUkfGgVGz9+g0MudODqOk3nSCcpqbelCo2EjI
         ciilid3BYoo/wax6/8NRiKWT5e4KnfyVg73nHeqRZRXKDmzsYpdyoIncpbnCYSaMRZlR
         ApNAP0GAfPBO1X3Cfd/uf/J85cMYIJ2wCvFim7nIYad54ipnBhIHujQyKIPrtgmXrAOB
         wcGg==
X-Gm-Message-State: AGi0Pua69SQxT4dFmfnNdDu4bHBJPunmV5FFTUgPs2E8X71L83E3WUyR
        5NsB3Yq2EqAZLg/KMe/ughWImHG7CR7dQx/wc52Ta6epDTvRAahSmbsRv1LPIaEQHEtM14asLTN
        vavpiuTxyAQkiKoVlvQlcCpY5
X-Received: by 2002:a5d:4248:: with SMTP id s8mr25583550wrr.216.1589303085399;
        Tue, 12 May 2020 10:04:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypLOEkp3WuBJdQnqqpb/4lnr6rZh/LIA6qPC9JP3oIY9hAHjNhPSRB/z0jmttDOlQ3tOOg/l9Q==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr25583534wrr.216.1589303085146;
        Tue, 12 May 2020 10:04:45 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id 81sm15940776wme.16.2020.05.12.10.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 10:04:44 -0700 (PDT)
Subject: Re: [RFC][PATCH 2/5] objtool: Move struct objtool_file into
 arch-independent header
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <dfa8c8aaf75493d739ef4f8feabf99bbb3f5d195.1588888003.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <f7e08aba-03cc-b57a-6122-3801091b1387@redhat.com>
Date:   Tue, 12 May 2020 18:04:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <dfa8c8aaf75493d739ef4f8feabf99bbb3f5d195.1588888003.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 5/11/20 6:35 PM, Matt Helsley wrote:
> The objtool_file structure describing the files objtool works on is
> not architecture dependent -- it's not x86 only -- and it will be useful
> for any future commands that might not be part of the check / orc
> tooling. So we move it from the check.h header  into the objtool.h header.
> 

The change itself looks alright to me, however I'd say the justification 
is more about the fact the more subcommands dealing with object files 
are going to be added to objtool, and all those subcommand will likely 
use the objtool_file representation.

I think it doesn't have much to do with arch specificity. (But this is 
really about the commit message, otherwise the changes make sense)

> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>   tools/objtool/check.h   | 10 +---------
>   tools/objtool/objtool.h | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+), 9 deletions(-)
>   create mode 100644 tools/objtool/objtool.h
> 
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index f0ce8ffe7135..ec6ff7f0970c 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -7,11 +7,10 @@
>   #define _CHECK_H
>   
>   #include <stdbool.h>
> -#include "elf.h"
> +#include "objtool.h"
>   #include "cfi.h"
>   #include "arch.h"
>   #include "orc.h"
> -#include <linux/hashtable.h>
>   
>   struct insn_state {
>   	struct cfi_reg cfa;
> @@ -47,13 +46,6 @@ struct instruction {
>   	struct orc_entry orc;
>   };
>   
> -struct objtool_file {
> -	struct elf *elf;
> -	struct list_head insn_list;
> -	DECLARE_HASHTABLE(insn_hash, 20);
> -	bool ignore_unreachables, c_file, hints, rodata;
> -};
> -
>   int check(const char *objname, bool orc);
>   
>   struct instruction *find_insn(struct objtool_file *file,
> diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
> new file mode 100644
> index 000000000000..afa52fe6f644
> --- /dev/null
> +++ b/tools/objtool/objtool.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
> + */
> +
> +#ifndef _OBJTOOL_H
> +#define _OBJTOOL_H
> +#include <stdbool.h>
> +#include <linux/list.h>
> +#include <linux/hashtable.h>
> +
> +#include "elf.h"
> +
> +struct objtool_file {
> +	struct elf *elf;
> +	struct list_head insn_list;
> +	DECLARE_HASHTABLE(insn_hash, 20);
> +	bool ignore_unreachables, c_file, hints, rodata;
> +};
> +#endif
> 

-- 
Julien Thierry

