Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD19C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0EA20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582711765;
	bh=3B3veZdlBp+DL9ZU8Me1rQ1RDCAsrD3RKd0F5bKuw7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CIz2hME6Rs8GYleUbhrAyACJBfWELbeiwGhEJ20+fVJdrmDdNithMG5SMmdOM5kpV
	 nmwTGDcUgOD86KFctpbSd5Nn5r7UZIz2vLJFYwAOQYGBE1VNPryL6Ye7pSTLTH3G14
	 R/RQFPAvtLnJ6+Mf/TU3ctrjuXtf/BvmSOOuIwvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgBZKJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:09:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39701 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:09:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id n30so1525280lfh.6;
        Wed, 26 Feb 2020 02:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tY/3ZhNqAfe25zbsUNHIg9lCEmF6tZUqDehw6V5qg4Q=;
        b=JcdvggEbzD7YMixs1hEjV6dzDg4R7d61RlT5hwn+K4HrShgKmhSd6Fq0J6gbIqP20/
         q8fvwMLiEF5B0GNER4CwOP8gq4JaldsS8nOlUn0WTjHsH2o+Jsgv1R9SE7aeWZRU+HeA
         71pxSEy0rRVt7EtHpbS2LCBQWsrw7d2BBz0EHUDgVbVNBmvuzf5fUw15c7aQpZZ4IBn5
         gk/ll1FhmiGDj/AqsDUqTs11HQWK7+HvZef9VxJjLErC6xwek/laN9k46F2MMnIwMlU7
         IuxcgDJp15ndu/hjXFJ2IoOzygDmlEvEAyw1nPKOCqTfPedj+JH2cpeduCNaU9rqGc5Q
         CDBA==
X-Gm-Message-State: APjAAAUNBtNbXJaUN6uSlnRfIBvvUKRFUhVBayAA8WgvK8C0pa+1pcV+
        FyPIsbURD++GxCuGg1T8rOCwmWmv
X-Google-Smtp-Source: APXvYqwF8rKFVB6d3mu3fqyd3R+AGjJUovwvYTAlzXLqX/mU+/+mSz1NRfr4TLMe6SV8nMa4rPDb/w==
X-Received: by 2002:ac2:4255:: with SMTP id m21mr2052545lfl.23.1582711761611;
        Wed, 26 Feb 2020 02:09:21 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id i13sm885909ljg.89.2020.02.26.02.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 02:09:20 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j6td2-0004zV-Bm; Wed, 26 Feb 2020 11:09:20 +0100
Date:   Wed, 26 Feb 2020 11:09:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/2] USB: core: Fix build warning in
 usb_get_configuration()
Message-ID: <20200226100920.GW32540@localhost>
References: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
 <20200226080459.GU32540@localhost>
 <d9637b5a-6d5e-17a1-e615-f828d311f654@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9637b5a-6d5e-17a1-e615-f828d311f654@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:35:48PM +0800, Tiezhu Yang wrote:
> On 02/26/2020 04:04 PM, Johan Hovold wrote:
> > On Wed, Feb 26, 2020 at 02:15:22PM +0800, Tiezhu Yang wrote:
> >> There is no functional issue, just fix the following build warning:
> >>
> >>    CC      drivers/usb/core/config.o
> >> drivers/usb/core/config.c: In function ‘usb_get_configuration’:
> >> drivers/usb/core/config.c:868:6: warning: ‘result’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>    int result;
> >>        ^
> > What compiler are you using? The warning is clearly bogus and it hasn't
> > been seen with any recent gcc at least.
> 
> [yangtiezhu@linux ~]$ gcc --version
> gcc (GCC) 4.9.4 20160726 (Red Hat 4.9.4-14)
> Copyright (C) 2015 Free Software Foundation, Inc.
> 
> The gcc version I used maybe too old,
> if the warning is bogus, please ignore this patch.

Hmm. I even tried installing 4.9.4 and still don't see that warning (on
x86).

Are you sure that's the compiler version you use?

We've silenced bogus maybe-uninitialized warnings for 4.9 and newer
before, but we shouldn't be adding compiler workarounds unless we have
to.

Johan
