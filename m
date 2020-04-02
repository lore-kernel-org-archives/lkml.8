Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D97206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgNxUPeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbgDBQQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:16:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35547 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389697AbgDBQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:16:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id g9so1702601pjp.0;
        Thu, 02 Apr 2020 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1I7odj2BfYg0So2IPfRpfnKxU7DoBLqYKVfmqBWS4fY=;
        b=vgNxUPeTi//Vd0UOmeNW9X/GsEjNMXtiz+i7szTkfn0FFm/Sx/0Wf1lO8//6NlmGe5
         MU863/HE2G6m+OcR0l9xky2f2FadlrcXPUJcBCU20tIHAa4oUiaTuEbqy8/csCQxTSWn
         5sz8H9vw7d8/0xh/dNdNzEnIPDi2je1SNLT0/jxAUr8PY1n8NBaSjJN2TEwj74xXtAAi
         9rOai/q+F3KiRrmPR6HSvKMBhEjK3G9gshYh0r/RZ4hej0rVimhfN32FddGKRZIBG2WX
         tzOoLPI11fAJyAlxp2goGpnJlfvxXlQsPi/3nvysYiSVy23uzZ138rtT44jIGjpfbYOE
         O3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1I7odj2BfYg0So2IPfRpfnKxU7DoBLqYKVfmqBWS4fY=;
        b=Z0VNeNxt31J/hGhIQ1TxFa6HSyvnmhjZVzFvX0X/ta4dKFSSPRb8bXEMxXNuhMEhoX
         6M2SALqf2Ws0cglSZ0oULBWCN19SiDAKf4TwaMOfxaeKb+BpFIPwGGlnVkq8552pvFmL
         TPZShIwy63js0+SbJ8SGyOaC0kNVtrtTyEfa3x+xiiyRLQVGIXopDGEzkq7a8EA8aqNg
         dlpa01RP/A80CaCKdUqUX5ieqcxJzW4+vMrYnL7B/1S9IM4FSqGSiEI1kolRQi2XDbl2
         p8o7EUebwQX8GaOW7Yf8HO3Qlo3zEcxQFsBzQyNmnHAgF2FrGiT4hGkiaG8xpvOgZ9Xh
         aBNQ==
X-Gm-Message-State: AGi0Pub4Puf2sweZXMfAaPNkBCcJeTcy9S7zQT9KHS3a7ThVapubaIic
        0l/8y77iKulmT2gMPjpxKw==
X-Google-Smtp-Source: APiQypLplYv4953I25fSVZYI02PPnrg1NVInzOGcTF3+kHiDXL0fKl2Sx8H9uCXye/QGp6lByd39ag==
X-Received: by 2002:a17:902:7204:: with SMTP id ba4mr3692413plb.232.1585844217361;
        Thu, 02 Apr 2020 09:16:57 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:d0a:d624:44da:9bb6:388c:6150])
        by smtp.gmail.com with ESMTPSA id lj14sm4036425pjb.25.2020.04.02.09.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 09:16:55 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 2 Apr 2020 21:46:50 +0530
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        gregkh@linuxfoundation.org, hariprasad.kelam@gmail.com,
        colin.king@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
Subject: Re: [PATCH] usb: host: u132-hcd: Traverse u132_static_list under
 mutex lock in u132_hcd_exit
Message-ID: <20200402161650.GB26696@madhuparna-HP-Notebook>
References: <20200401191735.10809-1-madhuparnabhowmik10@gmail.com>
 <Pine.LNX.4.44L0.2004021015270.9681-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2004021015270.9681-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:18:58AM -0400, Alan Stern wrote:
> On Thu, 2 Apr 2020 madhuparnabhowmik10@gmail.com wrote:
> 
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > The global list u132_static_list is protected by u132_module_lock.
> > Elements are added to this list in the probe function and this list is
> > traversed in u132_hcd_exit() to unregister devices.
> > 
> > If probe and exit execute simultaneously there can be a race condition
> > between writing to this list in probe and reading the list in exit as
> > u132_module_lock is not held in exit function.
> > 
> > Even though u132_exiting variable is used in probe to detect if the module is
> > exiting, it is ineffective as the probe function may read the value
> > before it is updated in exit and thus leading to a race condition.
> > 
> > Therefore, hold u132_module_lock while traversing u132_static_list in
> > exit function.
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  drivers/usb/host/u132-hcd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
> > index e9209e3e6248..1cadc4e0c9b2 100644
> > --- a/drivers/usb/host/u132-hcd.c
> > +++ b/drivers/usb/host/u132-hcd.c
> > @@ -3217,10 +3217,10 @@ static void __exit u132_hcd_exit(void)
> >  	struct u132 *temp;
> >  	mutex_lock(&u132_module_lock);
> >  	u132_exiting += 1;
> > -	mutex_unlock(&u132_module_lock);
> >  	list_for_each_entry_safe(u132, temp, &u132_static_list, u132_list) {
> >  		platform_device_unregister(u132->platform_dev);
> >  	}
> > +	mutex_unlock(&u132_module_lock);
> 
> How about just getting rid of this loop entirely, along with the 
> u132_static_list?  As far as I can see, that list doesn't do anything.
>
Yes, that makes sense. I will send an updated patch soon.

Thank you,
Madhuparna

> Not to mention that this driver has no business calling 
> platform_device_unregister() here, since it didn't call 
> platform_device_register() in the first place.  The call to 
> platform_driver_unregister() below should do all the necessary work.
> 
> Alan Stern
> 
> >  	platform_driver_unregister(&u132_platform_driver);
> >  	printk(KERN_INFO "u132-hcd driver deregistered\n");
> >  	wait_event(u132_hcd_wait, u132_instances == 0);
> 
