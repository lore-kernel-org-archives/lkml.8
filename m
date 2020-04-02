Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0642AC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9A22077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbgDBKij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:38:39 -0400
Received: from kernel.crashing.org ([76.164.61.194]:37650 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBKii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:38:38 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 032Abb5C028468
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Apr 2020 05:37:40 -0500
Message-ID: <c556467d63cd5de806b4bf1806caee013ba5a808.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 6/6] dt-bindings: usb: document aspeed vhub device
 ID/string properties
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>
Cc:     rentao.bupt@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Date:   Thu, 02 Apr 2020 21:37:35 +1100
In-Reply-To: <CAL_JsqKZeCC352TKFGDNRRogSefF9vq+J=WqCEeg59PBsSOW1w@mail.gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
         <20200315191632.12536-7-rentao.bupt@gmail.com>
         <20200330192347.GA6388@bogus>
         <4dc3ac910c79dcca398eb5161dde44e1cc50baca.camel@kernel.crashing.org>
         <CAL_JsqKZeCC352TKFGDNRRogSefF9vq+J=WqCEeg59PBsSOW1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 10:21 -0600, Rob Herring wrote:
> Surely the descriptor building code can be shared at a minimum.
> 
> Regardless of whether gadget configfs fits, usually it is pretty clear
> whether something belongs in DT or userspace. That should be decided
> first.
> 
> > Maybe we could expose the port as UDCs but not actually expose them on
> > the bus until the hub is "activated" via a special configfs entry...
> 
> If control of the hub is done by userspace, I'd think configuration
> should be there too.

It's not in the current driver. For now, I expose the hub when the
driver loads/initializes, and it creates UDCs for each port, which are
then controlled from userspace.

That said, I did it this way because it was easy, not because there are
fundamental reasons to do so...

The main reason to want to change the hub descriptor is for the device
to advertise a vendor/device ID rather than our generic linux one,
which some vendors might want to do for ... reasons. I didn't implement
that functionality initially as in openbmc case, we didn't care. But I
know some vendors would like to, if anything because from a user
perspective, it's actually nice to have the string tell you that it's
your BMC rather than Linux Fundation Hub.

Originally I suggested we allow that via the device-tree because it was
the simplest way to get there and I love have to deal with less code ..
:)

However, if we want to support the whole language string set etc... it
gets really clumsy. So if there's a strong will to get there all the
way, then configfs is probably the way to go.

In that case, some sugery will probably be needed to make the gadget
descriptor building code a bit less dependent on the overall gadget
stuff... either that, or pre-create a "hub" gadget at driver loading
time that userspace can modify before "plugging".

In that case, the discussion should move back to linux-usb...

Cheers,
Ben.


