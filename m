Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F34C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F4120671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgEUQJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:09:45 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:56624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgEUQJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:09:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C19DC180143E1;
        Thu, 21 May 2020 16:09:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: form95_5f0de8926d1f
X-Filterd-Recvd-Size: 1701
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 May 2020 16:09:42 +0000 (UTC)
Message-ID: <e0d86bc30a0415674859b81f66db661fb443aaf9.camel@perches.com>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
From:   Joe Perches <joe@perches.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Thu, 21 May 2020 09:09:38 -0700
In-Reply-To: <20200521155931.GA568639@rani.riverdale.lan>
References: <cover.1589916689.git.joe@perches.com>
         <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
         <20200521155931.GA568639@rani.riverdale.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-21 at 11:59 -0400, Arvind Sankar wrote:
> On Tue, May 19, 2020 at 12:42:35PM -0700, Joe Perches wrote:
> > ARM may have its longest possible command line larger than the longest
> > possible printk.
[]
> I might be missing something, but this seems broken:

probably, note the "untested" bit.

> (1) If there is a ' ', the memchr will set pos to the ' ' the first time
> through the inner loop, and then go into an infinite loop? You want
> memrchr here but the kernel doesn't seem to have one.

Right.  I did look and didn't find one and didn't
want to add it just for this use.


