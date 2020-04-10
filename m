Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44336C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A47620CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g8Vghjl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDJPiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:38:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDJPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l8VIsmPRPr8v5kMqS/+p4+AvU2dJrNR5q5j6y6m9bss=; b=g8Vghjl/BN/1ByHXoBndldGfIQ
        DESR63bbRPlCYQN4u+cDrCG5aOJSvXg4PQdiD3RF4mlgKFgQ5ib3u59SMl0C8ybOcAzs73ejoRV6d
        r8JjSoBKP8dwYDH65B/gOcTcf5U7UH/hhFaP3UkyKHuIImsP9xrDkiXDAhPNDljnqnXJGr8a+R57A
        zMRC8wqi6ccE1Ve+0frtLJlqLz0stxIgjialP8aWo6b+HksDUE8yrPoJtdeZ2bZN19/gCzM/yO9c3
        NHWFo3a4wzj2r0zeP5NFdhM3nwm6JNZfuV/9Rxy8hLy5Igws6fPJ8tfdQCrJrO5c8QTv9nj4KuHUb
        lbpEi2IQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMvjJ-0007BR-Bq; Fri, 10 Apr 2020 15:38:05 +0000
Date:   Fri, 10 Apr 2020 08:38:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>, kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: f45ec5ff16 ("userfaultfd: wp: support swap and page migration"):
 [  140.777858] BUG: Bad rss-counter state mm:b278fc66 type:MM_ANONPAGES
 val:1
Message-ID: <20200410153805.GA21484@bombadil.infradead.org>
References: <20200410002518.GG8179@shao2-debian>
 <20200410073209.11164-1-hdanton@sina.com>
 <20200410153234.GB3172@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410153234.GB3172@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 11:32:34AM -0400, Peter Xu wrote:
> I'm still trying to digest on what's happened... It would be good too
> if more information on the test could be given, e.g., what is the
> behavior of trinity-c2. A reproducer is of course even better.

Trinity is a syscall fuzzer.  Don't expect what it's doing to make any
sense, it's just executing syscalls at random.
