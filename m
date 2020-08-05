Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B4AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD15E22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658335;
	bh=1KGUWj0pR+2MJSTXGoe2kv9kDdmhjrT4ZUDgSPT30Lg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=heVXOW61EJA9gq5J80G552tP7u4LCYGiRKgeTsbb0RTAzU7I2gdobXhSnq3+mDQze
	 FePvsFQhtgEkxjgxj1qdV3OTTpbeDjRvQbn+VALete8S3nfgOJZ+J5Co5q/yU2yFsl
	 9tjNY6cLZZ64PJ3cKjYTRip9DGeUGA+vAwqUpZbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHEUMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgHEQ1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:40 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E835422B48;
        Wed,  5 Aug 2020 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596623482;
        bh=1KGUWj0pR+2MJSTXGoe2kv9kDdmhjrT4ZUDgSPT30Lg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DztFBbHaJmfLXguERc4iO/+C8kDCuxWxe54V2rQADelhOhyrjs+B1R02wY4g9lGwR
         NYLc/XumwnvqUcNuDhKnkdZ5v8SfnUAb/71U87pSpdn+jnJbAj8Z4SECzowbaP3x2p
         4EBnGi/dsVGr4fG4ZH1deIbkZeUT/FXH/6HjeH5k=
Received: by mail-lj1-f174.google.com with SMTP id i10so12301461ljn.2;
        Wed, 05 Aug 2020 03:31:21 -0700 (PDT)
X-Gm-Message-State: AOAM531SQi1oBgKUQKUgQlARvMnnqBM/zjfD42hV8ifsmFIH1LdrEOow
        AR3dNn274KWdN6Yywe4bLHRcqFSjZMT9z5zMjFk=
X-Google-Smtp-Source: ABdhPJwzE7/C8D2eIm+yh36NJaV0W0Km5i0/HVwfBymfZU9rxA3GdNEiEf5+UTWgnJ9LTGmC2/RA9NpCIFcry1SA848=
X-Received: by 2002:a2e:9d17:: with SMTP id t23mr1114817lji.456.1596623480201;
 Wed, 05 Aug 2020 03:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <1595792274-28580-1-git-send-email-ilial@codeaurora.org>
 <20200726194528.GC1661457@lunn.ch> <20200727.103233.2024296985848607297.davem@davemloft.net>
 <CA+5LGR1KwePssqhCkZ6qT_W87fO2o1XPze53mJwjkTWtphiWrA@mail.gmail.com> <20200804192435.GG1919070@lunn.ch>
In-Reply-To: <20200804192435.GG1919070@lunn.ch>
From:   Ilia Lin <ilia.lin@kernel.org>
Date:   Wed, 5 Aug 2020 13:31:08 +0300
X-Gmail-Original-Message-ID: <CA+5LGR32kKvaeDnb4qpGS_f=t-U4dDCYpnVy7R9zgAQCJW6jtA@mail.gmail.com>
Message-ID: <CA+5LGR32kKvaeDnb4qpGS_f=t-U4dDCYpnVy7R9zgAQCJW6jtA@mail.gmail.com>
Subject: Re: [PATCH] net: dev: Add API to check net_dev readiness
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     David Miller <davem@davemloft.net>, ilial@codeaurora.org,
        kuba@kernel.org, jiri@mellanox.com, edumazet@google.com,
        ap420073@gmail.com, xiyou.wangcong@gmail.com, maximmi@mellanox.com,
        Ilia Lin <ilia.lin@kernel.org>, netdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My comments inline.

Thanks,
Ilia Lin

On Tue, Aug 4, 2020 at 10:24 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Aug 04, 2020 at 08:47:18PM +0300, Ilia Lin wrote:
> > Hi Andrew and David,
>
> Hi Ilia
>
> Please don't top post.
>
> >
> > Thank you for your comments!
> >
> > The client driver is still work in progress, but it can be seen here:
> > https://source.codeaurora.org/quic/la/kernel/msm-4.19/tree/drivers/platform/msm/ipa/ipa_api.c#n3842
> >
> > For HW performance reasons, it has to be in subsys_initcall.
>
> Well, until the user of this new API is ready, we will not accept the
> patch.
OK, but once we submit the change in the driver, is it good to go?
>
> You also need to explain "For HW performance reasons". Why is this
> driver special that it can do things which no over driver does?
There are very strict KPI requirements. E.g. automotive rear mirror
must be online 3 sec since boot.
>
> And you should really be working on net-next, not this dead kernel
> version, if you want to get merged into mainline.
Of course, the upstream submition will be done on the mainline. I just
gave an example of an existing product driver.
>
> Network drivers do not belong is drivers/platform. There is also ready
> a drivers/net/ipa, so i assume you will move there.
Sure, the driver in the drivers/net/ipa is the one that will be
updated in the future.
>
>   Andrew
