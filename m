Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE4C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0926220776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDVXWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:22:49 -0400
Received: from kernel.crashing.org ([76.164.61.194]:44588 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:22:48 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 03MNLOiu001422
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Apr 2020 18:21:28 -0500
Message-ID: <d73b32bea3aa640fefa0d62660b751377d0e431a.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 0/3] printk/console: Fix preferred console handling
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Thu, 23 Apr 2020 09:21:23 +1000
In-Reply-To: <20200228145820.6k4ddp457kf4e6c4@pathway.suse.cz>
References: <20200213095133.23176-1-pmladek@suse.com>
         <20200217130308.GA447@jagdpanzerIV.localdomain>
         <20200218095232.q6tqjmome4fhc6f5@pathway.suse.cz>
         <025fe463a37a01a39e8b988530b36ce79210897b.camel@kernel.crashing.org>
         <20200228145820.6k4ddp457kf4e6c4@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 15:58 +0100, Petr Mladek wrote:
> > > > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > 
> > > The patchset is commited in printk.git, branch
> > > for-5.7-preferred-console.
> > > 
> > 
> > Do you plan to send any of this to -stable ?
> 
> Good question. I would prefer to wait until 5.7 gets release or even
> longer. Changes in console registration order are prone to
> regressions. People then complain that they do not longer see console
> after reboot.
> 
> linux-next and rc phase has only pretty limited number of users.
> Released kernels hit much bigger user base, for example, via
> OpenSUSE Tumbleweed

Hi Petr !

I don't see this upstream yet, what happened ?

Cheers,
Ben.


