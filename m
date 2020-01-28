Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1723EC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F5024681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9nQR7VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA1QGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:06:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgA1QGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TC1JXRmVCDpfoX8tpOB7oJ8bDjUGxHzn4aFxhrwd/mc=; b=P9nQR7VG+b+ZF6H9cPXgLOYeZ
        k2bJEqsVznKzChQkk+U189Ob58LBOrI5q1BqGdqKfD4zPUkB5ELezs0FnqifPi3LiGfJUZGZkHzFB
        OdmjLsGhkWeaKVm3FM53fSZlu5tO62BsohOjwnCytMjzG3ECRYMKENlK+P0dvQ2dMC/5eEdckLTza
        naO3+5yPhpuXOLaueebGOuKgczLqDiXeX2O2GApmpUOJXspJoJrvHerNy4YyYVIIAeduvswtJIHJi
        c37+hgex0LKpF2eYd3v8Y8JRL3VCgFMfaxvY9pWsocfuCLH8bVc3IPVeq8ga/blLVgMDQneTwHiPf
        M3iyN19ZA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwTNw-0001bi-FA; Tue, 28 Jan 2020 16:06:40 +0000
Subject: Re: [PATCH v2 1/9] mm: Introduce Data Access MONitor (DAMON)
To:     sjpark@amazon.com, akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, sj38.park@gmail.com,
        acme@kernel.org, amit@kernel.org, brendan.d.gregg@gmail.com,
        corbet@lwn.net, dwmw@amazon.com, mgorman@suse.de,
        rostedt@goodmis.org, kirill@shutemov.name,
        brendanhiggins@google.com, colin.king@canonical.com,
        minchan@kernel.org, vdavydov.dev@gmail.com, vdavydov@parallels.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200128085742.14566-1-sjpark@amazon.com>
 <20200128085742.14566-2-sjpark@amazon.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <95f6d1e3-7052-252e-1c29-f320e84df302@infradead.org>
Date:   Tue, 28 Jan 2020 08:06:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128085742.14566-2-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/20 12:57 AM, sjpark@amazon.com wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ab80933be65f..144fb916aa8b 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -739,4 +739,16 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>  
> +config DAMON
> +	tristate "Data Access Monitor"
> +	depends on MMU
> +	default y

Might be lightweight but still should not default to 'y'.

> +	help
> +	  Provides data access monitoring.
> +
> +	  DAMON is a kernel module that allows users to monitor the actual
> +	  memory access pattern of specific user-space processes.  It aims to
> +	  be 1) accurate enough to be useful for performance-centric domains,
> +	  and 2) sufficiently light-weight so that it can be applied online.
> +
>  endmenu

thanks.
-- 
~Randy

