Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24502C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD84208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYqfqbrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbgE1LBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbgE1LBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:01:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71181C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:01:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so22028526wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8YQeuOJDn06o9Kk2yXAQ8S1S/zWUs7/D7wgGQiHSlDo=;
        b=bYqfqbrkFj1FZHFAzXsoQSlTYLWgrpcMnTB2pBoapXhOlKoLypnBJzKuAQnQ3D8KQ7
         4FlIVcc2ATGO0OVErlukatffDWx/NrW9BSpb5EMCPEyJtiZSDAg9Pyig20jMp/BeBURX
         dFK7oluyit4qnyVmN74vPkDhKJivnHxhcoQiIb5AW4h1v4OrsfbOlse9z/B4JDhXBjHp
         98fSCMNYP2RXclElfro2gyR4I9gan/O/UeGKDfRJgtFGtYZNFouaV1u0Go9zvUPZURln
         /Dsg1bd+sz52nA/2Y0mu+01QgNy2LVh6YAxZFYrYR+2zkxZc2vBwG2a3yWlrzuCz8vG7
         UwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YQeuOJDn06o9Kk2yXAQ8S1S/zWUs7/D7wgGQiHSlDo=;
        b=KPBK/uAB/uBDoocOrxh/xsH4U8GXgJ5Ucr5cpQzCArk0Mk2Xzg+2/n2i6GwrMmJW/C
         iND1OrCKkdTIqUX0mpAmS48i0ycJY8obo7SQpr1FoyGnbx9Huwgnc5mvmHrpsN45ls4J
         bU/3nfmKPgREOSTDAibKBTQrM2mXBEkyHbLjlPk58MKmqCHubBan/rY5PPBABPUB/F2R
         SvGv5/1IARzOZdlpQjqVeNdCCglxipi1UF9deQ+4zqY2SXPSkfOaSRVvuARcp6fDlcm+
         5i5nYkzx+5N9SHW8ROZOSNPN5ZXjUN+PFyPoKroWs8L6FsdVMLC4I5HnpWOUm2ByOIeX
         MwFw==
X-Gm-Message-State: AOAM5322hhmxRuU1Z8QD0mBfzF/4DGd3VAQj7QLjjLckE4TDvgTw3EHt
        lp00HP3jBIqWSjNuQig/M+lCZA==
X-Google-Smtp-Source: ABdhPJyRVaunzq/Sm8tZxu1hhg2+vZn1ONdzXQY6iv2kXmcjShIgl9xgdzaFGyxwuiaTc8v3Xcl8wA==
X-Received: by 2002:a05:6000:120b:: with SMTP id e11mr3008597wrx.107.1590663677449;
        Thu, 28 May 2020 04:01:17 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 190sm6423473wmb.23.2020.05.28.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:01:16 -0700 (PDT)
Date:   Thu, 28 May 2020 12:01:14 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Kgdb-bugreport] [PATCH v3] kdb: Remove the misfeature 'KDBFLAGS'
Message-ID: <20200528110114.54qbkclk5demvsmc@holly.lan>
References: <20200521072125.21103-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521072125.21103-1-liwei391@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 03:21:25PM +0800, Wei Li wrote:
> Currently, 'KDBFLAGS' is an internal variable of kdb, it is combined
> by 'KDBDEBUG' and state flags. It will be shown only when 'KDBDEBUG'
> is set, and the user can define an environment variable named 'KDBFLAGS'
> too. These are puzzling indeed.
> 
> After communication with Daniel, it seems that 'KDBFLAGS' is a misfeature.
> So let's replace 'KDBFLAGS' with 'KDBDEBUG' to just show the value we
> wrote into. After this modification, we can use `md4c1 kdb_flags` instead,
> to observe the state flags.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Wei Li <liwei391@huawei.com>

Applied. Thanks.


Daniel.

> ---
> v2 -> v3:
>  - Change to replace the internal env 'KDBFLAGS' with 'KDBDEBUG'.
> v1 -> v2:
>  - Fix lack of braces.
> 
>  kernel/debug/kdb/kdb_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 4fc43fb17127..392029287083 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -418,8 +418,7 @@ int kdb_set(int argc, const char **argv)
>  				    argv[2]);
>  			return 0;
>  		}
> -		kdb_flags = (kdb_flags &
> -			     ~(KDB_DEBUG_FLAG_MASK << KDB_DEBUG_FLAG_SHIFT))
> +		kdb_flags = (kdb_flags & ~KDB_DEBUG(MASK))
>  			| (debugflags << KDB_DEBUG_FLAG_SHIFT);
>  
>  		return 0;
> @@ -2081,7 +2080,8 @@ static int kdb_env(int argc, const char **argv)
>  	}
>  
>  	if (KDB_DEBUG(MASK))
> -		kdb_printf("KDBFLAGS=0x%x\n", kdb_flags);
> +		kdb_printf("KDBDEBUG=0x%x\n",
> +			(kdb_flags & KDB_DEBUG(MASK)) >> KDB_DEBUG_FLAG_SHIFT);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
> 
> 
> _______________________________________________
> Kgdb-bugreport mailing list
> Kgdb-bugreport@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
