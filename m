Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C40AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555B2206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k402dYHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGGNYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:24:48 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73BC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 06:24:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k17so11911011lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6e8r6byPcRWNj2RxIEqZuV+scBnjKV1qFFgcNxHbcMk=;
        b=k402dYHd3Sh9OuaY3cwiRV4OA2jwf8FVD3iGl46dMwT0scxWX2Ahxok8Kz7lUNu067
         KC3R/QFiRNC1VrNNacByaQCgAqf2UwaoboL0G0mzZJg0I+N0hM75jCpvjQ2GmU0xnDO2
         UTZ3t29Iv2jZbGuZRVueJf1A6A/y5uoqB1mwZWRj6/oj/JfbP2jG/uFEUHIx9pCeypKd
         i6LHxFb9mGknM1pouJ+4j1cOVY3WOD6UO2ernsJMVIhvrwvNsBf5p69gej3bzWhcbxBj
         RshS4ympZLipqgI0kpd9DrHQw/bHCDWaO49iB0o9H05JX0z/wmrrpH/NC4SWthw+tq3O
         wJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6e8r6byPcRWNj2RxIEqZuV+scBnjKV1qFFgcNxHbcMk=;
        b=IoU55RzTAzSYjKVh+4d0nT2MahGf/TCfgNSJEYtaoxZopEWJWvwqWxqdugIR8Mze4s
         0XelkMziU3pgXSwkkc5yN1UAAF62elMPGOsiOySqmJRyI5G4C9K3g3Vhxr9ETVykKQqj
         IbrUX6cxQ/Co/0t+KPNrecAKwn99yFKJnDJdYQxRus2XSEdMCamrkioag/6xjZ+Lwjx2
         BKeJoXooVU5S9KwbClQ6AEm4hiW/I47dYAgu0l+pNRHr+A0qHV1expNjlex6DyZ20v6R
         jIRz0+wvJDOZust5eqd0V+BjurbbHAqsLo/Zt8K4NMAuczMb61YdZoOWLBW/1RFKZZjM
         +0FQ==
X-Gm-Message-State: AOAM533ymRchPsDSQPjtj3S3nxQrlZiQ9Gkpwq/RTuQ8lp4HfqCbEeXC
        mXxadMLWXfc6PJE0J8jWwk8=
X-Google-Smtp-Source: ABdhPJwQolnlny6NtJTP91g3lOzH720eDwi/jkgPyEN1QbUdoCuVMdkDoFONP41bGbAbd4RxmG0GKA==
X-Received: by 2002:a05:6512:250:: with SMTP id b16mr32303647lfo.67.1594128286073;
        Tue, 07 Jul 2020 06:24:46 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id t7sm166872ljh.22.2020.07.07.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 06:24:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 7 Jul 2020 15:24:42 +0200
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] vmalloc: Removing incorrect logs when vmalloc failed
Message-ID: <20200707132442.GA26493@pc636>
References: <1594113232-32193-1-git-send-email-tiantao6@hisilicon.com>
 <5e7885ef-081e-0682-7be7-40eb7712d2c7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7885ef-081e-0682-7be7-40eb7712d2c7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:18:54PM +0530, Anshuman Khandual wrote:
> 
> 
> On 07/07/2020 02:43 PM, Tian Tao wrote:
> > It is not possible to increase size with vmalloc=<size> in arm64
> > architecture and it will mislead.however vmalloc return failure
> > is a rare occurrence in 'many architectures including arm64'.
> 
> But there is a chance that vmalloc() might work on architectures
> that support 'vmalloc=' command line i.e after a change and this
> information here might be helpful in those cases.
> 
Agree. At least i see a few users of it:

<snip>
urezki@pc638:~/data/coding/linux-next.git$ grep -rn early_param ./arch/ | grep vmalloc
./arch/arm/mm/mmu.c:1152:early_param("vmalloc", early_vmalloc);
./arch/unicore32/mm/mmu.c:276:early_param("vmalloc", early_vmalloc);
./arch/x86/mm/pgtable_32.c:86:early_param("vmalloc", parse_vmalloc);
urezki@pc638:~/data/coding/linux-next.git$
<snip>

Thanks!

--
Vlad Rezki
