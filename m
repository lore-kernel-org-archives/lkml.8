Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95CEC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B006F222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UmXHXH52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgB2XXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:23:14 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35267 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:23:14 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so1014285pjq.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sC3t5GcfT+mcs+Zl2p6smFfDxG3Nl3S/QcoxnFPIWpo=;
        b=UmXHXH52+3Ibq5SY+DNh7RIg8T1q46HbakkJRAP/XErovTGr0KFi97JvUqadnH/Qjr
         L9w/0j4cC3oBKseA4rV+Y+oVI7+M4QrrFFuTVNOB7SlkP9qTSvM7MpXqakjP/ekXwrrQ
         TiWSi5ZIHMZ5aUBf8/dCfcojIKCdtRQ/4geaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sC3t5GcfT+mcs+Zl2p6smFfDxG3Nl3S/QcoxnFPIWpo=;
        b=QwEpbcYcjHCGZGwiIt5nUMphPyd6SSYGVaEkZuF6u5Qos0ARRB0Hz0E4DtXu/Jqnd6
         h0XFzhoZemBwi4ONxfkpND/pc7JEpEG4A0J+W7lqSetjIDbrEZhNmXFSiuHflR9vbvP5
         GhpzspWReU7huZTd9VQRYPyf+QbiNqXQ9UC+AJtvXhW8Qrs1DdlVLOix7qpdoRUW0VDw
         a12VN8PCZp1fbcJQ+uWqYlZHZgpDV9181QgZAB+VsriRuPvyDOAESQy1xUZNtuRkp7/6
         shFMsKtSQ5P2LzqNseldQgVRRiawik+/9cyGvHYaQ5/Y1+ZtsDZ/eQmv5wRbk7FF7/+V
         iG0g==
X-Gm-Message-State: APjAAAX8oDVx2LpPQKrpd1hfjEu4BBzUShc/xNTuPgZ4sGVs0OJzrqvi
        Zj301xxF34047uowfU8EnOiMxg==
X-Google-Smtp-Source: APXvYqzVpbm3DEESlR++G+OA4fQWfBPAh03D5/Ll8Sl1B81nyeETr8NLa8x/DcUXrDFDPjAxKgZrfw==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr10571774ple.95.1583018593161;
        Sat, 29 Feb 2020 15:23:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19sm8278912pgf.33.2020.02.29.15.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 15:23:12 -0800 (PST)
Date:   Sat, 29 Feb 2020 15:23:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     x86@kernel.org
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/init: Stop printing pgt_buf addresses
Message-ID: <202002291522.0EDB380@keescook>
References: <20200229231120.1147527-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229231120.1147527-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 06:11:20PM -0500, Arvind Sankar wrote:
> This currently leaks kernel physical addresses into userspace.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/mm/init.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index e7bb483557c9..dc4711f09cdc 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -121,8 +121,6 @@ __ref void *alloc_low_pages(unsigned int num)
>  	} else {
>  		pfn = pgt_buf_end;
>  		pgt_buf_end += num;
> -		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
> -			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
>  	}
>  
>  	for (i = 0; i < num; i++) {
> -- 
> 2.24.1
> 

-- 
Kees Cook
