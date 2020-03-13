Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFCDC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 06:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4C920746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 06:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkEhqaoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCMG5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 02:57:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37343 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCMG5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 02:57:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id 6so10652027wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6UokMBrb16XQMjC4W5sYs9WXunu7bAf0zdkEZSA1/Y0=;
        b=HkEhqaoqriTLHMwDsQ+HcWjYWLeJg3o3VNYxxD17YF4huyCrbqahOQ25xrDRBc5XkZ
         ahVJhtOYx5OwmqlgqetRY57OUauHWsy4a2hI7VYOgecM3nwWzYohetC20vd7VeYPjtT0
         Lq8HL+7DtmHgGkCp/SyI4TzVXC5LHfTo0h8RBpgUnxbBhjI3j77ZAs4meDa+TTAwVZaS
         Xhqyc+0xcOSJ3SrROvnV3ZOAf0kkLQDq2v//4oP0XfgNUcYU7q9/SDWZckd1hILnQlJD
         6HuRcO5lP3w812MFyiTZ9PwEzyKl3NDqd6oZOvQ8hRZUThA23xxJR9PK9gULH6o6+kP3
         2wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6UokMBrb16XQMjC4W5sYs9WXunu7bAf0zdkEZSA1/Y0=;
        b=iMRayLHePzUkM+HdFgr5ZoDP60WNR8UFC+2btWKktMx9RS5jqQWqlAEiIuZh3E/c+G
         ZToPkq3/UTEcdjMh6DH5pzTmv+qQ7nRfqETOIAXhmwQtSKUQRVwYxnGbJotJNTzeNBpx
         IYrtNznbYdcqNHfouq9e/dN6HO5gMNNw4zEZZI6B/rYViD07J+aY2r+3rdEAynCa0VQ3
         MIOowGm6u/6E4J1OYmDguK64HsIs1En4XFCWMmWB4sVRsqHZoZxACb7jxNpTTVat7daT
         5CR3uYnioYN8bKaZ0rtXkgNeBDvXowODP+9gvLmrHu1UHYEt8Zh4+bNO9eVheVd9TcaL
         o7Iw==
X-Gm-Message-State: ANhLgQ0A79lSzEmvWJcYvPd6xr8oXTtgOQKApvm7C5961D6e9+Got/NY
        d4YFj5UqvBnqJsYYEXBW0CCKZcOwztI=
X-Google-Smtp-Source: ADFU+vtPRRNVEQLgyP8VUHznw/0msUHZl1/lVK8dOh1PtBwBJvIf60zucDN4Hp5aQdvy3XNiMG10YA==
X-Received: by 2002:adf:9501:: with SMTP id 1mr16048790wrs.426.1584082665009;
        Thu, 12 Mar 2020 23:57:45 -0700 (PDT)
Received: from dell ([2.27.167.19])
        by smtp.gmail.com with ESMTPSA id m21sm15198787wmi.27.2020.03.12.23.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 23:57:44 -0700 (PDT)
Date:   Fri, 13 Mar 2020 06:58:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] mfd: dln2: Fix sanity checking for endpoints
Message-ID: <20200313065828.GB3142@dell>
References: <20200226145158.13396-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226145158.13396-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Andy Shevchenko wrote:

> While the commit 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
> tries to harden the sanity checks it made at the same time a regression,
> i.e.  mixed in and out endpoints. Obviously it should have been not tested on
> real hardware at that time, but unluckily it didn't happen.
> 
> So, fix above mentioned typo and make device being enumerated again.
> 
> While here, introduce an enumerator for magic values to prevent similar issue
> to happen in the future.
> 
> Fixes: 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: Add enumerator (Lee)
>  drivers/mfd/dln2.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
