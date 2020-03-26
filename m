Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4217AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CB820722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYUIFzAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgCZTyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:54:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgCZTyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qBHJQbHLQF5fkECeKcaVm9P1eGfOjzxiiidEad5lOk0=; b=qYUIFzAtI84UJLvuJGcNV+sO/w
        SSvEvCyVIHdUEkaeu1Ab3448vSH9GWkQdoya+vLKZig1NWhJuFGdaoAbYlNaixUGgkmkO8scdsM9o
        kkuN88Zz4/l/JiR7Dq3BDnRmOPjJgKRygtDYEjW8FM51VU6tPyrRcnDnqX4u0xHonq33djUEpFbRT
        lVJDRivxv9EaiFLuQG9Ov1N7f7OF8tfkA7cpX+lfQwi4BKaqJFBCMC1Z8Q86p8e+4QMenAif9wlx6
        ZIfCunk+1+tP2NHsRghq0z512sFGi5fmMw4hBGfHUNCliW7M5AB/mVhG5QlpEfrUm14g/IIasmZQ+
        I+pyjxNQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHYa4-0005Xg-FA; Thu, 26 Mar 2020 19:54:20 +0000
Date:   Thu, 26 Mar 2020 12:54:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     peter@bikeshed.quignogs.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/1] A compact idiom to add code examples in kerneldoc
 comments.
Message-ID: <20200326195420.GO22483@bombadil.infradead.org>
References: <20200326192947.GM22483@bombadil.infradead.org>
 <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
 <20200326195156.11858-2-peter@bikeshed.quignogs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326195156.11858-2-peter@bikeshed.quignogs.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:51:56PM +0000, peter@bikeshed.quignogs.org.uk wrote:
> From: Peter Lister <peter@bikeshed.quignogs.org.uk>
> 
> scripts/kernel-doc - When a double colon follows a section heading
> (e.g. Example::), write a double colon line to the ReST output to make
> the following text (e.g. a code snippet) into a literal block.
> 
> drivers/base/platform.c - Changed Example: headings to Example:: to
> literalise code snippets as above.
> 
> This patch also removes two kerneldoc build warnings:
> ./drivers/base/platform.c:134: WARNING: Unexpected indentation.
> ./drivers/base/platform.c:213: WARNING: Unexpected indentation.
> 
> Signed-off-by: Peter Lister <peter@bikeshed.quignogs.org.uk>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

(just to be clear, I'm no python programmer; I like the idea and it
looks clear enough to me)
