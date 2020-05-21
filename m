Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC65C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169D62070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgEUMbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:31:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:48482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgEUMbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:31:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3BCBCAC20;
        Thu, 21 May 2020 12:31:22 +0000 (UTC)
Date:   Thu, 21 May 2020 14:31:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200521123117.GD8397@linux-b0ei>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
 <20200520044127.GB938@jagdpanzerIV.localdomain>
 <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
 <20200520121000.GF520@jagdpanzerIV.localdomain>
 <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
 <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
 <20200521043628.GB755@jagdpanzerIV.localdomain>
 <20200520214007.86f36f61e1fc0329b66758ed@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520214007.86f36f61e1fc0329b66758ed@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-05-20 21:40:07, Andrew Morton wrote:
> On Thu, 21 May 2020 13:36:28 +0900 Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> 
> > On (20/05/20 18:00), Andrew Morton wrote:
> > [..]
> > > I'm wondering if we shold add a kernel puts() (putsk()?  yuk) which can
> > > puts() a string of any length.
> > > 
> > > I'm counting around 150 instances of printk("%s", ...) and pr_foo("%s",
> > > ...) which could perhaps be converted, thus saving an argument.
> > 
> > Can you point me at some examples?
> > 
> 
> ./arch/powerpc/kernel/udbg.c:           printk("%s", s);
> ./arch/powerpc/xmon/nonstdio.c:         printk("%s", xmon_outbuf);
> ./arch/um/os-Linux/drivers/ethertap_user.c:             printk("%s", output);
> ./arch/um/os-Linux/drivers/ethertap_user.c:             printk("%s", output);
> ./arch/um/os-Linux/drivers/tuntap_user.c:                       printk("%s", out
> 
> etc.
> 
> My point is, if we created a length-unlimited puts() function for printing the
> kernel command line, it could be reused in such places, resulting in a
> smaller kernel.

Interesting idea. Well, such a generic function would need to be safe
and do not modify the original string. We would need to implement
printk() variant that would support strigs limited by size instead
of the trailing '\0'. I am not sure if it is worth it.

Best Regards,
Petr
