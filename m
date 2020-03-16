Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF05C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9092520674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z4fiWqfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbgCPVYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:24:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38677 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgCPVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:24:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so8586978plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k6XAwrWDY/zsycDAo2K53Vl70GhIjA99tBrFA4ZGhTE=;
        b=Z4fiWqfQ8XqKDmI6T07Gvt9pSMGVDJUgyS7JXSsUrxYXw5wRk0V8uSAvIqRruGXw0p
         HJuR1b+QA5U1tbigOvOVLQ4OgbkYu4GefP+XZUhBtOVBKbOY/TueH94wGRDdLo1r9nve
         DPmbJMLt1BiluEmWC3f8a1Tkp1qIPaTIIKm9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k6XAwrWDY/zsycDAo2K53Vl70GhIjA99tBrFA4ZGhTE=;
        b=ousnD6RNdxtIG/Xk6NnefSXGUn2aXACiwoDYjw2U7p5WZKp0IXKVUVOsfGA+lY2dBg
         n1pAhb5fVGLmtAb7wXCoCJ8INLyiv3RWGEByVln4pL1rMXAxBEeTDTXom//+vdpHuMIv
         6bzQTLfxUjrdAc6a//O79TDn2rHL/6w4FwGWwkeXSaQJS3KO/7eo0AZZM0zIa57JXA4+
         eQlEMMMtgeiINMjxlnYEZisBSNnsrEYgsPBhu++bkzlMDgj7y/UgUISBeqr/RdSmtN8n
         RbNaC81m2AUvafox1hz5kE3kYuq+1PIUmY5zc9fPmToezQNmEjgH1vtefOkp8M9Z+R8U
         iOqQ==
X-Gm-Message-State: ANhLgQ30J4Ts9sDbcqY6MM1JYs+SNsgFC35Z/4hf6+GWWFHgvtx/25uv
        jwPVtNjQ1xx1z2GHoYL4aM0OOw==
X-Google-Smtp-Source: ADFU+vs68X9RkPUqkATV2iQxMOvZU1EVi/eKUQuxzDFOyagTnzRG37PM75ufsijB+ukeVItkeM7R/g==
X-Received: by 2002:a17:90a:c08f:: with SMTP id o15mr1552021pjs.155.1584393841314;
        Mon, 16 Mar 2020 14:24:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u26sm749763pfh.193.2020.03.16.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 14:24:00 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:23:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anton Protopopov <a.s.protopopov@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
Message-ID: <202003161423.B51FDA8083@keescook>
References: <20200316163646.2465-1-a.s.protopopov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316163646.2465-1-a.s.protopopov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 04:36:46PM +0000, Anton Protopopov wrote:
> The BPF_MOD ALU instructions could be utilized by seccomp classic BPF filters,
> but were missing from the explicit list of allowed calls since its introduction
> in the original e2cfabdfd075 ("seccomp: add system call filtering using BPF")
> commit.  Add support for these instructions by adding them to the allowed list
> in the seccomp_check_filter function.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

This has been suggested in the past, but was deemed ultimately redundant:
https://lore.kernel.org/lkml/201908121035.06695C79F@keescook/

Is there a strong reason it's needed?

Thanks!

-Kees

> ---
>  kernel/seccomp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index b6ea3dcb57bf..cae7561b44d4 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -206,6 +206,8 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>  		case BPF_ALU | BPF_MUL | BPF_X:
>  		case BPF_ALU | BPF_DIV | BPF_K:
>  		case BPF_ALU | BPF_DIV | BPF_X:
> +		case BPF_ALU | BPF_MOD | BPF_K:
> +		case BPF_ALU | BPF_MOD | BPF_X:
>  		case BPF_ALU | BPF_AND | BPF_K:
>  		case BPF_ALU | BPF_AND | BPF_X:
>  		case BPF_ALU | BPF_OR | BPF_K:
> -- 
> 2.19.1

-- 
Kees Cook
