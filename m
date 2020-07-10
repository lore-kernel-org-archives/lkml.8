Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C21C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C225207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UCxbXM/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGJNxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgGJNxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:53:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D03C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ey6uKFbNSnOPCZZza0xaCAwIsnIW4VILi+2xhSgWe/s=; b=UCxbXM/kVZe69IRi0UZIwVKCLP
        T0He1JuTeSqeB5GKa3llJnwxidsw7IvHdSNUIp9a978KMI1fm78/6dcO3Sx73L99JnaTxvtzlv5+0
        sbiumvbHy/OtapkXVKKwUzwEBwwG0DegP8Z//S7CkhS9dvYZJEvp5sb/Fs+d+K0p5d7RBLkFpTt2Y
        hNox503bzpITX/aODa9FTKlymXIvST6t+xS1H9EZ8mE+vlqpbJ3CjJnWHCUQ280wFSj/6Dr5T/yWt
        XfCNE+BZnuKrxm7rWqD7a/q1yvRR0siboC3+uj+ALjEy14+GNnsJtjdiy0PdaQW003R71r9uSTOaI
        bUGP8DxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttSX-0004Vm-Ri; Fri, 10 Jul 2020 13:53:01 +0000
Date:   Fri, 10 Jul 2020 14:53:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3] vmalloc: Add the right hint when vmalloc failed
Message-ID: <20200710135301.GM12769@casper.infradead.org>
References: <1594383472-52983-1-git-send-email-tiantao6@hisilicon.com>
 <20200710124323.GJ12769@casper.infradead.org>
 <20200710134956.GA14549@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710134956.GA14549@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:49:56PM +0200, Uladzislau Rezki wrote:
> > On Fri, Jul 10, 2020 at 08:17:52PM +0800, Tian Tao wrote:
> > > In fact "vmalloc=<size>" cmdline option is not available on many
> > > platforms.When the user encounters this error, add the correct
> > > hint to prevent misleading.
> > 
> > i don't think this is an improvement.
> >
> Matthew, maybe it should not be considered as improvements?

Every patch should be an improvement along some dimension.  This doesn't
feel like an improvement in any way.

> It is rather an extra information that indicates that your
> ARCH may not support "vmalloc" early parameter.

If anything needs to be improved, it's the documentation, not this
error message.
