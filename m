Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F405FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD0022B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n2rI8nqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHJSoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgHJSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:44:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93357C061756;
        Mon, 10 Aug 2020 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PzoXtefc2xa4aDuZ2kahfOK5e4Ic5jpl/FUwSRINSMw=; b=n2rI8nqq9g27Fx4PaBWbXc/5s8
        MaiThRqzynKZI8KRWOT5ciRt4PXAjekSHawWYDocen++frKVMugPmyz5D6d3GgJzzx3w7w4Z115E8
        d7DwQSrgdfEKHY4tZagFh+nlwA9YjlSYXRyt9ahdq1JFk/ppXj+3UZjW7ETam/VVydw4Qzyl/opYq
        GBMkv5SglxD4anzP1i1RZ4JdXYwLvWUTUuUx0n2cxlDtrXRyzEy3XYJVHutecQg8mSBi/DxKS5hVU
        ayW1wfVR3fext3XddEbN1u4U91HkvNRoLew+qr8qplaRy4Hmox7Vjcoj3W1OTheKNs12y+Vp0zsUf
        2xtCPMRw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5CmL-0008PC-DZ; Mon, 10 Aug 2020 18:44:13 +0000
Date:   Mon, 10 Aug 2020 19:44:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver-API: Documentation: Replace deprecated :c:func:
 Usage
Message-ID: <20200810184413.GO17456@casper.infradead.org>
References: <20200810182107.18577-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810182107.18577-1-puranjay12@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:51:07PM +0530, Puranjay Mohan wrote:
> Replace :c:func: with func() as the previous usage is deprecated.

Generally, reflowing text as part of these patches is discouraged,
but I'd make an exception here:

> @@ -135,15 +135,15 @@ Accessing Port Space
>  
>  Accesses to this space are provided through a set of functions which
>  allow 8-bit, 16-bit and 32-bit accesses; also known as byte, word and
> -long. These functions are :c:func:`inb()`, :c:func:`inw()`,
> -:c:func:`inl()`, :c:func:`outb()`, :c:func:`outw()` and
> -:c:func:`outl()`.
> +long. These functions are inb(), inw(),
> +inl(), outb(), outw() and
> +outl().

...
+long. These functions are inb(), inw(), inl(), outb(), outw() and outl().

The others are more of a judgement call where we could go either way.
