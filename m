Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F4FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A042068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTKfedOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFHWbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgFHWbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:31:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04AEC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 15:31:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a25so20159088ejg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V3feTmS496TJlimJvnm9RZmYbWgAPgqFZZ3GzAzheVo=;
        b=uTKfedOEoLu7ocU5Vu2DLSVViuUV/z8DaTpxsHuxcBQv+m13Fgwo78M4sHh6TVl5Er
         J8Wb6G/atd23J7bpEjLPk0D/MySM+FrJER6iowZYU0Rcon0qTH9znAw2ebUpUhvwRcTi
         MZasFSslwynfFjx3PYLWPEOuIvKQmizyWJPFD1LYJ/8Hxt5Q3si/L9cEIv62dfQrLlTT
         GKOJJy7RXw9UJnAuHHWt91Afq3zRYGljwQWg/nH1l8Whst/if0OYvn60YRsMk1sS9v3t
         1cyLQoBn+Y+4sngchzgwCGaT/X406qJOG3xTmW5t7ryGXhWHFGooFGnmLOGONz0p2MQg
         watw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V3feTmS496TJlimJvnm9RZmYbWgAPgqFZZ3GzAzheVo=;
        b=bY54k5I0892pzcaUGNq8d1NUzteh9jwOqlqMiKc4aA1wFVdg+cGrwL0fZIXM1N+yVQ
         hDIs9cSPNni/K12zzkGP3o6Y3xEeJMNJSRSSis7B9AgeRvbGzO0iJwMOjZYOId8LmKmA
         LqFNfhRKt9PTDyMO3vOHiP8ua9c/0ts2mUYxIt5PpuVd+Q/FnvtDCiRfpCcNez5cQYaq
         wGiwC2IuaOsMarqq2yhBA/FA+GSUUb8FY77QW1GCAOapzzhzalusndHJKLecZ4FrPB9d
         xGT1GTy0UrelnuNLGJxwBG37ZCX1Ioti2gaGPSBbIz6niIOZUvp9j4t6byHOxBT1WTCp
         h1dw==
X-Gm-Message-State: AOAM533QNJcBDvSP7I9zC5zd3R2SyKcFQB3kFv6cvZnoTFTNX/t6HmXE
        DTwDS6HiX4D0ftTNdOtsgUN9KKxL
X-Google-Smtp-Source: ABdhPJwUUToXpCHDRzJLjMUDrWcVnNFI9pI39Jq/BTqTcUvcFjX/ExLzrZDk3NhlzptzPxsjSJDOrw==
X-Received: by 2002:a17:906:509:: with SMTP id j9mr21868795eja.341.1591655473406;
        Mon, 08 Jun 2020 15:31:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ce25sm6873946edb.45.2020.06.08.15.31.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jun 2020 15:31:12 -0700 (PDT)
Date:   Mon, 8 Jun 2020 22:31:12 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200608223112.ftncszh7hfnmqj3m@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
 <20200604122805.d2ndjmkmti6wl3nz@master>
 <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
 <20200605230610.bizp2j23ivyma5rn@master>
 <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:16:29PM -0700, Andrew Morton wrote:
