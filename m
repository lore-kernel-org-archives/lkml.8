Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3567C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDFE21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jRTnLo/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGBRPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGBRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:15:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97597C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AkKtnmHmvL46FS6TSZsGc+QvVSp7DuMXzazIW+80hK0=; b=jRTnLo/s8fZyHcTuIdV5XmRbtl
        TYp8I7siWaanCxhbwrfxQQxjcvi6X+rMQ5zcOm9unFn+6gvGrKysJVMMsyLN6O/gvLY9CElt64Tot
        avdiY9Wsj898soNOG7Em/UmdjAwgik0oDQuaJyRBXzecN+SmtZjhMjL2MdoZMjsHIGGeixnHwTUAF
        YcN1+AJdCsiC+agBv/xd9YC1XjBBYeVzlQxG3P3iWeh3jLH0+oR2TbH5fDdhOAhW12Sn9eNVb1oP0
        Vl+v4gHed2WvoAHhbAhS798yrZmH804iJLmZVfdgbFCr9xwdcD26Y/ikl1UeZ3aXMXVgU9jSjDVXX
        ExHeqA2w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr2nU-0003Ji-5U; Thu, 02 Jul 2020 17:14:52 +0000
Date:   Thu, 2 Jul 2020 18:14:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Long Li <lonuxli.64@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm, slab: Check GFP_SLAB_BUG_MASK before alloc_pages
 in kmalloc_order
Message-ID: <20200702171452.GZ25523@casper.infradead.org>
References: <20200702152759.GA32931@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702152759.GA32931@lilong>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:27:59PM +0000, Long Li wrote:
> ---
> changes in V4:
> -Change the check function name to kmalloc_check_flags()
> -Put the flags check into the kmalloc_check_flags() 

The point of not doing that was that this is unlikely().  With your
change there is now a function call to check something that's (extremely)
unlikely().

I take David's point that I misnamed the function.  maybe kmalloc_fix_flags()?

