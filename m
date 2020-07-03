Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED634C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA67B206BE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OC/CRBEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGCOzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGCOzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:55:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB821C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CvKKH16oZBhNB/eW42Qi1UVOuy1Z/Oy4YKpmWORlVSo=; b=OC/CRBEsrpuFKEbrcoPlPOG7BW
        ll9zEEMzc5rte9m9HmvaDfQpBGIavsHMgaAHtrSjIWV7cmXKKPTuZ2AOjXx0YOpNKW3rMlwXtQ8/l
        XOP5tbE0W+8A/axbVKtN7mQ0ufGvVhBH8YHcfxT08Nab1skrcbycqTmVqZ8jJDK8REcOKpiXxXnRM
        /7hwmjnaYrCjZxaES/Pv7wL1pnntuKWS+cIAt+Rjr29IFGbLMRDRw/O2cF4y6u7WWc3HZH7bhb/jt
        L2usbH/cgRWXS7YC2YEVnvSpYHKHkFlfG7IZqT1xkYtSJenXKYjfwPCPnRrgzL8u9S/dR/zFxOGQ7
        GEhBtufw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrN5a-000827-VW; Fri, 03 Jul 2020 14:54:55 +0000
Date:   Fri, 3 Jul 2020 15:54:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     trix@redhat.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: initialize return of vm_insert_pages
Message-ID: <20200703145454.GH25523@casper.infradead.org>
References: <20200703145202.10629-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703145202.10629-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 07:52:02AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports a garbage return
> 
> In file included from mm/memory.c:84:
> mm/memory.c:1612:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
>         return err;
>         ^~~~~~~~~~
> 
> The setting of err depends on a loop executing.
> So initialize err.

I'd argue that returning zero is wrong.  If someone's asked to insert
zero pages, that's a nonsense thing to do so it should return -EINVAL..
