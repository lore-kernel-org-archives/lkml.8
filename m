Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E765C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5200E24998
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MW8/mQve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgDFQn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:43:27 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56175 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbgDFQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:43:26 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so26052pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eP345ArGYnfGAJ4jzoK1LoRsxz9bzdzVl4xTuSWk8YU=;
        b=MW8/mQveOroeY0x1xpt8gPhQROWiBKBbi6WYW1EvrM+99HqbdYjegbaYgTLHtdhq1J
         l4QPfHXLUAHwah6DKPElpdCoNk/mzsNS50F//u2UWG7wU5c4a4/GkJczthkimZUpn+qf
         DQIOFUaCcWiA0jzlGY8FZKr4Mnx0zlemtrO+SWFM+jmsaSw3jNiXjYEgvKJ/Gnr0NwUK
         MnClJVV3jSNRRkmUx3oKbc74LCCOJEYOHSeGdVPLODh175Xr4qGV0zFy7UPhLe/1NkmS
         WYcQaq3Ph8aIWWt+Ip0jt0z+671w0Sbq04XPtO1QlMeNjZ7c784pcgA2r2rnYpZcgi/o
         VlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eP345ArGYnfGAJ4jzoK1LoRsxz9bzdzVl4xTuSWk8YU=;
        b=RGuabHGg8anSowr0Vkg7hwqTzXjTWY2WWplPwbg9+npM02SWa55An5S+Ag50+HVXXW
         kKt5wWpt7pcqLpWz3ekLjonxC0X1s8o0oq39vcJ/hSkWtB/eB9pcQbwvP6rTYTEAJI62
         p1b10WstY+VN+8jid9TnIQXS78lClgh7zgSj94Hxe3q9VKBcIWWdGs7rJql72LmbxMYN
         5dKY0AYhGKhp+ZIeYot0Q+yLDUMlov+GM+c/o5t0+Z9oSXZD7/AgwbkfIbjYs26zh3g3
         xed8aGFrLvhFZ4U/0H5QLiE4/LoCDa6ocp+On7rp5pXvPI1yh9OsXPmGxtuqAHDn0tNQ
         2nHw==
X-Gm-Message-State: AGi0PubSAE7+fAbTLWXhpLZBCZeh3FMo6fhf9Lx/ERL48rlqwBVhZUxK
        /sISzoDMPfcJOZH9cluPa2rGelJbRHQWog==
X-Google-Smtp-Source: APiQypKGMyFeOjdTrlkRBPTR6ySLfo8qSkh83qKknt8owxl20zhRTJaNBpZZCNFvk4gJqtcAV7uKiA==
X-Received: by 2002:a17:90a:fa17:: with SMTP id cm23mr19190pjb.121.1586191404980;
        Mon, 06 Apr 2020 09:43:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id z7sm12001669pfz.24.2020.04.06.09.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:43:24 -0700 (PDT)
Date:   Mon, 6 Apr 2020 09:43:21 -0700
From:   Fangrui Song <maskray@google.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     YunQiang Su <wzssyqa@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: malta: Set load address for 32bit kernel correctly
Message-ID: <20200406164321.c3377heoqprzwbjc@google.com>
References: <20200405082451.694910-1-jiaxun.yang@flygoat.com>
 <alpine.LFD.2.21.2004051738000.4156324@eddie.linux-mips.org>
 <96C9B1A0-2F89-4650-B0A4-6A6242A2AA0A@flygoat.com>
 <alpine.LFD.2.21.2004051817310.4156324@eddie.linux-mips.org>
 <CAKcpw6U=VW+h4sU1fzrsqXU9z-zVfcFsENKHgAD4paqtndip2w@mail.gmail.com>
 <079F408B-9C44-4317-8DD3-7A1896564960@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <079F408B-9C44-4317-8DD3-7A1896564960@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-06, Jiaxun Yang wrote:
>
>
>于 2020年4月6日 GMT+08:00 下午6:57:18, YunQiang Su <wzssyqa@gmail.com> 写到:
>>Maciej W. Rozycki <macro@linux-mips.org> 于2020年4月6日周一 上午1:23写道：
>>>
>>> On Mon, 6 Apr 2020, Jiaxun Yang wrote:
>>>
>>> > > Given the description above I think it should be done uniformly
>>and
>>> > >automatically across all platforms by trimming the address
>>supplied
>>> > >with
>>> > >$(load-y) to low 8 digits in a single place, that is at the place
>>where
>>> > >
>>> > >the variable is consumed.  This will reduce clutter across
>>Makefile
>>> > >fragments, avoid inconsistencies and extra work to handle
>>individual
>>> > >platforms as the problem is triggered over and over again, and
>>limit
>>> > >the
>>> > >risk of mistakes.
>>> >
>>> > I was intended to do like this but failed to find a proper way.
>>> >
>>> > Makefile isn't designed for any kind of calculation.
>>> > And shell variables are 64-bit signed so it can't hold such a huge
>>variable.
>>> >
>>> > Just wish somebody can give me a way to do like:
>>> >
>>> > ifndef CONFIG_64BIT
>>> > load-y = $(load-y) & 0xffffffff
>>> > endif
>>>
>>>  Use the usual shell tools like `sed', `cut', `awk', or whatever we
>>use in
>>
>>perl may be the easiest to use tool here.
>>
>>ifndef CONFIG_64BIT
>>  load-y := $(shell $(PERL) -e 'print $(load-y) & 0xffffffff')
>>endif
>>
>>Note that it is `:=' instead of '='.
>
>It seems like perl is not one of kernel's build dependencies.[1]
>I'm comsidering a alternative solution,
>write a small hostprog in C to deal with that.
>
>Thanks.
>
>[1]: https://www.kernel.org/doc/html/v5.6/process/changes.html

load-y := 0xffffffff80100000
load-y := 0x$(shell echo "$(load-y)" | rev | head -c 8 | rev)

>>
>>> the kernel build already for other purposes.  There's no need to do
>>any
>>> actual calculation here to extract the last 8 characters (and the
>>leading
>>> `0x' prefix).  At worst you can write a small C program, compile it
>>with
>>> the build system compiler and run, as we already do for some stuff.
>>>
>>>   Maciej
>
>-- 
>Jiaxun Yang
