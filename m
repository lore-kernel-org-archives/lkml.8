Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A66CC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2AB206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3hbUWtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgEKPif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:38:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D55C061A0C;
        Mon, 11 May 2020 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=epwIJHUpefyX5kpcs/QOa15gIm+1CuDSPCRY6Ylps0M=; b=J3hbUWtG/JEACB0SgePeSJmIHu
        DbaCxKDF4C5qETHjpLYd/xo1qdZVCNr1RbRyN7d6UyYG+hcVvmYN3txj6nKHu9Vs0DreFxEyNhjjd
        0GmHNp7Jb9MuoEhaIJUaX/iqeZdEuT0eC53lye9aSyLxaqizwkvrioIs3zjjWUOW9+ndpSywdW0hp
        QpNDeaewFPA9Ko4b4CcONlU9EJ5qY7UssEunKSt7o/mBoWjDtffal/I/6dmz3Cr9ck4u3zuLYGVJ3
        i7TPWqAE+scSTAERazZD6F35FHeMnCFfd2XVd4LoojpW1i2ZrtVkbJFPvINhUzIur/pQXjwyth4Pl
        bJxyuZxw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYAVl-000217-Mp; Mon, 11 May 2020 15:38:33 +0000
Subject: Re: [PATCH v7 11/18] pstore/zone,blk: Add console frontend support
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
 <20200510202436.63222-12-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <db0ae27c-8e96-9b85-9526-920800da4755@infradead.org>
Date:   Mon, 11 May 2020 08:38:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510202436.63222-12-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 1:24 PM, Kees Cook wrote:
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index f18cd126d83f..f1484f751c5e 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -236,3 +236,15 @@ config PSTORE_BLK_PMSG_SIZE
>  
>  	  NOTE that, both Kconfig and module parameters can configure
>  	  pstore/blk, but module parameters have priority over Kconfig.
> +
> +config PSTORE_BLK_CONSOLE_SIZE
> +	int "Size in Kbytes of console to store"

maybe	                    of console log to store"

since my console size is not measured in Kbytes.

> +	depends on PSTORE_BLK
> +	depends on PSTORE_CONSOLE
> +	default 64
> +	help
> +	  This just sets size of console (console_size) for pstore/blk. The

	                         console log

> +	  size is in KB and must be a multiple of 4.
> +
> +	  NOTE that, both Kconfig and module parameters can configure
> +	  pstore/blk, but module parameters have priority over Kconfig.


-- 
~Randy

