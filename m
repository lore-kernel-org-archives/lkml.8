Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D47C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEB620656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595934317;
	bh=bzctt5eqby6/t2SPIhfAgWQrreEO8C8Z5+Mj5L4DRDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VV+BhQYBUD8xpl1pqy4EO5pyN5QYw9IQX342xLwvsIthQmR6uAsbf/iiQH1mQ7yB2
	 CqCx6W23CLdaHLpqN1mVMk1BboQ8/QX0fy+eCdqTYaKRdqBgLKJ+S/r4u+jP5Qlapm
	 dagLhfAMGcsLjZoNB9lp+mcnnutUBJA1hG+uxBmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgG1LFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgG1LFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:05:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94EDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:05:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w9so20183764ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jwBEdPxoQ001eHXgx78M10fO89W+OhULooyuXzafFUs=;
        b=STzyz2IVap0WAgdFOQ/QDS9eULYeyqq7xl3Lmcxv4waqT60tK60/IVJpvLPlhL0+q7
         mT58iFlm0dyRPrJYoaKzJ7AUufRa0lmUUrjNDtdXVVCuWJJKhNvS1ztjc9kUZAGRbWJt
         IDlKmu01jgOx4Ij35miP1BlbyCHXmPzXvKR8zIWpGDQMvXuwNOnn1P1qlMvosXy7CeJ8
         8dNhOPtSbUNSgpy4BpMoyRrQNHGN+KBAJzAz0m8xUIGiVZn7T1ffq/1w10eWK+bTnJKV
         a/J2nxJwrd1wEM6JVy45rnqh4o9S6lZKbUfiNMSzfwYuflQZCobCZea4j/7U8MM8/smv
         +Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jwBEdPxoQ001eHXgx78M10fO89W+OhULooyuXzafFUs=;
        b=WIanLFBZ5kOL1a3tKCJUl5n2HlkJw3k8a2bq4A9/8SZaYU0ixvJ9Sb5iYo5XiowBt+
         vqAA+fUl2niB2MEq2ncdA1AFD/2LEU1UB5VWnPtFkrP8PJtKHOOHrbC+r34eCDHcPwo2
         vQuU2jopW8OyXe8aqNmyNOds1T0oGj1LExuT5aXm3wY1LnJnmnUypjmUk6UUpSu51Mki
         dEmu4doJgXvYR6b6G9ME6zEn2qIcuhqKdjc6qF7EeJpqcX2bOEIemTKRQKSAm+xgXGAX
         hincSCJzFJzx9BYUZR6+y2yn2CxjGjd4GQKkZeGgX9v/QmmLYCbVqpGHYKDdtmrcZbbD
         8iHA==
X-Gm-Message-State: AOAM532xT8cPumZn/fiGUld1K8qjWKqRePsA3JgFQzyeyo6HseEMYDGx
        kK55DD25fjgR0inaQpTiZYY=
X-Google-Smtp-Source: ABdhPJwFivFb8R5I7TIg2LBjCrkXVgkOhlUheK6N8jx/sqYT4hh3eOC28le79daLlnKFTXpV40JBTQ==
X-Received: by 2002:a17:906:fb99:: with SMTP id lr25mr25039222ejb.49.1595934314437;
        Tue, 28 Jul 2020 04:05:14 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id rv16sm8863426ejb.60.2020.07.28.04.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 04:05:13 -0700 (PDT)
Date:   Tue, 28 Jul 2020 13:05:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] x86/kaslr: Don't use 64-bit mem_vector for 32-bit
 kernel
Message-ID: <20200728110512.GE222284@gmail.com>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727215047.3341098-9-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727215047.3341098-9-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> Commit
>   f28442497b5c ("x86/boot: Fix KASLR and memmap= collision")
> converted mem_vector type to use 64-bit on the 32-bit kernel as well,
> based on Thomas's review [0]. However:
> - the code still doesn't consistently use 64-bit types. For instance,
>   mem_avoid_overlap uses 32-bit types when checking for overlaps.  This
>   is actually okay, as the passed in memory range will have been clipped
>   to below 4G, but it is difficult to reason about the safety of the
>   code.
> - KASLR on 32-bit can't use memory above 4G anyway, so it's pointless
>   to keep track of ranges above 4G.
> 
> Switch the type back to unsigned long, and use a helper function to clip
> regions to 4G on 32-bit, when storing mem_avoid, immovable_mem, EFI,
> E820 and command-line memory regions.
> 
> [0] https://lore.kernel.org/linux-nvdimm/alpine.DEB.2.20.1701111246400.3579@nanos/

So why not just standardize all the calculations around u64, and for 
32-bit kernels add in a debug check that double checks that it all 
remained within the first 32 bits?

It's much easier to argue about this if we don't have to worry about 
32-bit overflows and if the types are simple and bitness invariant.

Yes, technically it's slightly bloated on 32-bit kernels, but 
maintainability of 32-bit kernels is the primary concern now ...

Thanks,

	Ingo
