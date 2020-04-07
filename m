Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D1AC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D35D206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDGXhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:37:04 -0400
Received: from kernel.crashing.org ([76.164.61.194]:40816 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGXhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:37:04 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 037NaIP6017886
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Apr 2020 18:36:22 -0500
Message-ID: <93ae433317a82de86ff5e9c8485563b78656b615.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] usb: gadget: aspeed: improve vhub port irq handling
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Joel Stanley <joel@jms.id.au>, taoren@fb.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 08 Apr 2020 09:36:16 +1000
In-Reply-To: <20200407060242.GA15050@taoren-ubuntu-R90MNF91>
References: <20200315191430.12379-1-rentao.bupt@gmail.com>
         <20200401215826.GA8248@taoren-ubuntu-R90MNF91>
         <512d625e45ea953d722bb7ea73c3619730312284.camel@kernel.crashing.org>
         <20200403064826.GA10866@taoren-ubuntu-R90MNF91>
         <20200407060242.GA15050@taoren-ubuntu-R90MNF91>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 23:02 -0700, Tao Ren wrote:
> I ran some testing on my ast2400 and ast2500 BMC and looks like the
> for() loop runs faster than for_each_set_bit_from() loop in my
> environment. I'm not sure if something needs to be revised in my test
> code, but please kindly share your suggestions:
> 
> I use get_cycles() to calculate execution time of 2 different loops, and
> ast_vhub_dev_irq() is replaced with barrier() to avoid "noise"; below
> are the results:
> 
>   - when downstream port number is 5 and only 1 irq bit is set, it takes
>     ~30 cycles to finish for_each_set_bit() loop, and 20-25 cycles to
>     finish the for() loop.
> 
>   - if downstream port number is 5 and all 5 bits are set, then
>     for_each_set_bit() loop takes ~50 cycles and for() loop takes ~25
>     cycles.
> 
>   - when I increase downsteam port number to 16 and set 1 irq bit, the
>     for_each_set_bit() loop takes ~30 cycles and for() loop takes 25
>     cycles. It's a little surprise to me because I thought for() loop
>     would cost 60+ cycles (3 times of the value when port number is 5).
> 
>   - if downstream port number is 16 and all irq status bits are set,
>     then for_each_set_bit() loop takes 60-70 cycles and for() loop takes
>     30+ cycles.

I suspect the CPU doesn't have an efficient find-zero-bit primitive,
check the generated asm. In that case I would go back to the simple for
loop.

Cheers,
Ben.


