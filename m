Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410EAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6CD2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJcmcz//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbgGOOJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgGOOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:09:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A65C061755;
        Wed, 15 Jul 2020 07:09:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so2130406pfq.11;
        Wed, 15 Jul 2020 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MlfFBN1+1C1gf5HPTvKKW7DTXwJjC0nNpsatcG0UhDQ=;
        b=rJcmcz//uD/jZ0saurdReSwPS3IX41zStr8IA7crGJj0YANomnM/k3CfHcaRCwya/Q
         rpXS6xlTSYQquw440FJYQIdPzwZaretWevlqSxyQzugEUq7MV2UQJyHL/o77TcQpVpma
         gkgZ+O2EQKs+gGCDj+DWjl6ofzIng+KS21Y/aJi4Bs7F4Y7gJkIdfajtFbpmxcecqCRA
         1cPWyU7A0/TLv+TV0f+Dx8qeols1SMKE7YNZZGoruR2MDpDAlkHidteDxiVh9OvljTXJ
         NH7fjX/o9qMG/qeYPMTFfnO/UDZ1745XfMC7VY5KwLLzNeZtePe7UyTj+2k7tYYalAgj
         Nlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MlfFBN1+1C1gf5HPTvKKW7DTXwJjC0nNpsatcG0UhDQ=;
        b=nBzhgEr7vLua+zsSHhJwWcznfI+U1lPsGxRn9kOkBt4+WT5s+fzWRbBX9LQX+IHyh8
         xZ67KFznmmJ7t9rZ76udbs5L/5Ef/y+2uVI/SBBlBpCt6IldpnalHO+JYQcVCp91c6LI
         3ZIZI96yU687lkPzg2yMs5fPtbU1YZS0MeaYW9ezPmyeveCM8OzBJqD9EJoHa26Qk07l
         g2Mb2hqy4LnQ07bDwRdTQpnHEruu/PeYFyYuiFYzOJJPMnmoixElRdqof2e2tpRLvBHn
         e2MASsoZ6pTBxD7/ua3UMxouz4fRx/dudo1REIDRRrI3H4+TcKrQpGTviQLM5W5ywA+V
         DMjg==
X-Gm-Message-State: AOAM5318EH/8Oc/qiqNwm2OqcCLogA7zBQdzgJIXcuts/IDB0NJYC8Lr
        ocQb/vHl/VcqollqiybdOs0=
X-Google-Smtp-Source: ABdhPJz2ZbE3bLgO/uY1WA8aGjrLElPYfUcYyi2xKy5D8dDtfSgnAQjgFt1uoBnnQdmFHIFfLgEsDQ==
X-Received: by 2002:aa7:871a:: with SMTP id b26mr8917117pfo.294.1594822164700;
        Wed, 15 Jul 2020 07:09:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a19sm2333899pfn.136.2020.07.15.07.09.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 07:09:23 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:09:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, sudeep.holla@arm.com
Subject: Re: [RESEND][PATCH] hwmon: scmi: fix potential buffer overflow in
 scmi_hwmon_probe()
Message-ID: <20200715140922.GA46932@roeck-us.net>
References: <20200715121338.GA18761@e119603-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715121338.GA18761@e119603-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:13:38PM +0100, Cristian Marussi wrote:
> SMATCH detected a potential buffer overflow in the manipulation of
> hwmon_attributes array inside the scmi_hwmon_probe function:
> 
> drivers/hwmon/scmi-hwmon.c:226
>  scmi_hwmon_probe() error: buffer overflow 'hwmon_attributes' 6 <= 9
> 
> Fix it by statically declaring the size of the array as the maximum
> possible as defined by hwmon_max define.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/scmi-hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 281454c5c5b1..758f66fc9afe 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -149,7 +149,7 @@ static enum hwmon_sensor_types scmi_types[] = {
>  	[ENERGY] = hwmon_energy,
>  };
>  
> -static u32 hwmon_attributes[] = {
> +static u32 hwmon_attributes[hwmon_max] = {
>  	[hwmon_chip] = HWMON_C_REGISTER_TZ,
>  	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
>  	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
