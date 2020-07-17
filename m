Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A540C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2578B20739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qRocWK+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGQVSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:18:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734FC0619D2;
        Fri, 17 Jul 2020 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=emlnUk7RryteoQg6xYj1kkPbZ5GkUzfxyk9S6H+65WM=; b=qRocWK+BCrcBflwkZsro5GJ0vZ
        0IoIJa7wj3mqklwECY4JKyEacxQ6M4j2Z0XVjbv3Ak2XDUBHkY6YscHvxhuRskvTDyYUdSGoOY7xJ
        H1YwP5u+6aANH0h8N0KAqT3EjVogB0SeYnI2KucACTASgmyvP2QTSIXkNMjLhHBTbG689GX/d5B+l
        E+he7Bo0PHqbdxRBqCz5A6Eqo7UAA+2EEYtaTMWpqRSBhHKRP/TGzZf/s6UJ/MZLI1MeMEJWpgBWc
        DLsPmKfKhOO9xRKzNGlorTWez0Qiz0Vocf+ajiE8Db33pd/RhNqkDwpBrm21trYxgwhFkjtlcLz06
        hRc5tUTA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwXke-0007oz-TN; Fri, 17 Jul 2020 21:18:41 +0000
Subject: Re: [PATCH 07/25] Documentation: gpio/driver.h: fix sphinx warnings
To:     Joe Perches <joe@perches.com>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
 <20200717185624.2009393-7-dwlsalmeida@gmail.com>
 <684c5c2e-1b2d-bcb4-1320-a3a0dbed9b70@infradead.org>
 <278ef62c230d69d51ca1bb4a0bbd978483f6f501.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <16d8378c-ab5b-7313-3cd9-be50181330a0@infradead.org>
Date:   Fri, 17 Jul 2020 14:18:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <278ef62c230d69d51ca1bb4a0bbd978483f6f501.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 12:48 PM, Joe Perches wrote:
> On Fri, 2020-07-17 at 12:37 -0700, Randy Dunlap wrote:
>> On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
>>> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
>>>
>>> Fix the following warnings:
>>>
>>> warning: Function parameter or member 'gc' not described in
>>> 'gpiochip_add_data'
>>>
>>> warning: Excess function parameter 'chip' description in
>>> 'gpiochip_add_data'
>>>
>>> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
>>
>> Mauro has already fixed this one.
> 
> Not quite fixed though.
> 
> Both patches did not update the text for chip->base where
> it should have been changed to gc->base
> 
> ---
>  include/linux/gpio/driver.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index db82451776fc..91ae7ad8730d 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -497,7 +497,7 @@ extern int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  
>  /**
>   * gpiochip_add_data() - register a gpio_chip
> - * @gc: the chip to register, with chip->base initialized
> + * @gc: the chip to register, with gc->base initialized
>   * @data: driver-private data associated with this chip
>   *
>   * Context: potentially before irqs will work

I had a patch for this but apparently I didn't send it since
Mauro's patch had been merged. My patch is dated June 15-2020:


From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in <linux/gpio/driver.h>:

../include/linux/gpio/driver.h:512: warning: Function parameter or member 'gc' not described in 'gpiochip_add_data'
../include/linux/gpio/driver.h:512: warning: Excess function parameter 'chip' description in 'gpiochip_add_data'

Fixes: 959bc7b22bd2 ("gpio: Automatically add lockdep keys")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
MAURO!
 include/linux/gpio/driver.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20200615.orig/include/linux/gpio/driver.h
+++ linux-next-20200615/include/linux/gpio/driver.h
@@ -481,25 +481,25 @@ extern int gpiochip_add_data_with_key(st
 
 /**
  * gpiochip_add_data() - register a gpio_chip
- * @chip: the chip to register, with chip->base initialized
+ * @gc: the gpio chip to register, with gc->base initialized
  * @data: driver-private data associated with this chip
  *
  * Context: potentially before irqs will work
  *
  * When gpiochip_add_data() is called very early during boot, so that GPIOs
- * can be freely used, the chip->parent device must be registered before
+ * can be freely used, the gc->parent device must be registered before
  * the gpio framework's arch_initcall().  Otherwise sysfs initialization
  * for GPIOs will fail rudely.
  *
  * gpiochip_add_data() must only be called after gpiolib initialization,
  * ie after core_initcall().
  *
- * If chip->base is negative, this requests dynamic assignment of
+ * If gc->base is negative, this requests dynamic assignment of
  * a range of valid GPIOs.
  *
  * Returns:
  * A negative errno if the chip can't be registered, such as because the
- * chip->base is invalid or already associated with a different chip.
+ * gc->base is invalid or already associated with a different chip.
  * Otherwise it returns zero as a success code.
  */
 #ifdef CONFIG_LOCKDEP




