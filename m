Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9589C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9A32073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpVmoKmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgE0Wpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE0Wpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:45:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381FDC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:45:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y13so8009149eju.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3sbcMftoxYa/Xr/vjAkRZEKjD0XqOCCZ3yYeqA4uvYw=;
        b=OpVmoKmFVDV8dviwNPeIyKVKsVCZXMzBNdAnQQgKzga9biUM2aBnPu3XvSTBnUU75R
         p0HNCABSwKAzdm0N5w/B2ddu5/pxX7g59yovMgSm3ya+pYQEYNfYAxBGKaqe67pqFRw/
         TIPJZL0VClnMu6KNJKPDt36kSWwVEYtMPEq1OTA1pjGvoC7Ov9OxtAQb3wEFk/bZOYvJ
         70Vi+pPjkeTlVeOpu5BUhV4TWzsfGWKMsXcuorJbDc9MMG6evxMUe9JPomltWxu1qzMG
         Gmd929aUSeksVhLK3syWE9JurToXBwHs8E2eJTwi34XAs88Y0uU4yu+IVPgblwCNi9p2
         LuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sbcMftoxYa/Xr/vjAkRZEKjD0XqOCCZ3yYeqA4uvYw=;
        b=l+ysgI6E5eXI2EH4fkSHh1n290kKJ04LQTbYIlDUxPzaWllolgWkB+jmThTz3fdsru
         1bKYMuxT5gNbSGJfD95/62CcjY/BEqJYaK6iQAxscCjLKwvouQr2rOk64djtx9Srx3ZE
         ep9xwhHu1ovr67dhP1/N5dbTnlD8abzOkICfmU80Eq+mzBIQyxEP4CpgErBEfW0/iyeP
         zrsBCqv3NLQmXbbGVGgCpPAZZ3XTiaFzprha2JZPPN4zuXrjj4ZrWlRSP4h408K04gBX
         gbkICDbsUACQGGxUTY0x+C9ScRapB6w0Ew1h5HVm5T1XDe1IO0frKSQk2v2maXVWcIbv
         aBzg==
X-Gm-Message-State: AOAM533yMQ+bNec3EjaxQSmuJLNxuZ0LgEApwPbaloESJoKT0J3OX769
        7rL6uHt+o1BRh8sTy9m4fPE=
X-Google-Smtp-Source: ABdhPJyCyzIrgD23qyxhNNzPLcD5w2F0kRE2aDnQ7PBSVhMyXOPgFn0jVe86suBBX6L3u6664+7uqw==
X-Received: by 2002:a17:906:4995:: with SMTP id p21mr500870eju.19.1590619543941;
        Wed, 27 May 2020 15:45:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l29sm3325727edj.74.2020.05.27.15.45.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 15:45:42 -0700 (PDT)
Date:   Wed, 27 May 2020 22:45:42 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: simplify get_count_order_long()
Message-ID: <20200527224542.yx45druzqtlaxrl7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200524123551.9469-1-richard.weiyang@gmail.com>
 <20200525091458.GK1634618@smile.fi.intel.com>
 <20200525144312.mbw2z3ydncyasvss@master>
 <20200525153216.GD1634618@smile.fi.intel.com>
 <20200525134110.5737dd603d5fa1230e2f7ece@linux-foundation.org>
 <20200525215741.zd3gry4yyqqplix6@master>
 <20200525153146.c1337b1ca7af386ac30e5702@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525153146.c1337b1ca7af386ac30e5702@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 03:31:46PM -0700, Andrew Morton wrote:
>On Mon, 25 May 2020 21:57:41 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> I see the patch just merged, so I suppose to add the above test code into that
>> one?
>
>Well, that's not really test code.
>
>But yes, something which tests both the 32-bit and 64-bit functions would be
>nice, sometime.

Mimic the test_bitops.c, I wrote a test like this:

/* a tiny module only meant to test get_count_order/long */
unsigned int order_comb[][2] = {
	{0x00000003,  2},
	{0x00000004,  2},
	{0x00001fff, 13},
	{0x00002000, 13},
	{0x50000000, 32},
	{0x80000000, 32},
};

static int __init test_getorder_startup(void)
{
	int i;

	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
			pr_warn("get_count_order wrong for %lx\n",
					order_comb[i][0]);
	}

	return 0;
}

Since I don't get a way to iterate all the possibilities, some random
combination is chosen. Is this one looks good?

-- 
Wei Yang
Help you, Help me
