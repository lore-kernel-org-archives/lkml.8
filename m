Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CDBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34602073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lnWs0M9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgFVVuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbgFVVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:50:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C720C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:50:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j4so8168457plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HO9AnfyoV6P1ml9RmfpxKfaeSgxzWVOaT2Vq3vNBOcc=;
        b=lnWs0M9bdocVBBBLhw+yUPaupQsgnQNFCJK+pJiVmZ07vNw8nK3vhTqTM7fjRtPrmQ
         BeXp8Y3BLVYRrEviTgHIDqlkTfPgwxk6+SKhwBh0lYzJXifq+81hLQjHZHXlwvYE7D3Z
         338rLHdodna0JLZ+58OXLxtuOD7htkoppjQHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HO9AnfyoV6P1ml9RmfpxKfaeSgxzWVOaT2Vq3vNBOcc=;
        b=PSVWZZ4mRAdmHwyZTAEfNG4bXnHiH2hbaK6XKSMNYAG80ldQhHOEh+ZJIlnjsdlu6f
         BXs0EoQ20X3jQScpAYVvnOuGzPMc5VWfCAcpuF7NvBQ+XC/GfCt0R1kjNMQduqUZYUMR
         0pHJ3JLhKMI9RCtH3cLQOjS2QPBYrrj855rUQpUPSbL74pK+Z1ylLZZnFlBJYPLYt8gw
         twrasG/MP59ufqjf7b9LDryE9wRRmi5S22w2eiCifXyBOYvcpk38iNMzZeHOQuOV2BeS
         zD1DJCFsDLWnwihUhQL6sHo/YKOTz8jMF0lnaODOsSQIkZNQ8jSzaFdNhA8xYfZfT0xg
         +NDw==
X-Gm-Message-State: AOAM530mcpKIRPuwMVmpKYdJ6mv49apVs48x0+mnfKlh2tINo8TiYL62
        4Bx4iQrwAwmMZJ9ylapIatu3rw==
X-Google-Smtp-Source: ABdhPJxa5Z82Hov2tfdjL/FmMAkdOj7Sb3arynM+T3CBUgUa49ZBQBQv4Q5BIBd9XVoezZqa3CUsJQ==
X-Received: by 2002:a17:90a:a405:: with SMTP id y5mr20189871pjp.15.1592862611014;
        Mon, 22 Jun 2020 14:50:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p14sm428618pjf.32.2020.06.22.14.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:50:09 -0700 (PDT)
Date:   Mon, 22 Jun 2020 14:50:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rd.dunlab@gmail.com>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: mmotm 2020-06-20-21-36 uploaded (lkdtm/bugs.c)
Message-ID: <202006221445.36E03CCBE9@keescook>
References: <20200621043737.pb6JV%akpm@linux-foundation.org>
 <20a39fd4-622d-693c-c8d6-1fbab12af62a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a39fd4-622d-693c-c8d6-1fbab12af62a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 08:37:17AM -0700, Randy Dunlap wrote:
> On 6/20/20 9:37 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-06-20-21-36 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> 
> drivers/misc/lkdtm/bugs.c has build errors when building UML for i386
> (allmodconfig or allyesconfig):
> 
> 
> In file included from ../drivers/misc/lkdtm/bugs.c:17:0:
> ../arch/x86/um/asm/desc.h:7:0: warning: "LDT_empty" redefined
>  #define LDT_empty(info) (\
>  
> In file included from ../arch/um/include/asm/mmu.h:10:0,
>                  from ../include/linux/mm_types.h:18,
>                  from ../include/linux/sched/signal.h:13,
>                  from ../drivers/misc/lkdtm/bugs.c:11:
> ../arch/x86/um/asm/mm_context.h:65:0: note: this is the location of the previous definition
>  #define LDT_empty(info) (_LDT_empty(info))

The LKDTM test landed a while ago:
b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")

and nothing has touched arch/x86/um/asm/desc.h nor
arch/x86/um/asm/mm_context.h in a while either.

Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?

-- 
Kees Cook
