Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566E4C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241462071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnI59is+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgHZKUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgHZKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:20:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC8C061574;
        Wed, 26 Aug 2020 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dK54gVnnFy7pciYtW/SwTc/MtpITyhwOr681Mcut1ZE=; b=QnI59is+0973mjiRBzv9QwXVLR
        S+2jm2IM/mKa/MbnFewPVnjTyj/m10ob5OT1T7EXdoqH6jxF80BLPOEakYl7L5i/kJzkUI8KOtNI6
        nswXPNly7Esre9mxaDdyPWFYhCF4Ih4J0Zr++bt0TUzTqd3W4EPoktnjjqF3LZjr9OMx1pqtJlZsQ
        dISCVH1eTmjnmICeCn6Qf6/Afq92UXK8R0WznI3I2z5RpI+241hVlok7nPFdAvEYGDx49BTpERhne
        vsRXie25PLSSnspCTPXjGFMrdup/t0dw+jbE7N5qbP3615e6wYRWw0lzSYs1nVgcx5Jx4AyduYQq+
        P2sub1wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAsXS-0006Lq-Kt; Wed, 26 Aug 2020 10:20:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71D243006D0;
        Wed, 26 Aug 2020 12:20:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 125D12BFE5A34; Wed, 26 Aug 2020 12:20:17 +0200 (CEST)
Date:   Wed, 26 Aug 2020 12:20:17 +0200
From:   peterz@infradead.org
To:     yamada.masahiro@socionext.com
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH -v2] scipts/tags.sh: Add custom sort order
Message-ID: <20200826102017.GT35926@hirez.programming.kicks-ass.net>
References: <20200805102550.GO2674@hirez.programming.kicks-ass.net>
 <20200806120438.GG35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806120438.GG35926@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 02:04:38PM +0200, peterz@infradead.org wrote:
> 
> One long standing annoyance I have with using vim-tags is that our tags
> file is not properly sorted. That is, the sorting exhuberant Ctags does
> is only on the tag itself.
> 
> The problem with that is that, for example, the tag 'mutex' appears a
> mere 505 times, 492 of those are structure members. However it is _far_
> more likely that someone wants the struct definition when looking for
> the mutex tag than any of those members. However, due to the nature of
> the sorting, the struct definition will not be first.
> 
> So add a script that does a custom sort of the tags file, taking the tag
> kind into account.
> 
> The kind ordering is roughly: 'type', 'function', 'macro', 'enum', rest.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

ping?
