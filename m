Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F362FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AE220575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504768AbgDNT3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:29:04 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:41858 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504730AbgDNT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:28:57 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 2B1CF18064C30;
        Tue, 14 Apr 2020 19:12:00 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 032BF100E7B45;
        Tue, 14 Apr 2020 19:12:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rain29_4b79cd438ab50
X-Filterd-Recvd-Size: 1707
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Apr 2020 19:11:58 +0000 (UTC)
Message-ID: <19df87f5d093a6c2721316811aca1c90d287bf1d.camel@perches.com>
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>, paul@crapouillou.net,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 14 Apr 2020 12:09:49 -0700
In-Reply-To: <20200414184925.GA12862@kadam>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
         <20200414135827.GB3593749@ulmo>
         <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
         <20200414184925.GA12862@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-14 at 21:49 +0300, Dan Carpenter wrote:
> Huh...
> 
> If you look at dev_vprintk_emit().  It looks like if
> create_syslog_header() returns a string then vprintk_store() will add
> a newline.
> 
> I guess that means that dev_printk() can't be used to pr_cont().  And
> probably that's deliberate because using pr_cont() after boot is racy
> anyway.

Perhaps that's true, it didn't used to be.

There are couple dozen or so KERN_CONT uses after a dev_<level>
without a newline, so those _might_ be broken, but I don't thinks so.

$ git grep -P -A10 '\bdev_\w+\s*\(' | \
  grep -P -B10 "KERN_CONT|pr_cont"

