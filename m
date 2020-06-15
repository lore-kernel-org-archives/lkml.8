Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9297220756
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgFOTYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:24:04 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:44374 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728093AbgFOTYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:24:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A63731818F1C1;
        Mon, 15 Jun 2020 19:24:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: push89_210d4b126df8
X-Filterd-Recvd-Size: 1648
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jun 2020 19:24:01 +0000 (UTC)
Message-ID: <7abefbc81fc6aaefed6bbd2117e7bc97b90babe9.camel@perches.com>
Subject: Re: [PATCH 1/4] proc/bootconfig: Fix to use correct quotes for value
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Jun 2020 12:24:00 -0700
In-Reply-To: <20200615151139.5cc223fc@oasis.local.home>
References: <159197538852.80267.10091816844311950396.stgit@devnote2>
         <159197539793.80267.10836787284189465765.stgit@devnote2>
         <20200615151139.5cc223fc@oasis.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-15 at 15:11 -0400, Steven Rostedt wrote:
> On Sat, 13 Jun 2020 00:23:18 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
[]
> > diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
[]
> > @@ -27,6 +27,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> >  {
> >  	struct xbc_node *leaf, *vnode;
> >  	const char *val;
> > +	char q;
> >  	char *key, *end = dst + size;
> >  	int ret = 0;
> 
> Hmm, shouldn't the above have the upside-down xmas tree format?
> 
> 	struct xbc_node *leaf, *vnode;
> 	char *key, *end = dst + size;
> 	const char *val;
> 	char q;
> 	int ret = 0;

Please don't infect kernel sources with that style oddity.


