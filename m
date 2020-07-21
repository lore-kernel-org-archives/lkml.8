Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B51C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB21D2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmUoe1GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgGUTv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGUTv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:51:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F09C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P2JzSWRqxLYlDAhbvSb5CG3LChZDp/jOA9dGTX2ajrs=; b=RmUoe1GIlACXI3VqsoIKpR2ggR
        /ulgN5A5y6GA/SpzQkOl8Dy21aof5dCfN3RINM7gRqaYzdN9IJvSuu3hRqU7oygPnd88mnTPrrMoF
        vsKGuNz44x5K6ZAGmOSbSOSzRJgV+VMwT21U2yg00LGrubgkXsngMGD9HIMiiW6QSSiO1bqWNC9KE
        IU0GHjYdFyUi7Rgeay+P0yUz56GJ5A+zC8Dm4FBG3/Dl/T3Cx2BzVlLhNdxjVgGCsgg9vMD8jLZcQ
        6+2tpEsvKpdKyxvYLRLgbekqChLCzIuPdv/QNmAFi1pUPyCf5ee0FAZva7B8wZlKU9M357pjtPvCV
        NRQgPzzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxyIY-0001QV-34; Tue, 21 Jul 2020 19:51:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04366304D28;
        Tue, 21 Jul 2020 21:51:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2EDB29A6A87E; Tue, 21 Jul 2020 21:51:32 +0200 (CEST)
Date:   Tue, 21 Jul 2020 21:51:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Howells <dhowells@redhat.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Message-ID: <20200721195132.GJ10769@hirez.programming.kicks-ass.net>
References: <202006142054.C00B3E9C9@keescook>
 <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <544539.1595328664@warthog.procyon.org.uk>
 <202007211144.A68C31D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007211144.A68C31D@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:44:53AM -0700, Kees Cook wrote:
> On Tue, Jul 21, 2020 at 11:51:04AM +0100, David Howells wrote:
> > Kees Cook <keescook@chromium.org> wrote:
> > 
> > > > Should mm->mm_users also be replaced by refcount_t?
> > > 
> > > I'll say "yes". :)
> > > https://lore.kernel.org/lkml/1487671124-11188-1-git-send-email-elena.reshetova@intel.com/
> > > 
> > > > In addition, is it better to change all variables that use
> > > > atomic_dec_and_test to control the release process to refconut_t?
> > > 
> > > For the most part, yes. The following may find a lot of them:
> > > scripts/coccinelle/api/atomic_as_refcounter.cocci
> > 
> > I've been gradually undoing some of the conversions as there's no equivalent
> > of atomic_add_return() and atomic_dec_return() that allow me to log the
> > altered refcount through a tracepoint.
> 
> Please do not _undo_ the changes; just add the API you need.

add_return and sub_return are horrible interface for refcount, which is
the problem.

If you meant: refcount_dec(), but want the old value for tracing, you
want a different ordering than if you wanted to do
refcount_dec_and_test(); dec_return can't know this.

David, would something like a __refcount_*() API work where there is a
3rd argument (int *), which, if !NULL, will be assigned the old value?

