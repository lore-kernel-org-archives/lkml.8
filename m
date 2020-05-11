Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D002DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A349E2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeZ4/dWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEKHbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgEKHbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:31:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B98C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:31:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so16842863wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=u/c2TqKgKJopQqqgPouzz8FU8h9cHatEsqHl7LLH6wY=;
        b=eeZ4/dWfksZbvurF5GewZ0SUQcLEWKGYHDF0UD69fssqdT+KLgPSsqdz7iZBXQUX1v
         k6gvAQIUJGOC8VPS7WVR9HIG8rV7hsVoO4DUGcdPCKfgjvRtmoGSkYrH684bdT8t3t8q
         84CU4YqHrzdgHRrp9ilUiV4ziZj+/XeaBfvDLK+C1wPf7wwyxu7m+/ubw0VGBWelzfSy
         ojn9MKASl0qEDvZSvWiMlwTw/ovVkcYoHNcO706s9snDjI5bbou/oH9hfmn7mkHKRQsb
         3kS/esClFDnzAJjuvkirHJR55VBlOyTEwFy/YAhv5c75RNML+72oopTWZrLTv9H9Zem4
         +Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=u/c2TqKgKJopQqqgPouzz8FU8h9cHatEsqHl7LLH6wY=;
        b=FQcebTa/R/mF5226k+0EC//LVmO+afxITkaa6ikPzTuq6vljN2VnJRoFxCFuFpHElR
         pJ3zBx29kjijv8qqe53AUH08D+rYyJSEHPZicG8CZI1Gs4VQoMf84ZaqjVpoBTJ9xa1+
         pYOrjXL6BfupwSLUl1EpI0jZlGrUDsU0ozjEjFn0MWzrS6pwVUAdLUbOCjKf2qVMiBUn
         AzIpf0Fs/hgNWYBqBxHVvaRyIqfhHFQ+/ew2eGJoiVWjZlTK+QuHpl1T/DjDXALO7U/o
         P4X8VED8v98eN3qxA3eOcjA+v9mW+wfZmhsygM1R9y+jT0oVyz0B/MUbmRmKuzJtDUEX
         4ovA==
X-Gm-Message-State: AGi0PuZ2N8FyMbLds//UrS6pfg1jMYI9LghXYr/ns3pEcIpsw5ZvlGVU
        Q221Xa/EhgpAP4/G3vX2Ec8=
X-Google-Smtp-Source: APiQypIWFEib7KFXUE3voJad2W7Qi9KWkt6qKweHeSQCyVlDwjreBHcfxWKePu/hel/D8hBVENjRGg==
X-Received: by 2002:a05:600c:114d:: with SMTP id z13mr30018787wmz.54.1589182266494;
        Mon, 11 May 2020 00:31:06 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id q2sm14359023wrx.60.2020.05.11.00.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 00:31:06 -0700 (PDT)
Message-ID: <bea27b6f2e78aa96a6a96e18a7d562b2564b188f.camel@gmail.com>
Subject: Re: [PATCH v6 1/9] w1_therm: adding code comments and code
 reordering
From:   Akira shimahara <akira215corp@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 09:31:04 +0200
In-Reply-To: <47e5d267-071a-f6cb-33d3-2a6f1c3ba67e@infradead.org>
References: <20200510141506.172021-1-akira215corp@gmail.com>
         <47e5d267-071a-f6cb-33d3-2a6f1c3ba67e@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dimanche 10 mai 2020 à 20:33 -0700, Randy Dunlap a écrit :
> Hi,
> 
> A few more comments here (inline):
> 
> On 5/10/20 7:15 AM, Akira Shimahara wrote:
> 
> >  drivers/w1/slaves/w1_therm.c | 398 ++++++++++++++++++++---------------
> >  1 file changed, 232 insertions(+), 166 deletions(-)
> > 
> > diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> > index 18f08d7..890cf09 100644
> > --- a/drivers/w1/slaves/w1_therm.c
> > +++ b/drivers/w1/slaves/w1_therm.c
> > @@ -41,42 +41,55 @@
> >  static int w1_strong_pullup = 1;
> >  module_param_named(strong_pullup, w1_strong_pullup, int, 0);
> >  
> > +/* Helpers Macros */
> > +
> > +/* return the address of the refcnt in the family data */
> > +#define THERM_REFCNT(family_data) \
> > +	(&((struct w1_therm_family_data *)family_data)->refcnt)
> > +
> > +/* Structs definition */
> > +
> > +/**
> > + * struct w1_therm_family_converter - bind device specific functions
> > + * @broken: flag for non registred families
> 
>                         non-registered

Noted, will be corrected

> 
> > + * @reserved: not used here
> > + * @f: pointer to the device binding structure
> > + * @convert: pointer to the device conversion function
> > + * @precision: pointer to the device precicion function
> 
>                                         precision

Noted, will be corrected

> 
> > + * @eeprom: pointer to eeprom function
> > + */
> > +struct w1_therm_family_converter {
> > +	u8		broken;
> > +	u16		reserved;
> > +	struct w1_family	*f;
> > +	int		(*convert)(u8 rom[9]);
> > +	int		(*precision)(struct device *device, int val);
> > +	int		(*eeprom)(struct device *device);
> > +};
> > +
> > +/**
> > + * struct w1_therm_family_data - device data
> > + * @rom: ROM id of the device
> > + * @refcnt: ref count
> > + */
> >  struct w1_therm_family_data {
> >  	uint8_t rom[9];
> 
> Why is "rom" 9 bytes in length?  Does it come from some
> spec or standard?  Can it be a macro instead of an arbitrary
> magic number?

9 bytes is required per device communication protocol (8 data bytes + 1 CRC). I
will detailled that in comments but I don't think that macro is required.

> 
> >  	atomic_t refcnt;
> >  };
> >  
> > +/**
> > + * struct therm_info - store temperature reading
> > + * @rom: readen device data
> 
>             read

Noted, will be corrected

> 
> > + * @crc: computed crc from rom
> > + * @verdict: 1 crc checked, 0 crc not matching
> > + */
> >  struct therm_info {
> >  	u8 rom[9];
> >  	u8 crc;
> >  	u8 verdict;
> >  };
> >  
> ...
> 

