Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A7CC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BED20637
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8jKWrhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgBLIVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:21:07 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38056 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:21:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so560969pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CfGZzB9Va9GOFnbrC3+NV6pgVienX+BwcNoaklIgIRc=;
        b=I8jKWrhSo4bBnvfA9BZlVt/PQF3Pmrz+BaD3lcjOIVpIBoK+F9qxr7fk6NX0ud62ul
         Rz5eCzrDNbIAayKz8AbhLfCxy/LFlhj20ACJttLFQLvhA2IHqi9fycyG+TXNeZZbX040
         UqyWwCkva0RL0z80TiElVdvqhoLlId019epFavT+nTltI4Jz2qshvdo/47ZmPfbPH1cX
         FrN7q2KI/Ep1ggmuMSZPrg5bnSC96mV/Wt/4KVsCioh0x57zigef1N0FHdb0++kTO1kw
         TEg7n7/kPY6pzfxKUY9kEdgmSBDGr0+I9zstBNL7eCCxsGVqx3mCAvNdBJTYWjZTR7yg
         gAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CfGZzB9Va9GOFnbrC3+NV6pgVienX+BwcNoaklIgIRc=;
        b=s9XYVW/+5fSU1Ha6kUOOu0OB4GHKUNVj8SUPJzvI5fs/d/fEMC5ktfRNxRKx+UMrSz
         V1gB+HKt7/pJgbi6ZrErXUEG8KGSqnk0kzBVpjaaD61ThWy5GfxbisqLUmuBUda7WjjQ
         hf2purfA2c50QdeElfmPcivXU5UsyiXff7Ix2wwLytXEl2EhO61FyHJEktPVNdVtGn9y
         rv7AnYAMqvGhcExyKCQXYcHB58+NvcZFWtyKAWnHHOiOq62PKWE6N9/m5PzZi66haudt
         1g++vC4WH3Iu1uofcihpOQ75kelmlB4Kvcx2+dDipvlDGdfgJC98hKpAcwgSU/fgdMVW
         mGlQ==
X-Gm-Message-State: APjAAAUF7PuuFM7F/4fUlFNxutCyZW/B8t6wZ8KLbJnf7s+QjDPWzBgS
        JIAvjn9RaC/3eMpTjPuqlMS/is2E
X-Google-Smtp-Source: APXvYqyqKld2C2psaVU0PDFMX2zRunakTVo0389FWPYuz4usQkL3rtL7i3ApK+ZL4HbmupufRSDisg==
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr8753219pjq.93.1581495665368;
        Wed, 12 Feb 2020 00:21:05 -0800 (PST)
Received: from localhost ([73.93.154.168])
        by smtp.gmail.com with ESMTPSA id f9sm6991678pfd.141.2020.02.12.00.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 00:21:04 -0800 (PST)
Date:   Wed, 12 Feb 2020 00:21:03 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Torsten Hilbrich <torsten.hilbrich@secunet.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/uapi: Fix invalid use of BITS_PER_LONG in __swab
Message-ID: <20200212082103.GA19517@yury-thinkpad>
References: <6ecc4021-9beb-2ceb-98ba-5fc8954a05e1@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ecc4021-9beb-2ceb-98ba-5fc8954a05e1@secunet.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 08:51:06AM +0100, Torsten Hilbrich wrote:
> This caused compile problems in user-space application using that
> header. Seen with systemd:
> 
> In file included from /build/client/devel/kernel/_/usr/include/linux/byteorder/little_endian.h:13,
>                  from /build/client/devel/kernel/_/usr/include/asm/byteorder.h: ,
>                  from /build/client/devel/kernel/_/usr/include/linux/icmpv6.h:6,
>                  from ../src/network/networkd-route.c:3:
> /build/client/devel/kernel/_/usr/include/linux/swab.h: In function ‘__swab’:
> /build/client/devel/kernel/_/usr/include/linux/swab.h:138:5: error: "BITS_PER_LONG" is not defined, evaluates to 0 [-Werror=undef]
>  #if BITS_PER_LONG == 64
>      ^~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> [181/1207] Generating sys with a custom command.
> ninja: build stopped: subcommand failed.
> 
> Signed-off-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
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
> -- 
> 2.20.1

Acked-by: Yury Norov <yury.norov@gmail.com>
