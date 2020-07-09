Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A03BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D50206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGIGLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:57398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgGIGLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85A95ACC6;
        Thu,  9 Jul 2020 06:11:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C772C1E12BF; Thu,  9 Jul 2020 08:11:36 +0200 (CEST)
Date:   Thu, 9 Jul 2020 08:11:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     jack@suse.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: DISKQUOTA
Message-ID: <20200709061136.GF25069@quack2.suse.cz>
References: <20200708171905.15396-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708171905.15396-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-07-20 19:19:05, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Thanks. I've applied the patch. I'll also note that somehow your script
missed converting the sourceforge.net link in quota.rst to https. I did
that myself together with replacing link to libnl doc with a working one...

								Honza

> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  Documentation/filesystems/quota.rst | 2 +-
>  fs/quota/Kconfig                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/quota.rst b/Documentation/filesystems/quota.rst
> index a30cdd47c652..6508c4520ba5 100644
> --- a/Documentation/filesystems/quota.rst
> +++ b/Documentation/filesystems/quota.rst
> @@ -31,7 +31,7 @@ the above events to userspace. There they can be captured by an application
>  and processed accordingly.
>  
>  The interface uses generic netlink framework (see
> -http://lwn.net/Articles/208755/ and http://people.suug.ch/~tgr/libnl/ for more
> +https://lwn.net/Articles/208755/ and http://people.suug.ch/~tgr/libnl/ for more
>  details about this layer). The name of the quota generic netlink interface
>  is "VFS_DQUOT". Definitions of constants below are in <linux/quota.h>.
>  Since the quota netlink protocol is not namespace aware, quota netlink messages
> diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> index 7218314ca13f..d1ceb76adb71 100644
> --- a/fs/quota/Kconfig
> +++ b/fs/quota/Kconfig
> @@ -15,7 +15,7 @@ config QUOTA
>  	  Ext3, ext4 and reiserfs also support journaled quotas for which
>  	  you don't need to run quotacheck(8) after an unclean shutdown.
>  	  For further details, read the Quota mini-HOWTO, available from
> -	  <http://www.tldp.org/docs.html#howto>, or the documentation provided
> +	  <https://www.tldp.org/docs.html#howto>, or the documentation provided
>  	  with the quota tools. Probably the quota support is only useful for
>  	  multi user systems. If unsure, say N.
>  
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
