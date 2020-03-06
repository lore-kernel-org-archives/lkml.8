Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934FAC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0F22084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Iw0ZWJAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCFKko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:40:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44461 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:40:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id n7so1728522wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3uwQmoeCVMR1OjRUyFcSdUC36g6Oo2T6mj6l89+Qx08=;
        b=Iw0ZWJATxL79py60HW/tvolmLUL5DiTJF3n+O9KSkscsoVaDd1sC+1a99B/XaFEnvD
         pufFlRVL3+f+wG50aKPpypMk0JrVexnVpCKewc0I7WHWdopgdwRd8hv6V7g5QwBmbzwS
         QJ68Po5jb2PQb1aJ9Oo25pmODM/axP3qzitM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3uwQmoeCVMR1OjRUyFcSdUC36g6Oo2T6mj6l89+Qx08=;
        b=PWzwYnD/biv5fYm6meoCWb0D5oVDIIfG68kK4GAdXc8SFXScYgB7FkGVMt7XmLw44c
         ZstlZUe0GTGHrsZGwpVL1iGCD6C9gZSfgA6r2itLFFoVVfjljiJaN+gp5LngIGwSNA/9
         5060oddlxos/P1gF9cTXemlCdG5yEM+aCr5H8u2vptjKnDl2Xcb8UEq3wwrQsx6KeXGo
         4dnM/MtNc/8wYdO0QaF+ht66i3tCbAr4sTrgDYCyRLI5VWhzgBNFDtZccrDkSoKQ4bXz
         LRtDoL+Sbzlf8x+pZEt8MbKJnT5QcihwdvnLBPkhWnAaIjjg27Y6V8bhLfDDSqwHksEf
         1IFw==
X-Gm-Message-State: ANhLgQ3LeksVPeS1CAWlhhjFDeXmNnacN3X1baiCqLJaW8cJCKWxgS7+
        22uW95/11iK1dUhAiQF2xxFcRA==
X-Google-Smtp-Source: ADFU+vt7qifkWSBCAuJEHAUYhMENNpFsi58HIatC73FFg/bEqMfF/ZaCUxUJrkB7PDaKqB+vx7xcIA==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr2203376wrx.14.1583491241522;
        Fri, 06 Mar 2020 02:40:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t14sm16353673wrp.63.2020.03.06.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:40:40 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:40:39 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/gma500/intel_bios.h: Replace zero-length array
 with flexible-array member
Message-ID: <20200306104039.GU2363188@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200305105306.GA18788@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305105306.GA18788@embeddedor>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:53:06AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/gma500/intel_bios.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/intel_bios.h b/drivers/gpu/drm/gma500/intel_bios.h
> index a1f9ce9465a5..0e6facf21e33 100644
> --- a/drivers/gpu/drm/gma500/intel_bios.h
> +++ b/drivers/gpu/drm/gma500/intel_bios.h
> @@ -227,7 +227,7 @@ struct bdb_general_definitions {
>  	 * number = (block_size - sizeof(bdb_general_definitions))/
>  	 *	     sizeof(child_device_config);
>  	 */
> -	struct child_device_config devices[0];
> +	struct child_device_config devices[];
>  };
>  
>  struct bdb_lvds_options {
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
