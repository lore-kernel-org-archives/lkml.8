Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76945C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D0E20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgFPFF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:05:29 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:48522 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgFPFF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:05:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BC50112150A;
        Tue, 16 Jun 2020 05:05:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bite75_290569326dfc
X-Filterd-Recvd-Size: 1972
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Jun 2020 05:05:26 +0000 (UTC)
Message-ID: <ac93acd4f757f3286f7782ad7c8117a6ad224b5c.camel@perches.com>
Subject: Re: [PATCH 1/4] proc/bootconfig: Fix to use correct quotes for value
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Jun 2020 22:05:25 -0700
In-Reply-To: <a3cbc2cf-7371-3e2b-e794-4fbfc52aaad9@infradead.org>
References: <159197538852.80267.10091816844311950396.stgit@devnote2>
         <159197539793.80267.10836787284189465765.stgit@devnote2>
         <20200615151139.5cc223fc@oasis.local.home>
         <7abefbc81fc6aaefed6bbd2117e7bc97b90babe9.camel@perches.com>
         <20200615172123.1fe77f3c@oasis.local.home>
         <ddb4adb9-bf01-abd4-38dd-d6d064569d6e@infradead.org>
         <20200615184218.752a17fa@oasis.local.home>
         <a3cbc2cf-7371-3e2b-e794-4fbfc52aaad9@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-15 at 16:12 -0700, Randy Dunlap wrote:
> On 6/15/20 3:42 PM, Steven Rostedt wrote:
> > On Mon, 15 Jun 2020 15:30:41 -0700
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > > > > Please don't infect kernel sources with that style oddity.  
> > > > 
> > > > What do you mean? It's already "infected" all over the kernel, (has
> > > > been for years!)

Not really.  For instance:

$ git grep -A6 "^{" fs/proc/*.[ch]

> But yes, we all have preferences. For data declaration, mine is more like
> order of use or some grouping having to do with locality.
> 
> cheers.

Mine too.

But a few years ago I submitted this:
https://lore.kernel.org/patchwork/patch/732076/


