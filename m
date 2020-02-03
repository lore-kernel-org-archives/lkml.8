Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9FC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76A62086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lE8nW5EG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgBCRsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:48:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgBCRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qaNhAb2AuX/dDKlI2Nc6HqM1nu/HRABHcDrGh66UQSo=; b=lE8nW5EGQC3bFw6YfTWzEFDcER
        Rnb+N2XhqFZSRYUeZuTz14Q+J0Ax6E8czMpT6tFvgPiKmEmHWBV2wDlio2LWhPkwPEdG1+iiTlYls
        bfXjYeSFFWrZJa4SbIsS3yoIqTNZ2eGgdr6ClF59ihqJZcGmu8M6JiBaWu6i82Pq2+VTev9SEDOA5
        N0aYadTGjbHJLieL6LtqXy44K6NYSN1pJcLJtXr+hhYdRXrrWtUO2nBVkJew/xYL3mRzZbKQN7z6e
        PI7JCeNLC7YltU5MgoaL9ITb13mCbniHEz6c6GDFw8EJvZpQpmPmyD5QllEjaSqu1l5EvRNyYSIfs
        JZz/27jA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyfpn-0004EU-Gp; Mon, 03 Feb 2020 17:48:31 +0000
Date:   Mon, 3 Feb 2020 09:48:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, mingo@kernel.org,
        will@kernel.org, oleg@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH -v2 5/7] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20200203174831.GA9834@infradead.org>
References: <20200131150703.194229898@infradead.org>
 <20200131151540.155211856@infradead.org>
 <20200203142050.GA28595@infradead.org>
 <20200203150933.GJ14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203150933.GJ14914@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 04:09:33PM +0100, Peter Zijlstra wrote:
> > Can you split the removal of the non-owned resem support into a separate
> > patch?  I still think keeping this one and moving aio to that scheme is
> > a better idea than the current ad-hoc locking scheme that has all kinds
> > of issues.
> 
> That's basically 2 lines of code and a comment, surely we can ressurect
> that if/when it's needed again?

Sure, I could.  But then you'd still need to update your commit log for
this patch explaining why it includes unrelated changes to a different
subsystem.  By splitting it you also document your changes much better.
