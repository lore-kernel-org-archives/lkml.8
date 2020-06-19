Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739F5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFCE20786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWs0f5DT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405175AbgFSPim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405011AbgFSPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:38:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397E2C06174E;
        Fri, 19 Jun 2020 08:38:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so4047189pld.13;
        Fri, 19 Jun 2020 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30oGrPF+Hf+5fkIfi8X9FX6JFyI5zPvG3i5GYaL/ATM=;
        b=HWs0f5DTlCe6wHSZpD0Kx7AlT2503FFuRMQCa52JL282WLeUj2vXNmK8TQkzIwv8Kp
         vwanqqR3iyR6IyftI0dVCMwlfh7vd0xBu9LZjOChvzKnDrpyupvb6O5PdGPYUNu0q26F
         XUgIKRC9GSHJyD0FcRzyFFCiDCIjuG1mb+SUWAGIvDHubTxWeXM3l+drjzE/DSBuC3Wp
         Shx0/aWeKApDjKJkPijjilf0AXi0ExE0n5H5mNoriUzq+HSvHDpSfnPNhfGRL8izRiFJ
         3DDQvree2SB+ScvFIv+0LFwfDQmAXtzvr/Ipf2cS0TKv0X8r6mht2D16CtYIIZ54JOJh
         0Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=30oGrPF+Hf+5fkIfi8X9FX6JFyI5zPvG3i5GYaL/ATM=;
        b=QIWv4DSvgf1QDVGotClle83WlE4SBsx+eylqrxn9JoTlQn24hgmOXWSbqylcDgdgID
         R27xdJKr5zbLnwFpLJw8seLWmt/rpHuxcVFnCeACKCysswPR/pDzcr4fhx15Tr9vm5b6
         Wr1EYWIqqylJT0oQKlMD6IkzSHxtmy1/Q7WgxC8h7BilydflRZ2J5b+Yko+JWdAdhrh4
         ZEvAhPe/Zy9GY3UQA68pNLZhURy5WmAfezAMZtVy9YEkZER7u7amtpEy6+6pJ/TWidDU
         3NRDP548URpjix5I6ltpY45Cv+O0F18QS9iWa93Yj6mruyRqtUMm9DUOjefyfxg9/CAS
         0bGA==
X-Gm-Message-State: AOAM531NEaMIKaTrCKsVnCClmcFrbuuWWU2SJUFFk79MnwpSf13l3bbA
        lR3Wdy65zwXtyNp/A31AAHw=
X-Google-Smtp-Source: ABdhPJwNrLmfds9PVZ5VRHfJd3aIUKqd9W9ZW/0qWo/rH6dJ+grD/00L85ejW7y9jsBMojLxMKA0aQ==
X-Received: by 2002:a17:90a:a58b:: with SMTP id b11mr4251156pjq.107.1592581114582;
        Fri, 19 Jun 2020 08:38:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14sm5511417pgt.6.2020.06.19.08.38.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2020 08:38:33 -0700 (PDT)
Date:   Fri, 19 Jun 2020 08:38:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, saipsdasari@fb.com, patrickw3@fb.com,
        vijaykhemka@fb.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, manikandan.e@hcl.com
Subject: Re: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200619153832.GA57109@roeck-us.net>
References: <20200619144853.GA18271@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619144853.GA18271@cnn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 08:18:53PM +0530, Manikandan Elumalai wrote:
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> v4:
> ---
> Reported-by: kernel test robot <lkp@intel.com>
> v3:
> ----
> fix invalid signed-off.
> removed checkpath warnings.
> write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> v2:
> ----
> add Signed-off-by.
> removed ADM1278_TEMP1_EN check.
> 
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>

The problem is that this is after '---', meaning it is considered a comment.
The Signed-off-by: tag needs to be located before the first '---'.
The change log should not be part of the commit log and follow '---'.

Guenter

> ---
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
> -- 
> 2.7.4
> 