>On Fri, 5 Jun 2020 23:06:10 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> On Thu, Jun 04, 2020 at 02:51:40PM +0200, Geert Uytterhoeven wrote:
>> >Hi Wei,
>> >
>> >On Thu, Jun 4, 2020 at 2:28 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>> [...]
>> >>
>> >> You mean
>> >>
>> >>        {0x0000000000000003,  2},
>> >>        {0x0000000000000004,  2},
>> >>        {0x0000000000001fff, 13},
>> >>        {0x0000000000002000, 13},
>> >>        {0x0000000050000000, 31},
>> >>        {0x0000000080000000, 31},
>> >>        {0x0000000080003000, 32},
>> >
>> >Yes, those values.  And those should work with get_count_order_long()
>> >on both 32-bit and 64-bit.
>
>Geert meant "no, the values in order_comb[]" :)
>
>We have a table of numbers in order_comb[] so we may as well feed them
>into get_count_order_long() (as well as get_count_order()) just for a
>bit more testing.
>
>So how about the below?  order_comb_long[] just can't be used on 32-bit
>machines because their longs are 32-bit.  If we had a
>get_count_order_u64() then we could use it.
>
>I haven't runtime tested this - could you please do so?
>
>
>static unsigned int order_comb[][2] = {
>	{0x00000003,  2},
>	{0x00000004,  2},
>	{0x00001fff, 13},
>	{0x00002000, 13},
>	{0x50000000, 31},
>	{0x80000000, 31},
>	{0x80003000, 32},
>};
>
>#ifdef CONFIG_64BIT
>static unsigned long order_comb_long[][2] = {
>	{0x0000000300000000, 34},
>	{0x0000000400000000, 34},
>	{0x00001fff00000000, 45},
>	{0x0000200000000000, 45},
>	{0x5000000000000000, 63},
>	{0x8000000000000000, 63},
>	{0x8000300000000000, 64},
>};
>#endif
>
>static int __init test_bitops_startup(void)
>{
>	int i;
>
>	pr_warn("Loaded test module\n");
>	set_bit(BITOPS_4, g_bitmap);
>	set_bit(BITOPS_7, g_bitmap);
>	set_bit(BITOPS_11, g_bitmap);
>	set_bit(BITOPS_31, g_bitmap);
>	set_bit(BITOPS_88, g_bitmap);
>
>	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
>		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
>			pr_warn("get_count_order wrong for %x\n",
>				       order_comb[i][0]);
>	}
>
>	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
>		if (order_comb[i][1] != get_count_order_long(order_comb[i][0]))
>			pr_warn("get_count_order_long wrong for %x\n",
>				       order_comb[i][0]);
>	}
>
>#ifdef CONFIG_64BIT
>	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
>		if (order_comb_long[i][1] !=
>			       get_count_order_long(order_comb_long[i][0]))
>			pr_warn("get_count_order_long wrong for %lx\n",
>				       order_comb_long[i][0]);
>	}
>#endif
>	return 0;
>}
>
>
>From: Andrew Morton <akpm@linux-foundation.org>
>Subject: lib-test-get_count_order-long-in-test_bitopsc-fix
>
>Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Cc: Christian Brauner <christian.brauner@ubuntu.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>---
>
> lib/test_bitops.c |   23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)
>
>--- a/lib/test_bitops.c~lib-test-get_count_order-long-in-test_bitopsc-fix
>+++ a/lib/test_bitops.c
>@@ -28,7 +28,7 @@ enum bitops_fun {
> 
> static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
> 
>-unsigned int order_comb[][2] = {
>+static unsigned int order_comb[][2] = {
> 	{0x00000003,  2},
> 	{0x00000004,  2},
> 	{0x00001fff, 13},
>@@ -38,7 +38,8 @@ unsigned int order_comb[][2] = {
> 	{0x80003000, 32},
> };
> 
>-unsigned long order_comb_long[][2] = {
>+#ifdef CONFIG_64BIT
>+static unsigned long order_comb_long[][2] = {
> 	{0x0000000300000000, 34},
> 	{0x0000000400000000, 34},
> 	{0x00001fff00000000, 45},
>@@ -47,6 +48,7 @@ unsigned long order_comb_long[][2] = {
> 	{0x8000000000000000, 63},
> 	{0x8000300000000000, 64},
> };
>+#endif
> 
> static int __init test_bitops_startup(void)
> {
>@@ -62,14 +64,23 @@ static int __init test_bitops_startup(vo
> 	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
> 		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
> 			pr_warn("get_count_order wrong for %x\n",
>-				       order_comb[i][0]); }
>+				       order_comb[i][0]);
>+	}
> 
>-	for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
>+	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
>+		if (order_comb[i][1] != get_count_order_long(order_comb[i][0]))
>+			pr_warn("get_count_order_long wrong for %x\n",
>+				       order_comb[i][0]);
>+	}
>+
>+#ifdef CONFIG_64BIT
>+	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
                                   ^
I am afraid this one should be order_comb_long?

The test on 64bit machine pass. Since I don't have a 32bit machine by hand, 
Geert, would you mind have a try on 32bit machine? 

> 		if (order_comb_long[i][1] !=
> 			       get_count_order_long(order_comb_long[i][0]))
> 			pr_warn("get_count_order_long wrong for %lx\n",
>-				       order_comb_long[i][0]); }
>-
>+				       order_comb_long[i][0]);
>+	}
>+#endif
> 	return 0;
> }
> 
>_

-- 
Wei Yang
Help you, Help me
