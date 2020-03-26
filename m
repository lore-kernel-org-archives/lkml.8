Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC1C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37A620775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hl67uVF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgCZPjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:39:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCZPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=4Rhgc12JFsMtKIyNi6i/tNVpQycGEAdzKCaEdKdCY1c=; b=hl67uVF2FcEI0atatFBaSMyqLb
        o9r800pgWA+iabo3TAoBBmsfysRN/L8vsCIbcivB2IsSkEROq2xRWk6Hs9abnXfiSk0MnLkjMZliM
        ZEjx1ZEtsYIadI/EzFQhOJK7yZB8l7cLQV/cVo8yjUMt+NMNA5iD8HEJpdw/GK915SUHiqjFHaXPJ
        OrtPFrJplNu8gAVf4PkFJRqTdaeb5ABnQn6v89KBDggMtYJ5HbEM+AWWigha6i6cGgS+X0fmL7SM6
        YKckZOeA+AS5rP22i5iWdD2NLKBXKipQ45Nikr1U8PnB3X4CjKITFgnWiRBcfo0E5j3/xwEfQoqCY
        zGU/HzDg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHUb3-0002U8-Eb; Thu, 26 Mar 2020 15:39:05 +0000
Subject: Re: [PATCH] md/raid0: add config parameters to specify zone layout
To:     Jason Baron <jbaron@akamai.com>, songliubraving@fb.com
Cc:     agk@redhat.com, snitzer@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        NeilBrown <neilb@suse.de>
References: <1585236500-12015-1-git-send-email-jbaron@akamai.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d8433599-cd4f-80a1-d9f7-8ddad1693850@infradead.org>
Date:   Thu, 26 Mar 2020 08:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585236500-12015-1-git-send-email-jbaron@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 8:28 AM, Jason Baron wrote:
> Let's add some CONFIG_* options to directly configure the raid0 layout
> if you know in advance how your raid0 array was created. This can be
> simpler than having to manage module or kernel command-line parameters.
> 
> If the raid0 array was created by a pre-3.14 kernel, use
> RAID0_ORIG_LAYOUT. If the raid0 array was created by a 3.14 or newer
> kernel then select RAID0_ALT_MULTIZONE_LAYOUT. Otherwise, the default
> setting is RAID0_LAYOUT_NONE, in which case the current behavior of
> needing to specify a module parameter raid0.default_layout=1|2 is
> preserved.
> 
> Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---
>  drivers/md/Kconfig | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/md/raid0.c |  7 +++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index d6d5ab2..c0c6d82 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -79,6 +79,61 @@ config MD_RAID0
>  
>  	  If unsure, say Y.
>  
> +choice
> +	prompt "RAID0 Layout"
> +	default RAID0_LAYOUT_NONE
> +	depends on MD_RAID0
> +	help
> +	  A change was made in Linux 3.14 that unintentinally changed the

	                                       unintentionally

> +	  the layout for RAID0. This can result in data corruption if a pre-3.14
> +	  and a 3.14 or later kernel both wrote to the array. However, if the
> +	  devices in the array are all of the same size then the layout would
> +	  have been unaffected by this change, and there is no risk of data
> +	  corruption from this issue.
> +
> +	  Unfortunately, the layout can not be determined by the kernel. If the
> +	  array has only been written to by a 3.14 or later kernel its safe to

	                                                           it's

> +	  set RAID0_ALT_MULTIZONE_LAYOUT. If its only been written to by a

	                                     it has

> +	  pre-3.14 kernel its safe to select RAID0_ORIG_LAYOUT. If its been

	                  it's                                  If it has been

> +	  written by both then select RAID0_LAYOUT_NONE, which will not
> +	  configure the array. The array can then be examined for corruption.
> +
> +	  For new arrays you may choose either layout version. Neither version
> +	  is inherently better than the other.
> +
> +	  Alternatively, these parameters can also be specified via the module
> +	  parameter raid0.default_layout=<N>. N=2 selects the 'new' or multizone
> +	  layout, while N=1 selects the 'old' layout or original layout. If
> +	  unset the array will not be configured.
> +
> +	  The layout can also be written directly to the raid0 array via the
> +	  mdadm command, which can be auto-detected by the kernel. See:
> +	  <https://www.kernel.org/doc/html/latest/admin-guide/md.html#multi-zone-raid0-layout-migration>
> +
> +config RAID0_ORIG_LAYOUT
> +	bool "raid0 layout for arrays only written to by a pre-3.14 kernel"
> +	help
> +	  If the raid0 array was only created and written to by a pre-3.14 kernel.
> +
> +config RAID0_ALT_MULTIZONE_LAYOUT
> +	bool "raid0 layout for arrays only written to be a 3.14 or newer kernel"

	                                              by

> +	help
> +	  If the raid0 array was only created and written to by a 3.14 or later
> +	  kernel.
> +
> +config RAID0_LAYOUT_NONE
> +	bool "raid0 layout must be specified via a module parameter"
> +	help
> +	  If a raid0 array was written to by both a pre-3.14 and a 3.14 or
> +	  later kernel, you may have data corruption. This option will not
> +	  auto configure the array and thus you can examine the array offline
> +	  to determine the best way to proceed. With RAID0_LAYOUT_NONE
> +	  set, the choice for raid0 layout can be set via a module parameter
> +	  raid0.default_layout=<N>. Or the layout can be written directly
> +	  to the raid0 array via the mdadm command.
> +
> +endchoice
> +
>  config MD_RAID1
>  	tristate "RAID-1 (mirroring) mode"
>  	depends on BLK_DEV_MD
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index 322386f..576eaa6 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -19,7 +19,14 @@
>  #include "raid0.h"
>  #include "raid5.h"
>  
> +#if defined(CONFIG_RAID0_ORIG_LAYOUT)
> +static int default_layout = RAID0_ORIG_LAYOUT;
> +#elif defined(CONFIG_RAID0_ALT_MULTIZONE_LAYOUT)
> +static int default_layout = RAID0_ALT_MULTIZONE_LAYOUT;
> +#else
>  static int default_layout = 0;
> +#endif
> +
>  module_param(default_layout, int, 0644);
>  
>  #define UNSUPPORTED_MDDEV_FLAGS		\
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
