Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12C0C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925CF2487E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt0Mavq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgDFPoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:44:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55909 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729059AbgDFPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586187849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ksel4zeuxEuvzlfkWBaq7N2seFfLhw/qIgpcMtr4cuE=;
        b=gt0Mavq/yhlJDXnEyl191ZO3UMBjkeuZRoXrpeWn+cnQlpjUgyowI6GLS7Z52gbcpTMmVU
        +tOmCtOb4zRQqUsm3R/sqH8n4wZWnpx4r0bGlFeWHA5vmLQhT6w1Run2AJT0yhJCdek6lr
        ewzEt1Ge9+kX7m5ytk7HeOtuu9Wenz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-dD4Qfb39M42Ul0_Vv7_vmQ-1; Mon, 06 Apr 2020 11:44:08 -0400
X-MC-Unique: dD4Qfb39M42Ul0_Vv7_vmQ-1
Received: by mail-wr1-f71.google.com with SMTP id m15so14346wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ksel4zeuxEuvzlfkWBaq7N2seFfLhw/qIgpcMtr4cuE=;
        b=lQyYuWSqf0UMzzJokKs8pthKS081O++2Jt4h9YLBE3f/65lgLW1G3nJH4wrbmLP196
         RZPR5lPzh30bRyKYIbZfQlKL3fBgYq69xNq6leZudzjTwqHZ7/khSVmGcSMVPm2BcFjl
         083zcVTEAJzsDxxi3O96DEWfNQA0GqKJy1C+c3jCJaPGgk/7qjLO0+r8D8fSYZLPo2Cs
         YlDqTACjUFioeu5u1BFxEjs61/bhUFLcX6GEzZDb9MkpKRBivoQMISjBRtsHVnHzLXiK
         laUnESWq8ANaMfmIWtqLRjWWwrUEzZntUtozEjK7o8dp5+lWLnKCrIYJL8GE6/0/OnhJ
         HBHA==
X-Gm-Message-State: AGi0PubwUbUkhU1Wun26Jdf+qzUB/986D/Q84n61ZLEZN8XeAtL2uaAO
        F3bgdjuY20/TA/BCCofg8eLVgmhXwgJwAZ2imgBZqvDsfzT8whDFGoMmZKmA5+IjHYdldbUSO+S
        zinIvNdZf3PEVVTp6NpbOxlID
X-Received: by 2002:adf:cf09:: with SMTP id o9mr23888995wrj.74.1586187847097;
        Mon, 06 Apr 2020 08:44:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypIq8KKSvRFBuJvpiGY0hkZeDDxmoHMbGHpSedw+9ufGA1JoBNOnkv7Pi7rNRZL2IOokbrnHLw==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr23888982wrj.74.1586187846908;
        Mon, 06 Apr 2020 08:44:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id n6sm8802wmn.10.2020.04.06.08.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:44:06 -0700 (PDT)
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Add the Meegopad T02 to
 the blacklist.
To:     rafirafi <rafirafi.at@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200406140538.11894-1-rafirafi.at@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eff57daf-6f71-1f6f-e4f9-5b5b1ed974cd@redhat.com>
Date:   Mon, 6 Apr 2020 17:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406140538.11894-1-rafirafi.at@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/6/20 4:05 PM, rafirafi wrote:
> From: Rafael Gandolfi <rafirafi.at@gmail.com>
> 
>      The Meegopad T02 is a PC in stick format and doesn't have a battery,
>      it is reported with a random and constant battery charge but as
>      discharging to userspace.
> 
>      Add it to the blacklist to avoid the bogus battery status reporting.
> 
> Signed-off-by: Rafael Gandolfi <rafirafi.at@gmail.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index e1bc4e6e6f30..0bc548865a61 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -717,6 +717,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
>   		},
>   	},
> +	{
> +		/* Meegopad T02 */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MEEGOPAD T02"),
> +		},
> +	},
>   	{
>   		/* Meegopad T08 */
>   		.matches = {
> 

