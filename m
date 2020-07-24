Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFFC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C8020674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGXRd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:33:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A958EC0619D3;
        Fri, 24 Jul 2020 10:33:26 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2ADB32BA;
        Fri, 24 Jul 2020 17:33:26 +0000 (UTC)
Date:   Fri, 24 Jul 2020 11:33:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>
Subject: Re: Minor RST rant
Message-ID: <20200724113325.44923f75@lwn.net>
In-Reply-To: <20200724132200.51fd2065@oasis.local.home>
References: <20200724132200.51fd2065@oasis.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 13:22:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > It is tempting to describe the second kind as starting with a
> > component, but that isn't always accurate: a pathname can lack both
> > slashes and components, it can be empty, in other words.  This is
> > generally forbidden in POSIX, but some of those "xxx``at``" system calls
> > in Linux permit it when the ``AT_EMPTY_PATH`` flag is given.  For
> > example, if you have an open file descriptor on an executable file you
> > can execute it by calling `execveat() <execveat_>`_ passing
> > the file descriptor, an empty path, and the ``AT_EMPTY_PATH`` flag.  
> 
> All those `` are throwing me off to understanding what is being written.

Give people a tool, some of them will make more use of it than you might
like. I do my best to push back against excessive markup (which all of the
above qualifies as, as far as I'm concerned), but I can't really even do
that will all that goes through my tree, much less all the docs stuff
merged by others.

The markup in question was seemingly added by Neil; I've added him to CC
in case he wants to comment on it.

I'm not sure what to do other than to continue to push for minimal use of
intrusive markup.

jon
