Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7256C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B24206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/aRBPTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgDUQ7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgDUQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:59:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9EC061A41;
        Tue, 21 Apr 2020 09:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HtKNGwsPGT9z04MYk90WXK+YrujPBRD7JmkNyPw2IHs=; b=i/aRBPTQWUDJ5ugfiG/m5s5hDC
        yog+BipzBKhfXX/z8klfpu4IJsBAYgiGykAtxBgDFBZx2s4qJgiEe3douRJxjuJL6Kicz6hxR/vrK
        Yf6VDTLIIkCl7voStyG/ijxHU0lv/Ts1m3WnL+yE7IF592hvMU5VK/RICKiYEA/XWh3CAkyojI1hz
        ktHvv5P8xQHJOAqqI4VYAVuHNIoUicXpc7hzeekeGA90qlbEYjyQrTuygYI899TuWml4ynRzGIgf8
        f7mhtFt9GDxvh9HqAA5AhICygPcK9TiIcpzDKUU1VAtQag8EgMoUWlBT9ghnlT/xTmh4T14eGN66D
        YVQ7BAfg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQwFQ-0008HB-Dl; Tue, 21 Apr 2020 16:59:48 +0000
Date:   Tue, 21 Apr 2020 09:59:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 03/15] print_integer: new and improved way of printing
 integers
Message-ID: <20200421165948.GO5820@bombadil.infradead.org>
References: <20200420205743.19964-1-adobriyan@gmail.com>
 <20200420205743.19964-3-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420205743.19964-3-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:57:31PM +0300, Alexey Dobriyan wrote:
> 1) memcpy is done in forward direction
> 	it can be done backwards but nobody does that,

If you're determined to do this, then use memmove() which actually
guarantees to work with overlapping ranges.  Don't rely on non-guaranteed
behaviour of current implementations of memcpy().  Did you really check
the two dozen assembly implementations of memcpy() in the kernel?

> 2) digits can be extracted in a very simple loop which costs only
> 	1 multiplication and shift (division by constant is not division)

> +noinline
> +char *_print_integer_u32(char *p, u32 x)
> +{
> +	do {
> +		*--p = '0' + (x % 10);
> +	} while (x /= 10);
> +	return p;
> +}

Why not do two digits at a time like put_dec() does?

