Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A64C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 21:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A85C2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 21:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgAZVIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 16:08:43 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:37254 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgAZVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 16:08:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id DA703837F24A;
        Sun, 26 Jan 2020 21:08:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: year52_86035b18a9e04
X-Filterd-Recvd-Size: 2054
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jan 2020 21:08:40 +0000 (UTC)
Message-ID: <5b221ac7e49666b76cd9ca368b37e721cfb4aa9c.camel@perches.com>
Subject: Re: [for-next][PATCH 7/7] tracing: Use pr_err() instead of WARN()
 for memory failures
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 26 Jan 2020 13:07:36 -0800
In-Reply-To: <20200126155013.5cfc23aa@rorschach.local.home>
References: <20200126191932.984391723@goodmis.org>
         <20200126192021.350763989@goodmis.org>
         <e70ff75e9712478704fad44ac6b66c86a45df6a6.camel@perches.com>
         <20200126155013.5cfc23aa@rorschach.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-01-26 at 15:50 -0500, Steven Rostedt wrote:
> On Sun, 26 Jan 2020 12:38:55 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > On Sun, 2020-01-26 at 14:19 -0500, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > As warnings can trigger panics, especially when "panic_on_warn" is set,
> > > memory failure warnings can cause panics and fail fuzz testers that are
> > > stressing memory.
> > > 
> > > Create a MEM_FAIL() macro to use instead of WARN() in the tracing code
> > > (perhaps this should be a kernel wide macro?), and use that for memory
> > > failure issues. This should stop failing fuzz tests due to warnings.  
> > 
> > It looks as if most of these could just be removed instead
> > as there is an existing dump_stack() on failure.
> 
> That sounds more generic. This is specific for my own tracing tests to
> look for. As the point is, it is *not* to dump_stack, and still report
> the error.

__GFP_NOWARN is available too.


