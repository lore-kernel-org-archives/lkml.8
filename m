Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4391AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2525420784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502984AbgDPIyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502885AbgDPIru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:47:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED75AACD8;
        Thu, 16 Apr 2020 08:47:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1D3711E1250; Thu, 16 Apr 2020 10:47:48 +0200 (CEST)
Date:   Thu, 16 Apr 2020 10:47:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 24/34] docs: filesystems: convert quota.txt to ReST
Message-ID: <20200416084748.GB23739@quack2.suse.cz>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
 <36dc2cc02b525893ab66dca7ada2090236fb1879.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36dc2cc02b525893ab66dca7ada2090236fb1879.1586960617.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-04-20 16:32:37, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Looks good to me. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/index.rst           |  1 +
>  .../filesystems/{quota.txt => quota.rst}      | 41 +++++++++++++------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 31 insertions(+), 13 deletions(-)
>  rename Documentation/filesystems/{quota.txt => quota.rst} (81%)
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index a35b7d6ee5bc..8a17f8234b86 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -33,6 +33,7 @@ algorithms work.
>     locks
>     mandatory-locking
>     mount_api
> +   quota
>  
>     automount-support
>  
> diff --git a/Documentation/filesystems/quota.txt b/Documentation/filesystems/quota.rst
> similarity index 81%
> rename from Documentation/filesystems/quota.txt
> rename to Documentation/filesystems/quota.rst
> index 32874b06ebe9..a30cdd47c652 100644
> --- a/Documentation/filesystems/quota.txt
> +++ b/Documentation/filesystems/quota.rst
> @@ -1,4 +1,6 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  
> +===============
>  Quota subsystem
>  ===============
>  
> @@ -39,6 +41,7 @@ Currently, the interface supports only one message type QUOTA_NL_C_WARNING.
>  This command is used to send a notification about any of the above mentioned
>  events. Each message has six attributes. These are (type of the argument is
>  in parentheses):
> +
>          QUOTA_NL_A_QTYPE (u32)
>  	  - type of quota being exceeded (one of USRQUOTA, GRPQUOTA)
>          QUOTA_NL_A_EXCESS_ID (u64)
> @@ -48,20 +51,34 @@ in parentheses):
>  	  - UID of a user who caused the event
>          QUOTA_NL_A_WARNING (u32)
>  	  - what kind of limit is exceeded:
> -		QUOTA_NL_IHARDWARN - inode hardlimit
> -		QUOTA_NL_ISOFTLONGWARN - inode softlimit is exceeded longer
> -		  than given grace period
> -		QUOTA_NL_ISOFTWARN - inode softlimit
> -		QUOTA_NL_BHARDWARN - space (block) hardlimit
> -		QUOTA_NL_BSOFTLONGWARN - space (block) softlimit is exceeded
> -		  longer than given grace period.
> -		QUOTA_NL_BSOFTWARN - space (block) softlimit
> +
> +		QUOTA_NL_IHARDWARN
> +		    inode hardlimit
> +		QUOTA_NL_ISOFTLONGWARN
> +		    inode softlimit is exceeded longer
> +		    than given grace period
> +		QUOTA_NL_ISOFTWARN
> +		    inode softlimit
> +		QUOTA_NL_BHARDWARN
> +		    space (block) hardlimit
> +		QUOTA_NL_BSOFTLONGWARN
> +		    space (block) softlimit is exceeded
> +		    longer than given grace period.
> +		QUOTA_NL_BSOFTWARN
> +		    space (block) softlimit
> +
>  	  - four warnings are also defined for the event when user stops
>  	    exceeding some limit:
> -		QUOTA_NL_IHARDBELOW - inode hardlimit
> -		QUOTA_NL_ISOFTBELOW - inode softlimit
> -		QUOTA_NL_BHARDBELOW - space (block) hardlimit
> -		QUOTA_NL_BSOFTBELOW - space (block) softlimit
> +
> +		QUOTA_NL_IHARDBELOW
> +		    inode hardlimit
> +		QUOTA_NL_ISOFTBELOW
> +		    inode softlimit
> +		QUOTA_NL_BHARDBELOW
> +		    space (block) hardlimit
> +		QUOTA_NL_BSOFTBELOW
> +		    space (block) softlimit
> +
>          QUOTA_NL_A_DEV_MAJOR (u32)
>  	  - major number of a device with the affected filesystem
>          QUOTA_NL_A_DEV_MINOR (u32)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 470389ef0135..519f5d84adca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5009,7 +5009,7 @@ W:	http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
>  DISKQUOTA
>  M:	Jan Kara <jack@suse.com>
>  S:	Maintained
> -F:	Documentation/filesystems/quota.txt
> +F:	Documentation/filesystems/quota.rst
>  F:	fs/quota/
>  F:	include/linux/quota*.h
>  F:	include/uapi/linux/quota*.h
> -- 
> 2.25.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
