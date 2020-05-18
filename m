Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7987AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D98420715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpk1EG3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgERSlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgERSlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:41:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B25C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:41:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u35so5242304pgk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BbV/LEIOeouRXOmK+GKN6o5kBO4anE2Qst31rAC/h8s=;
        b=wpk1EG3wH9AfuuSAZTKJ+/n0Q9IjxGLodBjTu4ynOAG7Oao8ePt7F7SjaPQi9rYFBW
         vTCGn5jpPiGn8sP5TKR4fBIzl8X9fsFTOYKFPTb5F3AHf4SMLBDa30kiGOOx9gMf0vy1
         aCFLjZgohKiam+RjD+RPJxjAMEV3Movg6BLoGWxnmo9SwsN7aYuVgFyq3fhx2D23ln2S
         YfMxuQDebgG45W/1YRp1agw9YqdJ9v0+swjux9ma+c/ER6RwDShQ18qxv2t9S/AHctoO
         lxbR3qnHIIx8VG8ImM0hPjjD/EYgZ8jlOYCuvhtqOm3rlT2aF+H9ymdN8ob3LH3KMKPa
         NDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BbV/LEIOeouRXOmK+GKN6o5kBO4anE2Qst31rAC/h8s=;
        b=lgsx4gLj/wdG/0b0OjT51cD/1u9Wvr5H7pwRTLrRALOVdEmDY0NXCe2jeSRZlssbTx
         hguODWN7DvbnP7/nQ9qX0SFwohV+5PPm8garidhpbuAAh6mdg+6N6a6DWiezDDgUX9uR
         mzJMzjNr4+4FFXon03kUHIs27EDSuHFKx4ftj4CWu9KSqzy0eq3EX1FDuoBmQXO9uBPx
         JeJ4fH71LT014G0cQeUk460XnLLLVqVRGJgLi7w1fqtU8Rq+DNG15UnYVQbxJHNy+DaR
         Mwz6ROAOTZ9LjBYjKrycsfdt2lvOMaUXccvjlmPb0pkqxyomU14J9CoMl0xzBe7PMJJ/
         JXTw==
X-Gm-Message-State: AOAM533A/aGeAftSxeqNjqh2FsvNE0EqJoD7KCca6zV9pRgEMdejYAVo
        UJI+QhWCOr1sJWevlZiHMVutgw==
X-Google-Smtp-Source: ABdhPJz0TbunwEJ3QS58Piw9hJtSVbZ5pMCjwwHgcI7aZsqjDXKf1WlgVOn75F7erOVKbayPWGlQIA==
X-Received: by 2002:a63:f64d:: with SMTP id u13mr15918251pgj.151.1589827294403;
        Mon, 18 May 2020 11:41:34 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x62sm9251663pfc.46.2020.05.18.11.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:41:33 -0700 (PDT)
Date:   Mon, 18 May 2020 11:40:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as
 a module
Message-ID: <20200518184010.GF2165@builder.lan>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
 <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
 <20200515071152.GA1274556@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515071152.GA1274556@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 May 00:11 PDT 2020, Greg Kroah-Hartman wrote:

> On Fri, May 15, 2020 at 07:48:47AM +0300, Georgi Djakov wrote:
> > On 9/12/19 19:33, Bjorn Andersson wrote:
> > > On Thu, Aug 29, 2019 at 1:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >>
> > >> Building individual drivers as modules is fine but allowing a core
> > >> framework to be built as a module makes it really complex and should be
> > >> avoided.
> > >>
> > >> Whatever uses the interconnect core APIs must also be built as a module
> > >> if interconnect core is built as module, else we will see compilation
> > >> failures.
> > >>
> > >> If another core framework (like cpufreq, clk, etc), that can't be built
> > >> as module, needs to use interconnect APIs then we will start seeing
> > >> compilation failures with allmodconfig configurations as the symbols
> > >> (like of_icc_get()) used in other frameworks will not be available in
> > >> the built-in image.
> > >>
> > >> Disallow the interconnect core to be built as a module to avoid all
> > >> these issues.
> > 
> > Hi Greg,
> > 
> > We had a discussion [1] a few months back about frameworks being built as
> > modules. IIUC, you initially expressed some doubts about this patch, so i
> > wanted to check with you again on this.
> > 
> > While i think that the possibility for a framework core to be a module is a
> > nice feature, and we should try to be as modular as possible, it seems that
> > handling dependencies between the different core frameworks becomes difficult
> > when one of them is tristate.
> > 
> > This of course affects the drivers which use it (every client should express
> > the dependency in Kconfig as a "depends on framework || !framework"), in order
> > to avoid build failures in the case when framework=m and client=y. However, this
> > is not a big issue.
> > 
> > But it gets more complex when another framework2 becomes a client of the modular
> > framework and especially when framework2 is "select"-ed in Kconfig by it's
> > users. When selects are used in Kconfig, it forces the option, without ever
> > visiting the dependencies. I am not sure what we should do in this case, maybe
> > we can continue and sprinkle more "depends on framework || !framework" also for
> > every single user which selects framework2.. But i believe that this is very
> > inconvenient.
> > 
> > Well, the above is not impossible, but other frameworks (regulator, clk, reset,
> > pinctrl, etc.) are solving this problem by just being bool, instead of tristate.
> > This makes life much easier for everyone. So i am wondering if it wouldn't be
> > more appropriate to use the same approach here too?
> 
> Ok, if it makes things easier, perhaps this is the best way to handle
> it.
> 

It most certainly does.

With INTERCONNECT as a bool we can handle its absence with stub
functions - like every other framework does. But as a tristate then
every driver with a call to the interconnect api needs an entry in
Kconfig to ensure the client driver must be a module if the interconnect
framework is.

Regards,
Bjorn
