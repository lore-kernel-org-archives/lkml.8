Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECD0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBDB206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586522661;
	bh=CUa1+hFqvCFBDzh9953S1reA+cSlnUCI3GJGVkQCVBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ghCFJc5S+Jx+Zoj/tyK8p+g9dnsJlVVZWm/gQOzErbSNTlz5ibh943ooOnbtDskQQ
	 dEixf722sIIZPJd2yjyP0jLddXMKmbKahazdC8LAPhbYO3PLj0sCNLX/+8UI+qaMuy
	 OrWWlM1m/66kSFtlvy+o9l7Pzz0Qemu1U8zNbWIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDJMoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDJMoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 08:44:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20CC20769;
        Fri, 10 Apr 2020 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586522657;
        bh=CUa1+hFqvCFBDzh9953S1reA+cSlnUCI3GJGVkQCVBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyKUuxQJ6wntPFoJ/xbDgcBoS4XbrTowG9Bpqhpqz3OZ0HDdH2GlnG8fTFhnwtasP
         pAZQQU0j1bfEBrkO0BVolWbswPmY6xRQuyIrRvuEgwYrnFtRgfKgutsv1eu22U5kSe
         uozERvwqmFvaUnbyaj2FOPe5D6eKp7Y7+dpLjkIo=
Date:   Fri, 10 Apr 2020 14:44:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Orson Zhai <orson.unisoc@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com, Orson Zhai <orson.zhai@unisoc.com>
Subject: Re: [PATCH] dynamic_debug: Add an option to enable dynamic debug for
 modules only
Message-ID: <20200410124414.GB2091460@kroah.com>
References: <1586521984-5890-1-git-send-email-orson.unisoc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586521984-5890-1-git-send-email-orson.unisoc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 08:33:04PM +0800, Orson Zhai wrote:
> From: Orson Zhai <orson.zhai@unisoc.com>
> 
> Instead of enabling dynamic debug globally with CONFIG_DYNAMIC_DEBUG,
> CONFIG_DYNAMIC_DEBUG_CORE will only enable core function of dynamic
> debug. With the DEBUG_MODULE defined for any modules, dynamic debug
> will be tied to them.
> 
> This is useful for people who only want to enable dynamic debug for
> kernel modules without worrying about kernel image size and memory
> consumption is increasing too much.
> 
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>  Documentation/admin-guide/dynamic-debug-howto.rst |  7 +++++--
>  include/linux/dev_printk.h                        |  6 ++++--
>  include/linux/dynamic_debug.h                     |  2 +-
>  include/linux/printk.h                            | 14 +++++++++-----
>  lib/Kconfig.debug                                 | 12 ++++++++++++
>  lib/Makefile                                      |  2 +-
>  lib/dynamic_debug.c                               |  9 +++++++--
>  7 files changed, 39 insertions(+), 13 deletions(-)

Crazy idea, I like it :)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
