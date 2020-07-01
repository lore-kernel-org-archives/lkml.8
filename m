Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F63C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7833E206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KCwg4O7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbgGAOhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbgGAOhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:37:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870EBC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nH8QNwrKlviELTskqf12JsWIRCsmRrJ2DNsTml5Mm7I=; b=KCwg4O7rS7cNj/rqSOCMhTBzNM
        +yfZI+4K21q2QlZV4+M/xNZo/eHuOkwjYr1EK9Choecy9D9R7fb69hjNKSvMRpKY2vtGQEV9/ydNt
        1rin8Pi5InBgPm4VeNYCM2G13G/UjsEpZx3v9pH/6wASi1GOwurbCgt4/+pR7rhRmHbB41UOPv4za
        u0BuuUZkcnS4kdFCv4UdPuS5NCW9PMt+QElM9BtNLV0gUJ4FHA5Q0XAMEv0M+WVf13YjpwQUqLHv8
        SE7DEgWx15yGq04lbusARK2mMjcJ5LHUseM3QjcJ45efEbBgwAqdfcdQtioodVXVW2pf3h+kTlCHt
        0m4WfKZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqdrh-0001Fx-Sz; Wed, 01 Jul 2020 14:37:34 +0000
Date:   Wed, 1 Jul 2020 15:37:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: alternative to xa_for_each?
Message-ID: <20200701143733.GR25523@casper.infradead.org>
References: <20200701060239.GA27121@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701060239.GA27121@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 07:02:39AM +0100, Christoph Hellwig wrote:
> Hi Matthew,
> 
> I'm just reviewing a patch adding an xarray user, and I'm wondering
> if we could just replace xa_for_each with a loop on
> xa_find_after with a magic index to start from the beginning?  That
> would always seem like more readable code than the magic looping macro.

The problem is that there is no index we can use for that purpose.
xa_find_after(0) should return the entry at 1 (or higher).
xa_find_after(ULONG_MAX) should return NULL.  The xas_ version doesn't
have this problem because we can distinguish between "first time" and
"subsequent time" by values in the xa_state.

> And while we're at it:  is there an idiomatic way to get the entry with
> the highest index?

That's something I need to add.  I think I did it once but then the user
went away.
