Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC8C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F06222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582266789;
	bh=Wz9fLq8uVkhZTduNfXVnnXFpCOTUxHAAGlNDjGhUIvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Atyndnt4lUvaoO5CMnoMDD7eiTqgY2VpCioMeYRnqo3nKfXVkBBTB1DJLlWF05i1A
	 bB6GUXWP/MD8OF8juOzFlissLckcNeNGyFdr50tbPPfiWOSORHOD7rqfF3/EbLIf8w
	 Xja0y2OHsJ+a4tE0EISPx56t0mGWGDiZZKsTJFzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBUGdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgBUGdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:33:05 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C82208E4;
        Fri, 21 Feb 2020 06:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582266784;
        bh=Wz9fLq8uVkhZTduNfXVnnXFpCOTUxHAAGlNDjGhUIvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jMBSd8J2JVLEXUGps1He/Hr7xnRl/d94MWDbYwl2IwzDtLbJ8JOYnT+f6w+8L/npG
         0UxgsG5ismV5DpkQi/1KB1Ddm8YNJwG42y6c0+plvV9FTSM2vynjp+ymtpo57/DjTs
         Nh9sxlHnkWzZvPRajBnFfagn9jtkDZXELEG2dL0M=
Date:   Fri, 21 Feb 2020 15:32:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 6/8] bootconfig: Overwrite value on same key by
 default
Message-Id: <20200221153259.f55b65cdd1bf2888d0c61d76@kernel.org>
In-Reply-To: <20200220215618.7ee8ae5b@oasis.local.home>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
        <158220116248.26565.12553080867501195108.stgit@devnote2>
        <20200220121641.6c0d611a@gandalf.local.home>
        <20200221092101.f4a25d56de794db29ed5ed6f@kernel.org>
        <20200220215618.7ee8ae5b@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 21:56:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 21 Feb 2020 09:21:01 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 20 Feb 2020 12:16:41 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Thu, 20 Feb 2020 21:19:22 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Currently, bootconfig does not overwrite existing value
> > > > on same key, but add new value to the tail of an array.
> > > > But this looks a bit confusing because similar syntax
> > > > configuration always overwrite the value by default.  
> > > 
> > > Should we even allow this case? Or at the very least, some output
> > > should be made that a value is being overwritten.  
> > 
> > Both are OK, but I like just making it error. At this moment,
> > the bootconfig tool writes user-given bootconfig file to
> > initrd (not reformat it). This means if user ignores the warning
> > from bootconfig tool, they will see same warning on dmesg again.
> > 
> 
> OK, so you will be updating this patch?

Yes.

> 
> FYI, I pulled in patches 1-3,5 and 8. I dropped patch 4, and wanted
> feedback from you on patch 6, and patch 7 depended on 6.
> 
> Feel free to update patch 6 and 7 on top of my git tree branch
> ftrace/urgent.

OK, I'll send update soon.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
