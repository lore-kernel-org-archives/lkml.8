Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2902C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B835207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xuJ+Uuw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2G1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2G1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:27:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B49C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:27:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 131so766994pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8/ekMaS9IDMDDdO/sPjkKucuBStRVoSIxnyYCbHSwBw=;
        b=xuJ+Uuw9Ef07VpZZJck5BRrLLjK9JUuGHxlAQMLSxIjTqkhmVP7njEqLYb1QUHUbI6
         YeEoXUANw66Q1BMpHw3jD8+2VxIExgI3p03OEXFYYA5WI8lnezYaIC/HTyYi/aIF6IpF
         v/2v6nXdZ1Zuop9oOlIYtDz9JgyMLMOVhriSUoUO7iXgec7rsfGmv7p8bZjAeMeUn8cw
         dgz2ICNWSF+IQbpcF7XUQnVZWOV67wajBxaa7A/i0zH7Byx2+pEjLTMgTGHO/PU7Qq8t
         ZPSw3dfacj5WgyYRIVbn1O0AewUkjv7yJppEBRyvy2zOowjlnbwGymhMCkBBtb+tQmCH
         dYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8/ekMaS9IDMDDdO/sPjkKucuBStRVoSIxnyYCbHSwBw=;
        b=IMwz603HiH9XnAkxyU5EqE11cUsiz2PPLmuGxarKR7VbM35J8XgQ8eS/AJu1+CwArN
         Tuv5qXQyEEO8VB8r982Uq7uizoeZl5jULN2MNh6SxtbykGgxYSDTJExMc/FmUmFpBg6e
         FWvslwru4aROCpKbk0P/ei6iCksCF0wbUs0k5T/ZruMBKES5QFHDXhiUuWKz83lYj1cM
         PeO3y2U7amOuoeD7kyh+YkrMtNh5czeAuDWZDX0AZAiO6TAaRocZYawI2QI3IMdBpRBd
         t/y8eDfHhg/G59hmksaoP1pXyH3vsELPJTdhAisaob4MbP7hZetqmQdDVTkBJxI7mYm8
         skpw==
X-Gm-Message-State: AOAM5306aOCtNLdifrP7xnd89Oc6PqlWzxil5/b3+8y0HFcRSI+fyDmi
        1+9FMa3tWJMgdqgZ3l38lwyHZQ==
X-Google-Smtp-Source: ABdhPJxam8QRdVRuBgKKTLUtj/XnW3H2lWM3XSsyQFA/l5gFf4bV/xqthW3fpc0DOB/QJ02i9EnAew==
X-Received: by 2002:a63:d318:: with SMTP id b24mr6284198pgg.403.1590733632609;
        Thu, 28 May 2020 23:27:12 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id g27sm6532578pfr.51.2020.05.28.23.27.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 23:27:11 -0700 (PDT)
Date:   Fri, 29 May 2020 11:57:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200529062709.tjmlguu5ovhk4t7o@vireshk-i7>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus>
 <CABb+yY3KKpDHTsTBescW_rXmqmLzJh-Ogaotk2n=nYRkfHy2cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY3KKpDHTsTBescW_rXmqmLzJh-Ogaotk2n=nYRkfHy2cg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-20, 00:20, Jassi Brar wrote:
> The fact that all these bits are backed by one physical signal makes

I believe that within the IP itself, there must be 32 signals, just
that only one comes out of it all OR'd together. Maybe that can be
verified by writing 0x01 to it multiple times and it should generate
the interrupt only once on the first instance. i.e. writing 1 to any
big again won't raise the interrupt.

> the firmware implement its own mux-demux'ing scheme.

Similar to how the interrupt controllers do it in the kernel, they
receive a single interrupt and then go check its registers/bits to see
which peripheral raised it.

> So the choice was
> between demux and single signal at a time.

Well, the demux is on the firmware side and the kernel may not need to
worry about that, let the platform do it ?

> Had there been one signal
> per bit, the implementation would have definitely been 'efficient'.

I will say 'More efficient', it will still be 'efficient' if we
implement doorbell.

> And the first platform the driver was developed on, required message
> passing over the registers.

I think it was correctly done at that point of time. No doubt about
that.

> So now my approach is to make do with what
> we have...unless it shows in numbers.

ARM's office is closed (lock-down) and he doesn't have remote access
to the board and so was unable to do it until now.

Numbers or no numbers, I don't think there is a question here about
what is the most efficient way of doing it. Doing it in parallel (when
the hardware allows) is surely going to be more efficient. Sending a
signal, getting it processed by the firmware, doing something with it
and then sending an Ack and that being received by kernel will take
time. Why make a queue on the kernel side when we don't have to. :)

> Anyways, if it comes to that, I'd rather a separate "doorbell' driver
> than a driver working in two s/w modes.

I think that would be fine with everyone, if you are fine with that
now (based on plain logic and no numbers), maybe we can get that done
now?

-- 
viresh
