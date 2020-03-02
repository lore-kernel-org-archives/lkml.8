Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URG_BIZ,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F86821D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCBUTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:19:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBUTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:19:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D075214DB;
        Mon,  2 Mar 2020 20:19:41 +0000 (UTC)
Date:   Mon, 2 Mar 2020 15:19:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] Documentation: bootconfig: Update boot configuration
 documentation
Message-ID: <20200302151939.1a83a5ed@gandalf.local.home>
In-Reply-To: <20200302131351.1b51a58e@lwn.net>
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
        <158313622831.3082.8237132211731864948.stgit@devnote2>
        <20200302125033.4a62e88e@lwn.net>
        <20200302150802.348b814e@gandalf.local.home>
        <20200302131351.1b51a58e@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 13:13:51 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> On Mon, 2 Mar 2020 15:08:02 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > So I tried to apply this but failed - it's built on other changes to
> > > bootconfig.rst that went into linux-next via Steve's tree.  So Steve,
> > > would you like to take this one too?    
> > 
> > All my changes in linux-next have already hit Linus's tree. I haven't
> > started pushing my next merge window changes yet. Are you up to date with
> > Linus?  
> 
> I try not to do too many backmerges with mainline, so no.  I can pull
> forward if I have to, I guess.
>

I can add it to my tree, but I may not send it to Linus unless I have
another urgent request to send to him. So it may not make it till the next
merge window.

-- Steve
