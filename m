Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B53C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A120842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HZHcs+kJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgCDCWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:22:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38073 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgCDCWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:22:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id p7so308176pli.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 18:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OslAV9mLJU87ShUgNDM/Y8Td4Fc/ZYoQgnZ+SA4jRP4=;
        b=HZHcs+kJbkyqAdCktVsPVxMpigjF33NHQ91BkSN+PulxJBMgYMzvMbm4KzGsjfhnEs
         98hO8Cp/py0wqnLnm6Sd1ZMHD7UCzv20T/zBnr7LbgrRnf4/UFz70NpqHG5WGa5o12Pu
         GXT5j2FaD+x0WyG8OVtedJ++tVbwJJ2szUp0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OslAV9mLJU87ShUgNDM/Y8Td4Fc/ZYoQgnZ+SA4jRP4=;
        b=drJzucmjj2tNao8w38LixrT0axUD6MT/aGx9yxGvpQWeEC5ft6QEW0SrAgzKuPZE1o
         GgthstjiuBWmNlun4gXh8ZQUSif6DXvWpuMto24yN0dA7Fa2b1gl76PDg6i9hG1p8dmy
         BkimxEdRCoXL3XB01kWcAM5c84Bp1I+t3ueur0PQcKowGWbHpHRaYvQpOQFmWip38lLi
         tbvTMd7GqL5/rVXZUxK7q5HcKvsjDcTbwQIlv4zLe/5PUI7HHNS0sd/SUe/ZgcGWLbJA
         QpkmNjJ4WzL7negAE0pl3pdXk2U66mtzK8zNlZJOGtVbck9fXIseH1zkH5hrNsiIaQKH
         dkCQ==
X-Gm-Message-State: ANhLgQ2YU8r8lA5JLwnBYtR494m0ct77zB+CD1/84nmrRsqceyeFhEGX
        8wRmvifSJhqQ59a1ZGMzM8OKrg==
X-Google-Smtp-Source: ADFU+vv3JgHanygZXMBTQGHaaGvwMvnLimCLJ+XENS0VT2G8oSXcmGbWrdbcaCjBKhPBhC1A1tbsJQ==
X-Received: by 2002:a17:90a:9af:: with SMTP id 44mr633178pjo.160.1583288559031;
        Tue, 03 Mar 2020 18:22:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 15sm19917985pfp.125.2020.03.03.18.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 18:22:38 -0800 (PST)
Date:   Tue, 3 Mar 2020 18:22:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Jann Horn <jannh@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: SLUB: sysfs lets root force slab order below required minimum,
 causing memory corruption
Message-ID: <202003031820.7A0C4FF302@keescook>
References: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com>
 <alpine.DEB.2.21.2003031724400.77561@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003031724400.77561@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 05:26:14PM -0800, David Rientjes wrote:
> On Wed, 4 Mar 2020, Jann Horn wrote:
> 
> > Hi!
> > 
> > FYI, I noticed that if you do something like the following as root,
> > the system blows up pretty quickly with error messages about stuff
> > like corrupt freelist pointers because SLUB actually allows root to
> > force a page order that is smaller than what is required to store a
> > single object:
> > 
> >     echo 0 > /sys/kernel/slab/task_struct/order
> > 
> > The other SLUB debugging options, like red_zone, also look kind of
> > suspicious with regards to races (either racing with other writes to
> > the SLUB debugging options, or with object allocations).
> > 
> 
> Thanks for the report, Jann.  To address the most immediate issue, 
> allowing a smaller order than allowed, I think we'd need something like 
> this.
> 
> I can propose it as a formal patch if nobody has any alternate 
> suggestions?
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3598,7 +3598,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  	 */
>  	size = ALIGN(size, s->align);
>  	s->size = size;
> -	if (forced_order >= 0)
> +	if (forced_order >= slab_order(size, 1, MAX_ORDER, 1))
>  		order = forced_order;
>  	else
>  		order = calculate_order(size);

Seems reasonable!

For the race concerns, should this logic just make sure the resulting
order can never shrink? Or does it need much stronger atomicity?

-- 
Kees Cook
