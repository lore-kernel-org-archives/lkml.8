Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E217CC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54D1222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pawyRIvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBZE0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:26:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgBZE0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=83gDoyDlnRQ/ZUqMgV7ChYjSt3jJJvA9vZlseimex1Y=; b=pawyRIvmy4QVbsg2s7gnmOZlHm
        UCJNxH3pJFYYqipwSdDMobdwn+tkrAO9GinrkGIqpZqfBgSTQFdBeXD6MqBTE7hQiqdwU6XdFsX4+
        oDqAh40wi9qsuEk00YDof3l/yDqeCGb7s2nPCBd46c4RgVqOX7uR6h3w3BHNv40AV3keYDBoNL+kB
        6Xzul0EAVJtoxLaWRkdWNHRaDYkF2j35T+UyTAR8WRNbSbskvcpAAq4s4LbbA7CTyoXyjopy0GNmO
        nvsU1yb7a9SNhDQqBJYablcToEOhZKdNilpi497dx/R8So3Ws9iQQXPS6acZ3rLWuSh4GFmdmlIrL
        aox+OZsQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6oH7-0004qr-Jh; Wed, 26 Feb 2020 04:26:21 +0000
Subject: Re: [PATCH 1/2] quickstats, kernel sample collector
To:     Luigi Rizzo <lrizzo@google.com>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, naveen.n.rao@linux.ibm.com,
        changbin.du@intel.com, ardb@kernel.org, rizzo@iet.unipi.it,
        pabeni@redhat.com, toke@redhat.com, hawk@kernel.org
References: <20200226023027.218365-1-lrizzo@google.com>
 <20200226023027.218365-2-lrizzo@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c8101a7e-97a2-a32f-39d0-e6a229153398@infradead.org>
Date:   Tue, 25 Feb 2020 20:26:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226023027.218365-2-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Aside: in patch 0, is "abube" a typo?
Data are exported or controlled as abube.
)

For both patch 1 & patch 2, please use the expected/documented multi-line
comment style (in Documentation/process/coding-style.rst):

The preferred style for long (multi-line) comments is:
{except in net/ and drivers/net/}

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

On 2/25/20 6:30 PM, Luigi Rizzo wrote:
> quickstats is a helper to accumulate in-kernel samples (timestamps,
> sizes, etc) and show distributions through debugfs. Compiled as a module
> by default; set CONFIG_QUICKSTATS=y in your config to make it compiled in.

For inclusion in the kernel source tree, it should default to n, not m.

[snip]


> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  include/linux/kstats.h |  61 +++++++++
>  lib/Kconfig.debug      |   7 +
>  lib/Makefile           |   1 +
>  lib/kstats.c           | 303 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 372 insertions(+)
>  create mode 100644 include/linux/kstats.h
>  create mode 100644 lib/kstats.c
> 

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 69def4a9df009..d581ad075d438 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1452,6 +1452,13 @@ config LATENCYTOP
>  	  Enable this option if you want to use the LatencyTOP tool
>  	  to find out which userspace is blocking on what kernel operations.
>  
> +config QUICKSTATS
> +	tristate "collect percpu metrics and export distributions through debugfs"
> +	default m

Drop the "default m".
Add:	depends on DEBUG_FS

This code should build OK even when CONFIG_DEBUG_FS is not set/enabled,
but it seems that it would be useless in that case.


> +	help
> +	  Helper library to collect percpu kernel metrics, exporting
> +	  distributions through debugfs. See kernel/kstats.c
> +
>  source "kernel/trace/Kconfig"
>  
>  config PROVIDE_OHCI1394_DMA_INIT


thanks.
-- 
~Randy

