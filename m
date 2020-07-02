Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87D5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C289207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsFN61eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGBSmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:42:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDEDC08C5C1;
        Thu,  2 Jul 2020 11:42:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g17so11638652plq.12;
        Thu, 02 Jul 2020 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tbX9gnwNkjOzk/98d8BFqWlU3Yk39GHs2cPsD7jbrXM=;
        b=JsFN61eCI+fVmsDGKjx3xNcUB9PTWSDRaIF3nEA7cb13QIkZmIqYDssIQvKF2ony9w
         Bc/I8YIpo/DNOqg01APimdwuBKsysstKm3eNWmiCC3L/WkvKtEItiHdW/NHiV9JLIy2p
         HHTSap5HMi/MV+wih89HXnkggCyyyijeIt1gDdczQXVBEUvk5m8LIl6T18qw1O504bYW
         FNnUrxwdVjGvbXXZTLejVs98ZvwYFj8GJ/b87XNnMV+MkQ6DuZtq5a6uUyTj4NWjs7G1
         JUrHAvMaz6Hoel+1vWArGEnqsSgZTzcuLoyH6nNKRM2GUj/N382/u5XK3EnAfr8XtJJE
         FMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbX9gnwNkjOzk/98d8BFqWlU3Yk39GHs2cPsD7jbrXM=;
        b=eWVyLVa9d5da4bvd0ygclpMrKmOFLQFCj1IjJMFsJrGVF9CpfIGUn3RTpxnv0AKoNN
         zS4dRjm7akm9Jzu3AsmqBWorI2RA00LUIaErDAmkrpGel88Q1dIjzv+BdXC4GcZHL9o6
         mJpO3QwYhFP7sZRliBiJLl26fLELDQLKXHQu5yMAaTYC25FgyI/lVWVA2L5icU/hJEkn
         WdpCK/V9fYRGrlqgtfn/PVqz9yf9TMhPsabZ8I2yNLB0RmYbc4PnlkucHkhuaiZzuU4N
         1pX6CY7DvZh1aPl7Ni8ZuvEvsqpJ8pN5niFB6i2nM4plZuU0odcY+/hr6SsF2RWJ5ToP
         WJBg==
X-Gm-Message-State: AOAM531hnmqVf+CvrGXOwnkcC8eC5uGScO68jv5dnqBUI1j1VDHXMQyu
        yWJIClWUrTlDw4USXrs6m9A=
X-Google-Smtp-Source: ABdhPJzmKId/+K9zaOkh/BstpizWZM6xvVYuyR3syVZrxtWMXg/kTWp1q3xysYJLElQ8cgvSAK8/BA==
X-Received: by 2002:a17:90a:290e:: with SMTP id g14mr30210537pjd.85.1593715354041;
        Thu, 02 Jul 2020 11:42:34 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y7sm8819228pjy.21.2020.07.02.11.42.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 11:42:33 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:42:26 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200702184226.GA23935@Asurada-Nvidia>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On Thu, Jul 02, 2020 at 04:22:31PM +0200, Arnaud Ferraris wrote:
> The current ASRC driver hardcodes the input and output clocks used for
> sample rate conversions. In order to allow greater flexibility and to
> cover more use cases, it would be preferable to select the clocks using
> device-tree properties.

We recent just merged a new change that auto-selecting internal
clocks based on sample rates as the first option -- ideal ratio
mode is the fallback mode now. Please refer to:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20200702&id=d0250cf4f2abfbea64ed247230f08f5ae23979f0

Having a quick review at your changes, I think the DT part may
not be necessary as it's more likely a software configuration.
I personally like the new auto-selecting solution more.

> This series also fix register configuration and clock assignment so
> conversion can be conducted effectively in both directions with a good
> quality.

If there's any further change that you feel you can improve on
the top of mentioned change after rebasing, I'd like to review.

Thanks
Nic
