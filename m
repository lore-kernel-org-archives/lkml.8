Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4081CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 22:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6792078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 22:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="HnuNZx8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgHVWhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 18:37:08 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.156]:25459 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727907AbgHVWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 18:37:08 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 956E34030
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 17:37:04 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9c8GkZYLqdbRz9c8GkRzv0; Sat, 22 Aug 2020 17:37:04 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i3fRcLO9Zj5uPjsJufqeNfBBqB8YTaDM321wOCENjo8=; b=HnuNZx8HlRFQe8Ae7QXKjLDeO1
        gzJnT0pvsxNTcTRbtSvWTtmE9Kj50jD7f8fq6R5FD5oqBPho8sYrDq9I6EUxWyZlPPKlVy5fKThZI
        /u+OPUOAMAI5Y89p2+cw+dYpBUACVP495INkeanb2cL/1aK7e2W98T5NEwLjUzASPXCDm3NqM5uFg
        4C3yaI+i3Bh9hSN/JFjMUAXMgK9nbGD1vZu07B+sTKkpyfPfFnYetfvC6uW8K15L8YYJXC0u4qP2i
        4O/ShF5yydCQ2/uh2h3jcDPTL8UVv4jLmx87zO7LAUWDX1zI4EKxrvUmETc/m54hm6dKjdI+2iHSf
        TanmpD3A==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:60016 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1k9c8G-000NHY-AA; Sat, 22 Aug 2020 17:37:04 -0500
Subject: Re: [GIT PULL] fallthrough pseudo-keyword macro conversions for
 5.9-rc2
To:     Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200820220210.GA14894@embeddedor>
 <ae31327674df92df720b1f026804b66c59e43e4c.camel@perches.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <87d43467-d793-9bd6-816c-f2580e468926@embeddedor.com>
Date:   Sat, 22 Aug 2020 17:42:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ae31327674df92df720b1f026804b66c59e43e4c.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1k9c8G-000NHY-AA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:60016
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Joe,

On 8/22/20 12:36, Joe Perches wrote:
> On Thu, 2020-08-20 at 17:02 -0500, Gustavo A. R. Silva wrote:
>> This treewide patch doesn't address ALL fall-through markings in all
>> subsystems at once because I have previously sent out patches for some of
>> such subsystems separately, and I will follow up on them; however, this
>> definitely contributes most of the work needed to replace all the
>> fall-through markings with the fallthrough pseudo-keyword macro in the
>> whole codebase.
> 
> Hi Gustavo.  Thanks for this.
> 
> Some stragglers (for -next) in the arch/subsystems modified
> by this patch:
> 
> arch/x86/
> drivers/gpu/
> drivers/misc/
> drivers/net/ethernet/
> lib/
> 
> And some in scripts/ and tools/ which maybe shouldn't be changed.
> 

I didn't change anything in scripts/ and tools/

I first plan to send a patch series to the following to tools/include/linux/compiler-gcc.h:

/*
 * Add the pseudo keyword 'fallthrough' so case statement blocks
 * must end with any of these keywords:
 *   break;
 *   fallthrough;
 *   goto <label>;
 *   return [expression];
 *
 *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
 */
#if __has_attribute(__fallthrough__)
# define fallthrough                    __attribute__((__fallthrough__))
#else
# define fallthrough                    do {} while (0)  /* fallthrough */
#endif

and address the fallthrough markings in tools/

Thanks
--
Gustavo

