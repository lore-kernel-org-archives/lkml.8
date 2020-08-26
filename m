Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C53DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D91A20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598444662;
	bh=hiQ+qmwHnuf+AArij1lt3DQ8Vh/P/K/fn6fu7h8qSEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fPhpYgPBe6/O2BCMKrkV5i32BjAsCntdhG1rZ5jfPG3VaT0l9UtYqlHdunlyitodV
	 9AO93FgY/wL84FZj96Ft/RG587n+jdlQD0FjgmHZUR5gNDcV29v4wenEVb6DFNSUPJ
	 Sw92Dl8EwgF31ztc+Ub2zAu9Po5AgEl3rCkrAEJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgHZMYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:24:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38018 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgHZMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:24:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id t14so1569953wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kr6d5r4TO0k45nW4pONrReRDKQ5e3f17lY9VWFHfjOE=;
        b=Em9tWN0CO0yYMkNgVAPmMudAphixjrnQDgLHAgpLA/lo3oXoQA4M/OcFtlfcfWMCuP
         9HyMssK15hEqIscJh6veg+IMIh7ENjdtHA9gZ7tC8D1lp0ZL90miuLo0IzX3JiF9eJpJ
         GdtHdD0r3cbApvuPJHXCEkTic8oEBGT/9xVZa7ntDzSPrau+Bek2kM8LtgdxJ2MU1+36
         hoXdExYYD19iWvTFv1yyKHBWmhtfnd+KAPbgwgkm2BZ0SJ+pNEQO9nrthLYInJ0H/lkf
         gsrlEDHl2z0xMwsWJ4L1mUhfkuV3RquZMJFhx0bST6JZ8Ce2ICDcLqeXWXsdawuPnriI
         rMjw==
X-Gm-Message-State: AOAM533luvhiv0VsA4ThulIdXVWDQHL2edeouofZBQHtZGOTvZzdsKkw
        +VjlDc8pCnIWNvSUSw8Bpwc=
X-Google-Smtp-Source: ABdhPJwBWi4N5NKzxBH8vZDi0CPrYAixHOELyGVmsD4saEIfJjYSllt3uRpkX2lIL2ykYrGX9Y30NQ==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr6615468wma.87.1598444653880;
        Wed, 26 Aug 2020 05:24:13 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id f14sm1090208wrv.72.2020.08.26.05.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 05:24:13 -0700 (PDT)
Date:   Wed, 26 Aug 2020 14:24:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Subject: Re: [PATCH v1] extcon: ptn5150: Deduplicate parts of dev_err_probe()
Message-ID: <20200826122411.GA12977@pi3>
References: <20200826103910.81413-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826103910.81413-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:39:10PM +0300, Andy Shevchenko wrote:
> dev_err_probe() is designed to be used like
> 
> 	return dev_err_probe(dev, ret, "Error message\n");
> 
> Hence no need to have a separate return statement. Besides that
> dev_err_probe() prints already returned error code, no need to repeat
> that either.
> 
> Fixes: 48cbf8c6653c ("extcon: ptn5150: Reduce the amount of logs on deferred probe")

It's an code improvement, optimization, but there is no error here to
fix and Fixes tag would trigger backporting to stable. This patch
should not be backported because it does not meet the backporting
requirements.

With Fixes removed:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
