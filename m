Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4ABC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB4A206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQQ8JUaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgEKPg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729207AbgEKPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:36:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A0DC061A0C;
        Mon, 11 May 2020 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=amgk2kJlCbYp1G7kuYGnL7Ih27zYi++B9lrM3oyQ2eI=; b=YQQ8JUaDtgcYpTofYqCyLiD9b6
        lieYTmBAmmqWEyEgpmyeqBxWCZHSyOAfqQ1HS5jHqbQc6Ib1ZoWZy6yAozq6YzvfEa86XUrgyeaCt
        /uvm0n2yfJQxbKAAlh5Uf/4RQX6fbN3EqQX8gnwcWzpYOtRs9i4Ql6dAEzTY1pzbBh4aljvIpmZKL
        6n/8IrW38tR+AOUpl2kru4iU9Mtme9ahZvf7BaH+MyXdcKRMttZtwAcvQHYWBgKAva79Sb2A10GT+
        em/jtrmjNxX5BCrD9xGDELFNw0/WXZQe2/2YozUJXUcVIMy7taWdHINHfrCaqutrgGqJJfDIk+v9g
        7tPvHy9w==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYAU8-0001Rk-Mk; Mon, 11 May 2020 15:36:52 +0000
Subject: Re: [PATCH v7 09/18] pstore/blk: Introduce backend for block devices
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
 <20200510202436.63222-10-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b4fec3e-53f7-b8d9-49f8-d24401f83363@infradead.org>
Date:   Mon, 11 May 2020 08:36:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510202436.63222-10-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 1:24 PM, Kees Cook wrote:
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 98d2457bdd9f..92ba73bd0b62 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -160,3 +160,67 @@ config PSTORE_ZONE
>  	help
>  	  The common layer for pstore/blk (and pstore/ram in the future)
>  	  to manage storage in zones.
> +
> +config PSTORE_BLK
> +	tristate "Log panic/oops to a block device"
> +	depends on PSTORE
> +	depends on BLOCK
> +	select PSTORE_ZONE
> +	default n
> +	help
> +	  This enables panic and oops message to be logged to a block dev
> +	  where it can be read back at some later point.
> +
> +	  If unsure, say N.
> +
> +config PSTORE_BLK_BLKDEV
> +	string "block device identifier"
> +	depends on PSTORE_BLK
> +	default ""
> +	help
> +	  Which block device should be used for pstore/blk.
> +
> +	  It accept the following variants:
> +	  1) <hex_major><hex_minor> device number in hexadecimal represents
> +	     itself no leading 0x, for example b302.

	     itself with no leading 0x,

> +	  2) /dev/<disk_name> represents the device number of disk
> +	  3) /dev/<disk_name><decimal> represents the device number
> +	     of partition - device number of disk plus the partition number
> +	  4) /dev/<disk_name>p<decimal> - same as the above, this form is
> +	     used when disk name of partitioned disk ends with a digit.
> +	  5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
> +	     unique id of a partition if the partition table provides it.
> +	     The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
> +	     partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
> +	     filled hex representation of the 32-bit "NT disk signature", and PP
> +	     is a zero-filled hex representation of the 1-based partition number.
> +	  6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation
> +	     to a partition with a known unique id.
> +	  7) <major>:<minor> major and minor number of the device separated by
> +	     a colon.


-- 
~Randy

