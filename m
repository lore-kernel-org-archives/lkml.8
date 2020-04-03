Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6318AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3513D20659
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="adKEPDUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbgDCMK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:10:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403836AbgDCMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:10:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so8197547wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8mWBNkB1mpQPt43O1OjkI1/IjpLk3sF192gEDKaSPA4=;
        b=adKEPDUjtMciZxhtUKSncQ7uOdW5PzfVnh2wW0vPHlxbb0Ml6npH1wmP6l1/ebWuBS
         5/M5VhUcTla6U02FRhmujSlXleSg0bAFRAoWxxdJ0Qx6fNADKOuVf79CXGKVTQ4iusfD
         T1EsH0x15qgDefZ7+A0gVWWf4lDq43b4fr8fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8mWBNkB1mpQPt43O1OjkI1/IjpLk3sF192gEDKaSPA4=;
        b=SVw+i5nF0lP47/ZgIv8vaQRyoVdgI88uzvPjqcw9MLnuoNt5PMnDGOW+GYEwEiBgK3
         vRXZoA35EwqVHaV91NQEQVF515rSBft3/7LZLH3oBGtTKyQepSJggge05HH/d5PStH2J
         0DrPdJ2n9Q72zEDynY583mD7ycgugl04QXNGEHbu2SYSTGqP4XqzwnypAMyDadwZoLvM
         8iY/hOnYGuzZjly1xbR6VD5uPxUo75JYvRfoxTlDR7G1pyfwgbHbi2xC8SZ7SEM6mqI4
         d75/4ZNbaSDh5TVx9eNK3BiqQ71pvCVpntpLnDuh6NoCh0a0ZPCKZdQ8nClkXBRRA6Qo
         oAfg==
X-Gm-Message-State: AGi0PuaeIMp5pjt3aavMUwIOF5bQn4IE5J7T0TialNAOZBRGRfTjoNQq
        3Kli2qHRWUBGId7FjxVEdTAJuw==
X-Google-Smtp-Source: APiQypIwIzyIDkSJbAVVEfkHzuQnbPI/gjaKiG9yy6P0l/Lc3z/sFLfAD9qOo6Z+TElh0cprhE+HOQ==
X-Received: by 2002:a5d:4844:: with SMTP id n4mr1180275wrs.314.1585915855411;
        Fri, 03 Apr 2020 05:10:55 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id z129sm11337245wmb.7.2020.04.03.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 05:10:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Add support for printing V4L2 and
 DRM fourccs
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20200403091156.7814-1-sakari.ailus@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1105bfe5-88f1-040e-db40-54d7761747d5@rasmusvillemoes.dk>
Date:   Fri, 3 Apr 2020 14:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403091156.7814-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2020 11.11, Sakari Ailus wrote:
> Add a printk modifier %ppf (for pixel format) for printing V4L2 and DRM
> pixel formats denoted by 4ccs. The 4cc encoding is the same for both so
> the same implementation can be used.

This seems quite niche to me, I'm not sure that belongs in vsprintf.c.
What's wrong with having a

char *fourcc_string(char *buf, u32 x)

that formats x into buf and returns buf, so it can be used in a

char buf[8];
pr_debug("bla: %s\n", fourcc_string(buf, x))

Or, for that matter, since it's for debugging, why not just print x with
0x%08x?

At the very least, the "case '4'" in pointer() should be guarded by
appropriate CONFIG_*.

Good that Documentation/ gets updated, but test_printf needs updating as
well.


> Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> since v1:
> 
> - Improve documentation (add -BE suffix, refer to "FourCC".
> 
> - Use '%p4cc' conversion specifier instead of '%ppf'.

Cute. Remember to update the commit log (which still says %ppf).

> - Fix 31st bit handling in printing FourCC codes.
> 
> - Use string() correctly, to allow e.g. proper field width handling.
> 
> - Remove loop, use put_unaligned_le32() instead.
> 
>  Documentation/core-api/printk-formats.rst | 12 +++++++++++
>  lib/vsprintf.c                            | 25 +++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 8ebe46b1af39..550568520ab6 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -545,6 +545,18 @@ For printing netdev_features_t.
>  
>  Passed by reference.
>  
> +V4L2 and DRM FourCC code (pixel format)
> +---------------------------------------
> +
> +::
> +
> +	%p4cc
> +
> +Print a FourCC code used by V4L2 or DRM. The "-BE" suffix is added on big endian
> +formats.
> +
> +Passed by reference.

Maybe it's obvious to anyone in that business, but perhaps make it more
clear the 4cc is stored in a u32 (and not, e.g., a __le32 or some other
integer), that obviously matters when the code treats the pointer as a u32*.
> +
> +	put_unaligned_le32(*fourcc & ~BIT(31), s);
> +
> +	if (*fourcc & BIT(31))
> +		strscpy(s + sizeof(*fourcc), FOURCC_STRING_BE,
> +			sizeof(FOURCC_STRING_BE));

put_unaligned_le32(0x0045422d, s + 4) probably generates smaller code,
and is more in line with building the first part of the string with
put_unaligned_le32().

Rasmus
