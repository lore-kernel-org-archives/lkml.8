Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815CC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C3207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="am8mcinX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAMPSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:18:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RXrt3Kd23IFzHWsq5upqeoyGKMQUPdEAUxUoERZtuVo=; b=am8mcinXx2Zu+yhOYPVhO1Lw7
        6LCKFCG8HUhAfNBVLc9m1WjHZ9+SkzKsubejSpWwi1OUVDTEHHwS3jq8/ZV3BrHURlwuDusUvJo+9
        9Jiv0cEJ7xbnTK/qnFfgQieU27UsvcjeSLm6UPOSIJzsqIYgF2V6HfaScHHcnx05KojOs+Jy/7VpW
        Q1ofALeUGf3FV9ZDShzrDZZObyoands5qQAdBuFYiG1uCuV+bAnpXyBUw0Rw8aT57wNOPSBGSi0ec
        GnCR9G6EDG+To6fyxOhBOzmMLCrd+1DYTla2hebRPniyYcOworREP5O+zl2/FTGmLNpM6XJKaWT+6
        EPzrNjNMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir1Tk-0005sX-PG; Mon, 13 Jan 2020 15:18:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50DB8304121;
        Mon, 13 Jan 2020 16:16:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1A242B6AFBAA; Mon, 13 Jan 2020 16:18:06 +0100 (CET)
Date:   Mon, 13 Jan 2020 16:18:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 2/6] locking/lockdep: Throw away all lock chains with
 zapped class
Message-ID: <20200113151806.GW2844@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216151517.7060-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:15:13AM -0500, Waiman Long wrote:
> If a lock chain contains a class that is zapped, the whole lock chain is
> now invalid.

Possibly. But I'm thinking that argument can/should be made mode elaborate.

Suppose we have A->B->C, and we're about to remove B.

Now, I suppose the trivial argument goes that if we remove the text that
causes A->B, then so B->C will no longer happen. However, that doesn't
mean A->C won't still occur.

OTOH, we might already have A->C and so our resulting chain would be a
duplicate. Conversely, if we didn't already have A->C and it does indeed
still occur (say it was omitted due to the redundant logic), then we
will create this dependency the next time we'll encounter it.

Bart, do you see a problem with this reasoning?

In short, yes, I think you're right and we can remove the whole thing.
But please, expand the Changelog a bit, possibly add some of this
reasoning into a comment.

