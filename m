Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8E1C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 04:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC752206CC
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 04:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uYwZi40D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBOEHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 23:07:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgBOEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 23:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=jcBbZKTosyTPuLYpojPXU9rDaBi/eq4trzl7xWpOvWE=; b=uYwZi40DwgG4qj/vKHSSQGo6AG
        zQAWSw9Vom9ffDSDwRQF53rFgN/G3LVKMqwXNDDPB5lfZRkZ/9HwEq/ZM1AvFFD517XDTxFeG9/9q
        59TX92QzTjqmeCj8xAjSqaQCWJb4xecy2BJrde/xC2+0yj01NEQrD0uzJZ8uDIwU2AjV2OmvRYT0g
        Bq9a5IwDP2rLxGKOdI6BY3d3QJ+vqPOqO4QGO/wr9jhgiQ5eDjUSr1iCeAnqsOqFqvsBnrbMnhkVv
        BgfekVsQaru+IHPyKExJXm0WZTJm/0B31LiBKz3zSSQ07Pv3hNTfDeNrFzIX0WVzlNNC4sNyLvMNR
        y8tiKtyQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2ok8-0007Uk-TB; Sat, 15 Feb 2020 04:07:48 +0000
Subject: Re: [PATCH v4 10/11] mm/damon: Add kunit tests
To:     sjpark@amazon.com, akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        brendan.d.gregg@gmail.com, brendanhiggins@google.com, cai@lca.pw,
        colin.king@canonical.com, corbet@lwn.net, dwmw@amazon.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        sj38.park@gmail.com, vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200210144812.26845-1-sjpark@amazon.com>
 <20200210145350.28289-1-sjpark@amazon.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4a541951-fd36-2a19-75a0-ccfcf60e6f14@infradead.org>
Date:   Fri, 14 Feb 2020 20:07:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210145350.28289-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 6:53 AM, sjpark@amazon.com wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 387d469f40ec..b279ab9c78d0 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -751,4 +751,15 @@ config DAMON
>  	  be 1) accurate enough to be useful for performance-centric domains,
>  	  and 2) sufficiently light-weight so that it can be applied online.
>  
> +config DAMON_KUNIT_TEST
> +	bool "Test for damon"

s/bool/tristate/ ?

> +	depends on DAMON && KUNIT
> +	help
> +	  This builds the DAMON Kunit test suite.
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation.
> +
> +	  If unsure, say N.
> +
>  endmenu


-- 
~Randy

