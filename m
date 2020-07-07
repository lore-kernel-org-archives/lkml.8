Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA95AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24622078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgGGPly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgGGPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:41:54 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B5C2088E;
        Tue,  7 Jul 2020 15:41:52 +0000 (UTC)
Date:   Tue, 7 Jul 2020 11:41:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200707114151.2d7b0fc1@oasis.local.home>
In-Reply-To: <c4aec17f-3ac9-ce17-a131-b186a9b595dd@infradead.org>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
        <202007062234.A90F922DF@keescook>
        <20200707064921.GA9411@linux.ibm.com>
        <20200707093727.22aa39e2@oasis.local.home>
        <CY4PR13MB117519F548B125CB2F10F50FFD660@CY4PR13MB1175.namprd13.prod.outlook.com>
        <c4aec17f-3ac9-ce17-a131-b186a9b595dd@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 08:33:33 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> >> I was thinking good-list / bad-list.
> >>
> >> /me that has been doing a lot of git bisect lately...  
> > 
> > I think it depends on the context.  I'd prefer a grammatically awkward verb that described
> > the action more specifically, than a grammatically nicer generic term.  In other words,
> > yes/no, good/bad don't mean that much to me, unless it's obvious from context
> > what the effect will be.  With something like allow/deny, I have a pretty clear mental
> > model of what the code is going to do.  
> 
> That matches what I was about to say:
> Just using yes/no does not tell someone what they are saying yes or no about.
> It should be more descriptive, like allow/block.

After doing two days worth of git bisect, good/bad is hardcoded in my head :-p

-- Steve
