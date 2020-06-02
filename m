Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA87C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DDD206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eosk0M6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgFBRgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgFBRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:36:39 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A15C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h/a8DJ2EinTq8uzlA9vH8s3fN2Vz7r1F26+b/HdqMQc=; b=Eosk0M6OwjlKxotXET8571OT2S
        ZikpmaaB6cRhj5EUcC29Ghf/FLmZUXkY8LMLp2zplj77GZEHd1jIb3bhy9rGUZLPos+jleDlDsbNX
        ufD3C+9eCPZ5YrJ/cwO1TGBan/HzlMxL4DEzavYTL9NfhFX4K98f9iETKXWN6x4LHEWbak+1/Ym8W
        +dYqRXHjkvHXjptr+k2PuIuXF51djl1XWhR+/Pe6Ejln6yoCZc3aNm42tUlb4YwKNmMNYsRP+aNvP
        Y/FuppsGrPE0eylgEW4Eg9fKk8p7/ToKIrt9eCdQMDAkNUWpNneXMYk+pILTUAbiKVjtMyy7gkrjZ
        tyuxkOxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgApp-0000Tb-1y; Tue, 02 Jun 2020 17:36:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF384301AC6;
        Tue,  2 Jun 2020 19:36:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D13D42022DEAB; Tue,  2 Jun 2020 19:36:19 +0200 (CEST)
Date:   Tue, 2 Jun 2020 19:36:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: Prefer '__no_kcsan inline' in test
Message-ID: <20200602173619.GA2604@hirez.programming.kicks-ass.net>
References: <20200602143633.104439-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602143633.104439-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:36:33PM +0200, Marco Elver wrote:
> Instead of __no_kcsan_or_inline, prefer '__no_kcsan inline' in test --
> this is in case we decide to remove __no_kcsan_or_inline.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> 
> Hi Paul,
> 
> This is to prepare eventual removal of __no_kcsan_or_inline, and avoid a
> series that doesn't apply to anything other than -next (because some
> bits are in -tip and the test only in -rcu; although this problem might
> be solved in 2 weeks). This patch is to make sure in case the
> __kcsan_or_inline series is based on -tip, integration in -next doesn't
> cause problems.
> 
> This came up in
> https://lkml.kernel.org/r/20200529185923.GO706495@hirez.programming.kicks-ass.net

Thanks Marco!

I just sent the rest of that patch here:

  https://lkml.kernel.org/r/20200602173103.931412766@infradead.org



