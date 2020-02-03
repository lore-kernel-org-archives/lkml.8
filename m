Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B3CC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4932086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BqvVZzQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBCOIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:08:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgBCOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lt47hYwOCoEtYAhzMex6bTbOJB2FvP8uV0M22yI0zbQ=; b=BqvVZzQfc0l/w2F6dxoJApRy3n
        0twzi1ocyjdc8kDScFLn9VR+H75MeIXjD7BM8PBa26NjVKhx3K4gpbFiz00nk4iavDndzbEOSgpSg
        +8R0HniQJO4IymC7s1LlKTC4kaey5Yz4p2TJr3rXCKXmBufK9f18EzzPyVs6TYG7ESbeOkhBnS6Nr
        T5YwOLSgm7sCU7kJSY7ml6oRnaYydC7p8gH+M0TBMrhdikLwKAbW/vJ69k6jZgmrr0hUF7bBloh9O
        Bvmgf1+Avr39ovsmmtKq9IA1jjI1kiDGQ9i6/V4bdy1axE5YolH+KpI9raARWbj2XGEZQOk5jTxQj
        5vB+b9VA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iycOh-0003E0-OK; Mon, 03 Feb 2020 14:08:19 +0000
Date:   Mon, 3 Feb 2020 06:08:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gustavo@embeddedor.com, Clemens Ladisch <clemens@ladisch.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: Current Linus tree protection fault in __kmalloc
Message-ID: <20200203140819.GI8731@bombadil.infradead.org>
References: <20200203012702.GA8731@bombadil.infradead.org>
 <CACVXFVPyW9+oSPAv7-+=hExzktLkmPG=gYUY5acR5UGeJzTh0Q@mail.gmail.com>
 <20200203132334.GH8731@bombadil.infradead.org>
 <CACVXFVNqP=oEZNiu=nebJ5EKKXfMfq7e=M1Ko1_TVw-FJTUpZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVNqP=oEZNiu=nebJ5EKKXfMfq7e=M1Ko1_TVw-FJTUpZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 09:37:11PM +0800, Ming Lei wrote:
> My git bisect is just done, and it points to the following commit:
> 
> commit 987f028b8637cfa7658aa456ae73f8f21a7a7f6f
> Author: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Date:   Mon Jan 20 17:53:26 2020 -0600
> 
>     char: hpet: Use flexible-array member
> 
> I have double checked the commit, and looks it is really the 1st bad one.

Looks like this patch will fix it then:

https://lore.kernel.org/lkml/202001300450.00U4ocvS083098@www262.sakura.ne.jp/
