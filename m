Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF30C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFDA206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAOzMm5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgFDM2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgFDM2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:28:08 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611ADC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 05:28:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x93so4520112ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lSORlFcZSsY0YSYfNIbAg9Ey6cjiYjeRcAyhIYfab3I=;
        b=aAOzMm5UYQpWbPFKaS58u3xmexgi14qRjZYMPdk27iHfnfatHZaJkoaaGb7u4J4r9h
         MK5gOApbLjnpV4o3ZLyoqRvc7tyN8lL08IP+a1sy8UllVWCC9SHMmBoFda5JhMIFjJL8
         y8CFvNqAK3/9VmtctD+5twE1KWqehVim9TOxeQl49SbPWpd8IWOTaD/SiUwTgAJ1vgkb
         e3VXOjKeFEY6Jys8jWzuZQdwLeml0XCPJO4T/XiFADDsLllmN8lfzOIE/0/wtgisrwPK
         +u7+VwUM5hjfsmumtmwa+air5aMBVhpBeNa3XCBzPduaXSC3z0x6TexwzznqQS2Dv6bG
         uLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lSORlFcZSsY0YSYfNIbAg9Ey6cjiYjeRcAyhIYfab3I=;
        b=trFrZr7MPFveADy25TWtuIHr+c5nU4dpFdjKbn22R9UkUwnexLmefcNBJFGUxkqtOa
         hoyW9VMw5/zOK9xBY2UfORzsvvmcVryKJTRI7KvtAtLzthytI9o86BxGwOJ3f5qrRB2E
         S//rXTjZMowVcTcotKG+2hnkEO3HeyFHACZp8pI69xRvubTFQQJTRQ6tSJHSye8jruzz
         qtwTDycKLKYNmaGv9L5a6jDx1lfuf8NQbga1ojPofMOif95WFj4cyvnGr3Iq6+Xk3ftr
         /5bIpME68ecFdKX3gHFuE42Mg/u3rze/VohH2lrYwJkA5PXZL8lGOVkksKeBqhncxHR3
         gFGw==
X-Gm-Message-State: AOAM533GxzxujdmZ/y795X0+eHGBicmDPE8yTmwDiMR5uGAtKh6G7a9p
        B0Gzaw0I0ABM1QwbZIGP1jA=
X-Google-Smtp-Source: ABdhPJzOw5woxF7veFSGEA0tzhjvmTBEPptBE1hMxqScPSnhB4e++LViGz+BdbMPMrtZaf1if/o+cA==
X-Received: by 2002:aa7:d6d0:: with SMTP id x16mr4172336edr.175.1591273687067;
        Thu, 04 Jun 2020 05:28:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id la5sm2084347ejb.94.2020.06.04.05.28.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 05:28:06 -0700 (PDT)
Date:   Thu, 4 Jun 2020 12:28:05 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200604122805.d2ndjmkmti6wl3nz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:50:13PM +0200, Geert Uytterhoeven wrote:
>Hi Wei,
>
>On Wed, Jun 3, 2020 at 1:11 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>> Add some test for get_count_order/long in test_bitops.c.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>Thanks for your patch, which is now commit 7851d6639caeea40 ("lib:
>test get_count_order/long in test_bitops.c") in linux-next.
>
>> --- a/lib/test_bitops.c
>> +++ b/lib/test_bitops.c
>
>> @@ -24,6 +28,26 @@ enum bitops_fun {
>>
>>  static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
>>
>> +unsigned int order_comb[][2] = {
>> +       {0x00000003,  2},
>> +       {0x00000004,  2},
>> +       {0x00001fff, 13},
>> +       {0x00002000, 13},
>> +       {0x50000000, 31},
>> +       {0x80000000, 31},
>> +       {0x80003000, 32},
>> +};
>> +
>> +unsigned long order_comb_long[][2] = {
>> +       {0x0000000300000000, 34},
>> +       {0x0000000400000000, 34},
>> +       {0x00001fff00000000, 45},
>> +       {0x0000200000000000, 45},
>> +       {0x5000000000000000, 63},
>> +       {0x8000000000000000, 63},
>> +       {0x8000300000000000, 64},
>> +};
>
>noreply@ellerman.id.au reported for m68k-allmodconfig:
>
>lib/test_bitops.c:42:3: error: unsigned conversion from 'long long
>int' to 'long unsigned int' changes value from '12884901888' to '0'
>[-Werror=overflow]
>lib/test_bitops.c:43:3: error: unsigned conversion from 'long long
>int' to 'long unsigned int' changes value from '17179869184' to '0'
>[-Werror=overflow]
>lib/test_bitops.c:44:3: error: unsigned conversion from 'long long
>int' to 'long unsigned int' changes value from '35180077121536' to '0'
>[-Werror=overflow]
>lib/test_bitops.c:45:3: error: unsigned conversion from 'long long
>int' to 'long unsigned int' changes value from '35184372088832' to '0'
>[-Werror=overflow]
>lib/test_bitops.c:46:3: error: unsigned conversion from 'long long
>int' to 'long unsigned int' changes value from '5764607523034234880'
>to '0' [-Werror=overflow]
>lib/test_bitops.c:47:3: error: conversion from 'long long unsigned
>int' to 'long unsigned int' changes value from '9223372036854775808'
>to '0' [-Werror=overflow]
>lib/test_bitops.c:48:3: error: conversion from 'long long unsigned
>int' to 'long unsigned int' changes value from '9223424813412909056'
>to '0' [-Werror=overflow]
>
>Indeed, on 32-bit, none of these values fit in unsigned long.
>

Hmm... I didn't test on 32bit platform. Sorry for that.

>>  static int __init test_bitops_startup(void)
>>  {
>>         pr_warn("Loaded test module\n");
>> @@ -32,6 +56,18 @@ static int __init test_bitops_startup(void)
>>         set_bit(BITOPS_11, g_bitmap);
>>         set_bit(BITOPS_31, g_bitmap);
>>         set_bit(BITOPS_88, g_bitmap);
>> +
>> +       for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
>> +               if (order_comb[i][1] != get_count_order(order_comb[i][0]))
>> +                       pr_warn("get_count_order wrong for %x\n",
>> +                                      order_comb[i][0]); }
>> +
>> +       for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
>> +               if (order_comb_long[i][1] !=
>> +                              get_count_order_long(order_comb_long[i][0]))
>> +                       pr_warn("get_count_order_long wrong for %lx\n",
>> +                                      order_comb_long[i][0]); }
>> +
>>         return 0;
>
>BTW, shouldn't get_count_order_long() be tested with the values in
>order_comb[], too?
>

You mean 

       {0x0000000000000003,  2},
       {0x0000000000000004,  2},
       {0x0000000000001fff, 13},
       {0x0000000000002000, 13},
       {0x0000000050000000, 31},
       {0x0000000080000000, 31},
       {0x0000000080003000, 32},

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
