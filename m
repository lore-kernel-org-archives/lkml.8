Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE6C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 03:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A37F206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 03:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ly/PVvGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgEKDdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 23:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727824AbgEKDdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 23:33:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FEC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 20:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=afIaqFckM2LD5Yf2NarwiUlCG9vphJsT2US9ZSYg5cY=; b=ly/PVvGrjtS3z6BzuHGoVsbcN4
        7Nys40PA/BVEfwjkvOpy5f+CvjhKWfkvZuJBWHVBzdl2ObNOf3i/i4d8IR9ea79VU1UEHbwBIENAf
        +dr+hqXmgp/CQ9JSGBo7w9JR9Yt5kMhqBRxEY+P1DKyClcNQHbbGeQ06JwFsB6/hN4XIxcMecv0oo
        nWWAtQ2NJxYey7TdGNd4AYTdppEJaSZzKRh4Hr5NuZP7W54NJP4W7IEtr84TIa5BkaymyR+Yq71F6
        V225E7mz8glpLkoOT1Oiv5R8Efpgj9gUUis8A/JMxAjtGG8P6AB8HNRybYDWfvZCXzv1J/c0JTd3+
        eyAwYGeg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXzCH-00049R-Fr; Mon, 11 May 2020 03:33:41 +0000
Subject: Re: [PATCH v6 1/9] w1_therm: adding code comments and code reordering
To:     Akira Shimahara <akira215corp@gmail.com>, greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
References: <20200510141506.172021-1-akira215corp@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47e5d267-071a-f6cb-33d3-2a6f1c3ba67e@infradead.org>
Date:   Sun, 10 May 2020 20:33:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510141506.172021-1-akira215corp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few more comments here (inline):

On 5/10/20 7:15 AM, Akira Shimahara wrote:

>  drivers/w1/slaves/w1_therm.c | 398 ++++++++++++++++++++---------------
>  1 file changed, 232 insertions(+), 166 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 18f08d7..890cf09 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -41,42 +41,55 @@
>  static int w1_strong_pullup = 1;
>  module_param_named(strong_pullup, w1_strong_pullup, int, 0);
>  
> +/* Helpers Macros */
> +
> +/* return the address of the refcnt in the family data */
> +#define THERM_REFCNT(family_data) \
> +	(&((struct w1_therm_family_data *)family_data)->refcnt)
> +
> +/* Structs definition */
> +
> +/**
> + * struct w1_therm_family_converter - bind device specific functions
> + * @broken: flag for non registred families

                        non-registered

> + * @reserved: not used here
> + * @f: pointer to the device binding structure
> + * @convert: pointer to the device conversion function
> + * @precision: pointer to the device precicion function

                                        precision

> + * @eeprom: pointer to eeprom function
> + */
> +struct w1_therm_family_converter {
> +	u8		broken;
> +	u16		reserved;
> +	struct w1_family	*f;
> +	int		(*convert)(u8 rom[9]);
> +	int		(*precision)(struct device *device, int val);
> +	int		(*eeprom)(struct device *device);
> +};
> +
> +/**
> + * struct w1_therm_family_data - device data
> + * @rom: ROM id of the device
> + * @refcnt: ref count
> + */
>  struct w1_therm_family_data {
>  	uint8_t rom[9];

Why is "rom" 9 bytes in length?  Does it come from some
spec or standard?  Can it be a macro instead of an arbitrary
magic number?

>  	atomic_t refcnt;
>  };
>  
> +/**
> + * struct therm_info - store temperature reading
> + * @rom: readen device data

            read

> + * @crc: computed crc from rom
> + * @verdict: 1 crc checked, 0 crc not matching
> + */
>  struct therm_info {
>  	u8 rom[9];
>  	u8 crc;
>  	u8 verdict;
>  };
>  
...

>  
> +/* Interface Functions declaration */
> +
> +/**
> + * w1_therm_add_slave() - Called when a new slave is discovered
> + * @sl: slave just discovered by the master.
> + *
> + * Called by the master when the slave is discovered on the bus.Used to

                                                               bus. Used to

> + * initialized slave state before the beginning of any communication.

      initialize

> + *
> + * Return: 0 - If success, negative kernel code otherwise
> + */
> +static int w1_therm_add_slave(struct w1_slave *sl);
> +
> +/**
> + * w1_therm_remove_slave() - Called when a slave is removed
> + * @sl: slave to be removed.
> + *
> + * Called by the master when the slave is considered not to be on the bus
> + * anymore. Used to free memory.
> + */
> +static void w1_therm_remove_slave(struct w1_slave *sl);
> +
> +/* Family attributes */
> +
>  static struct attribute *w1_therm_attrs[] = {
>  	&dev_attr_w1_slave.attr,
>  	NULL,
> @@ -101,6 +140,8 @@ static struct attribute *w1_ds28ea00_attrs[] = {
>  	NULL,
>  };
>  
> +/* Attribute groups */
> +
>  ATTRIBUTE_GROUPS(w1_therm);
>  ATTRIBUTE_GROUPS(w1_ds28ea00);
>  
> @@ -154,6 +195,8 @@ static const struct hwmon_chip_info w1_chip_info = {
>  #define W1_CHIPINFO	NULL
>  #endif
>  
> +/* Family operations */
> +
>  static struct w1_family_ops w1_therm_fops = {
>  	.add_slave	= w1_therm_add_slave,
>  	.remove_slave	= w1_therm_remove_slave,
> @@ -168,6 +211,8 @@ static struct w1_family_ops w1_ds28ea00_fops = {
>  	.chip_info	= W1_CHIPINFO,
>  };
>  
> +/* Family binding operations struct */
> +
>  static struct w1_family w1_therm_family_DS18S20 = {
>  	.fid = W1_THERM_DS18S20,
>  	.fops = &w1_therm_fops,
...

> @@ -407,6 +332,7 @@ error:
>  	return ret;
>  }
>  
> +/* The return value is millidegrees Centigrade. */

                                       Celsius. */

>  static inline int w1_DS18B20_convert_temp(u8 rom[9])
>  {
>  	s16 t = le16_to_cpup((__le16 *)rom);
> @@ -414,6 +340,7 @@ static inline int w1_DS18B20_convert_temp(u8 rom[9])
>  	return t*1000/16;
>  }
>  
> +/* The return value is millidegrees Centigrade. */

ditto.

>  static inline int w1_DS18S20_convert_temp(u8 rom[9])

9?

...

> @@ -564,6 +529,81 @@ error:
>  	return ret;
>  }
>  
> +static inline int w1_therm_eeprom(struct device *device)
> +{
> +	struct w1_slave *sl = dev_to_w1_slave(device);
> +	struct w1_master *dev = sl->master;
> +	u8 rom[9], external_power;

9?


thanks.
-- 
~Randy

