Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCAFC8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6934720838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgD3K4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:56:21 -0400
Received: from kernel.crashing.org ([76.164.61.194]:50512 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgD3K4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:56:21 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 03UAtojD025184
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Apr 2020 05:55:54 -0500
Message-ID: <232b9fac588beb4d024ab496b118c51af2b0ecba.camel@kernel.crashing.org>
Subject: Re: [PATCH v0 linux master] i2c/busses: Avoid i2c interrupt status
 clear race condition.
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Apr 2020 20:55:48 +1000
In-Reply-To: <20200429090355.GA2891@kunai>
References: <20200429033737.2781-1-ryan_chen@aspeedtech.com>
         <20200429075357.GA1957@kunai>
         <56add9c6e6b5410986325a1360466e4b@TWMBX02.aspeed.com>
         <20200429090355.GA2891@kunai>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 11:03 +0200, Wolfram Sang wrote:
> > And is there maybe a Fixes: tag for it?
> > [Ryan Chen] Yes it is a fix patch.
> 
> I meant this (from submitting-patches.rst):

It fixes the original implementation of the driver basically. It's just
a classic posted-write fix. The write to clear the pending interrupt is
asynchronous, so you can get spurrious ones if you return from the
handler before it has percolated to the HW.

I assume it's just more visible on the 2600 because of the cores are
significantly faster but the IO bus is still as dumb.

Ryan: You could always add a Fixed-by: tag that specifies the commit
that added the initial driver...

Cheers,
Ben.

