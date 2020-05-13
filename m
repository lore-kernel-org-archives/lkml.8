Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF14CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19857205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtVbguBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbgEMKTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732842AbgEMKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:18:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E7C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:18:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so6643595plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lLoZsGIxtkk7j2CSSPpmeCKvNxSk8rWmhnaCpyOYcGw=;
        b=xtVbguBh8B5FtXizn6MSIzXDhCyv7k0rk1Y4qwDQBj3IBklzOmqenVnzcXEG4ZpQ+/
         crLdNgXyxSeMgHXb9yQfjnIwl6u0ioK0Bq/KoqUiB2bRVWPmOvm1EQd1zFVvC/s2V0Ke
         wcF7cbyY2FZWaOy99yT8RFX1TWkMnQwTppI3OOnbuPXmnndv28GBaEY7brU+tc8BhpvJ
         sI1g49t5aIrKexIVVJv2EapH5mfYqHGTQ1Itp0p2Vt/rKp5iLfU/N/l354T1sKh6uSbz
         q01l3vxyANrTRwQmU3aEWIjujPr9oDvA7Hlx2hJCmXPPBno6j53xqWrJm/h7zrHY94H+
         2V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lLoZsGIxtkk7j2CSSPpmeCKvNxSk8rWmhnaCpyOYcGw=;
        b=arPmd5GghQK4/FbVRR6IRmIYsLbAO6seUCn9OZnsjMS0HKcoXn/RcKcUX+XacTW0NP
         sL4Gv17PCFkYEwrfI/ctE1t32ilkQPQGKvRGvS1zx0bDdpKgUALmwG4e/ssyVteWKfAm
         yP5hLbat4dj3lPQJvhiGyO/HkloFdV7z4yO6Qr73uYGn70hHv+v1Fd69IeWVUwpNlXFZ
         ItGcKbjMyuKrCzN4gurU0zwIl3ulkzXYwLXmqjptVBcNN7df85Lnfth9acUJ3hkp2JJ0
         QH5/1JRoCQ5I+R8Y27HedaE3euolHqRD6AyfVCdapewg0G7SLWd2kN5C9aDXmMStQeC9
         LVSQ==
X-Gm-Message-State: AGi0Pua8ES8eGUJKUSkz6g82S2RN1S32jyIzJIT4LiRpyxnSYHjyRftM
        K14difmhuci/jP8JgUF0MrbLOA==
X-Google-Smtp-Source: APiQypJcrzuruIOsKMtnNxHm9luYlHHAVgwiZFkPh0F1nM5grzxMsIRwzyzv83Hle/OfkxoBiw8oKg==
X-Received: by 2002:a17:90b:8c4:: with SMTP id ds4mr30750303pjb.133.1589365136441;
        Wed, 13 May 2020 03:18:56 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id 1sm14060007pff.151.2020.05.13.03.18.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 03:18:55 -0700 (PDT)
Date:   Wed, 13 May 2020 15:48:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] Introduce OPP bandwidth bindings
Message-ID: <20200513101853.gedtaqxhg22jnbrp@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200513065559.wznvqc7tzvmv3ghy@vireshk-i7>
 <ea73d0e7-7428-c3cf-b44b-59427c4d6109@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea73d0e7-7428-c3cf-b44b-59427c4d6109@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-20, 13:10, Georgi Djakov wrote:
> There will be a minor conflict with my branch when this is merged upstream,
> so maybe we will need to report it or use an immutable tag/branch.

Okay, give me your branch and I will rebase over it then. Or if you
can do that over my branch, that will be better as mine is just based
of rc2.

-- 
viresh
