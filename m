Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588ECC433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F68E22CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIer+QW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHEUGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgHEQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:35:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CF4C00022F;
        Wed,  5 Aug 2020 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qTN3VYa4Jwjn/7oIAWkxtjMSdm7jmZvsa+Nlj8ztLXA=; b=iIer+QW6lRtaqM0e8Udd2KqWnX
        FkZCwirmtvgF11ikUzGqk6sFjTrLaS9PPgXhNQVhrEWEbAVZjgcjrU7kNYWoHONjrl4jrTDOiiGuq
        VryDW52i+I+Ftmqp0Vf/vXKXb+29EXrYXKXEFoB5lrTUxe2sxbqUc4KO4LQd6sYW5hDc+odOP4IX5
        Qr1hiJl4dm9ywd0iv+vF1Vfa4fhaxEz5dI89Tvt5Re7jWIy6vAnnust8dKiyvoueobhUdaPmuT248
        yQVWQV7f/0BitBKzqebKzKckSgjd5u/SFNpH3dPu5Jf5Om2M2XnWa1OcxA70nfMTacO/NlyLby4i0
        rR/vtRJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3L5k-0000vq-1c; Wed, 05 Aug 2020 15:12:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0E86301A66;
        Wed,  5 Aug 2020 17:12:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4870222B957C3; Wed,  5 Aug 2020 17:12:30 +0200 (CEST)
Date:   Wed, 5 Aug 2020 17:12:30 +0200
From:   peterz@infradead.org
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     NeilBrown <neilb@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: Minor RST rant
Message-ID: <20200805151230.GT2674@hirez.programming.kicks-ass.net>
References: <20200724132200.51fd2065@oasis.local.home>
 <20200724113325.44923f75@lwn.net>
 <20200724144234.3227b501@oasis.local.home>
 <877dusv5lc.fsf@notabene.neil.brown.name>
 <20200729124445.GB2638@hirez.programming.kicks-ass.net>
 <1e60ff85-4965-92cb-e50b-8ea9ccf6788e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e60ff85-4965-92cb-e50b-8ea9ccf6788e@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 04:49:50PM +0200, Vegard Nossum wrote:
> FWIW, I *really* like how the extra markup renders in a browser, and I
> don't think I'm the only one.

The thing is, I write code in a text editor, not a browser. When a
header file says: read Documentation/foo I do 'gf' and that file gets
opened in a buffer.

Needing a browser is a fail.

> If you want to read .rst files in a terminal, I would suggest using
> something like this:
> 
> $ pandoc -t plain Documentation/core-api/atomic_ops.rst | less

That doesn't help me with people sending me that abysmal shite in diff
format.


