Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE6C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D512083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNkYpc6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgD2RI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2RI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:08:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00CEC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:08:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so3397523lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2F/GGX+E0c0+b/vD1LG0X0Imv+S43d6dDOK/FkPT3g8=;
        b=jNkYpc6S0ZAt1d7I3WBLADvu8AvAoumyVfy15MqXYeffwC+o4Cob9YDhPtMZ8QWvH+
         NIwdCDYO3Ztb8zQ3NlSssEXDT66TreFG8fQZFp2Sf/GUZvt3pdbYSGtLKGnxRX+tQTcQ
         zb1kabUEdqdEgPGAX3PG8+MATiYMctEl87v0wIV8vw6cs9cJg5IaVwlKG6Zfiv5akn75
         jDsY1e2YbK6YsNoc8BmOCB3Kw7UeY8zYQ1iUdKYUGLuug2TQemrSwaCGKE4Xe4nS9V9P
         WBX0kvYhtVFlazgSsG0wd6v0mt1vwy7k9/83/pCmG6nJkn1eoGUkQmSC02Cnl2AeuK8+
         nCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F/GGX+E0c0+b/vD1LG0X0Imv+S43d6dDOK/FkPT3g8=;
        b=S+/6DUohDU5pkTrOwPMnLmsBCOfvktnLSuWpZIzR+mu4PHMz1bHsCBKskVlIq2sruQ
         VAZz+9oikQAHU1tNy6PmuPuQAFvir+4euhAW3wqmqlvdoEOQbn9NUeH9v1pD4Fta8W+0
         wFvP/TFqCuE3PPYHoyhDqJ5iLV6GiUo4o2fCs54QUicVRlBwdgrsaQrBvx4c/KvAsJ8K
         D95kbRjL3MDgVi9Iiu1pauxZcB73dv9JDaYk3aGWEX5XDaxlnWvnbrIczuiLisGM7/nn
         UCD3mHEkI7TYFoY1Raq/8zIswJYUo0kjcKLxb0dI5Is4TH3kKCUB1xvjeZgzdnA4LS64
         Kn6A==
X-Gm-Message-State: AGi0PuaZITbpohwcdRXUDtqD/i+LV6Mob79CcqyiAE7hMAhfN3GtlXOJ
        xqOhRSRILFBIhyBsu1u5VVlsl5+UNchmC+2bdjPFiA==
X-Google-Smtp-Source: APiQypI/p8hMCfeSVM1tpb+Hmphas9b6HroclmJaxP7F1hxtSeUvsqPKT++NGG1tH/H5GveF7lU55+kiTYZblxp87+I=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr20607906ljg.21.1588180106288;
 Wed, 29 Apr 2020 10:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200424114058.21199-1-benjamin.gaignard@st.com> <7657495.QyJl4BcWH5@kreacher>
In-Reply-To: <7657495.QyJl4BcWH5@kreacher>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 29 Apr 2020 19:08:14 +0200
Message-ID: <CAKfTPtBNH8x=83RVQajgK859qQGjMTyvEdP4GioMONEZp9t-NA@mail.gmail.com>
Subject: Re: [RFC 0/3] Introduce cpufreq minimum load QoS
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, hugues.fruchet@st.com,
        mchehab@kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 at 17:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, April 24, 2020 1:40:55 PM CEST Benjamin Gaignard wrote:
> > When start streaming from the sensor the CPU load could remain very low
> > because almost all the capture pipeline is done in hardware (i.e. without
> > using the CPU) and let believe to cpufreq governor that it could use lower
> > frequencies. If the governor decides to use a too low frequency that
> > becomes a problem when we need to acknowledge the interrupt during the
> > blanking time.
> > The delay to ack the interrupt and perform all the other actions before
> > the next frame is very short and doesn't allow to the cpufreq governor to
> > provide the required burst of power. That led to drop the half of the frames.
> >
> > To avoid this problem, DCMI driver informs the cpufreq governors by adding
> > a cpufreq minimum load QoS resquest.
>
> This seems to be addressing a use case that can be addressed with the help of
> utilization clamps with less power overhead.

Can't freq_qos_update_request() be also used if you don't have cgroup
enabled on your system ?

>
> Thanks!
>
>
>
