Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE0B20775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593589859;
	bh=p84kYY9UMRLBAMs9rNo8BJHfDwmh0Roplc3jfShd5k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PUYeR0PDS93ONm7np7c7/xgWL3xRWpkBEn+b4Gbs6PqE9OPjLs/0Y2WPgrIDv1jpB
	 S3okyN4Xbej0iducJ7V1RwWfCguahGrR9mLRDdRZq7fsXtwhs3JcpLBmD3xUUDRikj
	 Lv5E9pi6kyJnz/5Cjd8nLxB/AMAOHa0qLSkCfs3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgGAHu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:50:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42261 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgGAHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:50:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id h22so18630169lji.9;
        Wed, 01 Jul 2020 00:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5USxJUqdNDMLfwU5wJfAdESBZenthDQ0zK5od654+k=;
        b=fWCvcbToGLuUeogj4PEWGECpzTjIHxJe43I5nvoKXntAX93d2GP5HaTDNPPHLpCye6
         eL5BPfDqdb6fv8wxkoxol3NeooIPqczF0Y+yGcWnGrxWKw5sBg0skRacrySPhEuxbo+R
         jPHU0/nHZ6SFYTOuNUR5p+byG2Sdj4GSnHBrWQalBkbwPc5AX8lHJ9uAPTMAeWrQunXN
         aN5xsf0d9SCKZgYXBFY6c7u19MxErFbGg7gMdO8X04ZPzNS1Q6IZDOUzcOMNdUrgIHGy
         gX+l5cOfS8pebJeTvI0MvfXtqLZ1Eadw3izrX01nXYhuhl7DWZTe2Ynr2d0MhGlKonno
         px9Q==
X-Gm-Message-State: AOAM531n8yinI+8LdOZMAH2OaoaLDGmmLtdRIDSeXpoh1EEnEKrHPiYs
        ZdD3HHq9yIvuNH9Qu0DMJn49lxZWCSI=
X-Google-Smtp-Source: ABdhPJzcFqBA84jJpx6KwqXnUpdFMSRkHlEPlSIHbaryPhq0XLJl4MQGrzNcaj2OPvXqqXM5pR7hfA==
X-Received: by 2002:a2e:9ed0:: with SMTP id h16mr13495821ljk.366.1593589853723;
        Wed, 01 Jul 2020 00:50:53 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 23sm1744591lff.91.2020.07.01.00.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:50:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jqXW3-0006GS-8l; Wed, 01 Jul 2020 09:50:48 +0200
Date:   Wed, 1 Jul 2020 09:50:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v4 0/3] Add support for MaxLinear/Exar USB to serial
 converters
Message-ID: <20200701075047.GB3334@localhost>
References: <20200607160809.20192-1-mani@kernel.org>
 <20200626143136.GF8333@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626143136.GF8333@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 08:01:36PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Jun 07, 2020 at 09:38:06PM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds support for MaxLinear/Exar USB to serial converters.
> > This driver only supports XR21V141X series but it can easily be extended
> > to other series in future.
> > 
> > This driver is inspired from the initial one submitted by Patong Yang:
> > 
> > https://patchwork.kernel.org/patch/10543261/
> > 
> > While the initial driver was a custom tty USB driver exposing whole
> > new serial interface ttyXRUSBn, this version is completely based on USB
> > serial core thus exposing the interfaces as ttyUSBn. This will avoid
> > the overhead of exposing a new USB serial interface which the userspace
> > tools are unaware of.
> > 
> > This series has been tested with Hikey970 board hosting XR21V141X chip.
> > 
> 
> Gentle ping on this series!

You sending this in reply to your superseded v4. Please make sure to
always increment the revision number when updating a series, including
when changing authorship.

Johan
