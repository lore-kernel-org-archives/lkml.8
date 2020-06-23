Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3E7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A97620723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuAFCMQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbgFWOHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732674AbgFWOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:07:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DA6C061573;
        Tue, 23 Jun 2020 07:07:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d12so3185273ply.1;
        Tue, 23 Jun 2020 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cttTzLCbCwpPg7ZMsejcbzGgViOl4PIxIz/Vo6n6yx8=;
        b=EuAFCMQ2IYPM4zt/5UM3gO/o0wbS3vB78wogrigM17bZXuhr7nDHnuDrsUkkVCSJI0
         KINJG+io/pgFAvybGQ5Bm4yrjCjDi1nVvYTiqEmoheG9wNFEDjZseJivoXgqY+8vSogg
         RA9vrnSWi0+F8zYHR6dRGykUgnqHxEaNklvupYkm4crnYNSQ9SKK7m19C+z8QrnCb6PO
         AnxMZnNUD8Guenmp4tSEPhuP0F9aB1mCVRnGX699Ep7bohjP9NmAcGQIcvj743rA1cVk
         BHALYs0va2SMbRPmaY0DaG8TeGv28XfRRkp28JeK5NaTpXIns8Wdi24XY4XmlQJ1XCEo
         L+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cttTzLCbCwpPg7ZMsejcbzGgViOl4PIxIz/Vo6n6yx8=;
        b=Na8LToEZ6bf6RBXDqsGEyTY/+gvyE7y3cuP2Z3XlmGiDy+nDFqG5qa68Vk8/FxZBkj
         +m54h9HNHocF18X0ekWLc2Hs8ULPw+6ZF+aLJer8qG1W+oEcUOhQsED0G1pT4WfDcsCj
         6Fo/hLCNowoCVG5HZPPiRylWiGjhkkXE+rMjdTwFpxHX/Ynfq9vuqwX12ZWiUA12hDE5
         TbMo/cVrbLDAMjH7qM2OFchhluV+zQ+LTCw+GD+p3LT98g0CNGbrWzCPUI7tm5+xO63S
         zu9jpa1H9cNN4PhgXu8Jp6NXIFWwrFVyFcIY0Rgigwkk/SQIXP2EP33PCggFnkEC799H
         IkJg==
X-Gm-Message-State: AOAM530ssFf6uKtnI2qCeuOf6RR9B9/QmzK9OB7Pkgu79C3eAz0nN5cA
        3SDsfF5zz6DMrnq/F6934qL19QO8
X-Google-Smtp-Source: ABdhPJxVTbxY5KpaXYKS85YawQwpDMsPr7j/LysIzR4sGztdbV4yNnW1jHt0dWbN0eIRFNJdkWUmig==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr15563105plr.238.1592921232496;
        Tue, 23 Jun 2020 07:07:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8sm14688537pgi.18.2020.06.23.07.07.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 07:07:11 -0700 (PDT)
Date:   Tue, 23 Jun 2020 07:07:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Cc:     miltonm@us.ibm.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v6] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200623140711.GA208792@roeck-us.net>
References: <20200622153727.GA9347@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622153727.GA9347@cnn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 09:07:27PM +0530, Manikandan Elumalai wrote:
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>

Applied.

Thanks,
Guenter

> ---
> v5 -> v6: 
> add Reported-by in commit log
> align commit and change log as per guidelines.
> v4 -> v5: 
> align commit and change log. 
> v3 -> v4: 
> kernel test robot CI warning
> v2 -> v3: 
> fix invalid signed-off.
> removed checkpath warnings.
> write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> v1 -> v2: 
> add Signed-off-by.
> removed ADM1278_TEMP1_EN check.
> 
>  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 5caa37fb..d4e1925 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
>  		tindex = 3;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
> -		/* Enable VOUT if not enabled (it is disabled by default) */
> -		if (!(config & ADM1278_VOUT_EN)) {
> -			config |= ADM1278_VOUT_EN;
> +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
> +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
>  			}
>  		}
>  
> -		if (config & ADM1278_TEMP1_EN)
> -			info->func[0] |=
> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break;
