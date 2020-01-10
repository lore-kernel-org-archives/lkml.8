Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE26C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 05:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A51420721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 05:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dqJTwC9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgAJFNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 00:13:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51567 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgAJFNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 00:13:02 -0500
Received: by mail-pj1-f67.google.com with SMTP id j11so467863pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 21:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tmf+Kxucvb62NiCjSTWMZBNjJ8UNF1K5QBIAcifMgQI=;
        b=dqJTwC9nF+cQfR6H5U3TZiI9pnBoPZjL1vGQJveXhqrGGKv+0e0PiUtmGFRLEVIi9H
         PSrgKfip+Q8V76oK2lCMuGJnruqiAcJBDkHaKQgBPMN7yNGnReo2sKZldcep+jgXgpm4
         1X4p7ZaUv18Ed3P6kabJ4llMEdx8+fvGPmLjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tmf+Kxucvb62NiCjSTWMZBNjJ8UNF1K5QBIAcifMgQI=;
        b=p5K58uqCdLVe2jLC35ddNJJNlyxao2okwystvQpWa33UQGhjx5gIzswoGZ/H5UAkvM
         YfihcChp/TbY8oFcn4bDpIryY9V1SYjqYwoOlQ48Kk3ED52iaSBkZRONIOFG4TWwT4FY
         QGISFa6Vfxw4HY3LVPA3EHTasny8T8uBSVxSucITYSkBSlbPK/+OTcp0HkiYQjg1/5pu
         Je0feWk6uE02XTrQdj+3puY+eOY6nfktVQEy6pVwa0cfl6VstOGgiyQY2bLCzHyiVZ5A
         Nb5iYaU/Jzk0LY7bN/9RPeR2Z6Bh+bRIq0COaOuma2KyEBL6CT0eZferugBpx89w1j2O
         vIww==
X-Gm-Message-State: APjAAAXIzor6OtCiZ8wfB9k7N1x05W/Bavs9d8aHpvLMTySP8z7+CMTX
        J+1BW9AEOpTbLD1PMP9P0EEuXg==
X-Google-Smtp-Source: APXvYqya22I94aB51t/b5586U5xsAVsE1JwObmcgOBjtPfTa0YzbMamXcKH1ztnT77pUjbQTqlTx0Q==
X-Received: by 2002:a17:90b:8b:: with SMTP id bb11mr2367447pjb.27.1578633181385;
        Thu, 09 Jan 2020 21:13:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g19sm847886pfh.134.2020.01.09.21.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 21:13:00 -0800 (PST)
Date:   Thu, 9 Jan 2020 21:12:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] init: fix misleading "This architecture does not have
 kernel memory protection" message
Message-ID: <202001092112.14F20C4DCE@keescook>
References: <62477e446d9685459d4f27d193af6ff1bd69d55f.1578557581.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62477e446d9685459d4f27d193af6ff1bd69d55f.1578557581.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:15:01AM +0000, Christophe Leroy wrote:
> This message leads to think that memory protection is not implemented
> for the said architecture, whereas absence of CONFIG_STRICT_KERNEL_RWX
> only means that memory protection has not been selected at
> compile time.
> 
> Don't print this message when CONFIG_ARCH_HAS_STRICT_KERNEL_RWX is
> selected by the architecture. Instead, print "Kernel memory protection
> not selected by kernel config."
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Oh, yes, I like this. Should the message include a hint to the config
name?

Regardless:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  init/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 2cd736059416..fd31b15cc910 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1090,6 +1090,11 @@ static void mark_readonly(void)
>  	} else
>  		pr_info("Kernel memory protection disabled.\n");
>  }
> +#elif defined(CONFIG_ARCH_HAS_STRICT_KERNEL_RWX)
> +static inline void mark_readonly(void)
> +{
> +	pr_warn("Kernel memory protection not selected by kernel config.\n");
> +}
>  #else
>  static inline void mark_readonly(void)
>  {
> -- 
> 2.13.3
> 

-- 
Kees Cook
