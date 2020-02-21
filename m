Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F0C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FFB24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ipb0gqKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgBUO6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:58:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44501 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgBUO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:58:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so2385263wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oEykVJQOde/kw8FuzYyK6TbVeNPZu6MWcUJ10Pto0IA=;
        b=ipb0gqKpnH8eZQgist6/WhFHScfIIDaUKF+YlbE6HPBeFQIemlkloXs81cSL1ZN4iZ
         mTkfja6gIWCuppriqnMHuyB1am2J5DJYqQlrQ1HcbraCInK3TJESZy+li98cpiIEKEbP
         3Urd/YdG2Xo4GXDBzarxrAO+CgdH44P3OeR2Ff8gfoGNyJLRPZKeC9J39b41W1GJ9uWk
         18JrOBUtIvKTSGblB/mw1Bylv5ErmL/bxLhSrf/Gz2BXKca9J1xPWNFtivCbmdMWUIQa
         GhPNOirMvH/3Y5kPYR2jHURDfNOSD70w79VpYYODoogSQAGDhzrHoFKgeyu9jtA33sBK
         aZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oEykVJQOde/kw8FuzYyK6TbVeNPZu6MWcUJ10Pto0IA=;
        b=XOuJDYB7zP202JdaJpsvO2Ii8zFeMdCZ1ipJYVmqv7wB/Kl5m9sUtvsewIA/jnLjki
         q4lcKzIiuO0OqtULT0129/E1JrqjtgJYCmBxgmmTQzxviThQvFgfPps/sLdfMweiz15G
         GZxP4tZTF21q29RkaxvxE9+ptC3cZHpvIpzFJ5HfXVivAuWAGO3ZNXUhFyi+aigkTLqZ
         lsPykxUZNuN7zNVDw4tJ2oi2j9N01osePVfnUX5t1+0yoKMWNHEQqtwnOINaxJ08aSac
         ln5EPShHvA2DZWpxr+i/4oRU1FRs9sLt3dl0yJU6LIBYaL1y6Bd9TdxSJ/nA6YfDFjWR
         uuNg==
X-Gm-Message-State: APjAAAXjJPydIt+QRjYlbX5c593fIrFxOi/ypMwfNv4lwqbtTnLPqZ3m
        8KSIiFOUqRHauMsikaTNNd4DMA==
X-Google-Smtp-Source: APXvYqw5xErxKhMBv5gx7PiJTT4buaJCBAgeciEkFL3HX/fDBfWZq5ZsZ5zArg6gc4dn9bxvuaNzFQ==
X-Received: by 2002:adf:b352:: with SMTP id k18mr48018831wrd.242.1582297130530;
        Fri, 21 Feb 2020 06:58:50 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id b21sm4153587wmd.37.2020.02.21.06.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 06:58:49 -0800 (PST)
Date:   Fri, 21 Feb 2020 15:58:47 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/17] ARM: tegra: Remove pen-locking from
 cpuidle-tegra20
Message-ID: <20200221145847.GH10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212235134.12638-4-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:20AM +0300, Dmitry Osipenko wrote:
> Pen-locking is meant to block CPU0 if CPU1 wakes up during of entering
> into LP2 because of some interrupt firing up, preventing unnecessary LP2
> enter that will be resumed immediately. Apparently this case doesn't
> happen often in practice, I checked how often it takes place and found
> that after ~20 hours of browsing web, managing email, watching videos and
> idling (15+ hours) there is only a dozen of early LP2 entering abortions
> and they all happened while device was idling. Thus let's remove the
> pen-locking and make LP2 entering uninterruptible, simplifying code quite
> a lot. This will also become very handy for the upcoming unified cpuidle
> driver, allowing to have a common LP2 code-path across of different
> hardware generations.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
