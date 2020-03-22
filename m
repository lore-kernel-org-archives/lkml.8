Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F90C54FD0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C9520724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB2WW586"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCVQO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:14:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46560 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgCVQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:14:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id j17so10216712wru.13;
        Sun, 22 Mar 2020 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hizVSe59radb+6FhRqDPjO/ntM+mFAolvmlI5rEmhI0=;
        b=QB2WW586/dn1R2EKvP9IStphvlHgFLJvuuhgtH0CBS6HHLKq2N2mHhFKG3E5fwHN0W
         uw/NagBrkjWo1TreySFiPUrykpJZz6KiYSR7pAQxhSvjbNgoH7OkIk4PF/fiHRPzUHkK
         WyGPqHZxvyoCgWJUZLsmfFCS4tIK2SoDeAnP5f9Vo4VRy1EpAC0CZKQRF21O8W+MW811
         XTLNinDhFFgd2ZcVChKbC2EwsTadMosoMPgrO88IWBR1Zy+a6L2JLKpQlMzTe03BY/M0
         ttoXlV7KFxd7HR9gPQWMfplkEETMUnXOT2i0PZuGdHYkvMn9CbG3UPdIIfGegQvv9uwA
         H4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hizVSe59radb+6FhRqDPjO/ntM+mFAolvmlI5rEmhI0=;
        b=Y6Xa016eSiAXeBeFVkHQG+Zq3TlDGczDLv+rpqSIs6aEF6ZKOHWZjQjHf/RDpxOnkE
         OkGVbIzfys45m2gmgXLJ9FPaEpeAtPzE7Os9Mw+Qw6Zb+iG/yImJ2ZtJWMKjFUVV2ui8
         zoCwrGzJ18o7rnW6Rdtc848wOqI5t5pwFRF+Cdq/KtcqB50f68Z8NypFxoZkypvdntH7
         lA+l1tQi4Q/js8N72jCZW+d2fdglNfIxEILAOZF9+TLtH/iq6BUxBWFltltfKW4wjwoT
         BEFIZVmXItnxb2MS0oJ+iuJCB3PHY8sqssI779W5aoECqcTAcmBjqbMEopQWvv3nP+eu
         jJiw==
X-Gm-Message-State: ANhLgQ3RSlHsHfKrKdGtnVXdD5LWk1ycIOqIykJlIizQyu9xVI7cU8VB
        vDB22vG4Lo+ygToTJfVGLog=
X-Google-Smtp-Source: ADFU+vuL8u1yT0LW3mBPs899oOcxhjI7ql5VCngzIx8aQj1gkmk9nYlVF3dvavMFzzvuU9NzW/a43Q==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr17017585wrv.92.1584893696625;
        Sun, 22 Mar 2020 09:14:56 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q4sm19846680wmj.1.2020.03.22.09.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 09:14:56 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: fix defines in pd_vio node for
 rk3399
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org
References: <20200322140046.5824-1-jbx6244@gmail.com>
 <48a91cc1-7751-4df0-a2cd-940eb829fa16@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <1a6f0ba0-c49c-c547-1252-eed404655f43@gmail.com>
Date:   Sun, 22 Mar 2020 17:14:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <48a91cc1-7751-4df0-a2cd-940eb829fa16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Why is 'pd_tcpc0, pd_tcpc1' grouped under 'pd_vio' instead of VD_LOGIC?

Thanks

On 3/22/20 4:45 PM, Johan Jonker wrote:
> Hi,
> 
> The RK3399 TRM uses both
> 
> 'pd_tcpc0, pd_tcpc1'
> 
> as
> 
> 'pd_tcpd0, pd_tcpd1'.
> 
> What should we use here?
> 
> Thanks.
> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 8aac201f0..3dc8fe620 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -1087,12 +1087,12 @@
>>  					pm_qos = <&qos_isp1_m0>,
>>  						 <&qos_isp1_m1>;
>>  				};
>> -				pd_tcpc0@RK3399_PD_TCPC0 {
>> +				pd_tcpc0@RK3399_PD_TCPD0 {
>>  					reg = <RK3399_PD_TCPD0>;
>>  					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
>>  						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
>>  				};
>> -				pd_tcpc1@RK3399_PD_TCPC1 {
>> +				pd_tcpc1@RK3399_PD_TCPD1 {
>>  					reg = <RK3399_PD_TCPD1>;
>>  					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
>>  						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
>> -- 
>> 2.11.0
> 

