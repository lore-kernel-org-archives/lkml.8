Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7619FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A93B20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k0gOJrG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389767AbgEZV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388967AbgEZV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:27:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFFEC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qdvaRsxr7i84jB+7s5+FQWOnyFJl2KHp4wWCRvGNhl4=; b=k0gOJrG8ryKOn+EtI9ACNut+fY
        iJi7u6W4t5O0tUdkoZGQ4VnxsX01fLajBEeuMmRlbGkGCX//4DsE4fakfbnrKs/ykwqXAnzqbQ0s+
        iABr7FXdYeHMAFSoHbdsbZWSPsGcpSqy3P2IDHCncUCoKniP61MsEkSJVxS3LI1XGVvyp8sH23sef
        y2wyNWNy2e8UlslE7ovjhDeDOfDKeevEiIaVaSwlYfUax52+vmZ71VtSmj2cGqUoE4tpjcp+Klz8a
        LfEF3jo22xQyA3NxEG56VDgKGzb2tyO+2Agz93akuS8OOdHpgBoIhTPJj1RsNAEAXfGS9PL0dM5ge
        XZML54fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdh6M-0008EJ-Mu; Tue, 26 May 2020 21:27:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E43A99834AB; Tue, 26 May 2020 23:27:07 +0200 (CEST)
Date:   Tue, 26 May 2020 23:27:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
Message-ID: <20200526212707.GE2483@worktop.programming.kicks-ass.net>
References: <20200526174349.8312-1-longman@redhat.com>
 <20200526185850.GE991@lca.pw>
 <20200526195630.GF325280@hirez.programming.kicks-ass.net>
 <b88d5379-687d-8c14-40ae-221c79500996@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88d5379-687d-8c14-40ae-221c79500996@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 04:30:58PM -0400, Waiman Long wrote:
> On 5/26/20 3:56 PM, Peter Zijlstra wrote:
> > On Tue, May 26, 2020 at 02:58:50PM -0400, Qian Cai wrote:
> > 
> > > I still don't understand why reading all sysfs files on this system
> > > could increase that much, but here is the lockdep file after
> > > running sysfs read to see if you could spot anything obviously,
> > > 
> > > https://cailca.github.io/files/lockdep.txt
> > 00000000f011a2a5 OPS:      20 FD:   45 BD:    1 .+.+: kn->active#834
> > 
> > is that somewhere near the number of CPUs you have?
> > 
> > Anyway, there's very long "kn->active#..." chains in there, which seems
> > to suggest some annotation is all sorts of buggered.
> > 
> It is actually one active lock per instance of the kerfs_node structures.
> That means more than 800 sysfs files are accessed in some way. As we could
> have much more than 800 sysfs files in the system, we could easily overwhelm
> the lockdep tables if we really try to access all of them.

A lock per instance is crazy, that's not what lockdep is made for.
Fixing this seems like a far better idea than increasing the numbers.
