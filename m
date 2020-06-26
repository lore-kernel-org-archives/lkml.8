Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F21AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA1120775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVnXs4rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgFZGwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFZGwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:52:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF99FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:52:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w17so6519782oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qJtsXy9mC7/pKufhaTGbW2CZ1AND1qbdt8LzPm3EIxc=;
        b=mVnXs4rbx32mrZ58JwyusqJBL8hVhLWh3C9yj1jRzRzxVaNW1McdfWGbAhKv4F3fS3
         DGpP/fzLra1c6Kawy1Yto3jRmWoYBx6MHyBdmDjMc7toZCqv164CRl5zofPi94D7di4x
         IfVCXxjQY/DZLr+Omi2O0gs4koAH19uWK4Rtsr9Q9NN4WkIAdVFhrCOQPaxWzLcwVz9J
         +Azwa6IO7JD+HkQy8gUWkvN/Z3bP/Kq1mK3+aFUeW7UsZYHolrAlm/eOBRoPfnDxz0Nx
         aYSNsr2jAQcg/mr3fIRSsbz2OjtUkkjAzELELANVCBQriyF5HAWpeNjzKhI1NL7MGJ7g
         Gphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJtsXy9mC7/pKufhaTGbW2CZ1AND1qbdt8LzPm3EIxc=;
        b=Zu6QpeURySIKW0rILZCZmEu9k6TnotwFsDZWHY/O2KfdF8MpEHIoCUkCrRj/pu4rhA
         /i0oQ7SqNqO7iq1i2LFDYXjnfiHxl4/M8WtT9sTOvUw0tHVcmyEotQSQq+60y0eak1qy
         Km0M72A/tvi1pxj/lM2oGP8Jdn4T3f2fEb1QJHhh70Hr5tOPOz59VR8PYp6/boAA/dqA
         i0QRue/zau9uZox4btPRoyhHrZ6CdJnHkNkx3kYLbB5fTFad5LAJyjlpPYnjfjPoLqyh
         Pk6vVOIfD98ZAN/vCqjv0AKzqmN3W10gonwQy2fQhA4wTvFG1op5S1mrRa0dlJCAOLCY
         MV7w==
X-Gm-Message-State: AOAM533alaIFyOa58e8CSBhS67lfXnwQecHuRtAB59jIQZgjWQfFwUDP
        F2nnug3BTQZZSgg9cAuuthuu7zpA
X-Google-Smtp-Source: ABdhPJxD15PAIhnBKqsF0nzE0/qkDsIu1lskyuFRQ2abUGILSTrz+eD/j9/UbLV6tCp8RdllD1bipQ==
X-Received: by 2002:a05:6808:aa2:: with SMTP id r2mr1115333oij.162.1593154370316;
        Thu, 25 Jun 2020 23:52:50 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id c1sm6099493otn.81.2020.06.25.23.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:52:49 -0700 (PDT)
Date:   Thu, 25 Jun 2020 23:52:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>,
        Tomer Maimon <tmaimon77@gmail.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: drivers/char/hw_random/npcm-rng.c:166:34: warning: unused
 variable 'rng_dt_id'
Message-ID: <20200626065247.GA2956367@ubuntu-n2-xlarge-x86>
References: <202006232136.vz36SNV9%lkp@intel.com>
 <20200626064225.GA6023@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626064225.GA6023@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 04:42:25PM +1000, Herbert Xu wrote:
> On Tue, Jun 23, 2020 at 09:58:39PM +0800, kernel test robot wrote:
> >
> > >> drivers/char/hw_random/npcm-rng.c:166:34: warning: unused variable 'rng_dt_id' [-Wunused-const-variable]
> >    static const struct of_device_id rng_dt_id[] = {
> >                                     ^
> >    1 warning generated.
> 
> The kernel is supposed to be built with -Wno-unused-const-variable,
> so I guess this is a deficiency in clang.
> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 

No deficiency in clang, it's a W=1 build, which explicitly enables
-Wunused-const-variable per scripts/Kbuild.extrawarn. The 0day team
decided to enable W=1 for all build tests, hence the comment in the
reproduce notes. A thread with discussion:

https://lore.kernel.org/lkml/202005200123.gFjGzJEH%25lkp@intel.com/

Cheers,
Nathan
