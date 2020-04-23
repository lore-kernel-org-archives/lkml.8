Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D309C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5957120857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587663150;
	bh=w7GOTzU61w5iz2sI2oB4nl36pNz0/hQHD6NjHrABKvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ivrZ3M6qsRPWAn+FhbflZUmVcV1Dg0qGFs9YHrkGmpaWsPCDltysrE+Dpx74Gaffw
	 hEsBnU610oWtkxZe5nLqBdoTa6hzaXAkJYKdGwebUlp4CRfURZpDbc5hvgwhL9GaR8
	 Bvnqs8Ohpa6YztOGq7LMWRnFgYcGn6C/Rh2fexCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgDWRc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgDWRc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:32:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A77520736;
        Thu, 23 Apr 2020 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587663148;
        bh=w7GOTzU61w5iz2sI2oB4nl36pNz0/hQHD6NjHrABKvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSvY0ir9c0SUohXTKU7lIoUdA78xgQ1DWN/047qt8+5lPcvrX0Jj2Ve7lY20CQ+vW
         g7xI0a6sc4ouVkqww9/DTv0z1SWdC1muAW45goUiUkj8Xi2HNlvMGY4cCV0XtDoOpg
         Lc0ZVGD0H/uosKy/yWr8AiwduhdHcMWjdNuo0xcU=
Date:   Thu, 23 Apr 2020 19:32:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Ralf =?iso-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        Thomas =?iso-8859-1?Q?Bogend=F6rfer?= <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: console: Complete exception handling in newport_probe()
Message-ID: <20200423173226.GA75304@kroah.com>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
 <20200423142909.GB1562@nuc8i5>
 <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
 <20200423170245.GA3417@nuc8i5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423170245.GA3417@nuc8i5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 01:02:45AM +0800, Dejin Zheng wrote:
> On Thu, Apr 23, 2020 at 05:23:29PM +0200, Markus Elfring wrote:
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/coccinelle/free/iounmap.cocci
> > >>
> > >> How do you think about to extend presented software analysis approaches?
> > >>
> > > Sorry, I am not familiar with it, I don't know.
> > 
> > Do you find the comments helpful at the beginning of this SmPL script?
> >
> Sorry, I do not know how to use the SmPL script. 

<snip>

Please note you are responding to someone who many kernel maintainers,
myself included, have on their blacklist as they are totally unhelpful.
Please feel free to ignore them like the rest of us do.

greg k-h
