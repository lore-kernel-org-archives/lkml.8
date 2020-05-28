Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F6DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8044E2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iscaBhKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436944AbgE1WSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436938AbgE1WSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:18:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840A8C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:18:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e2so83285eje.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qKg4GQD93+ocMDoqhGvARqdw2NN5a+k6wEteAwkRwiM=;
        b=iscaBhKaJRMBYRmL3jaCQmPS5MVKKISbeQnSfPSpwxXyMucaVpbMm7jYzrmOSWpt7E
         B9Wr3krAJD54Dvc2PV8TW4upnQJW2f2b9h2Y8OgM1se7+By2+dGt0vEh8TZ7HiHCgdmv
         hyFFjJnhP9uZFVFfdAa+u1/oyStWoFEqcJ0HejusOYyIu7U8ctVfQkDfpMuv3EZxGNeJ
         G8sDD7vHoZORS3ISTW62X6nXgZl6+K/kMiTko88acj764uqEBDKjTZ0AF0DOGwQpqSr7
         rxMdKPAC7tN+wP0ecm++0TdKJ9G468TkeFkpX5e2G4wQ2XklVoNzgtMhZbIXc7tqFi+7
         3l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKg4GQD93+ocMDoqhGvARqdw2NN5a+k6wEteAwkRwiM=;
        b=h3j6xF1rAVWcbyKxgehToYWUVI4IBG+CznNWS6x3Qz/UCxK0ioyADV988sJhx9vugv
         hRr6KpbXdTjmEQzJsrHsX2Glkd+pLCNW6Io9PPjuSm3rqH2Kd1x5C5YIGn98ogjNAfNV
         mQoYZT2gVLLrOG5oA6D7goBGlRIg80VT8VShJTYgO7KaKsh4i6hOmPLssHs2wYHFAMxk
         z0O3fe8zg1v+YXKgBbDTVEhcgKfebQngqRyjJJKuZf61kxBLpVgYour/kltDw/gBHEV+
         LbEgdK5dDtSqMagXHqieOUPgggqBX7P2P0Knrzatq1EoKJW0lON3MbS5Yfurd/Cac+7h
         1kew==
X-Gm-Message-State: AOAM5315sJRn89l85qtBAn+7iBloVyGBl4oiwHasJ3Ls/zPPKy2xNSEv
        ZjomkQcID2aDsLv3+2FxiPc=
X-Google-Smtp-Source: ABdhPJwn56DMWVZjMcko+UFCXee1voiSKofvCg0zkPnhEfr3fpBHeMkCNndHXdFUtShVmxZBbXRAZw==
X-Received: by 2002:a17:906:bce6:: with SMTP id op6mr4930147ejb.337.1590704304233;
        Thu, 28 May 2020 15:18:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r1sm5885088eja.57.2020.05.28.15.18.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 May 2020 15:18:23 -0700 (PDT)
Date:   Thu, 28 May 2020 22:18:22 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: simplify get_count_order_long()
Message-ID: <20200528221822.icstykoyppbeznzs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200524123551.9469-1-richard.weiyang@gmail.com>
 <20200525091458.GK1634618@smile.fi.intel.com>
 <20200525144312.mbw2z3ydncyasvss@master>
 <20200525153216.GD1634618@smile.fi.intel.com>
 <20200525134110.5737dd603d5fa1230e2f7ece@linux-foundation.org>
 <20200525215741.zd3gry4yyqqplix6@master>
 <20200525153146.c1337b1ca7af386ac30e5702@linux-foundation.org>
 <20200527224542.yx45druzqtlaxrl7@master>
 <20200527160508.2ef29d6904c07ca6c650638c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527160508.2ef29d6904c07ca6c650638c@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 04:05:08PM -0700, Andrew Morton wrote:
>On Wed, 27 May 2020 22:45:42 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> /* a tiny module only meant to test get_count_order/long */
>> unsigned int order_comb[][2] = {
>> 	{0x00000003,  2},
>> 	{0x00000004,  2},
>> 	{0x00001fff, 13},
>> 	{0x00002000, 13},
>> 	{0x50000000, 32},
>> 	{0x80000000, 32},
>> };
>> 
>> static int __init test_getorder_startup(void)
>> {
>> 	int i;
>> 
>> 	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
>> 		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
>> 			pr_warn("get_count_order wrong for %lx\n",
>> 					order_comb[i][0]);
>> 	}
>> 
>> 	return 0;
>> }
>> 
>> Since I don't get a way to iterate all the possibilities, some random
>> combination is chosen. Is this one looks good?
>
>Looks good.
>
>You might want to add a less-negative number as well?  0x80030000. 
>Something that won't turn positive if it has 1 subtracted from it.

Thanks, this is a good suggestion.

-- 
Wei Yang
Help you, Help me
