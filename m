Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74016C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542B821741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgu+MIk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHZOuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgHZOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:50:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9A6C061574;
        Wed, 26 Aug 2020 07:50:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so1153653pgk.1;
        Wed, 26 Aug 2020 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LPGohmlezc7FaY8vrCO7jmNBwdri2cW9GxBu42JySH4=;
        b=bgu+MIk7sVaYY18YDrHS4liMWptYDp3vwU72mFoSD+Z92gM2Vud+qs3d8CHhAhN9bK
         TXvCV/4RpiN0zU/Dh3tY8TTScPy3LGeFXDlVnP3n1e1nY9+dZGsUM1X9Mium9IwqNurq
         uL8zxXL2M1thm6hrndpAbbCVNKuiBmv8Y18BtHYEurghlSOKcXkknMAXLzmMNW96v5Nq
         36EHx0WDWo2cm0oauJ8+71c5pcuQKqIMuEEpTj/Klli6cMtKNZtiy5Bb51L7GQJO7auW
         MDYcP/JcIAOLutIT5vnxuobHN3xH90jCoaDbDVRjQJDG6vXnTNsP+lFIrwSm2ZxU3n79
         U/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LPGohmlezc7FaY8vrCO7jmNBwdri2cW9GxBu42JySH4=;
        b=NXchzmzllGWl1SNbhAupeJzlDMyNjj8WgalqhYypCjetk7WlaeBmeg727llMBw3y+Q
         PN4SXWuhK40o+AUT7gkX53XS7gOLhtyOwWVNoS7CcXstdtY0f5eKJJvDX9NTB5N2rtQQ
         gq1Ry5rvSwArhH/5zMW5jLK+6tb3nhQxMqcM4pRY3nlbPlWaoBuR3eu6bx0nTqdlw/6j
         k79uCTWTFjooDeK8iGABF+9L07k1ywiZ9N9qzrhuq5MMqcb4jzTgCLVl5B1Ez09XbhaP
         AszsxMcAhna+wb61XKNC53Edz2Pr6NniJaiduGEGIUsl4Ku5hOQ3CgJMENVkFVRpuBbS
         /NDA==
X-Gm-Message-State: AOAM532j0GteQhavdJClEomxbgVL3C+Pfxsuy7VZLA3Uqw1RHrezOwun
        D8FRgYbVB01xgBhnQCXKgRw=
X-Google-Smtp-Source: ABdhPJzmch+C8TjGkhJobxT3SCijRRO+lbKnTbN4hFrDId7YExRhhFBvl236MNUPwT6iB7iyy6i4tA==
X-Received: by 2002:a63:fb4a:: with SMTP id w10mr10560088pgj.114.1598453442846;
        Wed, 26 Aug 2020 07:50:42 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 124sm3359836pfb.19.2020.08.26.07.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:50:42 -0700 (PDT)
Date:   Wed, 26 Aug 2020 23:50:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: consider devices with of_match_table during i2c
 device probing
Message-ID: <20200826145040.GF8849@jagdpanzerIV.localdomain>
References: <20200826050851.GA1081@ninjato>
 <20200826052544.GA500@jagdpanzerIV.localdomain>
 <20200826095356.GG1891694@smile.fi.intel.com>
 <20200826095617.GH1891694@smile.fi.intel.com>
 <20200826102411.GC8849@jagdpanzerIV.localdomain>
 <20200826103807.GD8849@jagdpanzerIV.localdomain>
 <20200826105426.GJ1891694@smile.fi.intel.com>
 <20200826112326.GC1081@ninjato>
 <20200826141810.GE8849@jagdpanzerIV.localdomain>
 <20200826143450.GQ1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826143450.GQ1891694@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/26 17:34), Andy Shevchenko wrote:
> > Oh, sure, will do. Is that OK if I'll base my patch on linux-next?
> > I'm also going to test the patch on more devices here on my side.
> 
> Today's one includes above mentioned patches, I think it's okay.

Right, just noticed that as well. Thanks.

	-ss
