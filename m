Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABD120872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjSTPbn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgH1UPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgH1UPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:15:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5560C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:15:19 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so186504edv.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZQ2wYX0JJ8AhJ31EPXvsOvOpaI9uw/KSJDkIWTlCWaU=;
        b=pjSTPbn+u9JJGX8lRd4F1RUrPhB5pytk7wJ6iVDOtrOVr4lGqEmVuJs88KHCylqWpc
         T9dHCZiDy9mkkQUNTaOLrutKIDTqTdvbItM4NWrzHfgzj+2UT5vodcbQomHBYoW2tkJr
         V6jLdxmmtnQmpWUtGgM/XLNiBlt2YzP2f7/e3N9J4V1wFXngESU1J/wVbmnqFL56HHjE
         rASJaE5CB5c1dNRJFi0pl2V3T6tKLSH65RLhWbFZUqyrK8am/vKeV3WiQHfPjhZno3pY
         N1VlsCEL+K9Wir3TCarFTYqeKiCdWGCtAxAUV1MwTQPtogDcFTP8DpwwwnDwcUyiQZOc
         bkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZQ2wYX0JJ8AhJ31EPXvsOvOpaI9uw/KSJDkIWTlCWaU=;
        b=pqGet/JvJ7lfO1oe+72nCIwOlnsSbT4hA3ooaejU7QAlPmgO9uEUeVXYY1QhHdkz4E
         zgW/mUbC5Xk8nYxqm5lmsHxI2dQkOWyfH7s2fHkaUiG6uawGEHeCN3bSwUrnARS4HE08
         9WsUcxS7nabOkf3B7RfZgxNurNRq4iFkBf4kTKdqRHTyZeB1leMTruMGGON8uqF9019E
         /pZ21e64INfdn2z+O2kcuxhLaPOn+xFZ19yFy4AsEbezZeIs35uBAnJdBaDLh7QsiPqY
         tPkhv+uHpu+nTdyP+LYrAXAnFU5qH5Dt7mccp2jOFtSHgjS8IBTKSIJlzCg3azbz5xj9
         TWyg==
X-Gm-Message-State: AOAM533Sagvr/b5fuSmJRFdT0R++Y0dhb/eGhHpSFWqygNRWUETpeuVp
        n4VL+2txwzu9+u8S3JFcrUCnQ+SEdUE=
X-Google-Smtp-Source: ABdhPJwEcc1HfWGOUW1j4qNo4SCTRUboj9OtnV/JXZCERzW49R8SANtRFvPNum+589D1AHHz9i2qjg==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr453058eds.131.1598645717601;
        Fri, 28 Aug 2020 13:15:17 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:b9d5:201e:8d86:3ad6])
        by smtp.gmail.com with ESMTPSA id m4sm201230ejn.31.2020.08.28.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:15:16 -0700 (PDT)
Date:   Fri, 28 Aug 2020 22:15:16 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
Message-ID: <20200828201516.p33577vucl6ke4j5@ltop.local>
References: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
 <CANiq72no4vv1dX13W8LL6kXj_0ethn0cbUfxM5Nn_Nxag-BrfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72no4vv1dX13W8LL6kXj_0ethn0cbUfxM5Nn_Nxag-BrfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 09:04:28PM +0200, Miguel Ojeda wrote:
> Hi Luc,
> 
> On Fri, Aug 28, 2020 at 10:53 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Hi Miguel,
> >
> > Could you also take this patch in your queue?
> > It has already be sent twice but ignored by the other channels.
> 
> Yeah, no problem. However, what about all those emails from the test
> bot? Is the bot using an old version of sparse or something like that?

Thanks.
The bot uses the very latest sparse version (which is very nice)
but is giving here false warnings. The change in the patch has as
consequence to change related warnings:
	: ...
	:   expected void const volatile [noderef] __user *
	:   got ...
into:
	: ...
	:   expected void const volatile [noderef] __user *ptr
	:   got ...

But to the bot, any change to the content of the warning itself
or its associated info is presented as a new warning.
I've talked to the bot's guys about this problem and they've
replied that they're seriously considering to change this behaviour.

Best regards,
-- Luc
