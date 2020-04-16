Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92ABC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3122076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qicloPiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbgDPCca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733009AbgDPCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:32:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B18FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:32:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i3so947970pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TqEg5Op8tvCWqEi639RgXT0ywOBk8iUyJxWjz6oTWuk=;
        b=qicloPiyu1Mxkeo/8xV5Zt+B740ERXtlKv1GKL3ZEYU+baSzY7tQAx0HLDvG5bDm22
         wTkX2CuuX5I5UflUGCC5Y1MTcgMCxTP2gjJedTpbAU8p8cA8ckIOzXJ3PzSwRTM9JmT+
         cPhMd1pbXfYHSXpKSCdl/lUXrmW4mPov4ouLSyDabRtuqWKIo/Nn7FwIrfXpynPVeg5q
         IdsnymYllTysXu8RfoxNbS01e5eL7Xo4zEXy63aSBLttfbnHyPMbq/RYZIWNJIG2SB6I
         m7IDaAhTubeoBgFy0C0RmC4YFIZ7Y8p9IzgLDmsyrd1mVcCH+qIBDCu/BSiVsIBgZdeS
         Yufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqEg5Op8tvCWqEi639RgXT0ywOBk8iUyJxWjz6oTWuk=;
        b=Gtv9y/N0B24vEFADjHoWTfNbd6RPKfTGPgWZPWHCrfZyAO0muNAEP5Md5gT7GTF6zo
         y3SiOTxL1WG3jIIATcth9ez6eNBVzxKZUdkA6Fn6wZ04Ggm6DnHEZq+AtsK4pAkwONVb
         Mrnj3dinLymteCjM7qVxgAFdmuYmRokphHPfz4T4BgrCu0jmt0SiP6z139AqR8qmDGHd
         GnVR3NCBklgYgC4CWu4ylaAWCht/pQXXBSHWvmUda2ZTEOgTEa3GZ/dUV8Ilz3b+Pkfr
         3wIGfm8UBTg7hm/GIDhfY8EBfA7YjkeeaEEv9/xH1B3ozbBBaGfXfaclAWlyLg8D4Un0
         7aBQ==
X-Gm-Message-State: AGi0PuaQklygRkUf7T+Vtj7f8jUMWPNu2OpTvzRXLF8nlEkzMOZxEXu8
        GjIgKW+dTd8dT/r6cmW1qrk=
X-Google-Smtp-Source: APiQypK8pVGa63dJJifvm3fmi1vHAiheO3sVzgrb7mfXJ0EnjVzqUhHdy3h04ELTWP+k5TX8mUkUhg==
X-Received: by 2002:a63:4b16:: with SMTP id y22mr28163012pga.251.1587004343436;
        Wed, 15 Apr 2020 19:32:23 -0700 (PDT)
Received: from localhost (181.56.30.125.dy.iij4u.or.jp. [125.30.56.181])
        by smtp.gmail.com with ESMTPSA id u24sm11928468pgo.65.2020.04.15.19.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 19:32:22 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 16 Apr 2020 11:32:19 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 1/3] lib/vsprintf: Print time64_t in human readable
 format
Message-ID: <20200416023219.GA30641@jagdpanzerIV.localdomain>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415170046.33374-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415170046.33374-2-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/15 20:00), Andy Shevchenko wrote:
[..]
>  #include <linux/of.h>
>  #include <net/addrconf.h>
> @@ -1819,6 +1820,29 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
>  	return buf;
>  }
>  
> +static noinline_for_stack
> +char *time64_str(char *buf, char *end, const time64_t time,
> +		 struct printf_spec spec, const char *fmt)
> +{
> +	struct rtc_time rtc_time;
> +	struct tm tm;
> +
> +	time64_to_tm(time, 0, &tm);
> +
> +	rtc_time.tm_sec = tm.tm_sec;
> +	rtc_time.tm_min = tm.tm_min;
> +	rtc_time.tm_hour = tm.tm_hour;
> +	rtc_time.tm_mday = tm.tm_mday;
> +	rtc_time.tm_mon = tm.tm_mon;
> +	rtc_time.tm_year = tm.tm_year;
> +	rtc_time.tm_wday = tm.tm_wday;
> +	rtc_time.tm_yday = tm.tm_yday;
> +
> +	rtc_time.tm_isdst = 0;

Here you convert time64_t (signed, we also have unsigned version - timeu64_t)
to tm first and then convert tm to rtc_time. Will rtc_time64_to_tm() do the
trick?

	-ss
