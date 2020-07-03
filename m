Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E12C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA095207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsr0sCx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGCKXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:23:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB4C08C5C1;
        Fri,  3 Jul 2020 03:23:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so4390446pfc.6;
        Fri, 03 Jul 2020 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jgu7HzzfOA2CuR2eyDhD/aJDX3ECG/FaHG9BF4/Mz8w=;
        b=Jsr0sCx5OB/K3dTt71tzZvRymHqtsuW05qElXzQfoqhtgqdY5XVT8XeHi7vnzp7TiK
         4GgaeL/3G2kus0U0kxux617JZtnHUGZEp2u0kyC4U2PNbiAlOZ3CBEJhcfj2jAf2F0wg
         ab3+TJU3qHSOAvt/33d0ZaXwy3eeZQgPvQLF25lxTSkvzh1TadWuSgHANd+uXuoTVZsx
         I+3dlVg5SNLSpMmH4bY36cVr2chu7JR/zJAqKdcJ+2GLMRUsfXFiXDZglsMTkdtg9BDf
         1ters6MDKculqIh/yJoukLeCj7fv+QYLI++LqMzvIRVzXQeXfaDQ6lJY/YwLByikLdT+
         f/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jgu7HzzfOA2CuR2eyDhD/aJDX3ECG/FaHG9BF4/Mz8w=;
        b=s0LOLYoEPwdhDpTvvz2XO9wC/Wmb2SEB2ahuygkaNmY5+6RXKUp6xYs+7QembRowEM
         gEf8LS6HLN4XESMA7ZFQE1RzV/ZYTKg8+946ffNwhAlzOqkXwTKFtIIANh4DW2MRxUC+
         veIq/Fh2QKMRPy/DFGdbDU+jVGefdTRB9MwMWStqM61E0rotVOt/LOEEACYz9mFl2eAK
         SA3620qJS+nt/vlB6JXfgBtLJUQ4LE96O+j17+TtocGCoOczD/Rp2w/PP467sycdZsw9
         wUznV/52FIIQN+HtfLWdlI9U2DO/Cnq+mFc31lv4cHet0+kEnxm9EHL37/VqIi67Y+ry
         ptOw==
X-Gm-Message-State: AOAM531kVw7Sc1OjXXD2KMYXTtpUXw+zCvTJgjfy50NH0b7UcIVTEBCl
        Wzj+o6ZpqaHFwUHi3S/7E/0=
X-Google-Smtp-Source: ABdhPJy2ERLnE4W6pWLNm2rm5lnXNQMQ0+ZI6FyAeTpn03f22qvfwhhwAvi8uI6Nyxepl64kl83jeQ==
X-Received: by 2002:a62:fc53:: with SMTP id e80mr31243917pfh.129.1593771818779;
        Fri, 03 Jul 2020 03:23:38 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x7sm11451255pfq.197.2020.07.03.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 03:23:37 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 3 Jul 2020 19:23:36 +0900
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: vsprintf
Message-ID: <20200703102336.GA182102@jagdpanzerIV.localdomain>
References: <20200702200536.13389-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702200536.13389-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/02 22:05), Alexander A. Klimov wrote:
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
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
