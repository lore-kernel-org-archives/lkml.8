Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CCC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CFC20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqDTnVdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBLCh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:37:56 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34714 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBLCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:37:56 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so1358941pjq.1;
        Tue, 11 Feb 2020 18:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vv3NHPZnBve5XiluETZotYu+d3bqwg0qJCx+3uhyaM4=;
        b=LqDTnVdwykUbgj17vRiSu0wFe6uQuLuoNTYxnt1hV1zA7zQJZ3Bu1dEQt4RI34I1TS
         Or2/lgMlxpcFQzXW463ugd85BrgR6lgMSKBiGhOmWpfD0H1f7PcEbVJhflRk3lwMfWo3
         x6wskEcFMMckElySxG0JLuRGy9KCJ0rFQPawyC295ueBCdHjobHOguzNBOOR7WlBwRaR
         OY5syFDOcpl+E49w1qaBDG105le2WjLWE+eQ6YJg8AubgePkguj0UTz+MB/RBxroaW0n
         lx2EFjfL5QjrX69I8wUKWAO2/nYbY5A1X27OhsVEa2/65vOy8MgC2ffxYouJxHKW6a/V
         4QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vv3NHPZnBve5XiluETZotYu+d3bqwg0qJCx+3uhyaM4=;
        b=pi3XhKiKMuhRhMiKBvNZIWXiz6wOV6ZRzgsw3FWeRcjHsC7MiVi1Ow3Pg6B2g0C2gP
         bcPwrAPmdR0RI/oFouP6IyhJ/ESsWbmbNeGWqQx0aOCULa/yrQGOTQKBee4ScRQDEmM3
         x0+/y+Sv7Dvjt64yhU6EVLnfEf4KefbK+kqvCYd4iflQ37ybWimYl3gPoj3QFnp5v0uh
         lBq4/uZKweUPN5hbnVInwIYArcVMZoDlbvJKx4q95zkoGwai3cZwiC68qOuKYGVJFPQg
         0oFkL1speeP6KNw8ChYN/QMy2ToB17XlSnAXuKkBMMhrorSL3HgQrEQkkN3pOeViryZ/
         LKNg==
X-Gm-Message-State: APjAAAUKXHd75IvVLU9CRT61H9LeUgIYDnqdsUIBAhz2JIrL2pd2Dpaw
        nzhUAgtql9LjSoewaDH1ud8=
X-Google-Smtp-Source: APXvYqyuDguANzB58wFOK/4Z7FCp2UtZ0LngNySWG7JX3V31NtSorTHf3Kf9HvxxX7mtQN6BVwdbmw==
X-Received: by 2002:a17:90a:c388:: with SMTP id h8mr6993554pjt.83.1581475075299;
        Tue, 11 Feb 2020 18:37:55 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:200::80a4])
        by smtp.gmail.com with ESMTPSA id d15sm5740978pgn.6.2020.02.11.18.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 18:37:54 -0800 (PST)
Date:   Tue, 11 Feb 2020 18:37:47 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] usb: gadget: aspeed: read vhub config from
 of_device_id
Message-ID: <20200212023746.GA9834@taoren-ubuntu-R90MNF91>
References: <20200131222157.20849-1-rentao.bupt@gmail.com>
 <20200131222157.20849-2-rentao.bupt@gmail.com>
 <CACPK8Xe0b+zVNqf8v5YXOLkzqDeb4JHqec-bqFpaVFGTwHThhA@mail.gmail.com>
 <386e905fb705266efcac0c1b3a10053889c7fead.camel@kernel.crashing.org>
 <20200210190744.GA5346@taoren-ubuntu-R90MNF91>
 <746b08aabf7ea976a382ad2ca30fa10a095e7ed8.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <746b08aabf7ea976a382ad2ca30fa10a095e7ed8.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:50:42AM +0100, Benjamin Herrenschmidt wrote:
> On Mon, 2020-02-10 at 11:07 -0800, Tao Ren wrote:
> > > > This looks generally okay. We should wait for Ben's ack before
> > > > applying.
> > > 
> > > Shouldn't we instead have DT fields indicating those values ?
> > 
> > May I ask why we prefer adding dt fields (such as "aspeed,vhub-max-ports"
> > and "aspeed,vhub-max-endpoints") instead of assigning these values based
> > on aspeed family? For example, is it to allow users to set a smaller
> > number of ports/endpoints?
> 
> It's not a strong drive but it makes it more convenient to add support
> to newer revisions if the only differences are those numbers.

Got it. Thanks for the clarify. Will send out v2 patches after more
testing.

> > 
> > > Also we should add a DT representation for the various ID/strings of
> > > the hub itself so manufacturers can customize them.
> > 
> > Sure. I will add DT nodes for vendor/product/device IDs/strings. As it's
> > not directly related to ast2600-support, shall I handle it in a separate
> > patch? Or I can include the patch in this patch series?
> 
> Separate. Thanks !

Will take care of the change once this patch series is accepted.


Cheers,

Tao
> 
> Cheers,
> Ben.
> 
> 
