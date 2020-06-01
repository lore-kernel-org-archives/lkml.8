Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAC0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EF320734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Ry72V/R5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFAGYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgFAGYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:24:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2793C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:24:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j198so11319786wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QFIV7FGtYRTpt76SqFuSWbwzzSofsQgm4fQkOksNz2Y=;
        b=Ry72V/R5DRVGyD4SfTF1+CHsDIt3+4Yac6GqlWhZD2jyd7uP+ffC05i0S1qdJCPw/I
         cG1KMAJni/PI8hdxw+Hd+5LxlmCJ3mJ0L3h4DG8rLt5yY6t6a2q/msh7cXIdhcWjKEj6
         u8iRO7m22VCZ+hdcXG67dh1thaJYdzWGKwUt3XXqYg14TOIFHhkhHwFNLQL3wDM/Y7lo
         PjdRsUncjg4bzQkP0WAbb7pV1lEUKKby6UgQ7bFjm3T1KY3KAwtoDmyQInYrfidOxzqi
         APm3zHTjLllq4iVOCerws+uJ0RMQ6iY7/jHX8pNsS5TtNXQZzWakWieOdW4Hs57MTQMy
         lVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QFIV7FGtYRTpt76SqFuSWbwzzSofsQgm4fQkOksNz2Y=;
        b=IBX4q+QHb97vxaCZ5uWvVVLJP0ymvDSyHqPn6X7OY98GTRLGA1UeeZ9zk4sEuLdtp2
         sFJRFzCmQM74XCyh9sGBzTPI5GV8Zui0BwdiF2RJI5chdHiq0nGbvz62b7co26HMQPkA
         o7oc124Hee1Jm7a5YoV32rt4pG9RI99Lt+tjJDt4zid4sp+HCdy6EvMMKBayeKzxHSqx
         NNQTPeVAm2W6hsX6Akp2uslwzID7owkuNgvJ0g9rasx9gpOQxYXjxuJiT6YBsdGdZu8s
         WSgbb27m6qMeNbdWqu7LiFTOHirDMoio2ip5IpKddY8/M0jWbzYN8xxAsIsZwKScaeqY
         WiRw==
X-Gm-Message-State: AOAM5327YwIPnUb6r55V0CMPFivld7WKYu/aS+vkXFcMk7JDW0yxJmhk
        89gDP4yhpW1bxjPLOQ1IUNNgrg==
X-Google-Smtp-Source: ABdhPJxPAMktkArwOxO/D5xc06ea2EMUEyTwCwxF1daPKDkxBjGrA9lQKdiGPFzbdM4DPIKrQHbg6A==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr19574219wmh.1.1590992658649;
        Sun, 31 May 2020 23:24:18 -0700 (PDT)
Received: from localhost (ip-78-102-58-167.net.upcbroadband.cz. [78.102.58.167])
        by smtp.gmail.com with ESMTPSA id 5sm9698264wmz.16.2020.05.31.23.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:24:18 -0700 (PDT)
Date:   Mon, 1 Jun 2020 08:24:17 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [net-next 0/6] net: marvell: prestera: Add Switchdev driver for
 Prestera family ASIC device 98DX326x (AC3x)
Message-ID: <20200601062417.GC2282@nanopsycho>
References: <20200528151245.7592-1-vadym.kochan@plvision.eu>
 <20200530142928.GA1624759@splinter>
 <20200530145231.GB19411@plvision.eu>
 <20200530155429.GA1639307@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530155429.GA1639307@splinter>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, May 30, 2020 at 05:54:29PM CEST, idosch@idosch.org wrote:
>On Sat, May 30, 2020 at 05:52:31PM +0300, Vadym Kochan wrote:

[...]


>> > WARNING: do not add new typedefs
>> > #1064: FILE: drivers/net/ethernet/marvell/prestera/prestera_hw.h:32:
>> > +typedef void (*prestera_event_cb_t)
>> I may be wrong, as I remember Jiri suggested it and looks like
>> it makes sense. I really don't have strong opinion about this.
>
>OK, so I'll let Jiri comment when he is back at work.

I was not aware of this warning, but for function callbacks, I think it
is very handy to have them as typedef instead of repeating the prototype
over and over. For that, I don't think this warning makes sense.

[...]
