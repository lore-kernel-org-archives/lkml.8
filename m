Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ACDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2722420882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="FxbANqXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgATRBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:01:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42996 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:01:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so339649otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 09:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7rXrWc9zdyZC8ngED66aztSeYAIdSfuXFbxTohqXwo=;
        b=FxbANqXV7CZGzzBj+hbAItH/ABPzjboPJBwcqWNsAjJuV6ZzuMFWZt//n7SNS2Wayf
         k0mrNKGCC8fY1WKehL7UEw5/dAFcFbpnJ/yv7FzE7CJKao/3UlEqXPMm3xJWLCuI7yxT
         O8CzgQT7Sxix0lNBYH6ezfmW/UAVM6lry0pzHCbb/L/F8f7HrR6LqIO98R9zi/w7rFMh
         /R/x8fEZNw4g3KbH+LUN3P47dkLHjf+1R/ZqTzZmIB4759TViL/KZQFiUrZS7byD/O7L
         cNXrebX0KFx5LoQJ63cYPxa7yQ7gvN1nrLoRIQrl5djAPy9p+FVedKPFK1VZTmRlT0R7
         6xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7rXrWc9zdyZC8ngED66aztSeYAIdSfuXFbxTohqXwo=;
        b=EIQO39P/BILOpAFv14GasHPG4ZoymkzKSqksQ8F29KTdFgd04sqN71nlNVTuFZrXKw
         +ycGjVGj+LwkXsLP5SZ5fYHoGDjWBCyWaVFZ6PyCIWReu9ukt7bj6qVhnXC2XpVwIGj+
         7nxpvQIeGPgi7BPSterOeOBUmtyjMSRorU61n2wTA3znS17vx0Fts3BJ7DiCyxZaOkcO
         4LR4Ja+aYgqeDFYSCi7qXah/JAxjoJc7ll2075QIfh/YQMf60i2RROl3k+xT+ZRdmcwd
         ij6hU8EGJk873ew/Meh4Jb3aSh0DdTNaL0HP6AxyIzrVTRcyS1Bve+Y1MxczMNQuGB6K
         i7/Q==
X-Gm-Message-State: APjAAAW+pkiq5om7+RfSuOeekl+6yLJqkXsJbAcATs1GJN96xAANJRI1
        ayaP/vW/VYOn2pegmln4YYotYO9Vkpo=
X-Google-Smtp-Source: APXvYqxQlqgtwctnFJkk3FTNJcvt4oudhWgrQUyGHRg/Lus5T12Up6Sc2lVZkysElds60n0QZ1910Q==
X-Received: by 2002:a9d:5885:: with SMTP id x5mr311761otg.132.1579539695269;
        Mon, 20 Jan 2020 09:01:35 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:9c9c:d583:ce3d:f87a])
        by smtp.gmail.com with ESMTPSA id n16sm12479084otk.25.2020.01.20.09.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 09:01:34 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:01:32 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drivers: ipmi: fix off-by-one bounds check that
 leads to a out-of-bounds write
Message-ID: <20200120170132.GT2886@minyard.net>
Reply-To: cminyard@mvista.com
References: <20200114144031.358003-1-colin.king@canonical.com>
 <DB6PR0501MB2712BEBCF959566EAB063769DA340@DB6PR0501MB2712.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0501MB2712BEBCF959566EAB063769DA340@DB6PR0501MB2712.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 03:50:22PM +0000, Asmaa Mnebhi wrote:
> Reviewed-by: Asmaa Mnebhi <asmaa@mellanox.com>

Thanks, I've picked this up in my next tree.

-corey

> 
> -----Original Message-----
> From: Colin King <colin.king@canonical.com> 
> Sent: Tuesday, January 14, 2020 9:41 AM
> To: Corey Minyard <cminyard@mvista.com>; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Vadim Pasternak <vadimp@mellanox.com>; Asmaa Mnebhi <Asmaa@mellanox.com>; openipmi-developer@lists.sourceforge.net
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH][next] drivers: ipmi: fix off-by-one bounds check that leads to a out-of-bounds write
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The end of buffer check is off-by-one since the check is against an index that is pre-incremented before a store to buf[]. Fix this adjusting the bounds check appropriately.
> 
> Addresses-Coverity: ("Out-of-bounds write")
> Fixes: 51bd6f291583 ("Add support for IPMB driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 9fdae83e59e0..382b28f1cf2f 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -279,7 +279,7 @@ static int ipmb_slave_cb(struct i2c_client *client,
>  		break;
>  
>  	case I2C_SLAVE_WRITE_RECEIVED:
> -		if (ipmb_dev->msg_idx >= sizeof(struct ipmb_msg))
> +		if (ipmb_dev->msg_idx >= sizeof(struct ipmb_msg) - 1)
>  			break;
>  
>  		buf[++ipmb_dev->msg_idx] = *val;
> --
> 2.24.0
> 
