Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D5EC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FCD206CD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROVy0iHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDZMgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgDZMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:36:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC7EC09B04F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 05:36:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so17126413wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JBh22gkkftDuWjwk1TPd/NAiCHWpk9SJUUjAQeP7t1E=;
        b=ROVy0iHE1cqI45Kv8mAcR/qxVxPLQjyDVkScDYip3VUyvfFd9cyO666gLWcTUAbawq
         GZSoVEUE5lfZLiCoMRECws33K96tT+Jnk3zM6ldYnmcWFmqPFF8u4vQAxqGEwj/Jy5fl
         xzTT4yfkaYqF7b2YE5F/TFOq5p2K0NV4W1OwQsmvGHvg7p0GLFmvdIeyzy1AO6aU3778
         WGg9EBpwvpFbBwwSDSct/aQj+3L36N5Mx28T0kpw3hYfNGPuXeBCCB2XoO1v9DzGpOP8
         ha/vG6OKpgPJU867aJzVkEsTHka03Se/59FmbrI/gRy0Ihq7zoNZU9WdAaylmEcK4xBp
         6fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JBh22gkkftDuWjwk1TPd/NAiCHWpk9SJUUjAQeP7t1E=;
        b=VIr4qdodSo+WnGmyfRD+G2oPTmoh9vqxm0VS6eUWLZVC1ixMNuCsQZSsfvzp1RAAXp
         kv0qmBuw2Mf2w3f2vl89N82Qcs1sz18cFiRxll6kykfwcbfUDWBqnbGyiKkn3wsTKQXP
         /bFVwdvlhEhQmfla95J2trgzzNyQ8s6Ty8uCHfa1c43xlTo9ClP6NjXKWzzb8Cy/eJf1
         3rn/+xUgfoD/PhXO0hSuw33xvMayqsXXubIfIkZfK6JatkSgTLeRzRh+BYjkogs6nmea
         8RCEgrU8Yd/nqhCYrXQCaLGI5cYSQ8OliezlYeZRZJ1E00uRlmINT9agg1tl8KWOw+G8
         6PrA==
X-Gm-Message-State: AGi0PuYoKV6FdDbrCXAAZh7SbUme6Z5FOKMbhUhqZ65jdm2N/02ugdXf
        MMTiNAJmP+g4WLzNL1mH+76UQgix
X-Google-Smtp-Source: APiQypLB/idfUST5xyrj4fhVSoR9xyL88dMHS3SbUwO+W2dwEUHSGlfn8Nt7esPrnXIqKf/glFt9uA==
X-Received: by 2002:a1c:2e07:: with SMTP id u7mr20752941wmu.74.1587904613856;
        Sun, 26 Apr 2020 05:36:53 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id h17sm10742381wmm.6.2020.04.26.05.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:36:53 -0700 (PDT)
Message-ID: <1b002fb8caf1755b89882fd7a3bbac1565959a6d.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] Changes in w1_therm.c and adding w1_therm.h
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Sun, 26 Apr 2020 14:36:52 +0200
In-Reply-To: <20200426075141.GB2100063@kroah.com>
References: <20200423144116.GA7319@kroah.com>
         <20200425153141.247055-1-akira215corp@gmail.com>
         <20200426075141.GB2100063@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 26 avril 2020 à 09:51 +0200, Greg KH a écrit :
> On Sat, Apr 25, 2020 at 05:31:41PM +0200, Akira Shimahara wrote:
> > From: Akira SHIMAHARA <akira215corp@gmail.com>
> > 
> > Patch for enhacement of w1_therm module. Added features :
> >  - Bulk read : send one command for all the slaves
> >  		on the bus to trigger temperature conversion
> >  - Optimized conversion time regarding to device resolution
> >  - Dedicated sysfs entry for powering read,
> >  		resolution set/get, eeprom save/restore
> >  - Alarms settings and reading
> >  - Code optimization to mitigate bus traffic
> >  		(devices information are stored to avoid
> > 		interrogating each device every-time)
> > 
> > Following sysfs entry are added :
> >  - temperature (RO) : return the temperature in 1/1000°
> >  - ext_power (RO) : return the power status of the device
> >  - resolution (RW) : get or set the device resolution (supported
> > devices)
> >  - eeprom (WO) :trigger a save or restore to/from device EEPROM
> >  - alarms (RW) : read or write TH and TL in the device RAM
> >  - therm_bulk_read (RW) : Attribute at master level to trigger
> >  		bulk read and to survey the progress of devices
> > conversions
> >  - w1_slave has been kept for compatibility
> > 
> > Main motivation was to improve temperature reading speed, which
> > depend
> > on resolution settings of devices. The module store the powwer
> > status and
> > the resolution of each device so that during reading operation, no
> > transaction is required on the bus, which improve speed.
> > The hardware status is checked as soon as a new device is
> > detected, 
> > when a user change occurred, or when the corresponding sys file is 
> > accessed by user.
> > 
> > The bulk read allow to trigger convserion of all devices on the bus
> > at
> > the same time. It will apply a strong pull up on the line if at
> > least
> > one device required it. The duration of the pull up is the max time
> > required by a device on the line.
> > 
> > Please let me know any feedback you have on this patch.
> > 
> > Thanks ahead,
> > 
> > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > ---
> > Changes in v2:
> >  - Adding documentation in Documentatin/ABI/testing/sysfs-driver-
> > w1_therm
> >  - Updating existing documentation in
> > Documentation/w1/slaves/w1_therm.rst
> > 
> >  drivers/w1/slaves/w1_therm.c | 1406 ++++++++++++++++++++++++++--
> > ------
> >  drivers/w1/slaves/w1_therm.h |  386 ++++++++++
> >  2 files changed, 1470 insertions(+), 322 deletions(-)
> >  create mode 100644 drivers/w1/slaves/w1_therm.h
> 
> No documentation files are added here :(
> 

It's in the PATCH 2/2 included in the previous mail. You want me to
merge in one commit ?. I thought it was easier for you to keep a track
of the v1.

Let me know what you prefer.

Thanks ahead

Akira SHIMAHARA




