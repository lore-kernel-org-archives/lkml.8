Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F0DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABAD207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZxTQ/+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFZP32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:29:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC9C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:29:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so9882162wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0lhWmz4gkWx6AfXZ8zpsPkE0z4DNkMEgiuxjbAaFYdo=;
        b=WZxTQ/+zLaRwJGkqQg3SIO+0/JJg7pHH9uxR6UMOEHq+be4kld/3Kq9L0TyY3Jln/4
         0v3XnTPja08y7R4MBjRa0uvIbJO0dG7F5q2DKw72m4xRLltHtPqFvc/GrhDXPhO7VYxf
         HU5SMTHvX59+us2s8wjzOB0jtvpkezy5PmDIX1RB/aRv2yLlhPoyaBosXQF8mKLv03gz
         Va1jZv2EoDAOBfGq80e5pYOaG/lwiDeqiFYIyyWb/C0ZJfL2F35mP3l9ZjCz50/Th6HT
         JaTvKPeUo7Jfh9epl3o2dPBvkr9FIzd5NfufUevzn7H4VMHSBl2R5W56eEYjHyhfKldq
         gLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0lhWmz4gkWx6AfXZ8zpsPkE0z4DNkMEgiuxjbAaFYdo=;
        b=VU8X6zDzKYoU9bK0iNYWzKzkWIuX3R08KNhrlFMAIFd07jfD6qfPZ5T3qqSTdx/pCX
         Q2VFSS8w6k/elnVK482E6PW1gM38iu1MvxWE/cjX8WToacDjlr7kVK1ZlmIr8JNvkoxi
         NUIh//XP5tAK3P1WK2UFzkgn2NtofrcwdM1TjoO5DPvuzNswOOGRD0T8P2w314HVZghf
         zUBmkyZFYmxBLEiOzrJCWa47Tk6DMbE06PecvniYKtnSzFOIyhYqg8M2lCKK0orpsfCP
         VW5QXIRZiREijeQdXwz0SCmfZBQFXyyqGyks/N2dfnluJvdfIL9gl5EMaN7xjxKhbU/r
         U8cg==
X-Gm-Message-State: AOAM533NLsg5Iks2hVSPWzPIlPSvwU26LqRZFjhZjVC24oF05oad4awJ
        MoHWodvo/ZSgRMQDwFX9QbzameAaZc4=
X-Google-Smtp-Source: ABdhPJyv6ie63rzwf5Ocm/+OTK6KofcfmUsxz9QSzons/gsDHIG6xDAofWkqzEfVKmWkVSICB1/TWw==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr4322319wrw.199.1593185365761;
        Fri, 26 Jun 2020 08:29:25 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l14sm21159461wrn.18.2020.06.26.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:29:25 -0700 (PDT)
Date:   Fri, 26 Jun 2020 16:29:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 07/10] misc: mic: vop: vop_main: Remove set but unused
 variable 'ret'
Message-ID: <20200626152923.GB177734@dell>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-8-lee.jones@linaro.org>
 <CAK8P3a38P1PGHkvTDqSQC6sBoDrfipbZzxUaJeV4q4At92g_bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a38P1PGHkvTDqSQC6sBoDrfipbZzxUaJeV4q4At92g_bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020, Arnd Bergmann wrote:

> On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Hasn't been checked since its conception 2 years ago.
> >
> > Squashes W=1 warning:
> >
> >  drivers/misc/mic/vop/vop_main.c: In function ‘_vop_scan_devices’:
> >  drivers/misc/mic/vop/vop_main.c:617:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >  617 | int ret;
> >  | ^~~
> >
> > Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> > Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> This is a correct change, but I'd take it one step further and make the
> _vop_remove_device() function return 'void' if you don't mind
> respinning the patch.
> 
> Either way
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

Do you mind if I handle your request as a subsequent patch?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
