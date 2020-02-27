Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF26C4BA3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A122468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvjpWo76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgB0MYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:24:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55205 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgB0MYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:24:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id z12so3320231wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jp5suxB8PwckKllUEmHtSKALSA4mXRMI2T39pt6o9kw=;
        b=JvjpWo76pRAiBmY2lyeQmsaLrQZ4mkX9aCLLvAw/4cQmfro8qn2QJbyZIf4LlQxDSb
         OGHOPDhDLa3UhXV8oOX/fTg8Oxa7UXEqa+zLOSMI5UZgDI+tdhAZv5Y34MVIUXSpPW6Y
         ZAe754fYrRw17tvJUjByXRCnvQSyu0QxiLB+nC+UzDu/zLgeutxmNWB73QPlUFofVdxF
         yaSWMCcCyfgMrsk42vUVvuZ1dC+eDsJjrgw/loMlqHXOAmvUtpHW/WtVjn2sGQ2b121M
         FVmudIXCXLJ4KoSzSu62z3icEDZSxz39TLkoiyG0KuKQ13di6ysdPUVEaC//zUno9dNX
         EcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jp5suxB8PwckKllUEmHtSKALSA4mXRMI2T39pt6o9kw=;
        b=Z0RmMy6LDr8N9ORhI+BhD0t42sDbVHELFk72g+VCs9qmKVKOVsXCAdvEIqt3r1RUX6
         d2UEekj3UfBx9S8gEBrVXKQWJVGBUMXaUuJGvAjLacpq79BwhnyoIFj0nKNZceExa/pi
         YmeBjJMJaWO64Ry7QFzQvANARLez5Ycq/J5q6OGVlMwy/UBSWrCAH6LekZ65BBFkWiuu
         FQJCKHA9r+1cQYXDWmisewpJfce8I/YqJqhbZM8xKwfJZwKTiQP38bFIpUKcqTq+rKjT
         fzHU98afTeCgX1UkyiD/XVlcsWZ1llbXl/t6ZRQvW86pip8pI4Mo18aUT/AZJoMbSlZ5
         9QYQ==
X-Gm-Message-State: APjAAAVlAgda5BMPjGQZjRH3CWMEWkWGjSe+THuBBAfuaiMo/3XvMdc6
        kQ4DR9KI0vVHUi+dy0ewjow=
X-Google-Smtp-Source: APXvYqy39CoQckRdV3i+42Rb9LPh5sCIUZPJ+vwEjuH0gGJK8KzCgsnF6pz5SR10++NHKt/Z7Aq3zg==
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr4978787wme.148.1582806240616;
        Thu, 27 Feb 2020 04:24:00 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id w19sm7017934wmc.22.2020.02.27.04.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:24:00 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Thu, 27 Feb 2020 15:23:31 +0300 (EAT)
To:     Jyri Sarha <jsarha@ti.com>
cc:     Wambui Karuga <wambui.karugax@gmail.com>, daniel@ffwll.ch,
        airlied@linux.ie, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 17/21] drm/tilcdc: remove check for return value of
 debugfs functions.
In-Reply-To: <614d42f2-881e-6e4e-f3c4-c247a86d9262@ti.com>
Message-ID: <alpine.LNX.2.21.99999.375.2002271516120.19554@wambui>
References: <20200227120232.19413-1-wambui.karugax@gmail.com> <20200227120232.19413-18-wambui.karugax@gmail.com> <614d42f2-881e-6e4e-f3c4-c247a86d9262@ti.com>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Feb 2020, Jyri Sarha wrote:

> On 27/02/2020 14:02, Wambui Karuga wrote:
>> Since 987d65d01356 (drm: debugfs: make
>> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
>> fails. Therefore, remove the check and error handling of the return
>> value of drm_debugfs_create_files() as it is not needed in
>> tilcdc_debugfs_init().
>>
>> Also remove local variables that are not used after the changes, and
>> declare tilcdc_debugfs_init() as void.
>>
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>
>
> Ok, so this is a part of a bigger series.
>
Yes, this was converted to a series after initial feedback. Thanks for 
your review

wambui karuga.
> Acked-by: Jyri Sarha <jsarha@ti.com>
>
> I assume the series will be merged as one without my involvement. Please
> let me know if that is not the case.
>
> BR,
> Jyri
>
>> ---
>>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 17 ++++-------------
>>  1 file changed, 4 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> index 0791a0200cc3..78c1877d13a8 100644
>> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> @@ -478,26 +478,17 @@ static struct drm_info_list tilcdc_debugfs_list[] = {
>>  		{ "mm",   tilcdc_mm_show,   0 },
>>  };
>>
>> -static int tilcdc_debugfs_init(struct drm_minor *minor)
>> +static void tilcdc_debugfs_init(struct drm_minor *minor)
>>  {
>> -	struct drm_device *dev = minor->dev;
>>  	struct tilcdc_module *mod;
>> -	int ret;
>>
>> -	ret = drm_debugfs_create_files(tilcdc_debugfs_list,
>> -			ARRAY_SIZE(tilcdc_debugfs_list),
>> -			minor->debugfs_root, minor);
>> +	drm_debugfs_create_files(tilcdc_debugfs_list,
>> +				 ARRAY_SIZE(tilcdc_debugfs_list),
>> +				 minor->debugfs_root, minor);
>>
>>  	list_for_each_entry(mod, &module_list, list)
>>  		if (mod->funcs->debugfs_init)
>>  			mod->funcs->debugfs_init(mod, minor);
>> -
>> -	if (ret) {
>> -		dev_err(dev->dev, "could not install tilcdc_debugfs_list\n");
>> -		return ret;
>> -	}
>> -
>> -	return ret;
>>  }
>>  #endif
>>
>>
>
>
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
