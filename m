Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D635C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D9C24680
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+SBS9eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgB1OKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:10:04 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39249 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1OKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:10:04 -0500
Received: by mail-yw1-f68.google.com with SMTP id x184so3377265ywd.6;
        Fri, 28 Feb 2020 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Y+68SImdbNSuY6IY5G/gWExk6KtO0Yf3n4LBQHQ3ys=;
        b=g+SBS9ehkUyyeKkDZo9WcEJkE9Y4Y7fazDrMAzr9AAPbVcQi5/eWSGq2l8llgnU8Om
         u6zsY+MMfGTB2kra9k7PfJ+B+lYqi16LkCRFK0lkD4mB4YK1NYXgY/Tc9ON6OrfLPgWN
         AoV7gQOkDFX+iWZRxykhxy5h+NjdoWv5Mu08Vjge925kOLSC0tPFFlnbonqWlqnq8hon
         gvVS9PLsDKk68b/T1gpKZ4lsZliLOeqNy2/86IuDzA0/jz9oBmUvfzFp6UiZ98p2Vc7d
         8sNvM7hjwDkdUu25vb1Kmgc4FvjFoe6uNkpXv30VDPTzAoWstV5sEcuQ9j12xfVt2ohL
         iQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Y+68SImdbNSuY6IY5G/gWExk6KtO0Yf3n4LBQHQ3ys=;
        b=IruqodLKWlcLlwO6XAbK3ZTc3AHU+B7jNvzgdtkUUh+1VPWUshcDvlekoxRylrTyyN
         yvIhMoC+n7mIDVJ7YIodUgu7v6ihc4NAjt//x2339jWtKSbY3d0MAEdPkVLatA1qYg5h
         OCZEu8xLfEITgxNrWceGThVJoDM0wb6NHqrN86qRKJCyldYNR4Zbd3T0Df1FwDhI0cAM
         iz8gAq2NQbVz/iwQaEtCBK/hhPIO9sf3xR80sveB8yq3i+c56U0qKiGQCiotFd5l2hKi
         UH02pW1m8H8h53lAM0PCQi2CTeig6XTLDC1rx3+oJ6rzmBZSfKIAZYCx77idbvVTsgpK
         +fQw==
X-Gm-Message-State: APjAAAUfv/Zw2D6IFeztMu1fIvI89AEOyaYVKdy7q0pVVPgN3cWmY0hZ
        qRDb4aA4FQlhJWIwSuFYFGg=
X-Google-Smtp-Source: APXvYqxVMXhQc+p3g+35S2Ibr299uOvcBUPkmHydozlkqmcnhfFp73LpAU5wNJlWr+vTHePs44ORpg==
X-Received: by 2002:a0d:eacd:: with SMTP id t196mr4466187ywe.100.1582899002859;
        Fri, 28 Feb 2020 06:10:02 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id e63sm3835179ywd.64.2020.02.28.06.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 06:10:00 -0800 (PST)
Subject: Re: [PATCH] of: unittest: make gpio overlay test dependent on
 CONFIG_OF_GPIO
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1582863389-3118-1-git-send-email-frowand.list@gmail.com>
Message-ID: <db823e84-5d59-374f-c616-e67819d62406@gmail.com>
Date:   Fri, 28 Feb 2020 08:10:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1582863389-3118-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2/27/20 10:16 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Randconfig testing found compile errors in drivers/of/unittest.c if
> CONFIG_GPIOLIB is not set because CONFIG_OF_GPIO depends on
> CONFIG_GPIOLIB.  Make the gpio overlay test depend on CONFIG_OF_GPIO.
> 
> No code is modified, it is only moved to a different location and
> protected with #ifdef CONFIG_OF_GPIO.  An empty
> of_unittest_overlay_gpio() is added in the #else.

Should I have used your 'next' or 'for-next' branch for the commit id:

Fixes: f4056e705b2e ("of: unittest: add overlay gpio test to catch gpio hog problem")

-Frank


> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 465 ++++++++++++++++++++++++++------------------------
>  1 file changed, 238 insertions(+), 227 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 96ae8a762a9e..1e5a2e4d893e 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -61,86 +61,6 @@
>  #define EXPECT_END(level, fmt, ...) \
>  	printk(level pr_fmt("EXPECT / : ") fmt, ##__VA_ARGS__)
>  
> -struct unittest_gpio_dev {
> -	struct gpio_chip chip;
> -};
> -
> -static int unittest_gpio_chip_request_count;
> -static int unittest_gpio_probe_count;
> -static int unittest_gpio_probe_pass_count;
> -
> -static int unittest_gpio_chip_request(struct gpio_chip *chip, unsigned int offset)
> -{
> -	unittest_gpio_chip_request_count++;
> -
> -	pr_debug("%s(): %s %d %d\n", __func__, chip->label, offset,
> -		 unittest_gpio_chip_request_count);
> -	return 0;
> -}
> -
> -static int unittest_gpio_probe(struct platform_device *pdev)
> -{
> -	struct unittest_gpio_dev *devptr;
> -	int ret;
> -
> -	unittest_gpio_probe_count++;
> -
> -	devptr = kzalloc(sizeof(*devptr), GFP_KERNEL);
> -	if (!devptr)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, devptr);
> -
> -	devptr->chip.of_node = pdev->dev.of_node;
> -	devptr->chip.label = "of-unittest-gpio";
> -	devptr->chip.base = -1; /* dynamic allocation */
> -	devptr->chip.ngpio = 5;
> -	devptr->chip.request = unittest_gpio_chip_request;
> -
> -	ret = gpiochip_add_data(&devptr->chip, NULL);
> -
> -	unittest(!ret,
> -		 "gpiochip_add_data() for node @%pOF failed, ret = %d\n", devptr->chip.of_node, ret);
> -
> -	if (!ret)
> -		unittest_gpio_probe_pass_count++;
> -	return ret;
> -}
> -
> -static int unittest_gpio_remove(struct platform_device *pdev)
> -{
> -	struct unittest_gpio_dev *gdev = platform_get_drvdata(pdev);
> -	struct device *dev = &pdev->dev;
> -	struct device_node *np = pdev->dev.of_node;
> -
> -	dev_dbg(dev, "%s for node @%pOF\n", __func__, np);
> -
> -	if (!gdev)
> -		return -EINVAL;
> -
> -	if (gdev->chip.base != -1)
> -		gpiochip_remove(&gdev->chip);
> -
> -	platform_set_drvdata(pdev, NULL);
> -	kfree(pdev);
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id unittest_gpio_id[] = {
> -	{ .compatible = "unittest-gpio", },
> -	{}
> -};
> -
> -static struct platform_driver unittest_gpio_driver = {
> -	.probe	= unittest_gpio_probe,
> -	.remove	= unittest_gpio_remove,
> -	.driver	= {
> -		.name		= "unittest-gpio",
> -		.of_match_table	= of_match_ptr(unittest_gpio_id),
> -	},
> -};
> -
>  static void __init of_unittest_find_node_by_name(void)
>  {
>  	struct device_node *np;
> @@ -1588,6 +1508,244 @@ static int of_path_platform_device_exists(const char *path)
>  	return pdev != NULL;
>  }
>  
> +#ifdef CONFIG_OF_GPIO
> +
> +struct unittest_gpio_dev {
> +	struct gpio_chip chip;
> +};
> +
> +static int unittest_gpio_chip_request_count;
> +static int unittest_gpio_probe_count;
> +static int unittest_gpio_probe_pass_count;
> +
> +static int unittest_gpio_chip_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +	unittest_gpio_chip_request_count++;
> +
> +	pr_debug("%s(): %s %d %d\n", __func__, chip->label, offset,
> +		 unittest_gpio_chip_request_count);
> +	return 0;
> +}
> +
> +static int unittest_gpio_probe(struct platform_device *pdev)
> +{
> +	struct unittest_gpio_dev *devptr;
> +	int ret;
> +
> +	unittest_gpio_probe_count++;
> +
> +	devptr = kzalloc(sizeof(*devptr), GFP_KERNEL);
> +	if (!devptr)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, devptr);
> +
> +	devptr->chip.of_node = pdev->dev.of_node;
> +	devptr->chip.label = "of-unittest-gpio";
> +	devptr->chip.base = -1; /* dynamic allocation */
> +	devptr->chip.ngpio = 5;
> +	devptr->chip.request = unittest_gpio_chip_request;
> +
> +	ret = gpiochip_add_data(&devptr->chip, NULL);
> +
> +	unittest(!ret,
> +		 "gpiochip_add_data() for node @%pOF failed, ret = %d\n", devptr->chip.of_node, ret);
> +
> +	if (!ret)
> +		unittest_gpio_probe_pass_count++;
> +	return ret;
> +}
> +
> +static int unittest_gpio_remove(struct platform_device *pdev)
> +{
> +	struct unittest_gpio_dev *gdev = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	dev_dbg(dev, "%s for node @%pOF\n", __func__, np);
> +
> +	if (!gdev)
> +		return -EINVAL;
> +
> +	if (gdev->chip.base != -1)
> +		gpiochip_remove(&gdev->chip);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(pdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id unittest_gpio_id[] = {
> +	{ .compatible = "unittest-gpio", },
> +	{}
> +};
> +
> +static struct platform_driver unittest_gpio_driver = {
> +	.probe	= unittest_gpio_probe,
> +	.remove	= unittest_gpio_remove,
> +	.driver	= {
> +		.name		= "unittest-gpio",
> +		.of_match_table	= of_match_ptr(unittest_gpio_id),
> +	},
> +};
> +
> +static void __init of_unittest_overlay_gpio(void)
> +{
> +	int chip_request_count;
> +	int probe_pass_count;
> +	int ret;
> +
> +	/*
> +	 * tests: apply overlays before registering driver
> +	 * Similar to installing a driver as a module, the
> +	 * driver is registered after applying the overlays.
> +	 *
> +	 * - apply overlay_gpio_01
> +	 * - apply overlay_gpio_02a
> +	 * - apply overlay_gpio_02b
> +	 * - register driver
> +	 *
> +	 * register driver will result in
> +	 *   - probe and processing gpio hog for overlay_gpio_01
> +	 *   - probe for overlay_gpio_02a
> +	 *   - processing gpio for overlay_gpio_02b
> +	 */
> +
> +	probe_pass_count = unittest_gpio_probe_pass_count;
> +	chip_request_count = unittest_gpio_chip_request_count;
> +
> +	/*
> +	 * overlay_gpio_01 contains gpio node and child gpio hog node
> +	 * overlay_gpio_02a contains gpio node
> +	 * overlay_gpio_02b contains child gpio hog node
> +	 */
> +
> +	unittest(overlay_data_apply("overlay_gpio_01", NULL),
> +		 "Adding overlay 'overlay_gpio_01' failed\n");
> +
> +	unittest(overlay_data_apply("overlay_gpio_02a", NULL),
> +		 "Adding overlay 'overlay_gpio_02a' failed\n");
> +
> +	unittest(overlay_data_apply("overlay_gpio_02b", NULL),
> +		 "Adding overlay 'overlay_gpio_02b' failed\n");
> +
> +	/*
> +	 * messages are the result of the probes, after the
> +	 * driver is registered
> +	 */
> +
> +	EXPECT_BEGIN(KERN_INFO,
> +		     "GPIO line <<int>> (line-B-input) hogged as input\n");
> +
> +	EXPECT_BEGIN(KERN_INFO,
> +		     "GPIO line <<int>> (line-A-input) hogged as input\n");
> +
> +	ret = platform_driver_register(&unittest_gpio_driver);
> +	if (unittest(ret == 0, "could not register unittest gpio driver\n"))
> +		return;
> +
> +	EXPECT_END(KERN_INFO,
> +		   "GPIO line <<int>> (line-A-input) hogged as input\n");
> +	EXPECT_END(KERN_INFO,
> +		   "GPIO line <<int>> (line-B-input) hogged as input\n");
> +
> +	unittest(probe_pass_count + 2 == unittest_gpio_probe_pass_count,
> +		 "unittest_gpio_probe() failed or not called\n");
> +
> +	unittest(chip_request_count + 2 == unittest_gpio_chip_request_count,
> +		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> +		 unittest_gpio_chip_request_count - chip_request_count);
> +
> +	/*
> +	 * tests: apply overlays after registering driver
> +	 *
> +	 * Similar to a driver built-in to the kernel, the
> +	 * driver is registered before applying the overlays.
> +	 *
> +	 * overlay_gpio_03 contains gpio node and child gpio hog node
> +	 *
> +	 * - apply overlay_gpio_03
> +	 *
> +	 * apply overlay will result in
> +	 *   - probe and processing gpio hog.
> +	 */
> +
> +	probe_pass_count = unittest_gpio_probe_pass_count;
> +	chip_request_count = unittest_gpio_chip_request_count;
> +
> +	EXPECT_BEGIN(KERN_INFO,
> +		     "GPIO line <<int>> (line-D-input) hogged as input\n");
> +
> +	/* overlay_gpio_03 contains gpio node and child gpio hog node */
> +
> +	unittest(overlay_data_apply("overlay_gpio_03", NULL),
> +		 "Adding overlay 'overlay_gpio_03' failed\n");
> +
> +	EXPECT_END(KERN_INFO,
> +		   "GPIO line <<int>> (line-D-input) hogged as input\n");
> +
> +	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
> +		 "unittest_gpio_probe() failed or not called\n");
> +
> +	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
> +		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> +		 unittest_gpio_chip_request_count - chip_request_count);
> +
> +	/*
> +	 * overlay_gpio_04a contains gpio node
> +	 *
> +	 * - apply overlay_gpio_04a
> +	 *
> +	 * apply the overlay will result in
> +	 *   - probe for overlay_gpio_04a
> +	 */
> +
> +	probe_pass_count = unittest_gpio_probe_pass_count;
> +	chip_request_count = unittest_gpio_chip_request_count;
> +
> +	/* overlay_gpio_04a contains gpio node */
> +
> +	unittest(overlay_data_apply("overlay_gpio_04a", NULL),
> +		 "Adding overlay 'overlay_gpio_04a' failed\n");
> +
> +	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
> +		 "unittest_gpio_probe() failed or not called\n");
> +
> +	/*
> +	 * overlay_gpio_04b contains child gpio hog node
> +	 *
> +	 * - apply overlay_gpio_04b
> +	 *
> +	 * apply the overlay will result in
> +	 *   - processing gpio for overlay_gpio_04b
> +	 */
> +
> +	EXPECT_BEGIN(KERN_INFO,
> +		     "GPIO line <<int>> (line-C-input) hogged as input\n");
> +
> +	/* overlay_gpio_04b contains child gpio hog node */
> +
> +	unittest(overlay_data_apply("overlay_gpio_04b", NULL),
> +		 "Adding overlay 'overlay_gpio_04b' failed\n");
> +
> +	EXPECT_END(KERN_INFO,
> +		   "GPIO line <<int>> (line-C-input) hogged as input\n");
> +
> +	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
> +		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> +		 unittest_gpio_chip_request_count - chip_request_count);
> +}
> +
> +#else
> +
> +static void __init of_unittest_overlay_gpio(void)
> +{
> +	/* skip tests */
> +}
> +
> +#endif
> +
>  #if IS_BUILTIN(CONFIG_I2C)
>  
>  /* get the i2c client device instantiated at the path */
> @@ -2517,153 +2675,6 @@ static inline void of_unittest_overlay_i2c_15(void) { }
>  
>  #endif
>  
> -static void __init of_unittest_overlay_gpio(void)
> -{
> -	int chip_request_count;
> -	int probe_pass_count;
> -	int ret;
> -
> -	/*
> -	 * tests: apply overlays before registering driver
> -	 * Similar to installing a driver as a module, the
> -	 * driver is registered after applying the overlays.
> -	 *
> -	 * - apply overlay_gpio_01
> -	 * - apply overlay_gpio_02a
> -	 * - apply overlay_gpio_02b
> -	 * - register driver
> -	 *
> -	 * register driver will result in
> -	 *   - probe and processing gpio hog for overlay_gpio_01
> -	 *   - probe for overlay_gpio_02a
> -	 *   - processing gpio for overlay_gpio_02b
> -	 */
> -
> -	probe_pass_count = unittest_gpio_probe_pass_count;
> -	chip_request_count = unittest_gpio_chip_request_count;
> -
> -	/*
> -	 * overlay_gpio_01 contains gpio node and child gpio hog node
> -	 * overlay_gpio_02a contains gpio node
> -	 * overlay_gpio_02b contains child gpio hog node
> -	 */
> -
> -	unittest(overlay_data_apply("overlay_gpio_01", NULL),
> -		 "Adding overlay 'overlay_gpio_01' failed\n");
> -
> -	unittest(overlay_data_apply("overlay_gpio_02a", NULL),
> -		 "Adding overlay 'overlay_gpio_02a' failed\n");
> -
> -	unittest(overlay_data_apply("overlay_gpio_02b", NULL),
> -		 "Adding overlay 'overlay_gpio_02b' failed\n");
> -
> -	/*
> -	 * messages are the result of the probes, after the
> -	 * driver is registered
> -	 */
> -
> -	EXPECT_BEGIN(KERN_INFO,
> -		     "GPIO line <<int>> (line-B-input) hogged as input\n");
> -
> -	EXPECT_BEGIN(KERN_INFO,
> -		     "GPIO line <<int>> (line-A-input) hogged as input\n");
> -
> -	ret = platform_driver_register(&unittest_gpio_driver);
> -	if (unittest(ret == 0, "could not register unittest gpio driver\n"))
> -		return;
> -
> -	EXPECT_END(KERN_INFO,
> -		   "GPIO line <<int>> (line-A-input) hogged as input\n");
> -	EXPECT_END(KERN_INFO,
> -		   "GPIO line <<int>> (line-B-input) hogged as input\n");
> -
> -	unittest(probe_pass_count + 2 == unittest_gpio_probe_pass_count,
> -		 "unittest_gpio_probe() failed or not called\n");
> -
> -	unittest(chip_request_count + 2 == unittest_gpio_chip_request_count,
> -		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> -		 unittest_gpio_chip_request_count - chip_request_count);
> -
> -	/*
> -	 * tests: apply overlays after registering driver
> -	 *
> -	 * Similar to a driver built-in to the kernel, the
> -	 * driver is registered before applying the overlays.
> -	 *
> -	 * overlay_gpio_03 contains gpio node and child gpio hog node
> -	 *
> -	 * - apply overlay_gpio_03
> -	 *
> -	 * apply overlay will result in
> -	 *   - probe and processing gpio hog.
> -	 */
> -
> -	probe_pass_count = unittest_gpio_probe_pass_count;
> -	chip_request_count = unittest_gpio_chip_request_count;
> -
> -	EXPECT_BEGIN(KERN_INFO,
> -		     "GPIO line <<int>> (line-D-input) hogged as input\n");
> -
> -	/* overlay_gpio_03 contains gpio node and child gpio hog node */
> -
> -	unittest(overlay_data_apply("overlay_gpio_03", NULL),
> -		 "Adding overlay 'overlay_gpio_03' failed\n");
> -
> -	EXPECT_END(KERN_INFO,
> -		   "GPIO line <<int>> (line-D-input) hogged as input\n");
> -
> -	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
> -		 "unittest_gpio_probe() failed or not called\n");
> -
> -	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
> -		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> -		 unittest_gpio_chip_request_count - chip_request_count);
> -
> -	/*
> -	 * overlay_gpio_04a contains gpio node
> -	 *
> -	 * - apply overlay_gpio_04a
> -	 *
> -	 * apply the overlay will result in
> -	 *   - probe for overlay_gpio_04a
> -	 */
> -
> -	probe_pass_count = unittest_gpio_probe_pass_count;
> -	chip_request_count = unittest_gpio_chip_request_count;
> -
> -	/* overlay_gpio_04a contains gpio node */
> -
> -	unittest(overlay_data_apply("overlay_gpio_04a", NULL),
> -		 "Adding overlay 'overlay_gpio_04a' failed\n");
> -
> -	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
> -		 "unittest_gpio_probe() failed or not called\n");
> -
> -	/*
> -	 * overlay_gpio_04b contains child gpio hog node
> -	 *
> -	 * - apply overlay_gpio_04b
> -	 *
> -	 * apply the overlay will result in
> -	 *   - processing gpio for overlay_gpio_04b
> -	 */
> -
> -	EXPECT_BEGIN(KERN_INFO,
> -		     "GPIO line <<int>> (line-C-input) hogged as input\n");
> -
> -	/* overlay_gpio_04b contains child gpio hog node */
> -
> -	unittest(overlay_data_apply("overlay_gpio_04b", NULL),
> -		 "Adding overlay 'overlay_gpio_04b' failed\n");
> -
> -	EXPECT_END(KERN_INFO,
> -		   "GPIO line <<int>> (line-C-input) hogged as input\n");
> -
> -	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
> -		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> -		 unittest_gpio_chip_request_count - chip_request_count);
> -}
> -
>  static void __init of_unittest_overlay(void)
>  {
>  	struct device_node *bus_np = NULL;
> 

