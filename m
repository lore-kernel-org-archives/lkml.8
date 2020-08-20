Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D7320885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHhcoDKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgHTUz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgHTUzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:55:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F456C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:55:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so1516169pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6TwpGd/r4Mn7ElBnoIBBXdYs8NqZlyvUTn+/6xljtGs=;
        b=CHhcoDKt92P1iuNMF43slopBF975xWzQO8yW5YBGHg/9KvAqPC6nDIlGAI6P/26qwM
         luvU2EGK0XbYmRxl62bkFdq1CAkHI4F/txV5fLisV4kHNY329v1Ne802gQs1YUIqH029
         x1cqhd0YCIykAPQ2zUZMLY9MjppCRF+tACTSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6TwpGd/r4Mn7ElBnoIBBXdYs8NqZlyvUTn+/6xljtGs=;
        b=FjFsnrRlN7PlXKfnQcfM/4/sM6zvc4GxDhsh0plF3Kj4sXo0FVcWwtYzPplMiRyz/y
         K3C0yFc8X6rTi47uq6zt69ShFGqpPgVP6lZHlr9yqdq4v8oq5n7zwMCCMbpGuq3kslSs
         X7QbQs5M0RwCRJxb7llokjV3ULoVPaUeUkBD0XOin532z4Cae70/uGtZ3U67D9gqNmG4
         2U+2O9940HUnwZ29rltIT6bDUsdWTLP0RQpNQEQymmVIzPIN9HFXHq1yVVU1S3QVShbV
         7rqCFOB+Kgq5QAMohN0dwQbgCerYAnQugpW4BHxNJ/TWA8GWXgXnkqvkqPLLIX8eN6xq
         OaRQ==
X-Gm-Message-State: AOAM532WUwVt2BclNNa+zNXgsQuXeDYprlnoDqBhJCGnPAGk4IC5qY9l
        Q6rH8GLIVgwmW1tXJI3CSZXBLQ==
X-Google-Smtp-Source: ABdhPJyvxjAB9vUUKZhW2l/MVLX392ebZRXBxMpnl3mO9WmQLI2Sqvs5yNtSbNoNJMbsb4I73E8ZsQ==
X-Received: by 2002:a17:90b:8c5:: with SMTP id ds5mr103938pjb.110.1597956918710;
        Thu, 20 Aug 2020 13:55:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a17sm3470764pgi.26.2020.08.20.13.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 13:55:17 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:55:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
Message-ID: <202008201353.F342E59EC@keescook>
References: <20200806004631.8102-1-scott.branden@broadcom.com>
 <20200806004631.8102-2-scott.branden@broadcom.com>
 <20200818135313.GB495837@kroah.com>
 <8894c3c4-4d5c-cb94-bc90-a26833ebf268@broadcom.com>
 <20200818174451.GA749919@kroah.com>
 <4adbd70e-c49b-c2d4-84c7-5e910f05e449@broadcom.com>
 <20200819070044.GA1004396@kroah.com>
 <fdbb7404-03c3-22b1-d409-5b6d8745ff2b@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdbb7404-03c3-22b1-d409-5b6d8745ff2b@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:37:46AM -0700, Scott Branden wrote:
> On 2020-08-19 12:00 a.m., Greg Kroah-Hartman wrote:
> > On Tue, Aug 18, 2020 at 05:35:04PM -0700, Scott Branden wrote:
> >>
> >> On 2020-08-18 10:44 a.m., Greg Kroah-Hartman wrote:
> >>> On Tue, Aug 18, 2020 at 10:23:42AM -0700, Scott Branden wrote:
> >>>>>> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
> >>>>> <snip>
> >>>>>
> >>>>> I thought BIT() was not allowed in uapi .h files, this really works
> >>>>> properly???
> >>>> I did some investigation and it looks like a few other header files in include/uapi also use the BIT() macro:
> >>>> include/uapi/misc/uacce/uacce.h
> >>>> include/uapi/linux/psci.h
> >>>> include/uapi/linux/v4l2-subdev.h
> >>> Does the header install test target now fail for these?
> >> I do not understand the question above.  make headers_install works.
> >> But I guess the above headers would have similar issue with the BIT macro.
> > Try enabling CONFIG_UAPI_HEADER_TEST and see what happens :)
> I enabled CONFIG_UAPI_HEADER_TEST and then
> built using "make" and "make headers_install".
> 
> There didn't appear to be any issue with the BIT macro in the headers.

FWIW, other subsystems have not been so lucky:

https://git.kernel.org/linus/23b2c96fad21886c53f5e1a4ffedd45ddd2e85ba

It may just be better to avoid BIT(), even if it works "by accident"(?)
for some header combinations...

-- 
Kees Cook
