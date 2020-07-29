Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033A92074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofspQFuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG2KwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgG2KwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:52:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DB5C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:52:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so11642576plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WhFbVEYdBuWmbguHqgMJoIU8l6rj1YTSmDQVlgl0JpA=;
        b=ofspQFuYcpGb1IknybKo34xrGON+rJ2a+Ss5wVRkJ9OPvepbIMIuhzs/LXMIeXfMDt
         EX0trwU7s/GXEQkJ7R2xklmVLfb60q+XUuPMpv5CPLT490sG0EVALjs6jYlesclF9NqV
         67V5FApMLc2o81VDmiRU3ZrdBEJ5SgwY2wnzEPcv4HXSfeUYaMT6T5Pk5bvvwkAU/h8x
         fS0YwxVi2i6yZHFf1N8UvV97i37XjR1b/GjguzSeKlwe/5MKhFDnaM2iOST17Kga5rTG
         2UlH0Nst8KRLBOuaWOY7bDUfOPd0RcH3PZR8vvJ3D/R6r51Uv+MeRP5FYTgnEaoNMDPK
         +dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WhFbVEYdBuWmbguHqgMJoIU8l6rj1YTSmDQVlgl0JpA=;
        b=lsXjIXGKNxHvDzU4n/kjCmFkhdGyl8njwtRuQcdtujgvF7lVNZPg8BKfk3lOOdOiD+
         SC73tAMSLVEqwBjfj8f68tohRisbXDOnod6OoJfKNpxhUW9sZYUvUKqqip6+XgUsAVV1
         kuLsD/qyCnWImYtUpsvHOIWhkkLtVJX41krdbDobNSXSL9aAcv+adS02PNZZksGRTUAD
         Im/p6FaTKImfpwWgQefkp/tE9yvIRfdXDsbh/lLNDGVVFgSh2Ugq/HWDSiSAgascGFZF
         JKcInDi3V2kolc1iDlVwu03SoikoXJ9e4esQ1pa9TfNdg9tEycGiKT/I0WoO98FRXENX
         Sy8A==
X-Gm-Message-State: AOAM5313vl4mWKOussS3vG8WNOou+kpLscJskZIbWikuS532RA0IpHVJ
        QxinyDWKxJ8v0H+ALQk9SLGkWA==
X-Google-Smtp-Source: ABdhPJyjqfmLd1KCGeokddfjZNoodziazvSIKGkL0tJgiQ4UQSUbAz3y7DMKjTVQ1iAX4qMdhRiSEA==
X-Received: by 2002:a17:90b:4b82:: with SMTP id lr2mr4625029pjb.126.1596019921756;
        Wed, 29 Jul 2020 03:52:01 -0700 (PDT)
Received: from localhost ([182.68.37.99])
        by smtp.gmail.com with ESMTPSA id w70sm1942251pfc.98.2020.07.29.03.52.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 03:52:00 -0700 (PDT)
Date:   Wed, 29 Jul 2020 16:21:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Alex Elder <elder@ieee.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH][next] greybus: Use fallthrough
 pseudo-keyword
Message-ID: <20200729105157.6acksxuzjdno5omq@vireshk-mac-ubuntu>
References: <20200727183258.GA28571@embeddedor>
 <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-07-20, 17:37, Alex Elder wrote:
> On 7/27/20 1:32 PM, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1].
> > 
> > [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Thanks for the patch.  It looks good, but it raises
> another question I'd like discussion on.
> 
> It seems that Johan likes default (or final) cases in
> switch statements without a "break" statement.  Viresh
> and Bryan appear to be fond of this too.
> 
> It's pedantic, but I don't like that.  Am I wrong?
>   --> Johan/Viresh/Bryan would you please comment?

I am not fond of them as they aren't required for the working of the code. It is
a bit like using an empty return statement for a routine with void return type,
though it surely adds some consistency to the switch case.

But if people really feel it must be there, then its fine :)

-- 
viresh
