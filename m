Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DAAC3F2D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5120D2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1IRc54H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFHWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:22:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41794 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgCFHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:22:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id v4so1057338wrs.8;
        Thu, 05 Mar 2020 23:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SnUqcrVsJzqJaaVzt0hPVe/gTQHBXGhcLib5WHQ/AJU=;
        b=p1IRc54H8JzpxRZeZG0bSTeItFXg8PjCDo21GH34exsa4OQYBGv6BRnOcCVkFANCiQ
         8dZCcI8PQnGba7V5LgTgvN0ETfNr+6jiDBa9JtgXS3lQtjn/S3n1Kf3WHv+ew/SzUmSk
         w7qihFs65T7614lKbUMSZrVVzGFfLc6sHKR1zMjBMk1XXl9Uaw395Gr+zeZsQWU1C4zI
         XYRtTPb4dzWNR5zjwLdFKfaXb7fiDF3kwG+2KuDBV4zDlQYNrcJEeSxZw+CEh06Mhfvu
         gedGylWQ/43fy9sKMJ+fG3n9R6fgYGItazcFMNVKEuexXIiVh1Ixo2a9DIIeJz7NgNhQ
         Hmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SnUqcrVsJzqJaaVzt0hPVe/gTQHBXGhcLib5WHQ/AJU=;
        b=Bv2sqheDl2wIouJ60seqC3xUOGO5RceLnbd+wWW67bGNHTdbsrf6vwE6RcXsAoP2MU
         nFYmDUfj8TspIxTlgW/1SMvGkW874cyShUil40nWiFoA3a6OE/3ZFMYLbWhxYkCoQtkT
         Kkj86Wu/S/GBMqvRy7ZOVYshKGlsTgPMpF8gCqvC3aev66+NokJ1vY25NzPYpuDBtigJ
         EgjpiRV+KXsVTvIXhfNLGAwHkf/p1nJDBiJZ1Z0bUX6jkK2ubH38BR4UFPTfvVvkM7tG
         nR2sa5sg4OEudY+NpGGg6ozxYusUmsyyEwQfnK3sBYthhQdDrpgSm+m0pLODkdH0tB9Z
         VP2Q==
X-Gm-Message-State: ANhLgQ3Q+YuggFQisPN6JBxBbK1zhz8uyvOMlTWbTkBHvsBQofiuLHXx
        thwsrxbMhHSOukZBV1PVCKw=
X-Google-Smtp-Source: ADFU+vt15QdHPEyOlXqze4BvjuHTIZJH5fEAu12zNjWL5ctAZ2d9xwsBEuNTt0doZ65A7htgMnXryA==
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr2431238wru.35.1583479324472;
        Thu, 05 Mar 2020 23:22:04 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f207sm14897847wme.9.2020.03.05.23.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 23:22:02 -0800 (PST)
Subject: Re: [PATCH v4 2/2] arm64: dts: rockchip: Add initial support for
 Pinebook Pro
To:     Heiko Stuebner <heiko@sntech.de>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Emmanuel Vadot <manu@freebsd.org>
References: <20200304213023.689983-2-t.schramm@manjaro.org>
 <20200304213023.689983-3-t.schramm@manjaro.org> <6168222.Wuk326WHQK@phil>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <7a799284-92ab-ea04-285e-37d655064118@gmail.com>
Date:   Fri, 6 Mar 2020 08:22:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6168222.Wuk326WHQK@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missing #address-cells, #size-cells
Can you still fix that?

On 3/6/20 1:23 AM, Heiko Stuebner wrote:
> Am Mittwoch, 4. März 2020, 22:30:23 CET schrieb Tobias Schramm:
>> This commit adds initial dt support for the rk3399 based Pinebook Pro.
>>
>> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> 
> applied for 5.7
> 
> Thanks
> Heiko
> 
> 

> +&edp {
> +	force-hpd;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&edp_hpd>;
> +	status = "okay";
> +
> +	ports {

#address-cells = <1>;
#size-cells = <0>;

Don't forget that extra empty line here.


> +		edp_out: port@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			edp_out_panel: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&panel_in_edp>;
> +			};
> +		};
> +	};
> +};

