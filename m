Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03845C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EE220DD4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8XCttay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgFPNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPNXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:23:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:23:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so2274771wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZUTJ/wJEfNjN2kSpycLtF70cONPP9yJfClX+Aj6V9Gs=;
        b=O8XCttayTGEgR6Ze2YmbgRKlCGknFu0mBnoBCuNePoL/Z8Ui3Y+GMWFDkhr4nD1Ys/
         pSc8MREA2ic2OBpCCL3dse5pOucCATESKXW2YRr7ujDe5QexqVToNBwFBXDsAz00UJGO
         WsbhW2IS1moURIAISxHUAUZ0gL9zWMul3EyUHC208QDnwam9h0bbjuVFmcCZf2Kim1g/
         /c5sXhisIHX4uqCZSwfsJZMY+hQ55t2kC83rWrRcAHkz/unTvAC1Z6eE7nPBsLL4kCRA
         nZ7dWAimE7Zo71bmhQGgLmMFQF9JSQQIEl3smr1ibM4LB/o/ZIjBqzne+xWx6u4KohPj
         CKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZUTJ/wJEfNjN2kSpycLtF70cONPP9yJfClX+Aj6V9Gs=;
        b=oaTb3KNAf4aQw/bJgvlN94RUSUuy5Ev1DWkQ0dOC5kPP4TEHOphHXcjVd0g3ItGH2H
         EWDj0iE3F6DAakNhyWfuAWGsj2JERAUr4r5tmXNmx0PUmC+l5I85PWocRUZNYyhkylOT
         UGxe6po/xxgQy5nnYt5jAmaG931SUpDXy9u4/S1fXNGQolCJCnF4qGVhUxCSi4OBCGDm
         FhOaibSgF5Mls+g0TVvRS8K29He2pWiOHsyh11WIynvVsq7AWOcJ1k0t3N5MCUl7Su0t
         kUFppNm9kvTztiSeD5O7aCDvx0pmUAnTwHeUau8e20JOgwIdVgo2vkp+zVOkejHcgtXp
         U4Rw==
X-Gm-Message-State: AOAM5331C6KRV3dlEt8VaxzOifv5gQeGslqfHo+k5+p+guNKfmrutXQv
        hxYfvxurwB+JmmVl+uFXdYyBsg==
X-Google-Smtp-Source: ABdhPJwtDboy6TQPzJBTRdGYO9I2ka/GcPEk+ZMra2vr8zWPPVMnHG1cnjbGXDOqfculpO79Cn+gGw==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr3264412wmo.139.1592313781463;
        Tue, 16 Jun 2020 06:23:01 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id f185sm4118618wmf.43.2020.06.16.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 06:23:00 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:22:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/2] mfd: mfd-core: Add mechanism for removal of a
 subset of children
Message-ID: <20200616132259.GS2608702@dell>
References: <20200615150722.5249-1-ckeepax@opensource.cirrus.com>
 <20200616075834.GF2608702@dell>
 <20200616084748.GS71940@ediswmail.ad.cirrus.com>
 <20200616091545.GP2608702@dell>
 <20200616100625.GT71940@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616100625.GT71940@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Charles Keepax wrote:

> On Tue, Jun 16, 2020 at 10:15:45AM +0100, Lee Jones wrote:
> > On Tue, 16 Jun 2020, Charles Keepax wrote:
> > > On Tue, Jun 16, 2020 at 08:58:34AM +0100, Lee Jones wrote:
> > > > On Mon, 15 Jun 2020, Charles Keepax wrote:
> > > Does this match how you would expect this to be used?
> > 
> > No, not at all.
> > 
> > > I do have some concerns. The code can't use mfd_get_cell since it
> > > returns a const pointer, although the pointer in platform_device
> > > isn't const so we access that directly, could update mfd_get_cell? We
> > > also don't have access to mfd_dev_type outside of the mfd core so
> > > its hard to check we are actually setting the mfd_cell of actual
> > > MFD children, I guess just checking for mfd_cell being not NULL is
> > > good enough?
> > 
> > Hmmm... looks like I missed the fact that you needed additional
> > processing between the removal of each batch of devices.  My
> > implementation simply handles the order in which devices are removed
> > (a bit like initcall()s).
> > 
> > How about the inclusion of mfd_remove_devices_late(), whereby
> > mfd_remove_devices() will refuse to remove devices tagged with
> > MFD_DEP_LEVEL_HIGH.
> > 
> 
> Yeah this should work fine for my use-case.
> 
> > Not sure why, but I really dislike the idea of device removal by
> > arbitrary value/tag, as I see it spawning all sorts of weird and
> > wonderful implications/hacks/abuse.
> > 
> 
> Its definitely a spectrum with flexibility covering more
> use-cases but also definitely opening things up to more abuse. If
> you are more comfortable with this approach that is fine with me.
> 
> Would you like me to have a crack at coding it up this way? Or
> did you want to do a patch?

Either/or.  I don't want to steal your thunder, but I'm happy to draft
if you are.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
