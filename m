Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71002C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4236B23127
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNYQG4jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEMH5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMH5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:57:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF127C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:57:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so19604926wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iYHNaCXW5xjfs5mLItCWmvqIS4ihxQJ2Bn4CeqPsH0M=;
        b=HNYQG4jI1ZonR9N0hRjeYQIx4jJh5bPkZLAC5SFCjUeLcQPlnBkPok16B3r7ijsSTv
         1m6ULiyNFPlg0FsX3HwxyvhN8Nf/ucUDTCrwQs01FAn9FPADclQZtUKgfC2ZVrSM31Ia
         fLn6C77rm+T8c9RwUZUjgZi8XNWyiQjikc4qaI+/LMZerKnQGaeDLn8C+eJMdqwFKjKk
         rgs8zPbvDzLBv0pQmTY+pqC5kAWS2WqU5iY4kW2oU+JbZWMdSPMGXUCn8fd9mLbGxoQv
         j4XtjN6+LscH4YCqCw/Wv0FNuRCmiHilik0gYb1rjJhLJmYejyx4v2vzoHB3wzGMZa0I
         UUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iYHNaCXW5xjfs5mLItCWmvqIS4ihxQJ2Bn4CeqPsH0M=;
        b=tKpdflX0Nv5yCwLL1+E05vJXn2xSuiq3sVueMHNrk5NN80JRSDggBuT7FeykOs1tIc
         iMThgK5P20tnisFKTZw7xkbqwalartLiD78auq5xFLQ7NclGBtnARtbxdpXpBZHomCPL
         W73LV3V7IuT2X0yy5YMJAhfhFxS3zaBsr0kRdU3wiKFBEPPcxWD9RKBwnQI5wQmC9eCk
         qyFpBwnP59HzHlKtQOv3nn+tlXJLOWBElk9CZ0mAw7ngB0rPCpjdEjz7JBm9b2WHufPD
         TkpjapLw0AAW8KmzsiPY8Xgzs1etLv0dBdGBRQITiaQGwmLKZoiVYM0LxbtYFf/2B99v
         i/Yw==
X-Gm-Message-State: AGi0Puaee77pERDdmWONFqddn30f4nOgdGCJ3sUS7MrNE5mosTbqBcWp
        371r3bjW1BynW2YYXUPsitGzc0Qog3c=
X-Google-Smtp-Source: APiQypKytjYXAnWxVYoUZ2gASPzYBFaN3UWDb05NVTvMTImqDvDQXkq5z+XtTNGEijCBcww4IUmgqA==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr30337488wrj.237.1589356621447;
        Wed, 13 May 2020 00:57:01 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id g6sm26294797wrw.34.2020.05.13.00.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 00:57:00 -0700 (PDT)
Date:   Wed, 13 May 2020 08:56:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mfd: htc-i2cpld: convert to use
 i2c_new_client_device()
Message-ID: <20200513075659.GC3548@dell>
References: <20200326211009.13411-1-wsa+renesas@sang-engineering.com>
 <20200326211009.13411-2-wsa+renesas@sang-engineering.com>
 <20200415110442.GK2167633@dell>
 <20200512162602.GH13516@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512162602.GH13516@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020, Wolfram Sang wrote:

> On Wed, Apr 15, 2020 at 12:04:42PM +0100, Lee Jones wrote:
> > On Thu, 26 Mar 2020, Wolfram Sang wrote:
> > 
> > > Move away from the deprecated API and return the shiny new ERRPTR where
> > > useful.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > >  drivers/mfd/htc-i2cpld.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > Applied, thanks.
> 
> Thanks! I don't see it in -next, though?

Haven't pushed for a while.  Should be there when -next is rebuilt.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
