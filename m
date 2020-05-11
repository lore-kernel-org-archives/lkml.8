Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E4EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 03:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D6020661
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 03:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pXm4pNvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgEKDZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 23:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbgEKDZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 23:25:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A4C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 20:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=3uZrKIybwm011uTDusn5igKUX1onE/0jJKF9PC/HkAg=; b=pXm4pNvxMa3FDvgJE6UUxg3blX
        brEYpze57lLc/JvxOJljTGkw5Jgoell3Jite475zhAIP7dMj/Gg2HzM0g2zIdJmjpAB048dF7IuKB
        P5Q3BpqpW18MvBGONt5CqF+5RsjeL9uVsHeAAi2EDsgQr4lMc2uCqexugFV2BXKEFZwU1CtlRGt95
        9IV1Ka8LMJ5vhfqtVCziWud7Ckfh5g4i66VY6C1rfn8Som6EHVKXAhWzz7R8mUv63BdlQSx0GjWd9
        mpqPl0VPrvAX+Q5KybFybOogq7066QbT7qpW5G/fBqBJ0aKuQr34Ag0jdfYotUcvHPJP5UzaxSZPl
        eSAUzafA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXz4U-00012l-Vk; Mon, 11 May 2020 03:25:39 +0000
Subject: Re: [PATCH v6 5/9] w1_therm: adding resolution sysfs entry
To:     Akira Shimahara <akira215corp@gmail.com>, greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
References: <20200510141707.173273-1-akira215corp@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7eb90dc8-2924-4c24-e305-5424c5953164@infradead.org>
Date:   Sun, 10 May 2020 20:25:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510141707.173273-1-akira215corp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The kernel-doc comment changes look good.  Thanks for doing that.


On 5/10/20 7:17 AM, Akira Shimahara wrote:

> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 08579dc..b1734ae 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -50,12 +50,24 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
>  
>  /* Helpers Macros */
>  
> +/* return a pointer on the slave w1_therm_family_converter struct:
> + * always test family data existence before
> + */

/*
 * Kernel multi-line comment coding style (except for networking source code)
 * is like this.
 */

(in multiple places)

> +/**
> + * write_scratchpad() - write nb_bytes in the device RAM
> + * @sl: pointer to the slave to write in
> + * @data: pointer to an array of 3 bytes, as 3 bytes MUST be written
> + * @nb_bytes: Nb bytes to be written (2 for DS18S20, 3 for other devices)

If Nb means Number, please spell it out.

> + *
> + * Return: 0 if success, -kernel error code otherwise
> + */
> +static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
> +
>  /**
>   * read_powermode() - Query the power mode of the slave
>   * @sl: slave to retrieve the power mode


thanks.
-- 
~Randy

