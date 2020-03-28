Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D37EC2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DBC206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fym4U+Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgC1VYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:24:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41071 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgC1VYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:24:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id d24so1170234pll.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cy0P29m0MX5a7JFbLWS3gTrzYWk3vEpJ85XaL9jURGY=;
        b=Fym4U+OhmhAbl1OsMQYALcHZh8Cbq7DPseAxcdF8GVCBfn1m5pmejdl7MBDQzNM5R5
         OWM8ZW+4c4IgDFIM+ijx7Uyw5qH+xM7rIUfAN/56TFdAmOHiEMrXne2TRw5j8HUrDjtE
         hT+A1ibxBhq9Mf0aBoV5UbX7a/Co0SN5finZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cy0P29m0MX5a7JFbLWS3gTrzYWk3vEpJ85XaL9jURGY=;
        b=SEOUSlC8E6DN6EJfFh4sTgWFTff581gwqg9j5iCCsjXv4FNucJ9LMKhrbjJWMJTCY5
         qrhLzNngG7KHIxz3/9bz/xZXMRhlhCofGD1IaFZmXjlzapYJE8T7qbpDX9V0oUhkHLlE
         O3BPGczS3q3y8mNAD8MTg0yEtYlg90dbtyUUw5L6LGayb4lGuoTxb26XZMt+XAad8IFu
         V1I2myh1GJWVThAV97lDUkgIH3+y42+3XbT1D52/hYFyaSBzSfzkKL/VfCaMOCRWjXTX
         H2V7BBGPSfs2RU/3uCjpkQ6LFV7f7G48ZiKHoeUO5rnKsY++LV1/rmTaC639RNuPCGhk
         7P9Q==
X-Gm-Message-State: ANhLgQ2mXwy76Sf/FUKHSrwv02JDHElt4ykeO5xhQszH2mRRahxNPtQF
        51oPub1/h/cNI+pxDAeMU2W7lw==
X-Google-Smtp-Source: ADFU+vsIk9aw4uyC0avS98IH5kwZ5Uml814+6i6qlsjFCB+5DFcxd0rGLtkHO7OYR5+4vffyy3kG+Q==
X-Received: by 2002:a17:90a:fa8f:: with SMTP id cu15mr5295441pjb.108.1585430688506;
        Sat, 28 Mar 2020 14:24:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6sm6441542pjk.33.2020.03.28.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:24:47 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:24:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Jules Irenge <jbi.octave@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "open list:PROC SYSCTL" <linux-kernel@vger.kernel.org>,
        "open list:PROC SYSCTL" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] kernel/sysctl.c: Replace 1 and 0 by corresponding
 boolean value
Message-ID: <202003281423.E2DA6482@keescook>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
 <20200327212358.5752-10-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327212358.5752-10-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:23:56PM +0000, Jules Irenge wrote:
> Coccinelle reports a warning
> 
> WARNING: Assignment of 0/1 to bool variable
> 
> To fix this, values 1 and 0 of first variable
> are replaced by true and false respectively.
> Given that variable first is of bool type.
> This fixes the warnings.

Sure! Thanks. :)

> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/sysctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ad5b88a53c5a..4132a35e85bd 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3158,7 +3158,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  			 void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int err = 0;
> -	bool first = 1;
> +	bool first = true;
>  	size_t left = *lenp;
>  	unsigned long bitmap_len = table->maxlen;
>  	unsigned long *bitmap = *(unsigned long **) table->data;
> @@ -3249,7 +3249,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  			}
>  
>  			bitmap_set(tmp_bitmap, val_a, val_b - val_a + 1);
> -			first = 0;
> +			first = false;
>  			proc_skip_char(&p, &left, '\n');
>  		}
>  		kfree(kbuf);
> @@ -3281,7 +3281,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  					break;
>  			}
>  
> -			first = 0; bit_b++;
> +			first = false; bit_b++;
>  		}
>  		if (!err)
>  			err = proc_put_char(&buffer, &left, '\n');
> -- 
> 2.25.1
> 

-- 
Kees Cook
