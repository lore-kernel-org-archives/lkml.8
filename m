Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F24DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EADE20672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgGHUQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:16:04 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:46860 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgGHUQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:16:04 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 2A0EE1B3FDC;
        Thu,  9 Jul 2020 05:16:03 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 068KG16U132648
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 9 Jul 2020 05:16:02 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 068KG1PM561493
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 9 Jul 2020 05:16:01 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 068KFvYo561489;
        Thu, 9 Jul 2020 05:15:57 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VFAT/FAT/MSDOS FILESYSTEM: Replace HTTP links with
 HTTPS ones
References: <20200708200409.22293-1-grandmaster@al2klimov.de>
Date:   Thu, 09 Jul 2020 05:15:57 +0900
In-Reply-To: <20200708200409.22293-1-grandmaster@al2klimov.de> (Alexander
        A. Klimov's message of "Wed, 8 Jul 2020 22:04:09 +0200")
Message-ID: <87y2ntdapu.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander A. Klimov" <grandmaster@al2klimov.de> writes:

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

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

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
>  fs/fat/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index ca31993dcb47..66532a71e8fd 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -41,7 +41,7 @@ config MSDOS_FS
>  	  they are compressed; to access compressed MSDOS partitions under
>  	  Linux, you can either use the DOS emulator DOSEMU, described in the
>  	  DOSEMU-HOWTO, available from
> -	  <http://www.tldp.org/docs.html#howto>, or try dmsdosfs in
> +	  <https://www.tldp.org/docs.html#howto>, or try dmsdosfs in
>  	  <ftp://ibiblio.org/pub/Linux/system/filesystems/dosfs/>. If you
>  	  intend to use dosemu with a non-compressed MSDOS partition, say Y
>  	  here) and MSDOS floppies. This means that file access becomes

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
