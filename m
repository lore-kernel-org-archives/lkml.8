Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688C7C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2216024649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks-com.20150623.gappssmtp.com header.i=@tyhicks-com.20150623.gappssmtp.com header.b="IDluMFGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgBNUpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:45:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33731 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBNUo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:44:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so5436016pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iMtV92vcKa/LIFazpQyvwUJquRUV8OBWC38HWuu3JF0=;
        b=IDluMFGZoeBXX6j4h2g0nLUo/PNQe3c9a/0e837aw4nP3hrEjfay1tLqPkMXZeAYoa
         DLr4ZgZNBG65wN6lNZF91M6Y7Z5Q6iYHlGucb8cDQOwl65uLcakU02dhMGEzhHklS6N4
         szuFbrl+C88Q7YrybcWVMH8hCQG3LF/EcsYEdeHPUDVDirHX7xiokZ+biDcVkZnnI++T
         jPYP1ALJ4MX+k/J4lmE349sutBn5IUIdlB46s0Cg1DwRfDsmflfPcu9pYU/4+uC4XSfP
         ozlPhLl/+BfYKYNI3+YvaAs0hG//0lKU9Wzb8dzSbeZ29+0dh+vxnMQX03JBOhcHf/JZ
         LsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iMtV92vcKa/LIFazpQyvwUJquRUV8OBWC38HWuu3JF0=;
        b=BL6NE3sRg16rWePmPge0mGV9sHxZrr2RF3I2wGeEnhi8zU3/ymWHXQbk0S68IGhdxw
         MCDBPkEwwQuhIdMYCO6asZHRj0VwlX9JkO9BLkTUz6I4Uh1Twg5ks41OMISIYCx8suXi
         rfXpvPFn25rRCDHCtJ3GDJzx7pTY2VVAi35BXfwJEoiWMufCzRVXmEllzIfYeBthRR8g
         hqEmkkAqf5jqQ6qFgVR1lYvackfJSPWoZaG9thb+nSP409T4Q5gf4gfY3IdfOSOoaXu8
         pdCwTc5LXKCkzk4ZMTkUeYaWRTvyUm+KLPiDebiaodHibEVGWE7H35Zk6XTPnf1g+qYY
         P7Zw==
X-Gm-Message-State: APjAAAUGPPcGwxMqdVxTcCnTbPP4CyMTPQRgCzdjD3uw5hHutS1ZtjZR
        rviyxMgnbtjMwKC9DSXnQ281wg==
X-Google-Smtp-Source: APXvYqzSg+eY0NZXJM1MD+gMKU4Eml2GScHOdbdGVELv03ncK1g18z3P8iZH/UEVPG0FeUEQXM01Mw==
X-Received: by 2002:a63:6d0b:: with SMTP id i11mr5252024pgc.266.1581713099087;
        Fri, 14 Feb 2020 12:44:59 -0800 (PST)
Received: from elm ([12.20.136.66])
        by smtp.gmail.com with ESMTPSA id c15sm8145660pja.30.2020.02.14.12.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:44:58 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:44:41 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Tyler Hicks <tyhicks@canonical.com>,
        Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ecryptfs: replace BUG_ON with error handling code
Message-ID: <20200214204441.GA254578@elm>
References: <20200214182101.17165-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214182101.17165-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-14 12:21:01, Aditya Pakki wrote:
> In crypt_scatterlist, if the crypt_stat argument is not set up
> correctly, the kernel crashes. Instead, by returning an error code
> upstream, the error is handled safely.
> 
> The issue is detected via a static analysis tool written by us.
> 
> Fixes: 237fead619984 (ecryptfs: fs/Makefile and fs/Kconfig)
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Thanks! This looks good to me and passes the eCryptfs regression tests.
I've queued it up in my tree.

Tyler

> ---
> v1: Add missing fixes tag suggested by Markus and Tyler.
> ---
>  fs/ecryptfs/crypto.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index db1ef144c63a..2c449aed1b92 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -311,8 +311,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
>  	struct extent_crypt_result ecr;
>  	int rc = 0;
>  
> -	BUG_ON(!crypt_stat || !crypt_stat->tfm
> -	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
> +	if (!crypt_stat || !crypt_stat->tfm
> +	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
> +		return -EINVAL;
> +
>  	if (unlikely(ecryptfs_verbosity > 0)) {
>  		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
>  				crypt_stat->key_size);
> -- 
> 2.20.1
> 
