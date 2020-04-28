Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3153BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F48206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+kd6Et9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgD1NmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgD1NmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:42:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788BC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:42:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so24677269wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SSD67r/RoD8vBQleLrjCX1npx0GGKSGp56Z0awn7EmY=;
        b=A+kd6Et9BBdUr4NXCP2rrG2k2LOAFcpuuuuYtczDlphxa6FmK/7fjFlNVUGPT4bEsq
         MUjkCT17sB+b+pRsMigQWKRZM/mWYvrMj7OK5ZVGyVPP4XUFt7/16Q1IDIs0cVfNNoW6
         cioXHWalcVADtnz/na3WmdIfwQ0pJOLdNMew1BiueKiZtZQARg9rtHKWbQ0726G412+F
         EeyWtdNInM4vvMNlorKjOUNrVFMz+R9RDz2tLHOhwwcoDcTm0FFtmoKZPzDsN9jXeG64
         ufKSE/aqRkzOVL8npVZe5F31kmnuE28+AcOastm1DWl4kIQnGYo71PFGmKYtky/KiA+E
         pg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SSD67r/RoD8vBQleLrjCX1npx0GGKSGp56Z0awn7EmY=;
        b=PvrQ2o2dBhmgYd2HPqHm4iB7rMtdYpuuNHYsRdSZMibYwNqi978/JDONkx7UJg//H3
         duBkPYKIoNsojUQD+S0aW2C7Cn10XpgJAyIhqAJ5GT1INYs7RYB+bg8SBLwp5o4hzMpU
         BGXcaHK4ogN7DBJGRhLDhWbIqJdaRSoljY5AndrNfiYS4J3mHWK65LhKss2LMxGPMxkm
         DW0DTFMVtvHSHW3mWeBo0YMk+cpBgHCxgByciQ5xnMVEc4YxaTB7NpLl10BB+HJNBN+t
         ophdsxiIpfNSTo6rSQafwdNPAqW7cPrsWzXpzm/A/fmY9e2XZNQZHnbFEMV/81LeMOpU
         /DHw==
X-Gm-Message-State: AGi0PuZDIrTPJuza6fbZbP84VXbxrlu8Ok86StFQzUMEQo/mbrJiyf4g
        0J7wJSwkqFE3u5N+VauwOiZ6aI+s
X-Google-Smtp-Source: APiQypJmhvA5LWzoNb1qkR0oyWZF+7Pq99kqTFV2ZEI6rgbjrBGmGaVpYRbOidPdhoixBKzbutU+Aw==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr32279447wrw.373.1588081343183;
        Tue, 28 Apr 2020 06:42:23 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id d143sm3288000wmd.16.2020.04.28.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 06:42:21 -0700 (PDT)
Message-ID: <f7e739bee4c2fe4150247b7d61b781f4747d8623.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] Changes in w1_therm.c and adding w1_therm.h
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 15:42:20 +0200
In-Reply-To: <20200428124401.GA1269471@kroah.com>
References: <20200423144116.GA7319@kroah.com>
         <20200425153141.247055-1-akira215corp@gmail.com>
         <20200426075141.GB2100063@kroah.com>
         <1b002fb8caf1755b89882fd7a3bbac1565959a6d.camel@gmail.com>
         <20200426170901.GA2139089@kroah.com>
         <97cc7047c5c3892c4a52a6a1fcc6ec948e0796ac.camel@gmail.com>
         <20200428124401.GA1269471@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 28 avril 2020 à 14:44 +0200, Greg KH a écrit :
