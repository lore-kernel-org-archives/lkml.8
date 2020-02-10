Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A0C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9933920842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgBJQyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:54:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgBJQyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:54:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55DD20661;
        Mon, 10 Feb 2020 16:54:11 +0000 (UTC)
Date:   Mon, 10 Feb 2020 11:54:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: bootconfig: fix Sphinx block warning
Message-ID: <20200210115410.292565d4@gandalf.local.home>
In-Reply-To: <20200210161647.416ce0dcd0710f4349a665b1@kernel.org>
References: <07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org>
        <20200210161647.416ce0dcd0710f4349a665b1@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jon,

Would you like to take this through your tree?

  https://lore.kernel.org/r/07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org

-- Steve



On Mon, 10 Feb 2020 16:16:47 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sun, 9 Feb 2020 19:53:17 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Fix Sphinx format warning:
> > 
> > lnx-56-rc1/Documentation/admin-guide/bootconfig.rst:26: WARNING: Literal block expected; none found.
> >   
> 
> Good catch!
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks for the fix!
> 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Documentation/admin-guide/bootconfig.rst |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- lnx-56-rc1.orig/Documentation/admin-guide/bootconfig.rst
> > +++ lnx-56-rc1/Documentation/admin-guide/bootconfig.rst
> > @@ -23,7 +23,7 @@ of dot-connected-words, and key and valu
> >  has to be terminated by semi-colon (``;``) or newline (``\n``).
> >  For array value, array entries are separated by comma (``,``). ::
> >  
> > -KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> > +  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> >  
> >  Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
> >  
> >   
> 
> 

