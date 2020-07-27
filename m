Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D43EC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E129D205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595848092;
	bh=FCKVuuwblXPspUiI5FTHTkVwa4FYH4IgbfJfxd4McO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=teuKJxKLFygKWuIxr1hswGgtjwb9z2HfI6K+FutIfjXEBWrBIMGD+U1TUpUN10p08
	 TV3tgfNOSN3KEHCJHqA57iybE1U86zbLSha6tmNM7y25O0NQ7W2/kKAxycNm/6x66v
	 3wsHaSSCiLGh3GI/yFMHv2w2VD/TpX7IP0HKDyBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgG0LIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgG0LIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:08:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D0C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:08:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g7so8348900ejw.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RwIbYX4tpIvaMqMMybkeITF1WqLqpQeUKMEgUeMi77w=;
        b=Wlk1/2t1P+pF4N7yMXUW4N2wf8GT1C+3c0lTst7Dm1Kl2N2vtZznaDJvyZ9+WzK9pD
         +TTKk4kKUSt2+k1wdZxBpDqg6BN7JlexuzvAS8niYNsqg4HCOBMGa65SCcuQBUWbSf9q
         At1LsqecLQDJh+XI4juzy+Ib/as0kYjWBfjO0ikwatUKCOVWWBFk3OddnMdPnEed9o+P
         O9oYkcLmeOL2m9xLutdxlmagLjFZGb8L66YY74x458YTt769aJa9UXnT7gz9gxvLYzyZ
         PHcxGynin8/rYFQME9NyCUUxZ/9evzFY34J+njGC2D1rNS05isLUF40pKcG+tuhbRgAU
         nCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RwIbYX4tpIvaMqMMybkeITF1WqLqpQeUKMEgUeMi77w=;
        b=MnEGjfwQnk7miCn7mY/B24FclrNvF6Q7iWy76CNW3ApkxyCBmMbxb0oAPZ9VPfxzvB
         Ae1QeBLx78/o+pdgMOW+ghOAIB4kpyJT0lImPw62wc73CXliKql4PvJf3KnVWhzl9Vwd
         b+kLXzvmDiVGkuAicT2fcmw4U5S4uMTgD2KCHGA5hPuPYqtc3vRe0FR1zNImnEm1hWxI
         sPNX21IwqG4mSmvvHbjl4JZ67f0EdMvKP6vhyzvG94bsWMAWZrgeEvXzOJVRfUNxLOmL
         Q6IGlwVPZu/w8u5sqirRy+fF9ykpBGU9tPYJcIoAuBSdZIpS4yrHqEjjIjLGCmQ5XKAJ
         9Glw==
X-Gm-Message-State: AOAM533R5sPHdDmCrTLhtpk5qubWsU2r8Kxkn6LMpgcfK/rLRS/PJFAb
        viomMh3hvYy5G6PZovMooJtJLdJN
X-Google-Smtp-Source: ABdhPJx74sN0vJYTB8+Uo4VZ5jmm4xaQnmBby1us3Jm4w0zB+hsL02a5kLmTjiyWDGYJjDvbg1cIDA==
X-Received: by 2002:a17:906:3614:: with SMTP id q20mr14816263ejb.142.1595848089310;
        Mon, 27 Jul 2020 04:08:09 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w20sm7227187eds.21.2020.07.27.04.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:08:08 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:08:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/mm/64: Remove vmalloc/ioremap pgtable
 synchronization
Message-ID: <20200727110806.GB3174@gmail.com>
References: <20200721095953.6218-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721095953.6218-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> Hi,
> 
> here is the third version of the patches to pre-allocate P4D/PUD pages
> for the vmalloc/ioremap areas on x86-64. This makes the page-table
> synchronization code obsolete and so it is also removed.
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Changes to v2:
> 
> 	- Rebased to tip/master
> 	- Some rewording of the commit-messages 
> 
> Joerg Roedel (3):
>   x86/mm: Pre-allocate p4d/pud pages for vmalloc area
>   x86/mm/64: Do not sync vmalloc/ioremap mappings
>   x86/mm/64: Make sync_global_pgds() static
> 
>  arch/x86/include/asm/pgtable_64.h       |  2 -
>  arch/x86/include/asm/pgtable_64_types.h |  2 -
>  arch/x86/mm/init_64.c                   | 59 ++++++++++++++++++++++---
>  3 files changed, 53 insertions(+), 10 deletions(-)

Applied to tip:x86/mm, thanks Joerg!

	Ingo
