Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAA720774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rQF9QclW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgHNRqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:46:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A4C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kYAQV0Tbe/Xkg6dDIRNNv2tqIRDwN5EAzR9Dc9+lDxA=; b=rQF9QclWzmH/lzMkTLJY7+O9L6
        v5PRKMXyA+vkFlN0Lo1x5yd5CR8Rpu41bsk4iwJicoeaJM777EjiHiWTIyoTJhT3jWjM1OANg2wCX
        1ffXx8thZ+jPHEfDjJRp8Em6hYcncLSUvi+oCiJIyBq6stJ5pgOp9U0JEKV7nUU9Nk6bwlglow5YM
        HDY1ueNIb4SqBiipfxSG0ncwWOEY0NRzu3g/dX6OxPiJIFuRJSEnh4sWPH50UOctqOHiiWLlTCbgq
        w7bsbthoIeQYauFXftbzU6Wg+82aWQyXT442gUWLTlz5+Nezqx92iY52IogxAyJWWxxP07k+tZxf/
        tA5RPhGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6dmf-0002lN-3f; Fri, 14 Aug 2020 17:46:29 +0000
Date:   Fri, 14 Aug 2020 18:46:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Roman Gushchin <klamm@yandex-team.ru>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm : update ra->ra_pages if it's NOT equal to
 bdi->ra_pages
Message-ID: <20200814174629.GY17456@casper.infradead.org>
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20200814014355.GS17456@casper.infradead.org>
 <20200814020700.GT17456@casper.infradead.org>
 <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
 <20200813193307.d5597367b7964d95f63e4580@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813193307.d5597367b7964d95f63e4580@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 07:33:07PM -0700, Andrew Morton wrote:
> On Fri, 14 Aug 2020 10:20:11 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > No, What I want to fix is the file within one process's context  keeps
> > using the initialized value when it is opened and not sync with new
> > value when bdi->ra_pages changes.
> 
> So you're saying that
> 
> 	echo xxx > /sys/block/dm/queue/read_ahead_kb
> 
> does not affect presently-open files, and you believe that it should do
> so?
> 
> I guess that could be a reasonable thing to want - it's reasonable for
> a user to expect that writing to a global tunable will take immediate
> global effect.  I guess.

But it's also reasonable for someone to have written an application
assuming that the current behaviour won't change.

As I understand it, if we change net.ipv4.tcp_window_scaling, that will
take effect only for new connections, and not for existing ones.

I think the _real_ problem is that readahead never scales down, except
for EIO.

I don't have time to take on another project right now, but I think this
patch is too simplistic and has too many downsides.  Someone needs to
really think the readahead situation through properly.
