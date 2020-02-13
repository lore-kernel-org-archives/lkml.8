Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0CFC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FFF206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3X7DBSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgBMUrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:47:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40701 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgBMUrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:47:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so3657009pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mC+IGwdPVaxHWNj8mNYZ18hdPPLG4fUBhPiGoWxhKxE=;
        b=j3X7DBSj5zX5OgW3FjuIP5XlFWRSCWBxH//ZxteGT1FVRQw3F8sb2Gl4Rjyax/bZD1
         9egkvtO6Qlt6ccniFbuWMFLOzKQ0dR2Lbeye5gd7C80+hMILADn/0bSI+kFAl2p5Fcxt
         nYxnN5D2rcw0r8l96CLp5005UPmDwRTA65RlFtvPrZchdmdb581wLJrS5CfAbVs1oHXW
         tTFY9HG2w8c7dPWRq7zT+TSd1IOtxetwIfM4JIz1vRdHINhhiwoGLStDTMiuag18KOgh
         G8ocsJT1plVZh9F8gtzcusgw6svbLgw7ZWkSNcbHPxKB58EP6c/CAJoiGl3d26yOFlbV
         3U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mC+IGwdPVaxHWNj8mNYZ18hdPPLG4fUBhPiGoWxhKxE=;
        b=kQmC/Z9tEFckZnlBM5K3MAqS9qNK2NYV/O2xFROEdCk5zX19gSgKa+niJ7wUFtM6PS
         F1ooW5HE8IdpcEAOVzA+GCdlSkurgUdYeeXVj+nEjyX59raldCvENb5+MCjxgu0pwgmP
         8M+7HVUwaEYuNU0S2EfVG+T++qABkU4fVXQXLjJxNBR7cTE+MusAeGwdSFVnBunQvNzW
         qIYm2i0K9134LzHJovW8Q4pP9t98GKERusxwCNVOJtBt+7+LWY/+5FfaoBoPai9NWqqH
         S5lDYMqFyBhKfO5+25FGlvrbahXaObxeSG0roniFp0aiktNkkAjTTwbFPfmZJf8e9xXX
         OEdw==
X-Gm-Message-State: APjAAAUm9c5xdyGd6g8J5wgbLFGb/4Nvj+weKiLhFbwkRdzze0XBbjvE
        1eP/LWSxVnzn7QLWamM96cI=
X-Google-Smtp-Source: APXvYqyd9pyCtc5N8+2APg5W0dnO2VBKRiLd30iN0yDW/F2HDyNPfQO2v/jLo2mGZPtCkwII3lpKiQ==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr15286361pff.98.1581626826350;
        Thu, 13 Feb 2020 12:47:06 -0800 (PST)
Received: from localhost ([73.93.152.205])
        by smtp.gmail.com with ESMTPSA id r9sm4219555pfl.136.2020.02.13.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:47:05 -0800 (PST)
Date:   Thu, 13 Feb 2020 12:47:04 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>,
        Allison Randal <allison@lohutok.net>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH] uapi: fix userspace breakage, use __BITS_PER_LONG for
 swap
Message-ID: <20200213204704.GA22037@yury-thinkpad>
References: <20200213142147.17604-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213142147.17604-1-borntraeger@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 03:21:47PM +0100, Christian Borntraeger wrote:
> QEMU has a funny new build error message when I use the upstream kernel headers:
> 
>   CC      block/file-posix.o
> In file included from /home/cborntra/REPOS/qemu/include/qemu/timer.h:4,
>                  from /home/cborntra/REPOS/qemu/include/qemu/timed-average.h:29,
>                  from /home/cborntra/REPOS/qemu/include/block/accounting.h:28,
>                  from /home/cborntra/REPOS/qemu/include/block/block_int.h:27,
>                  from /home/cborntra/REPOS/qemu/block/file-posix.c:30:
> /usr/include/linux/swab.h: In function ‘__swab’:
> /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
>    20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>       |                                  ^~~~~~
> /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:41: error: missing binary operator before token "("
>    20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>       |                                         ^
> cc1: all warnings being treated as errors
> make: *** [/home/cborntra/REPOS/qemu/rules.mak:69: block/file-posix.o] Error 1
> rm tests/qemu-iotests/socket_scm_helper.o
> 
> This was triggered by commit d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
> This patch is doing
> +#include <asm/bitsperlong.h>
> but it uses BITS_PER_LONG.
> 
> The kernel file asm/bitsperlong.h provide only __BITS_PER_LONG.
> 
> Let us use the __ variant in swap.h
> Fixes: d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Joe Perches <joe@perches.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  include/uapi/linux/swab.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
> index fa7f97da5b76..7272f85d6d6a 100644
> --- a/include/uapi/linux/swab.h
> +++ b/include/uapi/linux/swab.h
> @@ -135,9 +135,9 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
>  
>  static __always_inline unsigned long __swab(const unsigned long y)
>  {
> -#if BITS_PER_LONG == 64
> +#if __BITS_PER_LONG == 64
>  	return __swab64(y);
> -#else /* BITS_PER_LONG == 32 */
> +#else /* __BITS_PER_LONG == 32 */
>  	return __swab32(y);
>  #endif
>  }

There is a patch from Torsten Hilbrich fixing this:
https://lkml.org/lkml/2020/2/12/93
