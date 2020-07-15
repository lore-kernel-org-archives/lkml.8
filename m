Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7961BC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BF12068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHTiNevZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgGOGiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgGOGiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:38:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E628C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:38:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s189so2574099pgc.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2A3+9mh7yY4DJ4BNChsPgiBj6NoPHiNP3Ku5vhAEZsI=;
        b=fHTiNevZHDxEboHxqvUWoy3orjXk5gSBI46aF/9Y4GQlLCOTFoppVfPG7rZK4m/ZK8
         PgaXGu+LY7MGwnGI3qt3tyRT24g7k9jBerVoRojW0jzwCL4bIbRPRH/w/9ePABonlfCX
         ZxfLOO/7BXPNev3nPT42007h0O8o7oBuJDJpGD7udd+a4nGteEPuCfTacEemz6Pl74ym
         Es472qxqt0y/qXxDM2IvUh/oCHlzBnYoTR8nmSZvB/9q76kbmpglBVPqz4pQRf6ddVC6
         1MaNsVeD4zz25LfnmnAmJ8r+yNaKNwPhR01Xf2qhG5PKP5FTSKnHWttmJBg1mMNkKDH7
         mRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2A3+9mh7yY4DJ4BNChsPgiBj6NoPHiNP3Ku5vhAEZsI=;
        b=XAPr3R9N42o1jOWWG41v90MNKQBZe+9o++D02grOcQod85UBzxTFe9HM45jBvyVj9o
         50FuUjsctw5n6vxhlYu3lg1xivf41fNZifGryI9FFJkNlDSJy/8akBsKWlhQS/H8HqHG
         /3cJ9sPGhgdbC892EJ9x5sF1AfS+UwZofH7FYLy6agdDuGb0HwKrHPHrOySFlLu2CWXW
         TNbyC7vUiqwdoff62otDMZBfx/NIWtTpXLkfzb6YxspyLGMDrvaYGYJKuL+Vc5k6rtwr
         nGzNs5wmn5TJt5jx1AhL7oS/3DYhvKJcP8OaTDAnfkFc6sLphMsokTBeXRDwBCZ3ySbe
         /4dA==
X-Gm-Message-State: AOAM531obfw2wZXE9YwmGJHQzyOYgoeHKbtmgeZNFeDa9N1bBi/tfVuB
        tI9VXQdHY3g90SIlIpZnMS3L2kgOACk=
X-Google-Smtp-Source: ABdhPJwiES3Dzi7xr3uSng0QWol6Q63ReF9HR9TiEoQfZiYF2zVKPRtW4D1KZgZKAe+SQhn3apRuSg==
X-Received: by 2002:a65:5b05:: with SMTP id y5mr6690468pgq.90.1594795082971;
        Tue, 14 Jul 2020 23:38:02 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id gv16sm934295pjb.5.2020.07.14.23.38.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 23:38:02 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:08:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/13] Rid W=1 warnings in CPUFreq
Message-ID: <20200715063800.4vfxie2wrmaqdnra@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200715033627.k6ardlhm3z3w65xw@vireshk-i7>
 <20200715063214.GO1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715063214.GO1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 07:32, Lee Jones wrote:
> On Wed, 15 Jul 2020, Viresh Kumar wrote:
> 
> > On 14-07-20, 15:50, Lee Jones wrote:
> > > This set is part of a larger effort attempting to clean-up W=1
> > > kernel builds, which are currently overwhelmingly riddled with
> > > niggly little warnings.
> > > 
> > > After these patches are applied, the build system no longer
> > > complains about any W=0 nor W=1 level warnings in drivers/cpufreq.
> > 
> > And you need to rebase this stuff of pm/linux-next, as there are some
> > changes in cpufreq.c there.
> 
> It's based on the latest -next.  Is pm/linux-next in -next?

Yes it is. Actually my bad, I based it on my next which didn't had
pm/linux-next :)

-- 
viresh
