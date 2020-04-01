Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A62C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03812054F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbgDAVLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:11:18 -0400
Received: from mx.sdf.org ([205.166.94.20]:49842 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbgDAVLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:11:17 -0400
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 031LB4uG010365
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Wed, 1 Apr 2020 21:11:04 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 031LB4aa013811;
        Wed, 1 Apr 2020 21:11:04 GMT
Date:   Wed, 1 Apr 2020 21:11:04 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>, lkml@sdf.org
Subject: Re: [RFC PATCH v1 36/50] random: Merge batched entropy buffers
Message-ID: <20200401211104.GA2013@SDF.ORG>
References: <202003281643.02SGhLiv003379@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281643.02SGhLiv003379@sdf.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed a rather insidious bug in the preceding, so please
revoke my S-o-b.

Storing the batch position in the first byte works fine if it's
updated very late in get_random_uXX(), after the random value is
read from a refilled batch.  The first few versions of my code
did this.

But then I discovered the "xor trick" to handle unaligned reads
and it hugely simplfiied the code.  It simplified it so much that
the unaligned position wasn't needed much; only to compute the
aligned position.

While squashing together the various revisions to this code, I
moved the write-back of the position earlier in the code..  Which
violates the requirement stated in paragraph 2.  :-(

There are several possible fixes, but the simplest is to move
the "u8 position;" down a couple of lines, out of the union.
Since the following patch reduces the lock to a single byte,
there's room in the structure without increasing its size.

Revised patch will follow.
