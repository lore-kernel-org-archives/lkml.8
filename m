Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F16C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FA020848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBKIvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:51:38 -0500
Received: from kernel.crashing.org ([76.164.61.194]:55248 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgBKIvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:51:37 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01B8oi95016379
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Feb 2020 02:50:46 -0600
Message-ID: <746b08aabf7ea976a382ad2ca30fa10a095e7ed8.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/3] usb: gadget: aspeed: read vhub config from
 of_device_id
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Tao Ren <rentao.bupt@gmail.com>
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
Date:   Tue, 11 Feb 2020 09:50:42 +0100
In-Reply-To: <20200210190744.GA5346@taoren-ubuntu-R90MNF91>
References: <20200131222157.20849-1-rentao.bupt@gmail.com>
         <20200131222157.20849-2-rentao.bupt@gmail.com>
         <CACPK8Xe0b+zVNqf8v5YXOLkzqDeb4JHqec-bqFpaVFGTwHThhA@mail.gmail.com>
         <386e905fb705266efcac0c1b3a10053889c7fead.camel@kernel.crashing.org>
         <20200210190744.GA5346@taoren-ubuntu-R90MNF91>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 11:07 -0800, Tao Ren wrote:
> > > This looks generally okay. We should wait for Ben's ack before
> > > applying.
> > 
> > Shouldn't we instead have DT fields indicating those values ?
> 
> May I ask why we prefer adding dt fields (such as "aspeed,vhub-max-ports"
> and "aspeed,vhub-max-endpoints") instead of assigning these values based
> on aspeed family? For example, is it to allow users to set a smaller
> number of ports/endpoints?

It's not a strong drive but it makes it more convenient to add support
to newer revisions if the only differences are those numbers.
> 
> > Also we should add a DT representation for the various ID/strings of
> > the hub itself so manufacturers can customize them.
> 
> Sure. I will add DT nodes for vendor/product/device IDs/strings. As it's
> not directly related to ast2600-support, shall I handle it in a separate
> patch? Or I can include the patch in this patch series?

Separate. Thanks !

Cheers,
Ben.