Same as above

> >  
> > +/* Interface Functions declaration */
> > +
> > +/**
> > + * w1_therm_add_slave() - Called when a new slave is discovered
> > + * @sl: slave just discovered by the master.
> > + *
> > + * Called by the master when the slave is discovered on the bus.Used to
> 
>                                                                bus. Used to
> 
> > + * initialized slave state before the beginning of any communication.
> 
>       initialize

Noted, will be corrected

> 
> > + *
> > + * Return: 0 - If success, negative kernel code otherwise
> > + */
> > +static int w1_therm_add_slave(struct w1_slave *sl);
> > +
> > +/**
> > + * w1_therm_remove_slave() - Called when a slave is removed
> > + * @sl: slave to be removed.
> > + *
> > + * Called by the master when the slave is considered not to be on the bus
> > + * anymore. Used to free memory.
> > + */
> > +static void w1_therm_remove_slave(struct w1_slave *sl);
> > +
> > +/* Family attributes */
> > +
> >  static struct attribute *w1_therm_attrs[] = {
> >  	&dev_attr_w1_slave.attr,
> >  	NULL,
> > @@ -101,6 +140,8 @@ static struct attribute *w1_ds28ea00_attrs[] = {
> >  	NULL,
> >  };
> >  
> > +/* Attribute groups */
> > +
> >  ATTRIBUTE_GROUPS(w1_therm);
> >  ATTRIBUTE_GROUPS(w1_ds28ea00);
> >  
> > @@ -154,6 +195,8 @@ static const struct hwmon_chip_info w1_chip_info = {
> >  #define W1_CHIPINFO	NULL
> >  #endif
> >  
> > +/* Family operations */
> > +
> >  static struct w1_family_ops w1_therm_fops = {
> >  	.add_slave	= w1_therm_add_slave,
> >  	.remove_slave	= w1_therm_remove_slave,
> > @@ -168,6 +211,8 @@ static struct w1_family_ops w1_ds28ea00_fops = {
> >  	.chip_info	= W1_CHIPINFO,
> >  };
> >  
> > +/* Family binding operations struct */
> > +
> >  static struct w1_family w1_therm_family_DS18S20 = {
> >  	.fid = W1_THERM_DS18S20,
> >  	.fops = &w1_therm_fops,
> ...
> 
> > @@ -407,6 +332,7 @@ error:
> >  	return ret;
> >  }
> >  
> > +/* The return value is millidegrees Centigrade. */
> 
>                                        Celsius. */

Noted, will be corrected

> 
> >  static inline int w1_DS18B20_convert_temp(u8 rom[9])
> >  {
> >  	s16 t = le16_to_cpup((__le16 *)rom);
> > @@ -414,6 +340,7 @@ static inline int w1_DS18B20_convert_temp(u8 rom[9])
> >  	return t*1000/16;
> >  }
> >  
> > +/* The return value is millidegrees Centigrade. */
> 
> ditto.

Noted, will be corrected

> 
> >  static inline int w1_DS18S20_convert_temp(u8 rom[9])
> 
> 9?

Same as above

> 
> ...
> 
> > @@ -564,6 +529,81 @@ error:
> >  	return ret;
> >  }
> >  
> > +static inline int w1_therm_eeprom(struct device *device)
> > +{
> > +	struct w1_slave *sl = dev_to_w1_slave(device);
> > +	struct w1_master *dev = sl->master;
> > +	u8 rom[9], external_power;
> 
> 9?

Same as above

> 
> 
> thanks.

Thanks again for your time

Akira Shimahara

