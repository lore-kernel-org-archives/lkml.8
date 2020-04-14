Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEC420732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgDNPzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732077AbgDNPzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:55:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB8B206D5;
        Tue, 14 Apr 2020 15:55:00 +0000 (UTC)
Date:   Tue, 14 Apr 2020 11:54:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
Message-ID: <20200414115458.093e221b@gandalf.local.home>
In-Reply-To: <064f41bd-0dfe-e875-df7c-214184c29fa7@redhat.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
        <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
        <20200414093506.7b91bbbb@gandalf.local.home>
        <064f41bd-0dfe-e875-df7c-214184c29fa7@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 15:17:39 +0100
Julien Thierry <jthierry@redhat.com> wrote:

> > I was hoping to have objtool handle all the operations needed that required
> > reading elf headers.
> >   
> 
> That makes sense, however, having each operation as an objtool 
> subcommand doesn't solve that issue, right? Each invocation of objtool 
> will re-read the elf object.
> 
> I guess having all the relevant code in objtool as subcommand would be a 
> first step towards that goal.

Exactly. I believe the goal (it's been a while since we discussed this),
was that we could "batch" the sub commands into a single command. That way,
the executable will be executed once per object file, load all the elf
headers, than iterate over all the sub commands that we set on the command
line.

-- Steve
