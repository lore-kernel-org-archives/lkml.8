Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A63C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3E620739
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNfSFaxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQJb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:31:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9BAC061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:31:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q25so1249865wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jwXEf81LbR7teL/COdo9BlvOzBI0RFp1VoJeVoqc3Bc=;
        b=dNfSFaxVlPuHbIwpxZUgoYEzJt6i6QbbvSZc6umkZmp0rVWhkxdR+oKDoskOX0e6l+
         pXIc0w1ON/BN8+xrmv+6HB6abO79in+3pBwGps1/KcdfiDHNWaQn4tgDzXa/cZdUXYeM
         sYgyTCa/4TDCKBrm9fLvF+brVklx7wRvf1mBtdfRxbzOmqUIwRs1JH7R2Q1zjhxo9koe
         pWIKLxaRciCEESX0Pb/zVyscNf0fFYvdMfq7sjijzbqWyFADRmYdKwFjajP4sPqh1YlD
         Ry/IlQT/1DJpwQu+0b0mDU+zXeyb+VWcs4JaUM5IlG93at7cf0qDsnlXcsr2VJDMdHw7
         qvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwXEf81LbR7teL/COdo9BlvOzBI0RFp1VoJeVoqc3Bc=;
        b=txw62uNfvQnj0AjzaRjvBN9DyoRt4tPIu7tMBnmc6JbpFspPk747bzsni6EoN/9lII
         IdvTWVyARFCRg1l711DAla/8e2wta1N29UfgkOf7sda8cGZy6XD6ApXCnFDBMfVq/YdF
         CgUqcPYLg913Acgx7SfTTMoJAUjJu5BGYp6lGlsLZ6vsvvr2XHyiWoeL2n6Ly0NkIdi3
         NWV9gVFql2hFqrlqZhjDAFb/GFgGk23gdg8Gwuh0IN6JfQttONVPO0AwcExDuwovYl9j
         jsHAxrFsh7qGYeKYbOgTPwr/m9W9VZo2C1udvU8dTVT7mrTaOLRMDh/2uEok/Z2A5Fmf
         Imgg==
X-Gm-Message-State: AOAM532UVDcwZ8x1cTVmnmZ/RbasSU247hBfaavHsujWx5eyqEhZmkWi
        mb0zJZBMI+rtMG3+T4MpVc2q35/8VGE=
X-Google-Smtp-Source: ABdhPJytcjCv29MSyVQJZ5w4lhGyyUY7cxDmnIDIi51vs3rAXuL+my8fvayQUHi/q2+I5LeKtp9Bdw==
X-Received: by 2002:a1c:4954:: with SMTP id w81mr7807335wma.86.1592386316725;
        Wed, 17 Jun 2020 02:31:56 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id y14sm7110485wma.25.2020.06.17.02.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:31:56 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:31:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>, Jim Cromie <jim.cromie@gmail.com>,
        jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
Message-ID: <20200617093154.v7mf5355faa4c7ob@holly.lan>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-21-jim.cromie@gmail.com>
 <20200616134507.GO31238@alley>
 <5b0fade06c46da0a469266738c684ba55d8e39f0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0fade06c46da0a469266738c684ba55d8e39f0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 02:05:27PM -0700, Joe Perches wrote:
> On Tue, 2020-06-16 at 15:45 +0200, Petr Mladek wrote:
> > On Sat 2020-06-13 09:57:34, Jim Cromie wrote:
> > > There are *lots* of ad-hoc debug printing solutions in kernel,
> > > this is a 1st attempt at providing a common mechanism for many of them.
> > 
> > I agree that it might make sense to provide some common mechanism.
> []
> > My problem with this approach is that it is too generic. Each class
> > would have different meaning in each subsystem.
> > 
> > It might help to replace any existing variants. But it would be hard
> > for developers debugging the code. They would need to study/remember
> > the meaning of these groups for particular subsystems. They would
> > need to set different values for different messages.
> > 
> > Could you please provide more details about the potential users?
> > Would be possible to find some common patterns and common
> > meaning of the groups?
> 
> I doubt the utility of common patterns.
> Verbosity is common but groupings are not.
> 
> Look at the DRM patterns vs other groups.

I've seen drm.debug mentioned a couple of times but the comments about
it seem to only learn part of what is shows us.

drm.debug is a form of common grouping but it acts at a sub-system level
rather then whole system (and gives a whole sub-system enable/disable).
This is where grouping makes most sense.

The result is that drm.debug is easy to document, both in official
kernel docs and in other resources (like the arch distro documentation).
Having controls that are easy to document makes them easy to find and
thus sub-system grouping leads directly to higher quality bug reports.


Daniel.
