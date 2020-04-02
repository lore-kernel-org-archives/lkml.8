Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021BEC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99B620719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jow3N/Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbgDBNQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:16:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45039 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbgDBNQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:16:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so4107104wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Fq/Eghn+1NfjLYFOkcULDqoL6yltxz4HaQ8BR6dhF4=;
        b=jow3N/NtnJ2NUiBe8DP7aEx+duMfw+LnTB7XWPgLIux4aGU+0fWqa6/1lxkqSorFn9
         +0cUaHxbOcBjDwfe/fcJ5LlXShppifkG3pMKLII09QuEwxgAEbX8ImT08N6o0ud+4UM/
         2ZgzdGSAGskzGy/YI0pcksg2KoIiwslpiJHLewV2cjA2QJ0sAfk6ZvEVn3q8G43AvOeD
         c0pwEK9CYgrpjqHwMdvMdGukxek2nrYDaoNymTZfKt+9qg1LGG7rpANVqp+ApevTxC3j
         PwIXiYVvr/19VrpJH4wJ+y/f5kDJcc6sW5SV5q3pAgFB53lVp6SncEzRTyARCnd/j+rS
         YhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Fq/Eghn+1NfjLYFOkcULDqoL6yltxz4HaQ8BR6dhF4=;
        b=pHdFAAXcisXbepz32aN8gbhBvqsR0TI0To0hFssVVpLrkBSVUx6uNKF+NS8A02Ny9E
         fD2CGa8oWbYeJbqOOM3BuXG5Kh2pfxtRWUB2lr4q2Z87mIZp+tem/QJZmDprA5LoDOup
         oaaI5f6736DQ8XMIZy0+hJb5+xN5IELOgw9DtOZQGcwSGgNuKYssLfOOQL1MSatF5Rk/
         6uidNkymIAO/buOT8NauTeva9EBnZqj4aP+8dbkEQSvwK9RUrrGcUDltja3yYmTZfyxk
         NiG2ThO4bzC7N8eWJT4HB52GtboetGk/rS4tSmgB5QT4JLAOuxPyyE6dbVbfSrg6LVI5
         skcw==
X-Gm-Message-State: AGi0Pua46Gbtp+pZAMa0s3ky9C+bVAIyeLaTLf5FWzp7NSOBahdvcidr
        YKym8LWcY+kMr9TF5QF+TjE=
X-Google-Smtp-Source: APiQypIf6Ox3JWNLzTW5xz11z6IiJ42yBb5OEa/OTgAZ3d4kO0KMBXDPoOvBmm01icTzk30Vzq7Ofw==
X-Received: by 2002:adf:e74b:: with SMTP id c11mr3357240wrn.136.1585833382200;
        Thu, 02 Apr 2020 06:16:22 -0700 (PDT)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id j135sm7412272wmj.46.2020.04.02.06.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 06:16:21 -0700 (PDT)
Date:   Thu, 2 Apr 2020 14:16:18 +0100
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chen Zhou <chenzhou10@huawei.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: greybus: fix a missing-check bug in
 gb_lights_light_config()
Message-ID: <20200402131618.653dkeuz7c2vuujf@arch-thunder.localdomain>
References: <20200401030017.100274-1-chenzhou10@huawei.com>
 <20200402122228.GP2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402122228.GP2001@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Apr 02, 2020 at 03:22:28PM +0300, Dan Carpenter wrote:
> On Wed, Apr 01, 2020 at 11:00:17AM +0800, Chen Zhou wrote:
> > In gb_lights_light_config(), 'light->name' is allocated by kstrndup().
> > It returns NULL when fails, add check for it.
> > 
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > ---
> >  drivers/staging/greybus/light.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> > index d6ba25f..d2672b6 100644
> > --- a/drivers/staging/greybus/light.c
> > +++ b/drivers/staging/greybus/light.c
> > @@ -1026,7 +1026,8 @@ static int gb_lights_light_config(struct gb_lights *glights, u8 id)
> >  
> >  	light->channels_count = conf.channel_count;
> >  	light->name = kstrndup(conf.name, NAMES_MAX, GFP_KERNEL);
> > -
> > +	if (!light->name)
> > +		return -ENOMEM;
> >  	light->channels = kcalloc(light->channels_count,
> >  				  sizeof(struct gb_channel), GFP_KERNEL);
> >  	if (!light->channels)
> 
> The clean up in this function is non-existant.  :(

Yeah, this have a central point to do the cleanups, gb_lights_release,
since we may have other lights already configured at this point, we
could cleanup this specific one here, but than would need to make sure
all other already configure got clean also.

------
Cheers,
     Rui

