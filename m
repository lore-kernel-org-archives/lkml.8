Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DFBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53997205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="JusjcdkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCFXzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:55:51 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53272 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCFXzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:55:50 -0500
Received: by mail-pj1-f67.google.com with SMTP id cx7so1710178pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iy66Xc3T8EGl5ApJul/VUh4hjHhsU3+FU6jK2rSraPw=;
        b=JusjcdkAfTlIEOeg8mV4ChS+MtHqZ9MHCDVAs4ZUlmcQM64RsWbr9y/nwhnpw0jkkG
         Mdr+VZIL6Vi/oDO+DP0ybCmiArZDwCCGkU2YRJ5kIT0tS6PGXuQTo4GdPAfKnUOznUS/
         L4rPmPL07WDHK/xjfRB8nxgPfxnCteajWdrfBHhwdneV2UjAoHsFhWKpyAfXTPlBF7yb
         mj32MyepfyqiLRuhnMaRPuK584dw9JAhVeb8biV6d4xxRCiRJUlcHp9go8uzmO//WhUi
         f0WMSi2pjAWBBtqFJHZChWogsZUUIf2LLxp8LjaU9QG3x6m7J7VScgupV+ILwFaDKiL2
         js9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iy66Xc3T8EGl5ApJul/VUh4hjHhsU3+FU6jK2rSraPw=;
        b=NQpYFNy8JH25250A1JrB+0MobLnqEeH/0Px3EQAPpWWGtX+ijmZbGmixm3D2lloIAV
         TLtJiF8NKBuodoDgwcIIfuKPPiBflwscHMSJo6CVUiJM0m0tgYigGPrQSPXc1BUFBNRm
         mLbrRQ3/nA+q7aKPIki8NZWSeQwOeeYQXMFJhk1MPriydjFqocKcr3Rvcp4SkW6TYBLm
         5e6xnQaq5XEcGlOiHTcSlJiHoJ417RcIV0rTHcOysVvbgt0O3F6lVdxHtwfT/eIJFzIh
         bFVlfcZ/gO14rCX+TkaEY4lLzpSJlRpn+1oHp7qncpaSESNLp4Wj3ML1kLAq2tBlF1sf
         Br3A==
X-Gm-Message-State: ANhLgQ02tNtBjxNYHI0Ms2h5mQfDQNFVX2M8s7aL4hGbrVryENvO4d7K
        gtnUl9HrEyZ37XaroSTzpv8N9Q==
X-Google-Smtp-Source: ADFU+vtA0JLUpUrvRB8/URuMofw7zZLIpVDABYK+ucoeQeRBBorcDOV0QycC7SaSPAT1kqla8wgfOw==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr6358221pjs.107.1583538949817;
        Fri, 06 Mar 2020 15:55:49 -0800 (PST)
Received: from localhost ([2620:15c:211:0:fb21:5c58:d6bc:4bef])
        by smtp.gmail.com with ESMTPSA id f8sm36597168pfn.2.2020.03.06.15.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 15:55:49 -0800 (PST)
Date:   Fri, 6 Mar 2020 15:55:48 -0800
From:   Sandeep Patil <sspatil@android.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/4] power_supply: Add additional health properties to
 the header
Message-ID: <20200306235548.GA187098@google.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
 <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Jan 17, 2020 at 02:06:58AM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
> > Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
> > 
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > ---
> 
> Looks good. But I will not merge it without a user and have comments
> for the driver.

Android has been looking for these properties for a while now [1].
It was added[2] when we saw that the manufacturers were implementing these
properties in the driver. I didn't know the properties were absent upstream
until yesterday. Somebody pointed out in our ongoing effort to make sure
all core kernel changes that android depends on are present upstream.

I think those values are also propagated in application facing APIs in
Android (but I am not sure yet, let me know if that's something you want
to find out).

I wanted to chime in and present you a 'user' for this if that helps.

Cc: kernel-team@android.com

- ssp

1. https://android.googlesource.com/platform/system/core/+/refs/heads/master/healthd/BatteryMonitor.cpp#162
2. https://android-review.googlesource.com/c/platform/system/core/+/414481

> 
> -- Sebastian
> 
> >  Documentation/ABI/testing/sysfs-class-power | 2 +-
> >  drivers/power/supply/power_supply_sysfs.c   | 2 +-
> >  include/linux/power_supply.h                | 3 +++
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > index bf3b48f022dc..9f3fd01a9373 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -190,7 +190,7 @@ Description:
> >  		Valid values: "Unknown", "Good", "Overheat", "Dead",
> >  			      "Over voltage", "Unspecified failure", "Cold",
> >  			      "Watchdog timer expire", "Safety timer expire",
> > -			      "Over current"
> > +			      "Over current", "Warm", "Cool", "Hot"
> >  
> >  What:		/sys/class/power_supply/<supply_name>/precharge_current
> >  Date:		June 2017
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index f37ad4eae60b..d0d549611794 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -61,7 +61,7 @@ static const char * const power_supply_charge_type_text[] = {
> >  static const char * const power_supply_health_text[] = {
> >  	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
> >  	"Unspecified failure", "Cold", "Watchdog timer expire",
> > -	"Safety timer expire", "Over current"
> > +	"Safety timer expire", "Over current", "Warm", "Cool", "Hot"
> >  };
> >  
> >  static const char * const power_supply_technology_text[] = {
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 28413f737e7d..bd0d3225f245 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -61,6 +61,9 @@ enum {
> >  	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
> >  	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
> >  	POWER_SUPPLY_HEALTH_OVERCURRENT,
> > +	POWER_SUPPLY_HEALTH_WARM,
> > +	POWER_SUPPLY_HEALTH_COOL,
> > +	POWER_SUPPLY_HEALTH_HOT,
> >  };
> >  
> >  enum {
> > -- 
> > 2.25.0
> > 


