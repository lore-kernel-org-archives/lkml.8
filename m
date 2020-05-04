Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3542206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJLldmur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEDVBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDVBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:01:41 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D469C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 14:01:41 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id b17so50045ooa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4pnmV0c/dm6Nv8LiySYrkrUFrQxVYIQ8/fCCGBj3ME=;
        b=AJLldmurbaUk/dT5pTvnHr95+OCQHt8f2LcbXyVAtrwxSiXNAzm/jbddivJGTssLQK
         1CopvPy2PBNrN2MIEP9sJyGs9DhZd7NSglwd3cUDtonBbYbNf6Cx9fs1i2T+K3MshLnr
         fO9qR2ggQeHF3HcC8d+KrQw5iAdjwrhmmT0evp7/yK4mblrSLMKtc8lmeFNVod55ZDF6
         pjmsMyEwp2j1uxlQi9F+zAc82hDhVdiOEZ33hyLBFnsvigf1y/3sFQLEUV942RU27/ut
         Y2ps/n2H8WX8Y5opXM7774yj2JltOgc2e5KX6oy/67ZHDS5uj/pY3ifn37hO8btg1gtq
         vZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4pnmV0c/dm6Nv8LiySYrkrUFrQxVYIQ8/fCCGBj3ME=;
        b=FZdwI5N05dpzYcgO620sJ+PRm3gGm7UsWYBJ0kCxsmcaxBDn1fpS9Y+9IU4mkqrPdl
         eFSJs08bK7iZLd2yL/3ENlw2AubluGPnnqwnUGgfJD46+HHsOAqihI6TiCKO9hSXSJRf
         /gfJWMvXhNwiQlC+rWhZOPWz0hWmByiFnhXekbBDl1B5hLLVjbELYuS2pjDNKx2tOUaq
         9RyMUpwczFbjBYkR9AK3HGiX93IXq6tUJYD4NmeYo3JdvaATq6oIu/w1lDu34wxs3o6Z
         EcD6u/6S39MZsZ+0P5IsMv0G/t38+QJ9Z6Rs28jfgXQSmhQhrGip8pBIgpVFfxaXGjP0
         5dfg==
X-Gm-Message-State: AGi0PuayftGKXUR5hYltSa4coxmAK0Q/uU3MuK3JUVT1TFcTCj0YBkGI
        ZgpKuMcZYQQ8nvKI9qsh5pJo8iUU7AkEMHRa4uzw7g==
X-Google-Smtp-Source: APiQypK8oYJDyP3ObhEIT9SEbws2SoO9/BbsHEmShslZHU9S0WEjfLstz3778FPKfSFcRZWKchUAR+aJlvTfZ7Y/mZo=
X-Received: by 2002:a4a:ca9a:: with SMTP id x26mr194777ooq.84.1588626098771;
 Mon, 04 May 2020 14:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org> <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7> <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
 <20200430075356.rjtctfuenirvhxgn@vireshk-i7> <CAGETcx-W5XjNtgjDz2Ma_miN=cUBb5LFfhzYtKRpf6iAi4bXNw@mail.gmail.com>
 <20200504050017.nsd7fp7gtxxwt3d7@vireshk-i7>
In-Reply-To: <20200504050017.nsd7fp7gtxxwt3d7@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 4 May 2020 14:01:02 -0700
Message-ID: <CAGETcx_3ZrTigJ+CxJFA+N1xZaG9Vg6m0egew+kb-h4jSMsk2Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 10:00 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-04-20, 09:32, Saravana Kannan wrote:
> > You are missing the point. This is not about aggregation. This is
> > about OPP voting for bandwidth on a path when the vote can/should be
> > 0.
> >
> > I'll give another example. Say one of the interconnect paths needs to
> > be voted only when a particular use case is running. Say, the GPU
> > needs to vote for bandwidth to L3 only when it's running in cache
> > coherent mode. But it always needs to vote for bandwidth to DDR. With
> > the way it's written now, OPP is going to force vote a non-zero
> > bandwidth to L3 even when it can be zero. Wasting power for no good
> > reason.
> >
> > Just let the drivers/device get the bandwidth values from OPP without
> > forcing them to vote for the bandwidth when they don't need to. Just
> > because they decide to use OPP to set their clock doesn't mean they
> > should lose to ability to control their bandwidth in a more
> > intelligent fashion.
>
> They shouldn't use opp_set_rate() in such a scenario. Why should they?
>
> opp_set_rate() was introduced to take care of only the simple cases
> and the complex ones are left for the drivers to handle. For example,
> they take care of programming multiple regulators (in case of TI), as
> OPP core can't know the order in which regulators need to be
> programmed. But for the simple cases, opp core can program everything
> the way it is presented in DT.

Fair enough. But don't "voltage corner" based devices NEED to use OPP
framework to set their frequencies?

Because, if voltage corners are only handled through OPP framework,
then any device that uses voltage corners doesn't get to pick and
choose when to vote for what path. Also, maybe a one liner helper
function to enable BW voting using OPP framework by default might be
another option. Something like:
dev_pm_opp_enable_bw_voting(struct device *dev)?

If devices with voltage corners can still do their own
frequency/voltage corner control without having to use OPP framework,
then I agree with your point above.

-Saravana
