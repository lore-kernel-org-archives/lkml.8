Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDCCC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34BB205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cyJ67de5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgCPVHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:07:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45885 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732603AbgCPVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:07:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id t2so12991899wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e4Js+GQN9i9BA17yb5cl9W991Ln3p6FSzvC77lFfomI=;
        b=cyJ67de5xFz1SvZEhRxwZqWrPgxn0OKkczBOTpCiEBdsUAfjmlrHcgf1ubnpaLBXXl
         UD5u/Kt8WmQHfVqeeZwIwbQsWv1ZpvyKHQlfV5p2w6GtUBmXIAiDdvOIJkOaQKuo2pzk
         kI90cqzwoP6aTh1YX0/1Kd7iFxdR3H1peXxw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e4Js+GQN9i9BA17yb5cl9W991Ln3p6FSzvC77lFfomI=;
        b=DnelfBBqIFUmlL+gV5lxjImgRwZmWqw9Xyr5p0v+Tlk1wrnYyod5Kp+ljPAZe2cZwn
         ZDZzqeOe9fGyGZaPZJPcqpQubG36IaEfvF+w/58LcEorWN3itJIJJNBnB20z/zTAK4RL
         Xk6h3Nn6Kp1O6pQzK7YsQJYr3KSnCpss3v0/GKeITLQ0hHL28wrwLrGgYXPR0ZTfD5ym
         baSAnDp+xzpCinrlt3ZN5grl2IOWZdfE4YZHpl8GTRyFWUG7BuBbRKvp7cN/o95QDyoQ
         CfjaeUtPl7U7uScfa5FLhAelBPQKfr+4Jv5w/tw4MjICsIzOCb+/AQIUhoB/7rGa9ZaW
         WV5w==
X-Gm-Message-State: ANhLgQ1wi5+HyQWbVSxCnv91J8SmpwVBYMgbrVLDtgK6XsRjzAMbIA+g
        yaZCf0JoHqF2cz8201vkI7LhSfR/7JbtfQ==
X-Google-Smtp-Source: ADFU+vt5ctZNOHVsCYlZlRY1l6ofXMxdnVHIEAGpjfBZBJ9JDM+B9T++1/sSbSvJu1sP+6rFmFrJ0A==
X-Received: by 2002:adf:d1a9:: with SMTP id w9mr130439wrc.17.1584392847404;
        Mon, 16 Mar 2020 14:07:27 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-114-43.cgn.fibianet.dk. [5.186.114.43])
        by smtp.gmail.com with ESMTPSA id q13sm1407210wrs.91.2020.03.16.14.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 14:07:26 -0700 (PDT)
Subject: Re: [PATCH 6/6] soc: fsl: qe: fix sparse warnings for ucc_slow.c
To:     Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200312222827.17409-1-leoyang.li@nxp.com>
 <20200312222827.17409-7-leoyang.li@nxp.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b9c5a514-18c1-e36c-1595-2b86c9bfcff1@rasmusvillemoes.dk>
Date:   Mon, 16 Mar 2020 22:07:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312222827.17409-7-leoyang.li@nxp.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2020 23.28, Li Yang wrote:
> Fixes the following sparse warnings:
> 
[snip]
> 
> Also removed the unneccessary clearing for kzalloc'ed structure.

Please don't mix that in the same patch, do it in a preparatory patch.
That makes reviewing much easier.

>  
>  	/* Get PRAM base */
>  	uccs->us_pram_offset =
> @@ -231,24 +224,24 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
>  		/* clear bd buffer */
>  		qe_iowrite32be(0, &bd->buf);
>  		/* set bd status and length */
> -		qe_iowrite32be(0, (u32 *)bd);
> +		qe_iowrite32be(0, (u32 __iomem *)bd);

It's cleaner to do two qe_iowrite16be to &bd->status and &bd->length,
that avoids the casting altogether.

>  		bd++;
>  	}
>  	/* for last BD set Wrap bit */
>  	qe_iowrite32be(0, &bd->buf);
> -	qe_iowrite32be(cpu_to_be32(T_W), (u32 *)bd);
> +	qe_iowrite32be(T_W, (u32 __iomem *)bd);

Yeah, and this is why. Who can actually keep track of where that bit
ends up being set with that casting going on. Please use
qe_iowrite16be() with an appropriately modified constant to the
appropriate field instead of these games.

And if the hardware doesn't support 16 bit writes, the definition of
struct qe_bd is wrong and should have a single __be32 status_length
field, with appropriate accessors defined.

>  	/* Init Rx bds */
>  	bd = uccs->rx_bd = qe_muram_addr(uccs->rx_base_offset);
>  	for (i = 0; i < us_info->rx_bd_ring_len - 1; i++) {
>  		/* set bd status and length */
> -		qe_iowrite32be(0, (u32 *)bd);
> +		qe_iowrite32be(0, (u32 __iomem *)bd);

Same.

>  		/* clear bd buffer */
>  		qe_iowrite32be(0, &bd->buf);
>  		bd++;
>  	}
>  	/* for last BD set Wrap bit */
> -	qe_iowrite32be(cpu_to_be32(R_W), (u32 *)bd);
> +	qe_iowrite32be(R_W, (u32 __iomem *)bd);

Same.

>  	qe_iowrite32be(0, &bd->buf);
>  
>  	/* Set GUMR (For more details see the hardware spec.). */
> @@ -273,8 +266,8 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
>  	qe_iowrite32be(gumr, &us_regs->gumr_h);
>  
>  	/* gumr_l */
> -	gumr = us_info->tdcr | us_info->rdcr | us_info->tenc | us_info->renc |
> -		us_info->diag | us_info->mode;
> +	gumr = (u32)us_info->tdcr | (u32)us_info->rdcr | (u32)us_info->tenc |
> +	       (u32)us_info->renc | (u32)us_info->diag | (u32)us_info->mode;

Are the tdcr, rdcr, tenc, renc fields actually set anywhere (the same
for the diag and mode, but word-grepping for those give way too many
false positives)? They seem to be a somewhat pointless split out of the
bitfields of gumr_l, and not populated anywhere?. That's not directly
related to this patch, of course, but getting rid of them first (if they
are indeed completely unused) might make the sparse cleanup a little
simpler.

Rasmus
