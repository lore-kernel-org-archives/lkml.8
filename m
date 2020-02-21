Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F714C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D29208CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgBUC4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgBUC4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:56:21 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A29222C4;
        Fri, 21 Feb 2020 02:56:20 +0000 (UTC)
Date:   Thu, 20 Feb 2020 21:56:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 6/8] bootconfig: Overwrite value on same key by
 default
Message-ID: <20200220215618.7ee8ae5b@oasis.local.home>
In-Reply-To: <20200221092101.f4a25d56de794db29ed5ed6f@kernel.org>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
        <158220116248.26565.12553080867501195108.stgit@devnote2>
        <20200220121641.6c0d611a@gandalf.local.home>
        <20200221092101.f4a25d56de794db29ed5ed6f@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 09:21:01 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 20 Feb 2020 12:16:41 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 20 Feb 2020 21:19:22 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > Currently, bootconfig does not overwrite existing value
> > > on same key, but add new value to the tail of an array.
> > > But this looks a bit confusing because similar syntax
> > > configuration always overwrite the value by default.  
> > 
> > Should we even allow this case? Or at the very least, some output
> > should be made that a value is being overwritten.  
> 
> Both are OK, but I like just making it error. At this moment,
> the bootconfig tool writes user-given bootconfig file to
> initrd (not reformat it). This means if user ignores the warning
> from bootconfig tool, they will see same warning on dmesg again.
> 

OK, so you will be updating this patch?

FYI, I pulled in patches 1-3,5 and 8. I dropped patch 4, and wanted
feedback from you on patch 6, and patch 7 depended on 6.

Feel free to update patch 6 and 7 on top of my git tree branch
ftrace/urgent.

-- Steve
