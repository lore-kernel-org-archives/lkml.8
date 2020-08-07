Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE045C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C2C221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgHGM2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHGM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:27:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED276C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 05:27:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1k41TV-0006hW-30; Fri, 07 Aug 2020 14:27:53 +0200
Message-ID: <f088c78e335653c8e07d6f304b5995602ee7398f.camel@pengutronix.de>
Subject: Re: [PATCH v2 net-next] net/tls: allow MSG_CMSG_COMPAT in sendmsg
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>,
        Pooja Trivedi <poojatrivedi@gmail.com>
Cc:     Aviad Yehezkel <aviadye@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "David S. Miller" <davem@davemloft.net>
Date:   Fri, 07 Aug 2020 14:27:48 +0200
In-Reply-To: <b55718ad4e675ed9a9c3eb1c5d952945f8b20c7a.camel@pengutronix.de>
References: <20200806064906.14421-1-r.czerwinski@pengutronix.de>
         <20200806114657.42f1ce8c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <b55718ad4e675ed9a9c3eb1c5d952945f8b20c7a.camel@pengutronix.de>
Organization: Pengutronix e.K.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-07 at 10:26 +0200, Rouven Czerwinski wrote:
> On Thu, 2020-08-06 at 11:46 -0700, Jakub Kicinski wrote:
> > On Thu,  6 Aug 2020 08:49:06 +0200 Rouven Czerwinski wrote:
> > > Trying to use ktls on a system with 32-bit userspace and 64-bit
> > > kernel
> > > results in a EOPNOTSUPP message during sendmsg:
> > > 
> > >   setsockopt(3, SOL_TLS, TLS_TX, …, 40) = 0
> > >   sendmsg(3, …, msg_flags=0}, 0) = -1 EOPNOTSUPP (Operation not
> > > supported)
> > > 
> > > The tls_sw implementation does strict flag checking and does not
> > > allow
> > > the MSG_CMSG_COMPAT flag, which is set if the message comes in
> > > through
> > > the compat syscall.
> > > 
> > > This patch adds MSG_CMSG_COMPAT to the flag check to allow the
> > > usage of
> > > the TLS SW implementation on systems using the compat syscall
> > > path.
> > > 
> > > Note that the same check is present in the sendmsg path for the
> > > TLS
> > > device implementation, however the flag hasn't been added there
> > > for
> > > lack
> > > of testing hardware.
> > > 
> > > Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > 
> > I don't know much about the compat stuff, I trust our cmsg handling
> > is
> > fine?
> > 
> > Just to be sure - did you run tools/testing/selftests/net/tls ?
> 
> After some pains to get this to correctly compile I have two failing
> tests, both for multi_chunk_sendfile:
> 
> root@192:~ /usr/lib/kselftest/net/tls
> [==========] Running 93 tests from 4 test cases.
> …
> [ RUN      ] tls.12.multi_chunk_sendfile
> multi_chunk_sendfile: Test terminated by timeout
> [     FAIL ] tls.12.multi_chunk_sendfile
> …
> [ RUN      ] tls.13.multi_chunk_sendfile
> multi_chunk_sendfile: Test terminated by timeout
> [     FAIL ] tls.13.multi_chunk_sendfile
> …
> [==========] 91 / 93 tests passed.
> [  FAILED  ]

I just tested on my x86_64 workstation and these specific tests fail
there too, do they only work on 5.8? They were added in 5.8, but I am
running 5.7.11 here. It looks like these failures are not
MSG_CMSG_COMPAT related.

Pooja Trivedi do you have an idea?

Regards,
Rouven

