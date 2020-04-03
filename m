Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADDFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D05C206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbgDCHRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:17:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:34352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbgDCHRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:17:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A0ED3AC65;
        Fri,  3 Apr 2020 07:17:14 +0000 (UTC)
Date:   Fri, 3 Apr 2020 09:17:14 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, raphael.gault@arm.com
Subject: Re: [PATCH v2 00/10] Objtool updates for easier portability
In-Reply-To: <20200402183004.GJ20730@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2004030916220.25955@pobox.suse.cz>
References: <20200327152847.15294-1-jthierry@redhat.com> <20200402175827.kk7su6mo42aa6bh5@treble> <20200402183004.GJ20730@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020, Peter Zijlstra wrote:

> On Thu, Apr 02, 2020 at 12:58:27PM -0500, Josh Poimboeuf wrote:
> > On Fri, Mar 27, 2020 at 03:28:37PM +0000, Julien Thierry wrote:
> > > Hi,
> > > 
> > > This patchset includes some of the least controversial changes that
> > > were needed as part of the arm64 port [1].
> > > 
> > > I'm resending these rebase on top of linux-tip/core/objtool, following
> > > the addition of Peter's patches [2]
> > > 
> > > It consist mostly of small fixes or lifting some limitations to make it
> > > easier to support a new architecture in objtool. Of course, these will
> > > not be the only required changes, but these are the ones I hope make
> > > enough sense to be merged separately from the rest of arm64 port series.
> > > 
> > > Changes since v1[3]:
> > > - Really just rebased things
> > > 
> > > [1] https://lkml.org/lkml/2020/1/9/643
> > > [2] https://lkml.org/lkml/2020/3/25/807
> > > [3] https://www.spinics.net/lists/kernel/msg3453718.html
> > > 
> > > Thanks,
> > > 
> > > Julien
> > 
> > I'm taking everything except 5, 7, and 10.  I'll run them through
> > testing and then send them along to the tip maintainers.  Thanks!
> 
> For that set:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

And

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

for the same.
