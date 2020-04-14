Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75269C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504EF2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgDNToO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:44:14 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:45892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728340AbgDNTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:43:59 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 2B6EF1802B57F;
        Tue, 14 Apr 2020 19:06:44 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 00FE6181D341E;
        Tue, 14 Apr 2020 19:06:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sky28_1d7a3c1bf3225
X-Filterd-Recvd-Size: 2209
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Apr 2020 19:06:42 +0000 (UTC)
Message-ID: <b867ee8a02043ec6b18c9330bfe3a091d66c816c.camel@perches.com>
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        paul@crapouillou.net, Dan Carpenter <dan.carpenter@oracle.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 14 Apr 2020 12:04:32 -0700
In-Reply-To: <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
         <20200414135827.GB3593749@ulmo>
         <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-14 at 20:30 +0200, Christophe JAILLET wrote:
> Being able to detect early missing trailing '\n' would help maintainers 
> and patch providers.
> 
> You are the 2nd person (I've added Paul Cercueil in copy of my reply) 
> who reports that he is thinking that it is no more required to add a '\n'.

The printk subsystem will, for every printk, check
if the last printk has a newline termination and if
it doesn't and the current printk does not start with
KERN_CONT will insert a newline.

The negative to this approach is the last printk,
if it does not have a newline, is buffered and not
emitted until another printk occurs.

There is also the (now small) possibility that
multiple concurrent kernel threads or processes
could interleave printks without a terminating
newline and a different process could emit a
printk that starts with KERN_CONT and the emitted
message could be garbled.

See:

commit 4bcc595ccd80decb4245096e3d1258989c50ed41
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Oct 8 20:32:40 2016 -0700

    printk: reinstate KERN_CONT for printing continuation lines




