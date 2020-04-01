Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F40EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3282063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUYzm9tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbgDAQjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:39:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35338 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389029AbgDAQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:39:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id k5so328018pga.2;
        Wed, 01 Apr 2020 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1KvnqiTwTwGyUVWVo1ohp05PHzyr/fqOgpGS9E5cA/I=;
        b=nUYzm9tQjevOeNPGsLPIZsXkgwuQB0F7C9QXza/hqHM4+Q78jMvLHkYf9EtNeHY5R9
         WkoostobMpjq7Lk411c7WOtNozsD6ImrzVjQdjYla6cCHnxOqSPVFQFthX88L9j+X261
         HbOlNVWW6FqZ4CGKJEG3O5cQQBUZxQe7iYVu7RAurGXWam04lRgFvi2XwZOP+r0VBPNT
         UQj+7L6BCrI13vG+2IUZWOpvPxdB+0nOk9oKQuolcqONcdtQf31Sa0a1O1WuFCyMkQc3
         rg7ASPgLiNSA6mmFKFyuUQ7pX+vZt3y2twspIQKzmDOa36JzJiqLVCgI8T/qKHzD+5d+
         ufKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1KvnqiTwTwGyUVWVo1ohp05PHzyr/fqOgpGS9E5cA/I=;
        b=Z4pP4gVI1wywvLY8ON3/uBbVcUbt87HfFzTAGWbkMYli61uVXafq5pFocdhZyN33ek
         atD0yyfmz0mzrRWHsC0MRGZUXOUv3ChD8CXVBB/tJPCfIangxwJ8GVKaS3mjVOuoig2s
         ssZvak1vCvB4CN1vkY37zIvukbYwWvtZR87bVpZM7euKMy8OmbinwwWB4N8lgKYdwGwC
         BZPNJpUGLpsQOGkrMS+8QYxott65WoqdN1+5f3B+SfnaRSa26n/PsWK/rm3DvJdLsxJ7
         tfgurw8LnNmyi3NAfeqai3p+CE/rMi6WOFeMxMW1udY6PV2QlaJNQ90kW6hVpTRpEKy4
         sAKQ==
X-Gm-Message-State: AGi0PuZofVR38SLIdAhBzY9g9afMoGZYRVUoCUuMTMIXmxraxImdKfcD
        ZGbcxWUCK9E9UZz5ZT8INEXibFf2
X-Google-Smtp-Source: APiQypJFjgmkwYIWKxDW0nJltQbosUObrioPcvFAkb+CWEJtYbERVyIpfynLOm0BaHxU1+HaXCFJGw==
X-Received: by 2002:a62:1648:: with SMTP id 69mr10810975pfw.14.1585759186075;
        Wed, 01 Apr 2020 09:39:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q91sm2006250pjb.11.2020.04.01.09.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Apr 2020 09:39:45 -0700 (PDT)
Date:   Wed, 1 Apr 2020 09:39:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus) add support for 2nd Gen Renesas
 digital multiphase
Message-ID: <20200401163944.GA111856@roeck-us.net>
References: <cover.1584720563.git.grantpeltier93@gmail.com>
 <62c000adf0108aeb65d3f275f28eb26b690384aa.1584720563.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c000adf0108aeb65d3f275f28eb26b690384aa.1584720563.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:16:21AM -0500, Grant Peltier wrote:
> Extend the isl68137 driver to provide support for 2nd generation Renesas
> digital multiphase voltage regulators.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
> ---
[ ... ]

>  
> -static const struct i2c_device_id isl68137_id[] = {
> -	{"isl68137", 0},
> +static const struct i2c_device_id raa_dmpvr_id[] = {
> +	{"isl68137", isl68137},
> +	{"raa_dmpvr2_1rail", raa_dmpvr2_1rail},
> +	{"raa_dmpvr2_2rail", raa_dmpvr2_2rail},
> +	{"raa_dmpvr2_3rail", raa_dmpvr2_3rail},
> +	{"raa_dmpvr2_hv", raa_dmpvr2_hv},
>  	{}

I clearly didn't pay attention. I2C device IDs need to match chip names,
not functionality. Unfortunately I only realized that when I wrote the
pull request, and I didn't want to drop the patch. I'll send a fixup
patch later.

Guenter
