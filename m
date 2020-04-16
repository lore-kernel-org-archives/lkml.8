Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6AE20732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWFgdfot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408144AbgDPGa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408098AbgDPGal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:30:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B06C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:30:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o81so3304265wmo.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EbDpuqbSKXrhOOFdyAtrekuQH3pehoerdPXZvDK98Tk=;
        b=HWFgdfotIHfKyFSIvyaWoMY2NtygeXzAlWgHPDl1i2VaoQWuMp78v4YzBlg06OaE/d
         msmIRjge1Vd7VWnUTAh6T4uW8BPU6O+gaYAIPrNkz/xuR4xXc8yzIqlgSMs4owsXDDzQ
         S6+N8IacF4z6Ur7RDkn3yOsxuIo17z36wmGbQnZQ+VbsavIueQa1CVg8+BAYILIWz+yn
         sJaxQ6ILcnfAXDhlEn+2bdGU/s9Y5FFtDsRfmnsDYDkTKdhPPT5NhOtyA88ctsGlvR3z
         NStahHO4g1GDB6FEYRFYJDSzUbb00IhFtQXbhbha7/+AJPApgCiFTlZon9/iDd7LT+Z8
         dznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EbDpuqbSKXrhOOFdyAtrekuQH3pehoerdPXZvDK98Tk=;
        b=jO3WGazfBX72CW3X0c6mjSoxRQ6unal0D/3fyMYoSGbe8NPzDbSjQhln4tapiRt8+i
         uvrE14yswF7kKv5L3Ui6m+iZkL3IIY67turLHh9cTy3+BOXMiRfENwUkaKvMFC3K7sUW
         0rRByXEjEVSUCdXtwkpT3ZayxM1hGhLeDv6+hPez71DqxetakeF0bvzk8BvkQQIBQtBI
         BtDxKhSzoT1qSoXzUs2W1jzaP8b3HFZNtIgoKC8cPJot3VAm83q+nWY7JtluDXzgJHaP
         HcBm+oL6LcL84UaNBcBaCcGaCzdEhdjADsKO1baYQ7apPVpKuVOx4bJ3nYEI+ldsgt0J
         JZwA==
X-Gm-Message-State: AGi0PuZwFNib+hSld1Jy4d5Hzn+la6FT5aHRxte0iC+K8ghGM0O/uEdM
        7U8mAhdaP4evrap1eSnc7bNNCYMlqTY=
X-Google-Smtp-Source: APiQypJcP0ehu1VsY4ImcAf4XYv5L+l2pneZjAV+VsIU1PjZ2pIh/C05eHNjKMfuz65CjOyGUNiDlg==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr2962754wmi.57.1587018640202;
        Wed, 15 Apr 2020 23:30:40 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id w11sm2293775wmi.32.2020.04.15.23.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:30:39 -0700 (PDT)
Date:   Thu, 16 Apr 2020 07:31:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: rohm-bdXXX - switch to use i2c probe_new
Message-ID: <20200416063133.GM2167633@dell>
References: <20200326064852.GA23265@localhost.localdomain>
 <20200415095052.GI2167633@dell>
 <a4b45b01e78c37e23cc4e464ec07d2364e02e379.camel@fi.rohmeurope.com>
 <20200415110405.GJ2167633@dell>
 <abcb3356c78758cb176947fba7b2f291d63055a3.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abcb3356c78758cb176947fba7b2f291d63055a3.camel@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Vaittinen, Matti wrote:

> 
> On Wed, 2020-04-15 at 12:04 +0100, Lee Jones wrote:
> > On Wed, 15 Apr 2020, Vaittinen, Matti wrote:
> > > Hello Lee,
> > > 
> > > On Wed, 2020-04-15 at 10:50 +0100, Lee Jones wrote:
> > > > On Thu, 26 Mar 2020, Matti Vaittinen wrote:
> > > > 
> > > > > ROHM BD70528 and BD718x7 drivers do not utilize the I2C id.
> > > > > Do the trivial conversion and make them to use probe_new
> > > > > instead of probe.
> > > > 
> > > > Not sure I understand the purpose of the patch.
> > > > 
> > > > The only reason to switch to probe_new is to aid the removal of
> > > > the
> > > > compulsory I2C tables.  However, neither of these drivers have
> > > > them.
> > > 
> > > Maybe I have misunderstood the probe_new. My understanding was that
> > > the
> > > probe_new is what should become the standard - Eg. eventually all
> > > I2C
> > > drivers would use probe which is not getting the ID tables as
> > > argument
> > > - and the old probe could be removed. Thus I thought conversion of
> > > probe to probe_new would be required in order to get rid of the old
> > > probe. I think I got this understanding when I submitted driver for
> > > BD71828 - and I think it was you who suggested me to switch to
> > > probe_new as 'id' was unused. But if please just drop this patch if
> > > this change is not needed!
> > 
> > Some I2C drivers do make use of 'id' though.  So the standard probe
> > will probably never go away.  I wrote probe_new for drivers that
> > wished to omit the I2C table.  A better use of your time would be to
> > go through the original probe users and figure out which I2C tables
> > can be removed.
> 
> Right. Unfortunately I don't have problems with excessive amounts of
> free time xD I did this probe-conversion for bd718x7 because that
> driver is originally written by me - and I try to contribute on
> maintenance of stuff I have pushed on your and other maintainer's
> shoulders :)
> 
> And as I said - if the usage of probe is just as fine as usage of
> probe_new - then please just drop this patch :)

I should revisit the I2C situation at one point.  It does seem silly
to have a 4 year old *new* API.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
