Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B9BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DCA20787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwmzilWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389696AbgDBQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:04:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44506 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389366AbgDBQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:04:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so4832105wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qBVTjaLThJfumgo5ABo1WV3ZM7MbrBwLw7tmH+TZCSg=;
        b=kwmzilWpIVyO9RPctO+cX7UWmlcn0TxAF4fL+FpQSQJURfsVu2xLot/+y9d15PTkQE
         XWMzw1q9PtSSWuH9hxOuPR1bWKbxlAjy69znqTsRccXjq82wBemkSMvkxPHtF2AABG7x
         ifDlbdzrutQIByLyb8Q+EJi0TOXk1u4qnssc8dTMeGuJ8eBHvjw8jsPKyI873qd1/dVS
         WIb9YjrgdHF/Ad2SPQUNMwuU3WP8RY14JiuOpvT1Sbj1+5lKxYieQCum3oFl+CjmWv6j
         TM7pbWWr1WdE/1fxPqwC6FOpQl2s5X7KHFl8XJnarjar5fqrhf/6Ic+/57zKk8hqQx3Q
         frmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qBVTjaLThJfumgo5ABo1WV3ZM7MbrBwLw7tmH+TZCSg=;
        b=fWATWY16PIwnNnCVGUDMpwgiRZAJKSLCir03G71t4JM36dvM20vceaOFEvRGoqUD27
         p8SJsYHfysMd/5iB9wKjFNa5SPc28fh8GrLBJ8FhgozOGY63/RxemgLTEHP0oF0kTUtC
         7T6nu/koknLgsTJyGQqP1z1vxIW86g5qCW/X93ZjRtyCn8YF0X9FdDWZcSUnzMXAig2t
         BH5pQz7Y7z+laP02CeVx6Pm9pdER1Zzj92rMZElYRpZ68FgF4YPnUq9cu0RQZx+zkZf/
         jQan24rOh+yoRo3+BNW5IZAsjTGg6j+53V69yzllrWPER/EIKD5JLIC1FZ/jNlHfKyQc
         ARdQ==
X-Gm-Message-State: AGi0PuaSZvOiu1Ek3aXpinNeFYu2LUN6rPkE2ABkqvHhcgaYWJusDKr6
        m+/tEAVeK/B64J87bdj42trAsILjpG4S5Q==
X-Google-Smtp-Source: APiQypKxE40isqGXPYBa29scB1z8vPhNWxo1K4pgf8KCxsrh4y/cdK44Lrxa6WgqgtI8QdSesWLArg==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr4567354wrq.347.1585843444033;
        Thu, 02 Apr 2020 09:04:04 -0700 (PDT)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id y16sm7988816wrp.78.2020.04.02.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 09:04:03 -0700 (PDT)
Date:   Thu, 2 Apr 2020 17:04:00 +0100
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, elder@kernel.org,
        Chen Zhou <chenzhou10@huawei.com>, gregkh@linuxfoundation.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH -next] staging: greybus: fix a missing-check bug in
 gb_lights_light_config()
Message-ID: <20200402160400.cvgvd3da75x2f4qe@arch-thunder.localdomain>
References: <20200401030017.100274-1-chenzhou10@huawei.com>
 <20200402122228.GP2001@kadam>
 <20200402131618.653dkeuz7c2vuujf@arch-thunder.localdomain>
 <20200402142237.GT2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402142237.GT2001@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Apr 02, 2020 at 05:22:37PM +0300, Dan Carpenter wrote:
> On Thu, Apr 02, 2020 at 02:16:18PM +0100, Rui Miguel Silva wrote:
> > > > --- a/drivers/staging/greybus/light.c
> > > > +++ b/drivers/staging/greybus/light.c
> > > > @@ -1026,7 +1026,8 @@ static int gb_lights_light_config(struct gb_lights *glights, u8 id)
> > > >  
> > > >  	light->channels_count = conf.channel_count;
> > > >  	light->name = kstrndup(conf.name, NAMES_MAX, GFP_KERNEL);
> > > > -
> > > > +	if (!light->name)
> > > > +		return -ENOMEM;
> > > >  	light->channels = kcalloc(light->channels_count,
> > > >  				  sizeof(struct gb_channel), GFP_KERNEL);
> > > >  	if (!light->channels)
> > > 
> > > The clean up in this function is non-existant.  :(
> > 
> > Yeah, this have a central point to do the cleanups, gb_lights_release,
> > since we may have other lights already configured at this point, we
> > could cleanup this specific one here, but than would need to make sure
> > all other already configure got clean also.
> 
> Central clean up functions never work correctly.

I agree.

> 
> For example, we allocate "cdev->name" in gb_lights_channel_config()
> before we register the channel later in gb_lights_register_all(glights);.
> Now imagine that the register fails.  Then when we're freeing it in
> __gb_lights_led_unregister() we see that the ->is_registered is false
> so we don't kfree(cdev->name).
> 
> That's just a small memory leak.  But there are going to be tons of
> little bugs like that.

Yeah, when I have some cycles I'll go over that error codes paths and
mitigate this kind of issues.

> 
> Anyway it doesn't affect this patch so it's fine.

Yeah, thanks.

------
Cheers,
     Rui
