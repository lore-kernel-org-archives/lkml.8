Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E764C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1422A20675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+2NdbO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBKIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:16:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbgBKIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581408968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYZUJREDEE9g54q7OqZkjYWU4pIAXyPMj6QVRJEVGV8=;
        b=E+2NdbO7OSBaimDln9BdPyHviIZFHCrWA32wJnkqgS2OStD3uoZ00l7CssjN0MyCp+JJIO
        1p1iUimTRY+d8OpcGsXahTgR8NYpzI341HKDoHbt9zW+LxPYpbk+QT7lcruDHxAFVn+dgl
        C5yymjL6kc1vI6cjlz8B9nZGYNrBea8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-EE9Lv7rsOYqhD0rJq2PhyA-1; Tue, 11 Feb 2020 03:16:05 -0500
X-MC-Unique: EE9Lv7rsOYqhD0rJq2PhyA-1
Received: by mail-wm1-f70.google.com with SMTP id p2so732207wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 00:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JYZUJREDEE9g54q7OqZkjYWU4pIAXyPMj6QVRJEVGV8=;
        b=HhtTlpilTuIoE0FDDwCU6qi6RCCUIP4VQIRnn/wxQ9115fPkLFdwVeuDSDvRf2jEUN
         kmeiJCVMQh7L0mQpTDVZlxTNSE/uqBhjMqBFQV8zZmSnI513zTeY2PQjeR4yumnffQ3a
         izKwldcm20Fqcb19N1dKJ5y6rGK8P+2uK9aHlx3NIYixHPDyjhsD5ICaZmeFvQ/nhzUK
         IMuKO8Ff+tFoj8RFmJIF6B7zgwhEXyl4cllo6v7dOELh0ktTw07HnSGMY8cdJS8+JGCU
         ZDYvuozFxjpgbYjMPPY8vTbf7Cp0M60OJA/axi/GDhBeCQV/bVgIw8DcvPnC8PK5Kuyu
         AI3Q==
X-Gm-Message-State: APjAAAUNBPnzNR56qdUY43CK3BYS5xThLaKSinLxXd64yOcsMf7rZQnp
        fKoVLTBn3Zx4eLbBUnnNeV32lAitWyXLrEOVV3DlGkasdBvKM7a7ewkuxNjvNnsHJNHCW5UzoiY
        sgbByK04jJEPuzibNFKZ6Kz8q
X-Received: by 2002:a1c:f009:: with SMTP id a9mr4124569wmb.73.1581408963953;
        Tue, 11 Feb 2020 00:16:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqybO1BAnZIfA6i+udGEmbdw/CtdNNXCXgZQP+WLzSM4lROyM82z9DFdZQwCzQRWKF7khXaZ6A==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr4124530wmb.73.1581408963664;
        Tue, 11 Feb 2020 00:16:03 -0800 (PST)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id y8sm2681250wma.10.2020.02.11.00.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 00:16:02 -0800 (PST)
Subject: Re: [PATCH 3/3] objtool: Add relocation check for alternative
 sections
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cover.1581359535.git.jpoimboe@redhat.com>
 <7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <1bc9dfd5-0652-c5e1-7ab2-cdd025edc01b@redhat.com>
Date:   Tue, 11 Feb 2020 08:16:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 6:32 PM, Josh Poimboeuf wrote:
> Relocations in alternative code can be dangerous, because the code is
> copy/pasted to the text section after relocations have been resolved,
> which can corrupt PC-relative addresses.
> 
> However, relocations might be acceptable in some cases, depending on the
> architecture.  For example, the x86 alternatives code manually fixes up
> the target addresses for PC-relative jumps and calls.
> 
> So disallow relocations in alternative code, except where the x86 arch
> code allows it.
> 
> This code may need to be tweaked for other arches when objtool gets
> support for them.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>   tools/objtool/check.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5ea2ce7ed8a3..2d52a40e6cb9 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -786,6 +786,27 @@ static int handle_group_alt(struct objtool_file *file,
>   		insn->ignore = orig_insn->ignore_alts;
>   		insn->func = orig_insn->func;
>   
> +		/*
> +		 * Since alternative replacement code is copy/pasted by the
> +		 * kernel after applying relocations, generally such code can't
> +		 * have relative-address relocation references to outside the
> +		 * .altinstr_replacement section, unless the arch's
> +		 * alternatives code can adjust the relative offsets
> +		 * accordingly.
> +		 *
> +		 * The x86 alternatives code adjusts the offsets only when it
> +		 * encounters a branch instruction at the very beginning of the
> +		 * replacement group.

Yes, arm64 is a bit more permissive regarding this although it does 
disallow some patterns.

I guess once we introduce other archs there should be some function:

bool arch_validate_alt_insn(struct instruction *new, struct instruction 
*new, struct special_alt *alt);

> +		 */
> +		if ((insn->offset != special_alt->new_off ||
> +		    (insn->type != INSN_CALL && !is_static_jump(insn))) &&
> +		    find_rela_by_dest_range(insn->sec, insn->offset, insn->len)) {
> +
> +			WARN_FUNC("unsupported relocation in alternatives section",
> +				  insn->sec, insn->offset);
> +			return -1;
> +		}
> +
>   		if (!is_static_jump(insn))
>   			continue;
>   
> 

Reviewed-by: Julien Thierry <jthierry@redhat.com>

Cheers,

-- 
Julien Thierry

