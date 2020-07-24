Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8737C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AD9206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGXRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXRWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:22:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 517C120674;
        Fri, 24 Jul 2020 17:22:02 +0000 (UTC)
Date:   Fri, 24 Jul 2020 13:22:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Minor RST rant
Message-ID: <20200724132200.51fd2065@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

I like how RST can help make for a better grouping of our documents
and put it into other formats. But I have to rant a little because I'm
currently experiencing some of the frustration that Peter commonly
complains about.

I'm looking into how to make the event directory tree be created on the
fly, and not waste a lot of space on all these dentry and inodes that
are allocated for the thousands of events in the kernel. This is to
also make instances have a smaller memory footprint since each instance
creates a copy of those 1000s of events. But I really don't understand
the VFS layer. I decided to jump into Documentation/filesystems and try
to learn how to do this for tracefs.

Now for my rant.

I just finished reading Documentation/filesystems/path-lookup.txt and
learned a lot. It was even an enjoyable read.

Then I went to Documentation/filesystems/path-lookup.rst, and found
myself constantly re-reading the same paragraph over again, and losing
track of what I'm reading. I realized it wasn't due to the writing, but
due to the constant inserted markup of quotes, that makes it terribly
annoying to read, and unfortunately, not enjoyable at all.

For example:

> It is tempting to describe the second kind as starting with a
> component, but that isn't always accurate: a pathname can lack both
> slashes and components, it can be empty, in other words.  This is
> generally forbidden in POSIX, but some of those "xxx``at``" system calls
> in Linux permit it when the ``AT_EMPTY_PATH`` flag is given.  For
> example, if you have an open file descriptor on an executable file you
> can execute it by calling `execveat() <execveat_>`_ passing
> the file descriptor, an empty path, and the ``AT_EMPTY_PATH`` flag.

All those `` are throwing me off to understanding what is being written.

I don't even know what those are suppose to represent.

Again, I really like the effort to pull all this useful information in
the Documentation directory into other formats that others can enjoy,
but this is just to give you some feedback where this format can be a
real distraction for those that much prefer to read a simple text file
than a web page or pdf file.

Just my $0.02.

-- Steve
