Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C4CC41604
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3D7230FF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vMRW28d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgHFJ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgHFJZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:25:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B327FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uwezxHeiyaP46V7+gw/LOWQd5VBMStsMPyZz8mwar24=; b=vMRW28d8XB+LZ5/F3umjcu/6s1
        JHiPpaXc8g6GMXfgxJmovJDNR85MQigTyuMIc87kgKR8w1ybRJ6EJGS/8wokC7SWRiJG4l2cqIa8O
        ph1ZgeflH0bhuhMQB/nWqBkZicGkUITCREPG3bLaL3HtanQuN+eq6dvpoJi8bwKRGZiXrGG99uaDc
        tTeOtTmBq8DOdfXQggCi3dhHv3WXjKJVPlI1fxXBb7wxOzFJQmaSFQ+EqW40m6kkVQy2/qYB2GMXj
        VBS7Uxr+iQfqyG6ynPUuysB6SQQZIUdrfKObvvVhV3U8QPTTt51QrHx2/e4DMH2VO6zrNTYm2/4hg
        Mpc9ptlg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3c9j-0000nU-Ou; Thu, 06 Aug 2020 09:25:47 +0000
Date:   Thu, 6 Aug 2020 10:25:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/signal: Move and simplify get_clean_sp()
Message-ID: <20200806092547.GA2544@infradead.org>
References: <04169f40c09682ce5747518268ca84285bc17fbc.1596703345.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04169f40c09682ce5747518268ca84285bc17fbc.1596703345.git.christophe.leroy@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 08:50:20AM +0000, Christophe Leroy wrote:
> get_clean_sp() is only used in kernel/signal.c . Move it there.
> 
> And GCC is smart enough to reduce the function when on PPC32, no
> need of a special PPC32 simple version.

What about just open coding it in the only caller, which would seem even
cleaner?
