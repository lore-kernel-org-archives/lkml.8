Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A71C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0731D2073E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yrL1Q/zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgHDFfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgHDFfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:35:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DF4C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 22:35:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d188so13513419pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 22:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4Y9Eca8ia7RNKi2gmFOXnwohdlzWRJ+eWTXbB9dWO8=;
        b=yrL1Q/zRLwe7IKf6kSP3Sr4pXCxAqbv09twQbWxBsnVyTJbWbGP0GkXqONM2xWof7n
         q3NWpkQzXpJkUgIj8qBPrq1DhzMg81WfDihBPK4FPpyOx6as5Wv5AEUfwaBF1LHgLsX+
         rm55fG/reILc0pf8XVKCzkyNWtbvJZxzQIOAl3180wFmCJ43xvBL5minkQx/YkbuqKgM
         Za5ns9I7sF3hzAGTpx900m3bHGu9qzaiz/YBUWIumFz+CyM09fcrFuCcH/eYSq8KTiQr
         xKnthpEmgPpJn/zg1ztIPjRK/IegjrBMKYnQK43Em3ob/3y717o+KjEVcHFIYLiQipYC
         xO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4Y9Eca8ia7RNKi2gmFOXnwohdlzWRJ+eWTXbB9dWO8=;
        b=pO0yJgs6hwx0iQRfXOKJy5pm9Z7OISg31z5GGEA3x8KWIG3ycHgP9t5j7QgTHyknYA
         O5wDE0oOm+G6UVwTZW7H8MU281d5RJ4MgsJ9UpyvGrrObOBuem5tzBTw3qdZ2A4F5T/n
         8vAPXn7o3hPl+VElB89YC6n4M8DiJ2HWulF/nyB9lRWdLqsyBJqne2kPbntOJw0F4zOA
         eJILr8moyjh2xpxjp466Vhngg941u4NJXi+qYeXviASfD7okqvYjM/ZqIOsI0kExHp4Z
         rQZpn7BPG+vU1rthMUdBb54DEPkGaAOE0bdjaWuMA5SPbJ+C/bBw3dM9r896hQzpkY/o
         25cA==
X-Gm-Message-State: AOAM531zcM6Fv1iZSjayxZ98PegI3PBj1oPsmmp+YrGWP0STvCyP65i5
        2VzEDCeqtqDJY3+Sb2//lr0DvA==
X-Google-Smtp-Source: ABdhPJyPDTsErNmZ8nQABIsOqnVB+GY6LRnVQEfOJrS3F4f0XChQp7329lc+nTrOuz/sBYFVuAtJnA==
X-Received: by 2002:a63:7d8:: with SMTP id 207mr18365180pgh.263.1596519305772;
        Mon, 03 Aug 2020 22:35:05 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id z62sm20915898pfb.47.2020.08.03.22.35.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 22:35:04 -0700 (PDT)
Date:   Tue, 4 Aug 2020 11:05:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        cristian.marussi@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200804053502.35d3x3vnb3mggtqs@vireshk-mac-ubuntu>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
 <20200730091014.GA13158@bogus>
 <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-07-20, 10:36, Lukasz Luba wrote:
> On 7/30/20 10:10 AM, Sudeep Holla wrote:
> > On Thu, Jul 30, 2020 at 02:23:33PM +0530, Viresh Kumar wrote:
> > > On 29-07-20, 16:12, Lukasz Luba wrote:
> > > > The existing CPUFreq framework does not tracks the statistics when the
> > > > 'fast switch' is used or when firmware changes the frequency independently
> > > > due to e.g. thermal reasons. However, the firmware might track the frequency
> > > > changes and expose this to the kernel.
> > > > 
> > > > This patch set aims to introduce CPUfreq statistics gathered by firmware
> > > > and retrieved by CPUFreq driver. It would require a new API functions
> > > > in the CPUFreq, which allows to poke drivers to get these stats.
> > > > 
> > > > The needed CPUFreq infrastructure is in patch 1/4, patch 2/4 extends
> > > > ARM SCMI protocol layer, patches 3/4, 4/4  modify ARM SCMI CPUFreq driver.
> > > 
> > > Are you doing this for the fast switch case or because your platform
> > > actually runs at frequencies which may be different from what cpufreq
> > > core has requested ?
> > > 
> > 
> > I think so.
> 
> For both cases, but fast switch is major and present. Thermal is not
> currently implemented in SCP FW, but might be in future.

Okay, lets simplify things a bit and merge things slowly upstream and merge only
what is required right now.

IIUC, the only concern right now is to capture stats with fast switch ? Maybe we
can do something else in that case and brainstorm a bit..

> > > I am also not sure what these tables should represent, what the
> > > cpufreq core has decided for the CPUs or the frequencies we actually
> > > run at, as these two can be very different for example if the hardware
> > > runs at frequencies which don't match exactly to what is there in the
> > > freq table. I believe these are rather to show what cpufreq and its
> > > governors are doing with the CPUs.
> > > 
> > 
> > Exactly, I raised similar point in internal discussion and asked Lukasz
> > to take up the same on the list. I assume it was always what cpufreq
> > requested rather than what was delivered. So will we break the userspace
> > ABI if we change that is the main question.
> 
> Thank you for confirmation. If that is the mechanism for tracking what
> cpufreq governors are doing with the CPUs, then is clashes with
> presented data in FW memory, because firmware is the governor.

Why is firmware the governor here ? Aren't you talking about the simple fast
switch case only ?

Over that, I think this cpufreq stats information isn't parsed by any tool right
now and tweaking it a bit won't hurt anyone (like if we start capturing things a
bit differently). So we may not want to worry about breaking userspace ABI here,
if what we are looking to do is the right thing to do.

> > > Over that I would like the userspace stats to work exactly as the way
> > > they work right now, i.e. capture all transitions from one freq to
> > > other, not just time-in-state. Also resetting of the stats from
> > > userspace for example. All allocation and printing of the data must be
> > > done from stats core, the only thing which the driver would do at the
> > > end is updating the stats structure and nothing more. Instead of
> > > reading all stats from the firmware, it will be much easier if you can
> > > just get the information from the firmware whenever there is a
> > > frequency switch and then we can update the stats the way it is done
> > > right now. And that would be simple.
> > > 
> > 
> > Good point, but notifications may not be lightweight. If that is no good,
> > alternatively, I suggested to keep these firmware stats in a separate
> > debugfs. Thoughts ?
> 
> I agree that notifications might not be lightweight.

I am not sure what notifications are we talking about here.

> Furthermore I think
> this still clashes with the assumption that cpufreq governor decisions
> are tracked in these statistics, not the firmware decision.
> 
> In this case I think we would have to create debugfs.
> Sudeep do you think these debugfs should be exposed from the protocol
> layer:
> drivers/firmware/arm_scmi/perf.c
> or maybe from the cpufreq scmi driver? I would probably be safer to have
> it in the cpufreq driver because we have scmi_handle there.

For the CPUs it would be better if we can keep things in cpufreq only, lets see
how we go about it.

-- 
viresh
