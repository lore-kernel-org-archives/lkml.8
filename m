Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38503C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A30F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCJRND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:13:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:44002 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgCJRNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:13:02 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 805B92E4;
        Tue, 10 Mar 2020 17:13:01 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:13:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] docs: Move Intel Many Integrated Core documentation
 (mic) under misc-devices
Message-ID: <20200310111300.4bf7359a@lwn.net>
In-Reply-To: <CAHp75VfX0hWGaWqJcrShYW6SOi9B24LGm=02BGZXg7qOevgZBg@mail.gmail.com>
References: <20200308211519.8414-1-j.neuschaefer@gmx.net>
        <CAHp75VfX0hWGaWqJcrShYW6SOi9B24LGm=02BGZXg7qOevgZBg@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020 09:34:37 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Mar 8, 2020 at 11:17 PM Jonathan Neuschäfer
> <j.neuschaefer@gmx.net> wrote:
> >
> > It doesn't need to be a top-level chapter.
> >
> > This patch also updates MAINTAINERS and makes sure the F: lines are
> > properly sorted.
> >  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> for MAINTAINERS change.
> 
> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied, thanks.

jon
