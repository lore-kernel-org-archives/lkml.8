Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E70C55185
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810E12073A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDIMWoCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDWByf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgDWByf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 21:54:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF9C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 18:54:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so2138394pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9gO/jOmDbmIi4YH9skozzrQ7C4Ubf/dRYg/3aTUpYHc=;
        b=IDIMWoCeAa5ituZWv4aR5uTHX+7XW67yKvSpSpHgSfVnMi/JZDZm16mpf+tz/13Ooz
         2kM4IHWQk5x2DxLZAvllPyLlPDHFRLWODyJkwmcR4VBqkZAUTH6YbLyFR07jEfYthxBb
         upihERw+bOTPql4AnpGNVoY4sVdPB3h2clXQ3va8fHQDMQPo+kKcDgXwIbbN/Yms4JHH
         /3uwujltQLsft9Fyn6KHZQIptvC3YEh2mBEhL0IAE8Uk4JT62CPAd1XJWQH5i2Lrmswm
         sYt8mT0QVFkZVJCPZezjbpugcHbB6PPHYlm02uHsKTGkECSswqs+V2dPm/koa8Sduvjb
         nxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9gO/jOmDbmIi4YH9skozzrQ7C4Ubf/dRYg/3aTUpYHc=;
        b=ntlgEIVBs6U0t2BSGw2mxPXEbXuloRcGbQihn9PNE5wpE4doxOn1259m1ubIZO7dUF
         cYb8egNyDVzQTkg0WPne+mZ/qWx0WEvqUoMFXR7TYsK6ivIVS38c609TQmh6cVJ2L2pG
         EkFEcwfjtHtQ68Xhly7vw+nXqyzeMEpQiQTYIYYOjzLgcNYElVjl/ePczRAxPdiQ2whg
         Kw9vpR151QUx7gXDGaKIykL6uodO/LdzBhEDQuYoEOd9dkGOVdMFSXajqjEfMym3AEWE
         yhFajVE0FGwkXPgRit4YFk1/MDMaM+oxGJNA1WUtTkuUFSmRbEVyufWOs4nmaYPkRhds
         1azw==
X-Gm-Message-State: AGi0PuYLnGGVIQqhZTqU30nMrwhZVWtQ3k6CAe5MdxzzEtfQRYF4IV8c
        O23fwiPzeSvBdMw6gjeC2IU=
X-Google-Smtp-Source: APiQypKRXLoprifp0GnJG6+McjPd8QX8qzMbxhfr6enCoe/u68NFMaeEav2GLV6pzIciMsD1lOcOWA==
X-Received: by 2002:a62:1d48:: with SMTP id d69mr1502419pfd.102.1587606874702;
        Wed, 22 Apr 2020 18:54:34 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id f99sm520780pjg.22.2020.04.22.18.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 18:54:33 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 23 Apr 2020 10:54:31 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 1/3] lib/vsprintf: Print time64_t in human readable
 format
Message-ID: <20200423015431.GB246741@jagdpanzerIV.localdomain>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415170046.33374-2-andriy.shevchenko@linux.intel.com>
 <20200416023219.GA30641@jagdpanzerIV.localdomain>
 <20200421130846.GM185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421130846.GM185537@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/21 16:08), Andy Shevchenko wrote:
[..]
> > Here you convert time64_t (signed, we also have unsigned version - timeu64_t)
> > to tm first and then convert tm to rtc_time. Will rtc_time64_to_tm() do the
> > trick?
>
> You missed v2 round. The RTC is configuration dependent and Alexandre in favour
> of removing those from RTC completely by replacing with always enabled
> time64_to_tm().

I see.
I don't think I was Cc-ed on v1/v2.

	-ss
