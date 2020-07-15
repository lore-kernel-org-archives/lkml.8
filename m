Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D735C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1AD20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqrglwYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgGOOoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgGOOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:44:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C6C061755;
        Wed, 15 Jul 2020 07:44:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a23so587724pfk.13;
        Wed, 15 Jul 2020 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nydDo2IGGqR25N+w8PtLOs3MXp5bES++6+xt1I+Vmjk=;
        b=hqrglwYgUtRgifcLBzcP2OXHvOdssF5fOdXQPIs7+sE9/mgvmpr7zsmbhXLtfIN0PC
         tvRdE6R0eSeeRCX90DdmcFAE03mx+hKeH1fERVyIH+qHUabEjv1fTqYUTnfENsikiyoJ
         HViODlQn2nad3Gf5tDtcKIw5mn3Ox0njER1niVNoIHsqWDxoVXafhmaiPmFGJXB185id
         6xt4jekOHgu3b0vIVwYxfc1NBE3FKWAV4SwmVhduV1ofKVbN1kS0/YvrAi8w5m2odthW
         A2cUV0Yj5LEmXTMGtZFRlBeEOzudymFltEnD+NFlQV6RlUueYMpw8+vHFs2s4WQ38g7z
         jgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nydDo2IGGqR25N+w8PtLOs3MXp5bES++6+xt1I+Vmjk=;
        b=T+rjFUgISi0r2VVtn89+13H0n4Z/SoqfBgdd3aMtAAyh4rKR8JxDJFZzmDvyTnANeB
         QrxrZ85my+zdvKkijNGNn+NJ63J4e4UNQ+rxgWZAK4fU5z2CMKIqN+qq1HoKExcFMY8d
         v28z4uAKo7zuY+fYJ8GgND7r1RP8uULc5V9SDjoVaULrb+pRUEjSsigcRrpPjFgzNCZm
         8zTbc18ifgSzxaCWZb/GGdszN4uiz6YDrCeDvB1B1++gJvFabQZ/5YAiVpjaEDT0CiXT
         rxazcs1jOfoCeYnYn1ugUic89nn8NHFQoF65qq6C0x1NSC7vypxQvThb8acxny6TiV5W
         bN+Q==
X-Gm-Message-State: AOAM530GA9KoOJZtK6/R2pt/DnGfd044tJWZsQQChqCyUUqrak+9toeV
        Jo1yZ6O7rTTQ9uuVcjBKcVM=
X-Google-Smtp-Source: ABdhPJzezinQJM0SoCPi+3EjwcMGiykjz6+TvHYeXG+i1Fs+0gd2AYTuoQFJh6bLmigeTkg2IFu0VA==
X-Received: by 2002:a62:3645:: with SMTP id d66mr9418905pfa.275.1594824282573;
        Wed, 15 Jul 2020 07:44:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b4sm2449598pfo.137.2020.07.15.07.44.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 07:44:41 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:44:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-cpro: Change to hid driver
Message-ID: <20200715144441.GC201840@roeck-us.net>
References: <20200714105230.3126-1-mail@mariuszachmann.de>
 <20200715023622.GA164279@roeck-us.net>
 <1747396.iuIVfOqGsT@marius>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747396.iuIVfOqGsT@marius>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 08:59:52AM +0200, Marius Zachmann wrote:
> On 15.07.20 at 04:36:22 CEST, Guenter Roeck wrote
> > On Tue, Jul 14, 2020 at 12:52:30PM +0200, Marius Zachmann wrote:
> > > I found a project which uses hidraw to communicate with the device.
> > > Because I do not want to break any existing userspace code, I
> > > changed this to a hid driver, so hidraw can still be used.
> > > Do I need to include the hid maintainers for the undo in hid-quirks?
> > > 
> > That changelog needs some improvements. It should state what change
> > was made, and why, but not include any questions or personal statements
> > such as "I found ...".
> > 
> > You never really explained why you had changed the driver from hid to
> > usb. Maybe you can explain that decision now ?
> > 
> > Thanks,
> > Guenter
> > 
> 
> This device does not use numbered hid input reports. As far as I know
> it is not possible to determine from which command a response was
> requested. This being a usb driver would not allow any other driver
> to send data to the device.
> In the first (hid) version I did not use hid reports and got
> the usb_device directly from the hid_device which is not intended.
> In this version, requests are made via hid_hw_output_report, waited
> for and received via raw_event.
> If one uses hidraw and this driver at the same time, it still could
> be possible to get switched responses but there is nothing I can
> do about it, as far as I know. This is only about giving the
> possibility to unload the driver and using a userspace driver
> if one chooses.
> 
What a mess. Can you add some of this as comment to the top of the driver
to explain the reasoning ?

Thanks,
Guenter
