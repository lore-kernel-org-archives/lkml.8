Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3630C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865A0207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="TX+hzzw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHSSzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:55:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:55:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so22514785wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ooMhFUs9RFhswhrwBkRtQX2o8ZbiuA0ZfSr1gShQi2Q=;
        b=TX+hzzw73D70v1zibyNZazPeJ9ek6hmB8R8NSrhcQoCsyGihMKlNkLYi/p8HHcsP5c
         mVo5+ZJbc1ovI8/cPwyp4Vjz4CxsW+oX1zTf8QchcKsNAOwL+sEx5yQWbBLeghwfJCle
         Wkg5vrD01Xy4SIl6gHkVt0z1pNAkZHY77Yn5k8QbW7C69vlHls42Dy6sPTBQlO4lQQ0e
         rSPhxlyNAL/9D7eqbaGX+k4H+U2CViB77Cj6WyI4Ev1S9cGBGCXkKimNslmC5K6P/env
         XlOMu4LXPpqLzipkAo66pFGSL87UxW1Kbprjz0XZGXFkD5k7+pOFxEluJF/wnTToyp7d
         VWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ooMhFUs9RFhswhrwBkRtQX2o8ZbiuA0ZfSr1gShQi2Q=;
        b=XYG257ZVxCflYMLK4HFxfDchweNFODKIYKJM6xZSiH9ArGSh6szcnr8TwYRJdbSARc
         h2mgo3IWvyrmxKHQdyEujWIssOcYyGQTqAp4Jj0shaMKAVOEHimQq1PEmGeSrYJf6jzK
         su7/ydHiu8NXm3DSQKQGMLgzRcz/V/B8cib32xEyrPvu82KiZdNmY0G8iKU7Q2MJzJFa
         FplGx2tCfyZbbotwxhPrx6ZsVHD3FECjtTJfuc3ukKt/xNWvQyGU80Bh2hY1N/BCGtvI
         /hQJanl0hu0JHC7WJO5Au7lcZxURDu4AsC1ayCa89eHASjUWUaOSCEJPZd7H7PPEMKmN
         NWtg==
X-Gm-Message-State: AOAM530Sm6LKYtfeGENkl/EmFDg1J9gZ9p3f7K7y9V5rjnDnp1UnNpRP
        WbUEfPMEziAobL5JE/bvNEvPzw==
X-Google-Smtp-Source: ABdhPJx0Yv5S6txvI494QVf7VePMx3q8R6FTlG8yfzQhyZhSzunlCykNh+fbCmNLbxVhietRztfrow==
X-Received: by 2002:adf:a4d7:: with SMTP id h23mr5851348wrb.276.1597863305805;
        Wed, 19 Aug 2020 11:55:05 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id w10sm7599043wmk.0.2020.08.19.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:55:05 -0700 (PDT)
Date:   Wed, 19 Aug 2020 20:55:04 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Moshe Shemesh <moshe@nvidia.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v2 01/13] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200819185504.GB2575@nanopsycho.orion>
References: <1597657072-3130-1-git-send-email-moshe@mellanox.com>
 <1597657072-3130-2-git-send-email-moshe@mellanox.com>
 <20200817163612.GA2627@nanopsycho>
 <3ed1115e-8b44-b398-55f2-cee94ef426fd@nvidia.com>
 <20200818171010.11e4b615@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <cd0e3d7e-4746-d26d-dd0c-eb36c9c8a10f@nvidia.com>
 <20200819124616.GA2314@nanopsycho.orion>
 <fc0d7c2f-afb5-c2e7-e44b-2ab5d21d8465@nvidia.com>
 <20200819151815.GA2575@nanopsycho.orion>
 <20200819092551.6d94de03@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819092551.6d94de03@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Aug 19, 2020 at 06:25:51PM CEST, kuba@kernel.org wrote:
>On Wed, 19 Aug 2020 17:18:15 +0200 Jiri Pirko wrote:
>>>>> I will add counters on which reload were done. reload_down()/up() can return
>>>>> which actions were actually done and devlink will show counters.  
>>>> Why a counter? Just return what was done over netlink reply.  
>>>
>>> Such counters can be useful for debugging, telling which reload actions were
>>> done on this dev from the point it was up.  
>> 
>> Not sure why this is any different from other commands...
>
>Good question, perhaps because reset is more "dangerous"? The question
>of "what reset this NIC" does come up in practice. With live activation
>in the mix, knowing if the NIC FW was live activated will be very
>useful for dissecting failures, I'd imagine.

Okay, fair enough. Yet, I think that the info in the reply as I
suggested would be also nice to have, while we are at it.
