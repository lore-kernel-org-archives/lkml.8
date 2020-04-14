Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E02420768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgDNNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732332AbgDNNfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:35:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D2820575;
        Tue, 14 Apr 2020 13:35:08 +0000 (UTC)
Date:   Tue, 14 Apr 2020 09:35:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
Message-ID: <20200414093506.7b91bbbb@gandalf.local.home>
In-Reply-To: <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
        <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 08:24:15 +0100
Julien Thierry <jthierry@redhat.com> wrote:

> If all you need from objtool it the elf parsing code, wouldn't it make 
> more sense to move that out of objtool, as a utility library that both 
> objtool and recordmcount could use (and perhaps other tools in the future?)
> 
> In patch 3 you seem to mention that other tools already have their own 
> code to parse elf. So instead of converting everything as an objtool 
> subcommand, maybe just have the library with the required functionality.
> 
> Any opinions on the above? What do people prefer?

I think we discussed this before (and originally that was the plan), but I
believe one of the goals for bringing recordmcount into objtool is to speed
up the processing. Instead of having to read the elf sections for each use
case, we do it once, and then execute all the necessary operations for that
build.

If we just have a elf parsing library, then each object file is going to
have that read redundantly for each operation that is done on it.

I was hoping to have objtool handle all the operations needed that required
reading elf headers.

But if that's not what objtool maintainers want, then we can certainly go
back to looking at pulling out the elf headers, and have each tool be a
standalone again.

-- Steve
