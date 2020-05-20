Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32224C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED981207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgETUgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:36:52 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:54170 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgETUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:36:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id BD62F100E7B47;
        Wed, 20 May 2020 20:36:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shake90_010f55826d18
X-Filterd-Recvd-Size: 2078
Received: from XPS-9350 (unknown [172.58.35.10])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 May 2020 20:36:48 +0000 (UTC)
Message-ID: <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 20 May 2020 13:36:45 -0700
In-Reply-To: <20200520121000.GF520@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
         <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
         <20200520044127.GB938@jagdpanzerIV.localdomain>
         <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
         <20200520121000.GF520@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-20 at 21:10 +0900, Sergey Senozhatsky wrote:
> On (20/05/19 21:58), Joe Perches wrote:
> [..]
> > >  Maybe we can
> > > use here something rather random and much shorter instead. E.g.
> > > 256 chars. Hmm. How 
> > 
> > 	min(some_max like 132/256, PRINTK_LOG_LINE_MAX)
> > 
> > would work.
> 
> An alternative approach would be to do what we do in the
> print_modules() (the list of modules which can definitely
> be longer than 1K chars).
> 
> We can split command line in a loop - memchr(pos, ' ') - and
> pr_cont() parts of the command line. pr_cont() has overflow
> control and it flushes cont buffer before it overflows, so
> we should not lose anything.

It doesn't matter much here, but I believe
there's an 8k max buffer for pr_cont output.

include/linux/printk.h:#define CONSOLE_EXT_LOG_MAX      8192

Anyway, no worries, it simplifies the loop if
done that way.


