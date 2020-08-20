Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21621C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F130720674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHTWgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:36:32 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:38122 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgHTWga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:36:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 39BA8100E7B44;
        Thu, 20 Aug 2020 22:36:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: help66_310d87527034
X-Filterd-Recvd-Size: 1645
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Aug 2020 22:36:27 +0000 (UTC)
Message-ID: <73689b91d023ccc3e3f22e255cda72e3d66830ca.camel@perches.com>
Subject: Re: [RFC PATCH 2/5] sysrq: use pr_cont_t for cont messages
From:   Joe Perches <joe@perches.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Aug 2020 15:36:26 -0700
In-Reply-To: <87364hge7t.fsf@jogness.linutronix.de>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
         <20200819232632.13418-3-john.ogness@linutronix.de>
         <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com>
         <472f2e553805b52d9834d64e4056db965edee329.camel@perches.com>
         <87364hge7t.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 00:17 +0206, John Ogness wrote:
> On 2020-08-20, Joe Perches <joe@perches.com> wrote:
> > And here it seems like the 'for (j =...)' loop is superfluous.
> 
> AFAICT it is skipping duplicate entries. In the case of a duplicate,
> only the first one is printed.

Ah, right.  thanks.


