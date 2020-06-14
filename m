Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36863C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C64206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 21:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXrpHKXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgFNVox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgFNVow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 17:44:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFDC05BD43;
        Sun, 14 Jun 2020 14:44:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t7so6744053pgt.3;
        Sun, 14 Jun 2020 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wgFojsFHICNsh6BwZtUH+aU954Av2YQxkY22XtP4/gU=;
        b=oXrpHKXTK2GgGJCuJbXWnxop4+tveGvtqvqm6BIXPK2aw+0gDcFl8rKtg1A7LWJSbJ
         uW0difkP4z/KelyGefu549eXIUFrxpLq+fx/NwCIUHs3Rdbvoqdat/aVwT1jWfaDHLwz
         voHkUMWw06Xt+FzzR2PGP6Tm2KzmZ+rc/MNjLdbT7xz/C3pKuGT9d5FWmCbUW2tNzrdg
         /OBvY7xqoYmAGIrvgpxw7BXy6fgYRJm+ftQjKW9c4qBb5SZ1L9IxO3fry4oxngw6oHyL
         bNEO6ubtFbwNiRghwxTDcTYkVliX8XH7RQTcT/BWMdchUMv+7Oxci8o1ms6gM0AsbVeq
         G8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wgFojsFHICNsh6BwZtUH+aU954Av2YQxkY22XtP4/gU=;
        b=D9JLKLkikpqwXcVcArwDZMwSyyK+BmA4wXKofMF0tyaAJJavednafIskP00OIhhkI9
         3vGvwkeagmM92THobM1M/tmHu6JOEpiUCApFJJU2n+WBjuKybfdED5YJZtcrCP2GMJO1
         uOIG+bveyOgsSrxdujWiZbgQnTtOEFIIRleRN8v5hILLYEWfNezePnFh/l2tr2hQYeVj
         jNo0Kh+Ad6rjXDV9jtftSnVc+SiwT61GAYM2NB5BMfEWVeaNkrn9eHtzj2S2bK3mD5iG
         6n8BEjHGhZk4GNeqmI9OY1r3unKzJlc2HFc925JjXs61Z+v2E1m9ysMSPKvS6+m5ck2S
         wuCg==
X-Gm-Message-State: AOAM533ZVUDOm2857ZQwiyHH6lxRVMAKyusvtMVhzltTSclzYqWU8fAx
        5dvLKqvzP0j1x09hbvkCx434dC27
X-Google-Smtp-Source: ABdhPJx8o7M83S30bzrFRtzplRxN/tIvXXowwkXtiPLyEIDv7IuijSRLvCpIB5SGupViHTbK6JMXDg==
X-Received: by 2002:a63:1617:: with SMTP id w23mr19552259pgl.248.1592171091204;
        Sun, 14 Jun 2020 14:44:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12sm10373001pjy.37.2020.06.14.14.44.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jun 2020 14:44:50 -0700 (PDT)
Date:   Sun, 14 Jun 2020 14:44:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/hwmon/nct6683: Use kobj_to_dev() instead
Message-ID: <20200614214449.GA102702@roeck-us.net>
References: <1592035604-22336-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592035604-22336-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 04:06:44PM +0800, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Applied. For future patches, I would suggest to look up subject labels
used in affected subsystems.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6683.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>  mode change 100644 => 100755 drivers/hwmon/nct6683.c
> 
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
> index c022915..2d29914
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -674,7 +674,7 @@ show_in_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  static umode_t nct6683_in_is_visible(struct kobject *kobj,
>  				     struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6683_data *data = dev_get_drvdata(dev);
>  	int nr = index % 4;	/* attribute */
>  
> @@ -739,7 +739,7 @@ show_fan_pulses(struct device *dev, struct device_attribute *attr, char *buf)
>  static umode_t nct6683_fan_is_visible(struct kobject *kobj,
>  				      struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6683_data *data = dev_get_drvdata(dev);
>  	int fan = index / 3;	/* fan index */
>  	int nr = index % 3;	/* attribute index */
> @@ -857,7 +857,7 @@ show_temp_type(struct device *dev, struct device_attribute *attr, char *buf)
>  static umode_t nct6683_temp_is_visible(struct kobject *kobj,
>  				       struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6683_data *data = dev_get_drvdata(dev);
>  	int temp = index / 7;	/* temp index */
>  	int nr = index % 7;	/* attribute index */
> @@ -944,7 +944,7 @@ SENSOR_TEMPLATE(pwm, "pwm%d", S_IRUGO, show_pwm, store_pwm, 0);
>  static umode_t nct6683_pwm_is_visible(struct kobject *kobj,
>  				      struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6683_data *data = dev_get_drvdata(dev);
>  	int pwm = index;	/* pwm index */
>  
