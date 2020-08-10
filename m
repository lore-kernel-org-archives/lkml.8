Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB200C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9A22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qljNspzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgHJSmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgHJSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:42:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC28C061756;
        Mon, 10 Aug 2020 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bg4wvYCFgi2LJkMB+zazI0Hb6qHpqkIiplriJYhyPmc=; b=qljNspzFLEaIRvIDjm9Uo01u4F
        OvUHxPOY5yUkahjC53iyj0bEiTUjIkwcF4b6kAnx5vJmjO/YM8ZMH8CGiMPSM5JiNmt/BnWtjnm6M
        LW647o5GKDA7C3wdgao3k8bAkVcFv9f0RJIrN+qBOyWw6XRKWQxCFAzW4IG4/DGeJ2ix9+cPWvuYi
        WkpzYDTTOTnxlkxXIfpjBu20/B91RRBXYQoxfAx0tBqmNNnNGWtIcjX9ZQWKRIvh9rRh9jiWdSWEs
        RPr9dKvx3FDMXGCnsq6s43c4nsf2tmODQe0+YsJkiUQ/8r4JsBYIH12s3r9N1v2uHgfhiODSpHWff
        td2vRrfg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Ck5-0008MI-Vu; Mon, 10 Aug 2020 18:41:54 +0000
Date:   Mon, 10 Aug 2020 19:41:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Core-api: Documentation: Replace deprecated :c:func:
 Usage
Message-ID: <20200810184153.GN17456@casper.infradead.org>
References: <20200810183019.22170-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810183019.22170-1-puranjay12@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:00:19AM +0530, Puranjay Mohan wrote:
> Replace :c:func: with func() as the previous usage is deprecated.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Jon, I'm comfortable with you merging this through the docs tree.
Looks like we also need:

+++ b/MAINTAINERS
@@ -18686,6 +18686,7 @@ XARRAY
 M:     Matthew Wilcox <willy@infradead.org>
 L:     linux-fsdevel@vger.kernel.org
 S:     Supported
+F:     Documentation/core-api/idr.rst
 F:     Documentation/core-api/xarray.rst
 F:     include/linux/idr.h
 F:     include/linux/xarray.h

but i can do that in the xarray tree.

