Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC9BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D427206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WXh8K6dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgEKPhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729207AbgEKPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:37:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECC5C061A0C;
        Mon, 11 May 2020 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
        Subject:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=d1W/NZGeiY5JP7NkI0N/PUJK+J1IKqZshzJsy5W4acs=; b=WXh8K6dkS7goWNfFNd6esBTWyo
        HJct8mK7wnVX5QuLJYM1ks4j0uSaGqJqhXgIaPRn303QyR33S1UNVsTSWZkFgeUW4Yd5Q45SnjOYN
        0JP3e79AEtNhWmfBDGJzF8JvWHZXP7q+ytnbDf7tXiDHx+W8ZRJLVIUAHrWgXTppatj6zrT3mKOUv
        aPivgfaGk2liOOoAPuZYF8mH1QiDmkJPaFLqJngCuqcXLntxTmKa5r0D8ccnIg368rp3HCNtUyBa/
        dWcwkvsYl0rtsFC4B2MplR1otjTMn/LZxU5pGMjb3dg6aUX1JIvVCzB6e9j2JIxsuIHFqZcqKIdQj
        N/F1OB0Q==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYAUM-0001dj-In; Mon, 11 May 2020 15:37:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 12/18] pstore/zone,blk: Add ftrace frontend support
To:     Kees Cook <keescook@chromium.org>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20200510202436.63222-1-keescook@chromium.org>
 <20200510202436.63222-13-keescook@chromium.org>
Message-ID: <c48617f0-0697-e7e9-ee14-718e6cea0e28@infradead.org>
Date:   Mon, 11 May 2020 08:37:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510202436.63222-13-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 1:24 PM, Kees Cook wrote:
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index f1484f751c5e..16a0440d8d5a 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -248,3 +248,15 @@ config PSTORE_BLK_CONSOLE_SIZE
>  
>  	  NOTE that, both Kconfig and module parameters can configure
>  	  pstore/blk, but module parameters have priority over Kconfig.
> +
> +config PSTORE_BLK_FTRACE_SIZE
> +	int "Size in Kbytes of ftarce to store"

	                       ftrace

but I don't know what this prompt string means.
Could it possibly be "Size in Kbytes of ftrace log to store"?

> +	depends on PSTORE_BLK
> +	depends on PSTORE_FTRACE
> +	default 64
> +	help
> +	  This just sets size of ftrace (ftrace_size) for pstore/blk. The
> +	  size is in KB and must be a multiple of 4.
> +
> +	  NOTE that, both Kconfig and module parameters can configure
> +	  pstore/blk, but module parameters have priority over Kconfig.


-- 
~Randy

