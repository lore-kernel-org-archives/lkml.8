Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C9EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2103420737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqWbXVjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896738AbgDOLGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408836AbgDOLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:03:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDBC061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:03:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so18603702wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=63+Kapds64fF8VnH8kQ6DVrjXzlI9XalKF9fI3VjpmQ=;
        b=dqWbXVjdQwjBJE5+Q3mHBZLR/g7DBUYdxPAhik4lttLfusKXdE3xujCQIyupg7KdMP
         dsIMIE4q+Y2QWiBRiCvMHGnmtt67QMsXzGA61zJTcRh9B4zDJMTkhTsIpuqYd8xu8Ic1
         oFOhzdxHgH4SVcC4CpHuLpKTwG04jAS3jmdZhu6+59ccN/3+93tDntZr84WxtSh/eXr2
         AjloNumg87+LMov24pYo37U8ZbVEVk/hESCzRniMAP9EAQvjfcFGZO1Q4on5Bqc5As9z
         te8spmsxZspjB1Vv2c1wDR5vpRY5J7EfcxjTyZD7x4k0XQjPYb52aY2cX5yyixhgVm97
         gFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=63+Kapds64fF8VnH8kQ6DVrjXzlI9XalKF9fI3VjpmQ=;
        b=D2WrlprRMRC+t7pM4IxQNAJi+2KvCwaiZX/poDDQ/7NPz50q6VWn23CshnrM7WaLYv
         LGgVQYOoUliYWvXZGFFZ1+9i/DHp0uTt3LfacewOvYz8VErKgrENFgq9z8liWdkDODPB
         uhSkAdeprGrJNqXf3x6PPQ69wxX+fanK5NzOxJsKE4b7qtZv5gcvadW/0FEtm+p1dSq+
         209pyS1UYrY/Goz46aRHAYIb1NNUxHnm6x1Jd+Z3aizsQtoMGlHMG3t7UTonjHz+F0XS
         NiXpylOWV+Us+4e7Hfmu2UsF0JbVgd7n4oNUlIjNA0fp+xzNON7WGbYKG4kaG7DB7+rm
         8jrg==
X-Gm-Message-State: AGi0Pua++G8LprO3ZwPSGKS9bOmbd/5pw7iPGzVMuGzLbbiRt1uFj5yE
        JdsuOa5AzCgc4Mj1ibMYPW0VJQ==
X-Google-Smtp-Source: APiQypLdt898OWc/sug/xv0mEQBtfTQQ07gc4gV91+6KybjmQja5SFIZ+jv8Lm+nIZQPUI/bU+3R+w==
X-Received: by 2002:adf:8149:: with SMTP id 67mr29872018wrm.60.1586948585205;
        Wed, 15 Apr 2020 04:03:05 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id q17sm14179579wmj.45.2020.04.15.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 04:03:04 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:04:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: rohm-bdXXX - switch to use i2c probe_new
Message-ID: <20200415110405.GJ2167633@dell>
References: <20200326064852.GA23265@localhost.localdomain>
 <20200415095052.GI2167633@dell>
 <a4b45b01e78c37e23cc4e464ec07d2364e02e379.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4b45b01e78c37e23cc4e464ec07d2364e02e379.camel@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Vaittinen, Matti wrote:

> Hello Lee,
> 
> On Wed, 2020-04-15 at 10:50 +0100, Lee Jones wrote:
> > On Thu, 26 Mar 2020, Matti Vaittinen wrote:
> > 
> > > ROHM BD70528 and BD718x7 drivers do not utilize the I2C id.
> > > Do the trivial conversion and make them to use probe_new
> > > instead of probe.
> > 
> > Not sure I understand the purpose of the patch.
> > 
> > The only reason to switch to probe_new is to aid the removal of the
> > compulsory I2C tables.  However, neither of these drivers have them.
> 
> Maybe I have misunderstood the probe_new. My understanding was that the
> probe_new is what should become the standard - Eg. eventually all I2C
> drivers would use probe which is not getting the ID tables as argument
> - and the old probe could be removed. Thus I thought conversion of
> probe to probe_new would be required in order to get rid of the old
> probe. I think I got this understanding when I submitted driver for
> BD71828 - and I think it was you who suggested me to switch to
> probe_new as 'id' was unused. But if please just drop this patch if
> this change is not needed!

Some I2C drivers do make use of 'id' though.  So the standard probe
will probably never go away.  I wrote probe_new for drivers that
wished to omit the I2C table.  A better use of your time would be to
go through the original probe users and figure out which I2C tables
can be removed.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
