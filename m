Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A99C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2620792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I0UZujWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgHEIbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgHEIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:31:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F26C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/yuLYIrVVPyuAM0QkEn26Pt/A0HWWYq0MC6g2XMp15I=; b=I0UZujWpcFzbnEPMxTeE0qsUuB
        OZlCRWTLYMUdHaGJdv5ElNMtV1cb27+1vhMPF0+raFIByv0dTt/khhyWfqotkiYDlIx2fbd889TcD
        5yFYOZSPjjcLlJ918Irf21VaSBTu4uOtCDAZSr1zJW08P2P98swOOVPxPYlS83y/t2GQhJbI+5BAq
        +CBgkmCVH06mxK+Y/RGQhmNizXMb8KbggqQSkelkRcYk6TR2CxCKxXuYIVvcvDCE4LywbZfoJlW6q
        hRqy7yn4E4GNKK23TF64iQ17/gHoGLZHyVTgmMhmg7mh+Eu8S2Fo+WoQlVNV/lgKvPhRwOUoUnXGr
        UVTSEwUg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Epc-0007FO-JO; Wed, 05 Aug 2020 08:31:28 +0000
Date:   Wed, 5 Aug 2020 09:31:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fork cleanup for v5.9
Message-ID: <20200805083128.GA27209@infradead.org>
References: <20200804112801.72380-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804112801.72380-1-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:28:01PM +0200, Christian Brauner wrote:
> High-level this does two main things:
> 1. Remove the double export of both do_fork() and _do_fork() where do_fork()
>    used the incosistent legacy clone calling convention. Now we only export
>    _do_fork() which is based on struct kernel_clone_args.

Can we retire the _do_fork name as well please?  For one we really don't
use single underscore prefix in the kernel, and we also try to avoid our
normal __ prefixes if there is no non-prefixed vesion.  Also the name
feels wrong, as this implements all of clone and not just fork.
What about kernel_clone to match the name of the args structure?

Also none of them actaully is exported (thankfully!).