> Possible diffs for each straggler directory block below:
> 
>>  arch/x86/
> 
> $ git diff -U0 arch
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0f3d01562ded..b825a5a5ede7 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1149 +1149 @@ static inline void x86_assign_hw_event(struct perf_event *event,
> -               /* fall through */
> +               fallthrough;
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 983cd53ed4c9..097cc3439e53 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -190 +190 @@ static void __init e820_print_type(enum e820_type type)
> -       case E820_TYPE_RAM:             /* Fall through: */
> +       case E820_TYPE_RAM:
> @@ -197 +197 @@ static void __init e820_print_type(enum e820_type type)
> -       case E820_TYPE_PMEM:            /* Fall through: */
> +       case E820_TYPE_PMEM:
> @@ -1044 +1044 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
> -       case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
> +       case E820_TYPE_RESERVED_KERN:
> @@ -1060 +1060 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
> -       case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
> +       case E820_TYPE_RESERVED_KERN:
> @@ -1062,7 +1062,7 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
> -       case E820_TYPE_ACPI:            /* Fall-through: */
> -       case E820_TYPE_NVS:             /* Fall-through: */
> -       case E820_TYPE_UNUSABLE:        /* Fall-through: */
> -       case E820_TYPE_PRAM:            /* Fall-through: */
> -       case E820_TYPE_PMEM:            /* Fall-through: */
> -       case E820_TYPE_RESERVED:        /* Fall-through: */
> -       case E820_TYPE_SOFT_RESERVED:   /* Fall-through: */
> +       case E820_TYPE_ACPI:
> +       case E820_TYPE_NVS:
> +       case E820_TYPE_UNUSABLE:
> +       case E820_TYPE_PRAM:
> +       case E820_TYPE_PMEM:
> +       case E820_TYPE_RESERVED:
> +       case E820_TYPE_SOFT_RESERVED:
> @@ -1082,3 +1082,3 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
> -       case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
> -       case E820_TYPE_RAM:             /* Fall-through: */
> -       case E820_TYPE_UNUSABLE:        /* Fall-through: */
> +       case E820_TYPE_RESERVED_KERN:
> +       case E820_TYPE_RAM:
> +       case E820_TYPE_UNUSABLE:
> 
>>  drivers/gpu/
> 
> $ git diff -U1 drivers/gpu
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index b5986d19dc08..77dec1a56b9b 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -6203,3 +6203,3 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
>  #endif
> -                       /* fall through */
> +                       fallthrough;
>                 default:
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index 886e9959496f..6ba12f141833 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -4863,3 +4863,3 @@ static void ci_request_link_speed_change_before_state_change(struct radeon_devic
>  #endif
> -                       /* fall through */
> +                       fallthrough;
>                 default:
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index d1c73e9db889..76427c893827 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5751,3 +5751,3 @@ static void si_request_link_speed_change_before_state_change(struct radeon_devic
>  #endif
> -                       /* fall through */
> +                       fallthrough;
>                 default:
> 
>> drivers/misc/
> 
> diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
> index 326955b04fda..683871267f4f 100644
> --- a/drivers/misc/mei/interrupt.c
> +++ b/drivers/misc/mei/interrupt.c
> @@ -135 +134,0 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
> -                               fallthrough;
> 
>>  drivers/net/ethernet/
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
> index 08c76636c164..2a86307e3c43 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
> @@ -87,3 +87,2 @@ static struct anarion_gmac *anarion_config_dt(struct platform_device *pdev)
>         case PHY_INTERFACE_MODE_RGMII:
> -               fallthrough;
>         case PHY_INTERFACE_MODE_RGMII_ID:
> 
>>  drivers/scsi/
> 
> $ git diff -U1 drivers/scsi
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index cd7c7d269f6f..26c992213c9c 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -468,5 +468,4 @@ static void sas_discover_domain(struct work_struct *work)
>                 pr_notice("ATA device seen but CONFIG_SCSI_SAS_ATA=N so cannot attach\n");
> -               /* Fall through */
> +               fallthrough;
>  #endif
> -               /* Fall through - only for the #else condition above. */
>  
>>  lib/
> 
> $ git diff -U0 lib
> diff --git a/lib/nlattr.c b/lib/nlattr.c
> index 665bdaff02c8..e0da8c23d674 100644
> --- a/lib/nlattr.c
> +++ b/lib/nlattr.c
> @@ -404,2 +404 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
> -		/* fall through */
> -
> +		fallthrough;
> diff --git a/lib/zlib_inflate/inflate.c b/lib/zlib_inflate/inflate.c
> index 67cc9b08ae9d..8147b0ade347 100644
> --- a/lib/zlib_inflate/inflate.c
> +++ b/lib/zlib_inflate/inflate.c
> @@ -399 +399 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -407 +407 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -410 +410 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -449 +449 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -483 +483 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -504 +504 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -578 +578 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -618 +618 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -626 +626 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -652 +652 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -672 +672 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> @@ -723 +723 @@ int zlib_inflate(z_streamp strm, int flush)
> -	    /* fall through */
> +        	fallthrough;
> 
> 
> 
