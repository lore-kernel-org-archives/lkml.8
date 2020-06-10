Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD5EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D81A2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRW27njH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFJWGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:06:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B029C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:06:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so3769229ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3BpkZYB+elKS0Yw4EnV1AMN0cPOW3ML+jsxiyHjKknk=;
        b=eRW27njH8oKTgYyM//6JRFb4FJdjzx26Zryt/Mp0MB40jWLxyabVzmPoQNO+bWhJvs
         zzVpkA2qk6KaS23C54q/DKGCm2ZjrxaCIDiEPXk/N0UXfM/+yh8ppFc6GR93+aDaLJwo
         Bdg9krohWH/8uOSSq2D99uIvaM4yL1Nn3B5GP7dnIY2efyfFalfKays0puykVZmPzNBO
         8FnsXl6SoEIuihrrXIar4Z0CzwV2yxFP0wAv8OnsUkLFFtpDFHWrXYaeflF60m5Ehbrx
         ip7I1/Z3u5ffQvGEBMK+9jic1EngJHyIz7KpT4D1bTySG76cewsYMwUs+r+Z2RIfUY1n
         ZZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3BpkZYB+elKS0Yw4EnV1AMN0cPOW3ML+jsxiyHjKknk=;
        b=mJOAJZazZO4qaZK/6/RJbX+mv8+b7AGbhVfMsBrmjPrlmhv2rA4UmFchNs/vevs0Pb
         cJ0/N9o5Q43eaZFr3X0iGcq1Am03c9ItKIugRLkPSNl8z1iC9ydPmGDC7tGvg/aGS9Ur
         /OdDiMyyJxHo7aJlds6PFurY0rRn7QStR9GsD4BvJHloc+iAieeFvkXYs66prRmsTMjZ
         FtZis7ov2MAnVP/zZ+wlMwP07SRyFHgS/WrzmCbWCDnkFyz3SgPqfEwOA7l4xeCCdft6
         LJvtJ0LKLn9BPuIRSOmVWk9Txr5+WK5P6NXYmFG+lfYCyOesnD9Tv889JxOzD1hxzBp6
         ULuA==
X-Gm-Message-State: AOAM532xUo9xsmCxhY+YyvTwJslxkZ0Z5OIS93NthmBvRI++zWVpProl
        0GuWYQgJkSDlIgrEpHv0ads=
X-Google-Smtp-Source: ABdhPJzJJxVGGBvw9XdfKn8DtbuxHxG5ie1As0bQc6SgQutog/ItqOl2CP+JXFe1kelcyrIyIjDuSw==
X-Received: by 2002:a17:906:1fcd:: with SMTP id e13mr5384581ejt.472.1591826774784;
        Wed, 10 Jun 2020 15:06:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id bg21sm694620ejb.90.2020.06.10.15.06.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 15:06:13 -0700 (PDT)
Date:   Wed, 10 Jun 2020 22:06:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200610220613.ets3envsukjstvlu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
 <20200604122805.d2ndjmkmti6wl3nz@master>
 <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
 <20200605230610.bizp2j23ivyma5rn@master>
 <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
 <20200608223112.ftncszh7hfnmqj3m@master>
 <20200609091649.GX2428291@smile.fi.intel.com>
 <20200609230241.gdqebrspmucnru5k@master>
 <CAHp75VdVUNqUsfr19jKHjba8CPTQhbSK+WfTKwZFtCfK0JtRCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdVUNqUsfr19jKHjba8CPTQhbSK+WfTKwZFtCfK0JtRCw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:17:28PM +0300, Andy Shevchenko wrote:
>On Wed, Jun 10, 2020 at 2:06 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>> On Tue, Jun 09, 2020 at 12:16:49PM +0300, Andy Shevchenko wrote:
>> >On Mon, Jun 08, 2020 at 10:31:12PM +0000, Wei Yang wrote:
>> >> On Fri, Jun 05, 2020 at 05:16:29PM -0700, Andrew Morton wrote:
>> >
>> >...
>> >
>> >> The test on 64bit machine pass. Since I don't have a 32bit machine by hand,
>> >
>> >Out of curiosity what that machine is?
>> >
>>
>> It is a Intel Xeon Gold CPU.
>
>I suppose it's x86 (and not ia64).
>In this case you can always build an i386 configuration and test on a
>32-bit "machine".
>

Yes, you are right. While last time I tried to run a 32bit guest, it took me a
lot of time to setup. If my understanding is correct, to run on a 32bit
machine, we not only need the kernel but a whole 32bit system. This means I
need to re-install a 32bit system. And I found many distro doesn't support
32bit system any more.

Do you have a better way to setup the environment?


>-- 
>With Best Regards,
>Andy Shevchenko

-- 
Wei Yang
Help you, Help me
