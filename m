Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4D620767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGJQq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:46:28 -0400
Received: from verein.lst.de ([213.95.11.211]:44026 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgGJQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:46:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8794C68B05; Fri, 10 Jul 2020 18:46:25 +0200 (CEST)
Date:   Fri, 10 Jul 2020 18:46:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: user_access_{save,restore}() semantics
Message-ID: <20200710164625.GA23719@lst.de>
References: <20200710161527.GA22579@lst.de> <20200710164037.GV597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710164037.GV597537@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:40:37PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 10, 2020 at 06:15:27PM +0200, Christoph Hellwig wrote:
> > Hi Peter,
> > 
> > can you explain (and maybe document while we're at it) what the
> > exact semantics of the user_access_{save,restore} helpers are?
> > 
> > Reverse engineering from the commit text they seem to be about
> > saving the current uaccess state.  But do they also enable/disable
> > anything?
> 
> user_access_save() is like local_irq_save(), it stores the EFLAGS and
> clears AC/IF resp. user_access_restore(), like local_irq_restore(),
> simply restores the previously saved EFLAGS.
> 
> So for code that had user_access_begin(),
> user_access_save()/user_access_restore() will temporarily disable
> user-access and allow calling other code.
> 
> something like so?

Looks good, thanks!
