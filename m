Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75B0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816B4207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="tjXqKCiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgHSPS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgHSPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:18:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3534CC061343
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:18:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o21so98854wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SxMh9e6mbIAsZJ0A31frMOmg3gZvSFe2o4lw2DcDccI=;
        b=tjXqKCiWyEz1/E8V0+0SvbrgpGkhEZV+J4WcpM+FKGV2NoIR05VBQtd1AgB1xdvXaN
         QZHOMP6mpfg0121lwLJ5IGNPqHzD5LYY9cFOkTXRSLm01YQRAJQQOfkkuwhhiGg/b3Va
         TtX4ko0YbgN92D71/FgkeazzxCSklfKv5dBcTA9Ht5X1V2APTkXDdMo+EZgSySGfgt9X
         tjJG7dK0lAgV2UM+KxF0+mzftee7kaFYzWzrzeLy17UfYn7eB8XQzZSr+JSFOCajK5mF
         My7EL6gyX5sBZT258FUk4iH6kZIkR8Vb1TO+y5nYroZwU9xMNnBU6VtAZEwrztj6IbBy
         Rptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SxMh9e6mbIAsZJ0A31frMOmg3gZvSFe2o4lw2DcDccI=;
        b=Paj4DeOTHJJq2TSg3MHfaRXdfg18LniHJ5JLQvd23zBIDAYFHmd20UlRfASZxJ4PeX
         6auCDdxBaoj0DCRizViNVYN8KuUi7jn70np01m0TtGycyV6yHmjxrJ5TZ89EQ20+Kmuo
         LFp1sECTfYxuOEYIqi4O5nLYh9tKcfMH3CRD93IvAJ2JsRlMuXFHtq/odvvb9uqy5JvJ
         LP2p99FFopC9tMR/sk/UIbKIOGMalYRnZ7zoF8KiVlYmpP41bOPE6qfbZjt8CbfLuoDL
         jtN8ea6X8q9AMPTIaPjNoS0lOQpx26z2i2BIJNTW1fjJ6qO4ow1xlSl3ZqKPS8C2oIUx
         VD1A==
X-Gm-Message-State: AOAM530jlqZn3u1cUZ+kIFsSYEeTMB3GOczOyXs14CtD/aQeu88vuFAK
        rgvsCss9caqwycZEmLU60zOT7sAJwsBDI/Bx
X-Google-Smtp-Source: ABdhPJxRmTZCdsJ36j9dI46sigvM3dovKBVuhYWw2XssKMM6VAIq/F/SfEu9/L1Ww91/o5I9Q7CMLA==
X-Received: by 2002:a7b:c15a:: with SMTP id z26mr87263wmi.35.1597850296887;
        Wed, 19 Aug 2020 08:18:16 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id l11sm5674200wme.11.2020.08.19.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:18:16 -0700 (PDT)
Date:   Wed, 19 Aug 2020 17:18:15 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v2 01/13] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200819151815.GA2575@nanopsycho.orion>
References: <1597657072-3130-1-git-send-email-moshe@mellanox.com>
 <1597657072-3130-2-git-send-email-moshe@mellanox.com>
 <20200817163612.GA2627@nanopsycho>
 <3ed1115e-8b44-b398-55f2-cee94ef426fd@nvidia.com>
 <20200818171010.11e4b615@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <cd0e3d7e-4746-d26d-dd0c-eb36c9c8a10f@nvidia.com>
 <20200819124616.GA2314@nanopsycho.orion>
 <fc0d7c2f-afb5-c2e7-e44b-2ab5d21d8465@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0d7c2f-afb5-c2e7-e44b-2ab5d21d8465@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Aug 19, 2020 at 04:23:25PM CEST, moshe@nvidia.com wrote:
>
>On 8/19/2020 3:46 PM, Jiri Pirko wrote:
>> Wed, Aug 19, 2020 at 02:18:22PM CEST, moshe@nvidia.com wrote:
>> > On 8/19/2020 3:10 AM, Jakub Kicinski wrote:
>> > > On Tue, 18 Aug 2020 12:10:36 +0300 Moshe Shemesh wrote:
>> > > > On 8/17/2020 7:36 PM, Jiri Pirko wrote:
>> > > > > Mon, Aug 17, 2020 at 11:37:40AM CEST, moshe@mellanox.com wrote:
>> > > > > > Add devlink reload action to allow the user to request a specific reload
>> > > > > > action. The action parameter is optional, if not specified then devlink
>> > > > > > driver re-init action is used (backward compatible).
>> > > > > > Note that when required to do firmware activation some drivers may need
>> > > > > > to reload the driver. On the other hand some drivers may need to reset
>> > > > > Sounds reasonable. I think it would be good to indicate that though. Not
>> > > > > sure how...
>> > > > Maybe counters on the actions done ? Actually such counters can be
>> > > > useful on debug, knowing what reloads we had since driver was up.
>> > > Wouldn't we need to know all types of reset of drivers may do?
>> > 
>> > Right, we can't tell all reset types driver may have, but we can tell which
>> > reload actions were done.
>> > 
>> > > I think documenting this clearly should be sufficient.
>> > > 
>> > > A reset counter for the _requested_ reset type (fully maintained by
>> > > core), however - that may be useful. The question "why did this NIC
>> > > reset itself / why did the link just flap" comes up repeatedly.
>> > 
>> > I will add counters on which reload were done. reload_down()/up() can return
>> > which actions were actually done and devlink will show counters.
>> Why a counter? Just return what was done over netlink reply.
>
>
>Such counters can be useful for debugging, telling which reload actions were
>done on this dev from the point it was up.

Not sure why this is any different from other commands...

>
