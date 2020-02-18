Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0BEC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E680B2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDyhwFE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBRSDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:03:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42015 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRSDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:03:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so25059850wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=V/tjhq7oBEyOycP7UZixOMOtUlTvd2hXQJK9Eop241Y=;
        b=DDyhwFE4de9F78yd1ZPlzxTgEeAp+R7qKvINaKsqzab98Bhiw1IzW4Hfout+GyH9wq
         VZEEok99wm14lIHZhVAgOZH3rllXIPqsBBMCW7QWxNu52fR/JbtbSv7nHTjI3AaVf4Hi
         D5kPt135GHHHZ8IYDfwPDA0i5vcVCGzV8X0505FxninFfNbdeiyAkOLhpPT0t70ivMvu
         O2KZCH7OQ2dOk2Ksb9DRkb8eoi0rjSp4EybIAi1INXt/r0fT91iKohal+LAqa2l87UA6
         gBZQLnMEcG+EA92Fcrqk2u+o0jEXSRK6NAKRw96ej9lVzlQnm1qnlgqwhkxLvGZlZinK
         qzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=V/tjhq7oBEyOycP7UZixOMOtUlTvd2hXQJK9Eop241Y=;
        b=HQSbT98msDDrdTNnUVn2yTltlvxVgFpiQ9ZqSAboYATVT0vjyETKue6B85Bd2GN/qN
         i0uMR/Rv2o7q6PDY9hJLbxMYsj1H/djeCRUipvEtpiOLQpyrux0H3uzXE0yk/MhjYuao
         4kkbSXM++q1N0txGl7gVSUR3R5hdZDOStnwyLoanfD4beEZ31QvWsNE+dV8nEvbGcRjH
         lfJ71nP0QIYcDdUpif5Xo08kLsuP65tZIjOWEC3cltafFMxPKiDWsO1RLSWl4uo3u0dD
         xGVwICq7EvFiSzH0PJcxXRzomDJ/9ZF6uoQOPn7lkmlpjY2w+wFIjLLh5WTumBQTZC20
         py3w==
X-Gm-Message-State: APjAAAVUW9EDZ4iQ0wQS7aeb1rDu9ynCluuwsKZURrqZnl2EKoS/wCG8
        epBCCDA/FPFbDf/ep4I0b7E=
X-Google-Smtp-Source: APXvYqzuZqIlzAcXP+ZKKIIA3TCwv6a2IseAjKCamN6X7gGt4vqM+Z/JqeNkVqO66rFMw8/UajOi/A==
X-Received: by 2002:a5d:61d1:: with SMTP id q17mr31130089wrv.156.1582048989986;
        Tue, 18 Feb 2020 10:03:09 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id o2sm4309335wmh.46.2020.02.18.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:03:08 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Tue, 18 Feb 2020 21:02:56 +0300 (EAT)
To:     Lucas Stach <l.stach@pengutronix.de>
cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] drm/etnaviv: remove check for return value of drm_debugfs
 function
In-Reply-To: <71275b167f41ca424216c2bda0459bf305a1162c.camel@pengutronix.de>
Message-ID: <alpine.LNX.2.21.99999.375.2002182102230.20178@wambui>
References: <20200218172821.18378-1-wambui.karugax@gmail.com> <20200218172821.18378-4-wambui.karugax@gmail.com> <71275b167f41ca424216c2bda0459bf305a1162c.camel@pengutronix.de>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Feb 2020, Lucas Stach wrote:

> On Di, 2020-02-18 at 20:28 +0300, Wambui Karuga wrote:
>> As there is no need to check the return value if
>> drm_debugfs_create_files,
>
> And here is where the commit message skips a very important
> information: Since 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail) this function never returns
> anything other than 0, so there is no point in checking. This
> information should be in the commit message, so the reviewer doesn't
> need to look up this fact in the git history.
>
Okay, I can add that to the commit message and resend.
Thanks.

> Regards,
> Lucas
>
>>  remove the check and error handling in
>> etnaviv_debugfs_init and have the function return 0 directly.
>>
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>> ---
>>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> index 6b43c1c94e8f..a65d30a48a9d 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> @@ -233,19 +233,11 @@ static struct drm_info_list
>> etnaviv_debugfs_list[] = {
>>
>>  static int etnaviv_debugfs_init(struct drm_minor *minor)
>>  {
>> -	struct drm_device *dev = minor->dev;
>> -	int ret;
>> -
>> -	ret = drm_debugfs_create_files(etnaviv_debugfs_list,
>> -			ARRAY_SIZE(etnaviv_debugfs_list),
>> -			minor->debugfs_root, minor);
>> +	drm_debugfs_create_files(etnaviv_debugfs_list,
>> +				 ARRAY_SIZE(etnaviv_debugfs_list),
>> +				 minor->debugfs_root, minor);
>>
>> -	if (ret) {
>> -		dev_err(dev->dev, "could not install
>> etnaviv_debugfs_list\n");
>> -		return ret;
>> -	}
>> -
>> -	return ret;
>> +	return 0;
>>  }
>>  #endif
>>
>
>