> On Sun, Apr 26, 2020 at 07:20:30PM +0200, Akira shimahara wrote:
> > Le dimanche 26 avril 2020 à 19:09 +0200, Greg KH a écrit :
> > > On Sun, Apr 26, 2020 at 02:36:52PM +0200, Akira shimahara wrote:
> > > > Le dimanche 26 avril 2020 à 09:51 +0200, Greg KH a écrit :
> > > > > On Sat, Apr 25, 2020 at 05:31:41PM +0200, Akira Shimahara
> > > > > wrote:
> > > > > > From: Akira SHIMAHARA <akira215corp@gmail.com>
> > > > > > 
> > > > > > Patch for enhacement of w1_therm module. Added features :
> > > > > >  - Bulk read : send one command for all the slaves
> > > > > >  		on the bus to trigger temperature conversion
> > > > > >  - Optimized conversion time regarding to device resolution
> > > > > >  - Dedicated sysfs entry for powering read,
> > > > > >  		resolution set/get, eeprom save/restore
> > > > > >  - Alarms settings and reading
> > > > > >  - Code optimization to mitigate bus traffic
> > > > > >  		(devices information are stored to avoid
> > > > > > 		interrogating each device every-time)
> > > > > > 
> > > > > > Following sysfs entry are added :
> > > > > >  - temperature (RO) : return the temperature in 1/1000°
> > > > > >  - ext_power (RO) : return the power status of the device
> > > > > >  - resolution (RW) : get or set the device resolution
> > > > > > (supported
> > > > > > devices)
> > > > > >  - eeprom (WO) :trigger a save or restore to/from device
> > > > > > EEPROM
> > > > > >  - alarms (RW) : read or write TH and TL in the device RAM
> > > > > >  - therm_bulk_read (RW) : Attribute at master level to
> > > > > > trigger
> > > > > >  		bulk read and to survey the progress of devices
> > > > > > conversions
> > > > > >  - w1_slave has been kept for compatibility
> > > > > > 
> > > > > > Main motivation was to improve temperature reading speed,
> > > > > > which
> > > > > > depend
> > > > > > on resolution settings of devices. The module store the
> > > > > > powwer
> > > > > > status and
> > > > > > the resolution of each device so that during reading
> > > > > > operation,
> > > > > > no
> > > > > > transaction is required on the bus, which improve speed.
> > > > > > The hardware status is checked as soon as a new device is
> > > > > > detected, 
> > > > > > when a user change occurred, or when the corresponding sys
> > > > > > file
> > > > > > is 
> > > > > > accessed by user.
> > > > > > 
> > > > > > The bulk read allow to trigger convserion of all devices on
> > > > > > the
> > > > > > bus
> > > > > > at
> > > > > > the same time. It will apply a strong pull up on the line
> > > > > > if at
> > > > > > least
> > > > > > one device required it. The duration of the pull up is the
> > > > > > max
> > > > > > time
> > > > > > required by a device on the line.
> > > > > > 
> > > > > > Please let me know any feedback you have on this patch.
> > > > > > 
> > > > > > Thanks ahead,
> > > > > > 
> > > > > > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > >  - Adding documentation in Documentatin/ABI/testing/sysfs-
> > > > > > driver-
> > > > > > w1_therm
> > > > > >  - Updating existing documentation in
> > > > > > Documentation/w1/slaves/w1_therm.rst
> > > > > > 
> > > > > >  drivers/w1/slaves/w1_therm.c | 1406
> > > > > > ++++++++++++++++++++++++++--
> > > > > > ------
> > > > > >  drivers/w1/slaves/w1_therm.h |  386 ++++++++++
> > > > > >  2 files changed, 1470 insertions(+), 322 deletions(-)
> > > > > >  create mode 100644 drivers/w1/slaves/w1_therm.h
> > > > > 
> > > > > No documentation files are added here :(
> > > > > 
> > > > 
> > > > It's in the PATCH 2/2 included in the previous mail. You want
> > > > me to
> > > > merge in one commit ?. I thought it was easier for you to keep
> > > > a
> > > > track
> > > > of the v1.
> > > 
> > > What previous mail?  I don't see a patch 2/2 here, did you not
> > > cc:
> > > me?
> > > 
> > > thanks,
> > > 
> > > greg kh
> > 
> > I'm so sorry Greg, I made a mistake. Please find hereby the patch
> > 2/2.
> > Let me know if you want me to merge into 1 commit.
> 
> No, multiple patches are good.
> 
> And the first patch really should be split up into smaller pieces
> too.
> Each patch should only do 1 thing, not lots of things all at once.  
> 
> Can you do that and send a patch series please?
> 
> thanks,
> 
> greg k-h

Well noted, I will do it tomorrow

Regards

Akira Shimahara

