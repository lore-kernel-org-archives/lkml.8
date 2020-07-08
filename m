Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C653C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1933B20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6ByzxiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgGHNsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgGHNsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:48:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887CC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:48:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j11so5586331ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tte8fl2zX3N2A0a3qeEnOT38zkmn+tzTckPAuzOgzME=;
        b=S6ByzxiAg4LODlPItwZaDXaMBGaPRyVORGLaO3tWgy4Ca1ZBGEMMd1jn4feb9AlOYh
         91BgReIkZ3nCgZ/mDHda/uVaZEgYZ1Xs1JWd4I/7/8e+Pp3b25qtC3lZWXwVvNRoUJ1e
         EqOC66OSW7gOOKj056PFbK2CQ76tsCbJOuzovIixvtOSIZJAmsfWCTNlrrunT6KMv3yr
         SwLWEowB9+4wf67ExE2iX/R/8AlA/1D5CIe3j+9cTed/WLN8p1voghsYFLY8PQ4RwIRS
         II18e5+eNrk44AbBZ/JLpC+faXMe+Dmipha69debboFjon+zDH5Zt5CEmISFfeAfXyAd
         VoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tte8fl2zX3N2A0a3qeEnOT38zkmn+tzTckPAuzOgzME=;
        b=MYx1PXUbHpUTY3GvDAihWgDuHLtOStVVkhC4VcK1ZiDXGjqnmliXlhAMVBS96GuSGu
         WJLTj21Z363x0wasRJZxIC/IUvN2kQwsKz6MebIYmAWQnsR9ljwSLP6LgIc1K6WJAePs
         pc2E6URcYQEIrsGeLuzdnH9+y5nkfOH7IuxJTH+nnrxkZK3cZYajC5Vd2zIKeNxy1EWl
         1aq9+BuF4yGqwUKr/nc+2zpLQg6VL+PerZ2S9+hMnQJubsHHGPgp9W4VNWGfWLAGctfz
         fHA08oJowOrotBVUgycndg38x3eUTojFmaOuKqdptstGa/vHNatyuzWg5sHT4qum8UEk
         LI4w==
X-Gm-Message-State: AOAM533cYkFt9qzOMxN01tyluPHzN6j7ispA45exo/jziKFZv6zUl1Kg
        mmsAtKCvzWH6A/sfJHpWRA8LQFrlT8d0zg==
X-Google-Smtp-Source: ABdhPJwPsTX7AMMbgbtj7GkFYv0wJTLthu7dNh/d7KOkmiOHolN2F1AirELR6sntpwwiuYRRtxQkMQ==
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr31554697ljg.284.1594216087280;
        Wed, 08 Jul 2020 06:48:07 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m10sm1070089lji.72.2020.07.08.06.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 06:48:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 8 Jul 2020 15:48:04 +0200
To:     "tiantao (H)" <tiantao6@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] vmalloc: Removing incorrect logs when vmalloc failed
Message-ID: <20200708134804.GA32309@pc636>
References: <1594113232-32193-1-git-send-email-tiantao6@hisilicon.com>
 <5e7885ef-081e-0682-7be7-40eb7712d2c7@arm.com>
 <20200707132442.GA26493@pc636>
 <3cf13a05-a6b8-aa2f-752d-f9a25a1005f9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf13a05-a6b8-aa2f-752d-f9a25a1005f9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On 07/07/2020 02:43 PM, Tian Tao wrote:
> > > > It is not possible to increase size with vmalloc=<size> in arm64
> > > > architecture and it will mislead.however vmalloc return failure
> > > > is a rare occurrence in 'many architectures including arm64'.
> > > 
> > > But there is a chance that vmalloc() might work on architectures
> > > that support 'vmalloc=' command line i.e after a change and this
> > > information here might be helpful in those cases.
> > > 
> > Agree. At least i see a few users of it:
> > 
> > <snip>
> > urezki@pc638:~/data/coding/linux-next.git$ grep -rn early_param ./arch/ | grep vmalloc
> > ./arch/arm/mm/mmu.c:1152:early_param("vmalloc", early_vmalloc);
> > ./arch/unicore32/mm/mmu.c:276:early_param("vmalloc", early_vmalloc);
> > ./arch/x86/mm/pgtable_32.c:86:early_param("vmalloc", parse_vmalloc);
> > urezki@pc638:~/data/coding/linux-next.git$
> > <snip>
> > 
> I'm actually having this problem with the arm64 architecture at centos 7.6
> and pagesize is 64K.
> I followed the prompts and added vmalloc=<size> to the command to increase
> the size of the vmalloc.and found out it's not worked.
> It took me some time to find out that this doesn't work for the arm64
> architecture, so this log is misleading on arm64.
>
Agree, it can take time to understand some code or logic behind of it.
So in that case having good documentation or comments always help.

> I think it's better not to be prompted than to be prompted incorrectly.
> I'm sure there will be others with similar problems.
> So I'd like to solve this problem this time, Please help me with your
> suggestions.
> If I change the PATCH to the following, will you accept it?
> 
Actually it is not up to me to decide what to take or not. Andrew Morton
is the key person here :) I can just review or make some comments same
as others.

>       if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> +#ifdef CONFIG_ARM64 && CONFIG_XXX
> +        pr_warn("vmap allocation for size %lu failed\n", size);
> +#else
>           pr_warn("vmap allocation for size %lu failed: use vmalloc=<size>
> to increase size\n",
>               size);
> +#endif
>
I do not have a strong opinion here, but counting arches seems odd.
Maybe modify the string with following message:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1f46c3b86f9f..0aa26bc128d7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1202,7 +1202,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
        }
 
        if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
-               pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
+               pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size, if your ARCH supports it\n",
                        size);
 
        kmem_cache_free(vmap_area_cachep, va);
<snip>

--
Vlad Rezki
