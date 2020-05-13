Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC2AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632592065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcXf/LwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbgEMPVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgEMPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:21:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CFEC061A0C;
        Wed, 13 May 2020 08:21:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k19so6942739pll.9;
        Wed, 13 May 2020 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cWFKfC62+6x0cIYD7JbR18PKDXXbx8nGB7XYfgqUvF4=;
        b=UcXf/LwO0ebFP2l74juHCGTii8BlrEnCisLBwXU9iBrGdE0F4Dh7tM35PLhI1CelSf
         D90sKcDWwfUNJetU6bOWntnUxER3HDl68AuV/oGIyRrWbs/2NbS3MSX///qA7+VarM+k
         PcS1MvIzZSP9pZSmEj0R6HkNph8/wo0Wf8VPT7UkhrgyTTT6IFLdg+XCGklDhTCvZVOR
         ZVVA/oU6jvXNcFb7sLyG5JVaaJ9gQAnmld2vsUzrCEEPAP8FQE+aYvi5wjMQjKvJvaum
         AUDZuh3gI5JiRriLLUkDc6ZUl6z4MQW7kMwiDI9RaSErrKDVCIS3S5PggLrat3ZdetqO
         UWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=cWFKfC62+6x0cIYD7JbR18PKDXXbx8nGB7XYfgqUvF4=;
        b=heaqZvKfa0qJZVl3zb7kPVZO70Al7OuWGRYn6l8xObvRaowh64m2alsS2GOuL1kDEb
         6GwyzD66kaw5dHXgKOknsOlCFpLNlTfhVIyKFGDVuIlHOX+gDYfkLrPu8Dvj0uJEFXyu
         WOJGH2bAgxo+4Rls0Yonci/hvWS6aOoXfqX3hQKHd5vRai6Ub2OQdDPYWlk2idutmJ3D
         ApCTpY84aRr6zg1t0AO5DKvKn0fR4B5YZJE2kYvFLzA1V4ehSmC/xB3Qbr7WSs+EL/z3
         58s9tBoPaCP1RQX+MoBVJ8krIh3kaBjuj3PLNLZStjjgC61N2pRzo4cNONU8CkeDYqP2
         3ldQ==
X-Gm-Message-State: AGi0PuY3+tTdSnm4WGaKt1deIo9Tu4qDPxRj3kWiL/W1Og9rHWut3O1A
        azxksq/rqv49y2wgnOwZSyU=
X-Google-Smtp-Source: APiQypIG3VnLUc5o3LGxO1a1f/FF6vP3C9zhpMSozv2JhiVOu26f8gI33aGjcezrncxrxG7y6GoXDQ==
X-Received: by 2002:a17:90a:ba84:: with SMTP id t4mr32154756pjr.81.1589383266524;
        Wed, 13 May 2020 08:21:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 82sm14944156pfv.214.2020.05.13.08.21.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 08:21:05 -0700 (PDT)
Date:   Wed, 13 May 2020 08:21:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        oakley.ding@advantech.com.tw, jia.sui@advantech.com.cn,
        yuechao.zhao@advantech.com.cn, Hy.Lee@advantech.com.tw
Subject: Re: [v1,1/1] hwmon: (nct7904) Add to read all of the SMI status
 registers in probe function.
Message-ID: <20200513152104.GA125097@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:25:23AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: Amy Shih <amy.shih@advantech.com.tw>
> 
> When nct7904 power up, it compares current sensor readings within the
> default threshold immediately, thus some of SMI status registers would
> get non zero values cause the false alarms on first reading. Add to
> read all of the SMI status registers in probe function to clear the
> alarms.
> 
> Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7904.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 571a649..6fb06f7 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -45,6 +45,7 @@
>  #define FANCTL_MAX		4	/* Counted from 1 */
>  #define TCPU_MAX		8	/* Counted from 1 */
>  #define TEMP_MAX		4	/* Counted from 1 */
> +#define SMI_STS_MAX		10	/* Counted from 1 */
>  
>  #define VT_ADC_CTRL0_REG	0x20	/* Bank 0 */
>  #define VT_ADC_CTRL1_REG	0x21	/* Bank 0 */
> @@ -1126,6 +1127,13 @@ static int nct7904_probe(struct i2c_client *client,
>  		data->fan_mode[i] = ret;
>  	}
>  
> +	/* Read all of SMI status register to clear alarms */
> +	for (i = 0; i < SMI_STS_MAX; i++) {
> +		ret = nct7904_read_reg(data, BANK_0, SMI_STS1_REG + i);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	hwmon_dev =
>  		devm_hwmon_device_register_with_info(dev, client->name, data,
>  						     &nct7904_chip_info, NULL);
> -- 
> 1.8.3.1
> 
