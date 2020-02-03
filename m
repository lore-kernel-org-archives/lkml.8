Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EACC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1262084E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzA5x7yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgBCVSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:18:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbgBCVSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580764683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdmKq+r8C34si2IoRsHi9fqIPvPKHv+jVYiBofqYidg=;
        b=dzA5x7yHIB0fzOJqCGyH6dxcsRy02ZibYOB3g6z6Mh25iSpM18BZRx2qUuVQ3QBOHyQCkA
        tsM3S4q3WUGKiv+7wH8dGvC9cg4CEGZfVUl2L92ruvSO4gzj0rgyWwPwf5V7onkcCLxcVC
        tA+vE/Q/HMdk8s0EE144bB11FCNyous=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-JCr3MsS7NbyUPUKiGxsUmg-1; Mon, 03 Feb 2020 16:17:59 -0500
X-MC-Unique: JCr3MsS7NbyUPUKiGxsUmg-1
Received: by mail-wm1-f72.google.com with SMTP id g26so284461wmk.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 13:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wdmKq+r8C34si2IoRsHi9fqIPvPKHv+jVYiBofqYidg=;
        b=Z6yCtEmac115np+Q82/eFCu+VM1qv/IF378j3ycZYeR946REVxwbXk8Lp1ZGoP+KHL
         Pl8uzvqiNlWc1qJUUQ12cCkfU0lBQA307fIvZ36SNddqm5wctH8cTXSN412rOrnadCuq
         JGQXDFF2J64HOwxKIUDWwiZoH51HB+aB/las4/0BR6qaImiP2MHCsPktf+UnnYqAQCix
         SEd6U2m+8H75KlILWcp6RAXmZIBf8vH+VmVyez03kqyJ2P3RQcm2t7Fp40Mt7VAzOF1E
         loNdqtpaIjPel3OuzLeG4ZgfHkAk2QXf7uwuLdCVroWOeYW5VR/fQxjnsKFwpltpaeeO
         +qDA==
X-Gm-Message-State: APjAAAWiG7j39gJaTMj4hv7ij0X/dz6KUILS+yL7XKm7UfiFabzA6cIO
        4l2ey2BsSdkv/8uzA956V8qhO0hkC5DfPL/falLRNzdlnEncLgQmk4MWD7TmPR5TIM0QIlJG7pk
        40nmqjdDrnkJeK7/1K+HeDrwx
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr942577wmh.94.1580764675157;
        Mon, 03 Feb 2020 13:17:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+xKpUSX7ybVFXjcCz+cUowAmvLC1AIMBE48DucQsuNnWMiuuwiasgraDHD6A5uXDQEy7TNg==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr942563wmh.94.1580764674977;
        Mon, 03 Feb 2020 13:17:54 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id y12sm809312wmj.6.2020.02.03.13.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 13:17:54 -0800 (PST)
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 2I385SW to
 critclk_systems DMI table
To:     =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
References: <20200203201105.11659-1-georgmueller@gmx.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <466fff4c-eb61-7fd5-1442-54499c3db645@redhat.com>
Date:   Mon, 3 Feb 2020 22:17:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203201105.11659-1-georgmueller@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-02-2020 21:11, Georg Müller wrote:
> The Lex 2I385SW board has two Intel I211 ethernet controllers. Without
> this patch, only the first port is usable. The second port fails to
> start with the following message:
> 
>      igb: probe of 0000:02:00.0 failed with error -2
> 
> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Tested-by: Georg Müller <georgmueller@gmx.net>
> Signed-off-by: Georg Müller <georgmueller@gmx.net>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/platform/x86/pmc_atom.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index 3e3c66dfec2e..ca684ed760d1 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -383,6 +383,14 @@ static const struct dmi_system_id critclk_systems[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
>   		},
>   	},
> +	{
> +		/* pmc_plt_clk* - are used for ethernet controllers */
> +		.ident = "Lex 2I385SW",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "2I385SW"),
> +		},
> +	},
>   	{
>   		/* pmc_plt_clk* - are used for ethernet controllers */
>   		.ident = "Beckhoff CB3163",
> --
> 2.24.1
> 

