Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA26C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 03:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D2420661
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 03:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnxLPhAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgAKDpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 22:45:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37017 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgAKDpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 22:45:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so1925211pga.4;
        Fri, 10 Jan 2020 19:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SvgTDU/VcLkOvwpHJLvY+IjyTi426+Csa68mRShOTlk=;
        b=tnxLPhAHC3+BgzuflpOC4RGXBdk3LCtfMQHcP7mhsRqDRpsXV4zF65tqw4gMVTC9TE
         f82Gq6QXpUW7kfDHhpCvcb3Ak2/6LlMR0oHv2RQqaIsfTuHk1c51h1wODKatGmSNYUDB
         B+V4pScjG1vddOuJ/Q1dTznvh8k1dEcbUaBjvIx6D51C5wNfouCzieHhTEtvSa2j9jxY
         hW8/Ta8ueTudFK36rh2b8ZDGwrIRcvyR1laAb82ToYwWluN67oB8u1JxEV0lqYrk2V/S
         yWlcMJgpGFQW92BT6q1lbnlCFvb6H7NmA1IaICVp5VXCJPYARBQ/hufcYjI1ITi+MD/l
         4P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SvgTDU/VcLkOvwpHJLvY+IjyTi426+Csa68mRShOTlk=;
        b=HIyq18r84P3h+LAh1YensqqiSxuNDtBN5Kz/NxNZ7vWA7vDp6oPOFIyrs0hnPmVSgL
         ZfKYC0JVCnnfmyQEyoTqsYUP7o+2WD9s4jTg70q3qv4HqSlYXvKnpBSLE+cYSnSZGm1I
         SzP4k+MmImJWS6MtXTc1GMDXcGEXThvap5rywR95d+iWOSJIrJCdjnFt4WEQQ7/6YTir
         MZIEcqDWaM5gM1ie6qN0jkuVxTEvpm6n7kuR31UAmp/qb91XK7pPTjFuvOOPpvy1Y0Jf
         VdpKxDa74fcUkcViJiW5s3ffqlzsENxTq6RlNuSXxJuY3TGlSPr6V8Q9OVZa+GhSE0Ue
         ZGpg==
X-Gm-Message-State: APjAAAWnGQNQASKo+qVtVcJVSKxShNsB1rK6XYaFJWyFjLtqWS06hwTi
        Hhx/qusQeLyZHZxw7vdz6Nc=
X-Google-Smtp-Source: APXvYqxKbZKW+5yWha6USZPycDQGjscnQfoGgIe8h506M9H8kh4ScCDAdCWJUso/xMoe8EQ/FWSU+Q==
X-Received: by 2002:a65:644b:: with SMTP id s11mr8619211pgv.332.1578714342363;
        Fri, 10 Jan 2020 19:45:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z26sm4243292pgu.80.2020.01.10.19.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 19:45:41 -0800 (PST)
Date:   Fri, 10 Jan 2020 19:45:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, dan.carpenter@oracle.com
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Prevent writing on_off_config
 with bad data
Message-ID: <20200111034541.GA5609@roeck-us.net>
References: <1578411640-16929-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578411640-16929-1-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:40:40AM -0600, Eddie James wrote:
> If the user write parameters resulted in no bytes being written to the
> temporary buffer, then ON_OFF_CONFIG will be written with uninitialized
> data. Prevent this by bailing out in this case.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index 1c91ee1f9926..3795fe55b84f 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -250,7 +250,7 @@ static ssize_t ibm_cffps_debugfs_write(struct file *file,
>  		pmbus_set_page(psu->client, 0);
>  
>  		rc = simple_write_to_buffer(&data, 1, ppos, buf, count);
> -		if (rc < 0)
> +		if (rc <= 0)
>  			return rc;
>  
>  		rc = i2c_smbus_write_byte_data(psu->client,
