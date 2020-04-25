Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2809C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 04:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52022071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 04:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgDYEcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 00:32:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDYEcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 00:32:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51B8CAE0F;
        Sat, 25 Apr 2020 04:31:59 +0000 (UTC)
To:     Jason Baron <jbaron@akamai.com>, songliubraving@fb.com
Cc:     agk@redhat.com, snitzer@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        NeilBrown <neilb@suse.de>
References: <1585236500-12015-1-git-send-email-jbaron@akamai.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Subject: Re: [PATCH] md/raid0: add config parameters to specify zone layout
Message-ID: <0b7aad8b-f0b7-24c6-ad19-99c6202a3036@suse.de>
Date:   Sat, 25 Apr 2020 12:31:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1585236500-12015-1-git-send-email-jbaron@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/26 23:28, Jason Baron wrote:
> Let's add some CONFIG_* options to directly configure the raid0 layout
> if you know in advance how your raid0 array was created. This can be
> simpler than having to manage module or kernel command-line parameters.
> 

Hi Jason,

If the people who compiling the kernel is not the end users, the
communication gap has potential risk to make users to use a different
layout for existing raid0 array after a kernel upgrade.

If this patch goes into upstream, it is very probably such risky
situation may happen.

The purpose of adding default_layout is to let *end user* to be aware of
they layout when they use difference sizes component disks to assemble
the raid0 array, and make decision which layout algorithm should be
used. Such situation cannot be decided in kernel compiling time.

> If the raid0 array was created by a pre-3.14 kernel, use
> RAID0_ORIG_LAYOUT. If the raid0 array was created by a 3.14 or newer
> kernel then select RAID0_ALT_MULTIZONE_LAYOUT. Otherwise, the default
> setting is RAID0_LAYOUT_NONE, in which case the current behavior of
> needing to specify a module parameter raid0.default_layout=1|2 is
> preserved.
> 

The difficulty is for a given md raid0 array, there is no clue whether
it is built on pre-3.14 kernel or not. If the kernel is not configured
and built by end user, we have risk that wrong algorithm will be applied
to unmatched layout.

Thanks.

Coly Li


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
> +	  the layout for RAID0. This can result in data corruption if a pre-3.14
> +	  and a 3.14 or later kernel both wrote to the array. However, if the
> +	  devices in the array are all of the same size then the layout would
> +	  have been unaffected by this change, and there is no risk of data
> +	  corruption from this issue.
> +
> +	  Unfortunately, the layout can not be determined by the kernel. If the
> +	  array has only been written to by a 3.14 or later kernel its safe to
> +	  set RAID0_ALT_MULTIZONE_LAYOUT. If its only been written to by a
> +	  pre-3.14 kernel its safe to select RAID0_ORIG_LAYOUT. If its been
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

