Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F639C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8786C20724
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGEULW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGEULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:11:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F98C061794;
        Sun,  5 Jul 2020 13:11:19 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 703EB739;
        Sun,  5 Jul 2020 20:11:19 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:11:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Manbing <manbing3@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] trace doc: fix typo of trace/ftrace.rst
Message-ID: <20200705141118.491a8045@lwn.net>
In-Reply-To: <20200630185356.3467-1-manbing3@gmail.com>
References: <20200630185356.3467-1-manbing3@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 11:53:55 -0700
Manbing <manbing3@gmail.com> wrote:

> Some documents was converted from the plain text documentation
> to reStructuredText format.
> 
> Signed-off-by: Manbing <manbing3@gmail.com>
> ---
>  Documentation/trace/ftrace.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

I've applied this, thanks.  I did change the subject line, though, since a
failure to update the names of some documents is not exactly a "typo".

In the future, please include your full name in the Signed-off-by tag.
For something this trivial it wasn't worth making a fuss about, but
maintainers are likely to balk with more significant changes.

Thanks,

jon
