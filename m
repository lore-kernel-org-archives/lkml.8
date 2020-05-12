Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02684C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C291720674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5skZfzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgELISe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgELISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:18:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D69C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fzXWi7XnwojoLXJd76cQwXCP7NYbm2GSHaGqNztZoLI=; b=d5skZfzU1mZbdJQzGej8iouOYG
        ZFAIzQc053cmUAHN1y1vvB5aSF6pgwffK2OGdehEXnLFHE3G8F7rwQOMGd9cgXMmHdh3esRY2Cu4H
        3h+NhCqR+/hHWCI/BTjHIaCScHZqKI8Af5mWqUad5usD09fFNlbNa50FUSxGk04kVzKdLVfEClNHr
        S8Hc6nrFsBdvV6glHMjY1mwDkoy0BorSWxvu1v0hV5I4je57p7CQKa/VyDGOufppAPfZsOzv15qIx
        M6VEJzq/p3FYURPl+JYZGXfJJgA7zMH3UfGApB+nQiF3TiMZMfVe6Jt0X0RigyZj2VaIYqBDyUu76
        KcdHXExg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYQ7Q-0005b0-Dt; Tue, 12 May 2020 08:18:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3333300261;
        Tue, 12 May 2020 10:18:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A8EF2037216B; Tue, 12 May 2020 10:18:26 +0200 (CEST)
Date:   Tue, 12 May 2020 10:18:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200512081826.GE2978@hirez.programming.kicks-ass.net>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:41:32PM +0100, Will Deacon wrote:
> Hi folks,
> 
> (trimmed CC list since v4 since this is largely just a rebase)
> 
> This is version five of the READ_ONCE() codegen improvement series that
> I've previously posted here:
> 
> RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
> v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org
> v3:  https://lore.kernel.org/lkml/20200415165218.20251-1-will@kernel.org
> v4:  https://lore.kernel.org/lkml/20200421151537.19241-1-will@kernel.org
> 
> The main change since v4 is that this is now based on top of the KCSAN
> changes queued in -tip (locking/kcsan) and therefore contains the patches
> necessary to avoid breaking sparc32 as well as some cleanups to
> consolidate {READ,WRITE}_ONCE() and data_race().
> 
> Other changes include:
> 
>   * Treat 'char' as distinct from 'signed char' and 'unsigned char' for
>     __builtin_types_compatible_p()
> 
>   * Add a compile-time assertion that the argument to READ_ONCE_NOCHECK()
>     points at something the same size as 'unsigned long'
> 
> I'm happy for all of this to go via -tip, or I can take it via arm64.

Looks good to me; Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
