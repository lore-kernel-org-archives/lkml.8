Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C50C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 23:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922BD206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 23:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRmndE7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFEXGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgFEXGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:06:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF15C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 16:06:14 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a25so11827003ejg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3u4/mtv2/jBtgjltUFBJn+fwtcCTe1s6zswW2F4KCzY=;
        b=vRmndE7dOuxm/AAsAHQcsWeerof/xY/UgYciuRI/oDFw0rGmfA91Q2fcSIrKIIaPfF
         D9M/AZyrktT5qX5lcuvboDcNQ7o+j7JYqpb4hgz7TwDD8z9VKFQ5QOQhK/rXMa4EwsVK
         fHWDRcgJvZCy8/vcCuY1jQ6osj87sktKX017wU5NiKLh1USimm10LRGxE6LaOeax7GT+
         NcOMw+Ksl0l1XGuZPOGkQ2uEkoTcAd47rb7WPF3tKzi4RG5F/2JSbsuAObpanwHiMYOY
         3I3peJ/s+zkUGBd55kMH2Y713lOHDZYr1jdyL57YvsMjv3ydDPd+DFUVdv61KwORvhmo
         iVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3u4/mtv2/jBtgjltUFBJn+fwtcCTe1s6zswW2F4KCzY=;
        b=GpuB1D1romv+4e+0pGxCLGIFprs2Nz5WDpQ60HFec9nwh66vO0iRW2GVgj8Wx2e1+r
         w6UKNIf2wsk9dm/2xaYOynC8c+jlKOyYNXxNMWzblSrulSfH5362czsXWWkDhkzJFkqi
         yxE/ZCLjkIx7B1MW3mBXWTtSMdS+H7UyZ5mrIW1n20KxgQKYYzhlg8NIy8n7LyyjrEG9
         lWnUk5NUmW3wgnHno47ojc/lM6pvLt8QkkurV9Pwrg91S55OCs9I6gVue9kqyRlNyXcr
         ASozBFY4x2vD8bKJSk9WdQ/EsTBmvOKg1uXNgvjHBsNrfNOcW3k2VzxBYW40/iGgHDIW
         zLvw==
X-Gm-Message-State: AOAM530V3cn+IMEWtEtbdlicEU/34iOTHCgu06sS87C0ZyOQH4jrCQ91
        okGOVhtbxqTbTb+VzoPxvjs=
X-Google-Smtp-Source: ABdhPJzF1zUEJn9o4WH1nf8c6CksAxGEwmpeOl9puddxoEOmEFsk8whw0mqO1rvFLjX21UJ5+EQjvQ==
X-Received: by 2002:a17:906:6403:: with SMTP id d3mr10712622ejm.386.1591398372697;
        Fri, 05 Jun 2020 16:06:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q25sm5282481ejz.93.2020.06.05.16.06.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jun 2020 16:06:11 -0700 (PDT)
Date:   Fri, 5 Jun 2020 23:06:10 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200605230610.bizp2j23ivyma5rn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
 <20200604122805.d2ndjmkmti6wl3nz@master>
 <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 02:51:40PM +0200, Geert Uytterhoeven wrote:
>Hi Wei,
>
>On Thu, Jun 4, 2020 at 2:28 PM Wei Yang <richard.weiyang@gmail.com> wrote:
[...]
>>
>> You mean
>>
>>        {0x0000000000000003,  2},
>>        {0x0000000000000004,  2},
>>        {0x0000000000001fff, 13},
>>        {0x0000000000002000, 13},
>>        {0x0000000050000000, 31},
>>        {0x0000000080000000, 31},
>>        {0x0000000080003000, 32},
>
>Yes, those values.  And those should work with get_count_order_long()
>on both 32-bit and 64-bit.

Hi, Geert

To be frank, I am afraid I lack some of the skill to achieve this. Maybe you
could give some guide.

get_count_order_long() takes one parameter, which is of type unsigned long.
This one has different size on 32bit and 64bit platform. On 32bit platform,
those value would be truncated.

Would you mind giving me a hint on this?

What we may achieve is like the implementation of fls_long(). This one check
the size of unsigned long on running, and choose different function. We could
use ifdef to check the size of unsigned long and use different data to feed
get_count_order_long(). But I don't find a way to feed get_count_order_long()
with 64bit data on 32bit platform.

>
>Gr{oetje,eeting}s,
>
>                        Geert
>
>-- 
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a hacker. But
>when I'm talking to journalists I just say "programmer" or something like that.
>                                -- Linus Torvalds

-- 
Wei Yang
Help you, Help me
