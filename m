Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C48BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB25B206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhjyr4lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgEFPka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgEFPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:40:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF6C061A0F;
        Wed,  6 May 2020 08:40:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so2881564ljl.2;
        Wed, 06 May 2020 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0VvaK4qV5Etc72CR3O+s6dMnkCvk9HbAf4bkxXWnjEk=;
        b=rhjyr4lDLoMgtOYB2r0o+OivmiLZx9dTkjsQDZagRb9Q7LOphEreVu7j948kVIskqU
         pB00zCfLrigfNDjQPvnSbpEA/3JH+bsvdictzcAByx3TSHu5HT3KKScX9HpYZoqbNRrQ
         pIgLDvC0dsm8atptTDJKGNXibJCC/ogo956lYPMcAG5wHID8weG0LsxzEImi0VYMPBHQ
         mM9r4Le4mdnH4VSA57t08E/b/8dRN6yq82Xwll0cEUhf/hWBrGgn7ywNMUTwIYFkN66c
         Po4MLektX/wUlAOBRPGHIVL+M2z724VA17kk0iDqCb+m30OIJE/yi3wHB3A8pFWyvZNM
         PGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0VvaK4qV5Etc72CR3O+s6dMnkCvk9HbAf4bkxXWnjEk=;
        b=tUXSgALTrehTRxwFxvJ1AChdI0Tqj7OwQtIpcz15sGjhp/oK/udaJHBvWtsHZU0h4u
         ghRKBKRaLznpMi3NN4du0zVKlNpglNm79JJZ/ZQAcYPS5i2NBPN+tS6ymFPvYqXGPpWY
         gX7ooIxaiREgrsZ4NsIyn0zzbpXR6WEKH0QWGSCqY8koXO+2pKoASNBsH62SqtbKve4U
         0TKQsPQ/WRljarphI5de8hM1inklSljtxhQYgmHApSYyUOfiSKMPSel93dMqUqWXaEhf
         4IYmI/W9o9NCjxO9dF8ZccaonCWhpCfLt/Vic+95jP90l0puDByKR30PBS45j7vjIkN4
         FciA==
X-Gm-Message-State: AGi0PubSUzXHi0yiZQ/vIRpNyzNcbSBNm4RZCzmgn5bQQsshWDbS88HL
        XSVvvD22M5o/Xw6FKzdphmc=
X-Google-Smtp-Source: APiQypJwNgzw4wq+U0P/io4z1Terb+WwllbnYJIXZLSDc1WfL/Fy5HRVyoHY9h17kjjk+8rpPHfUvw==
X-Received: by 2002:a2e:6a08:: with SMTP id f8mr5671980ljc.8.1588779627589;
        Wed, 06 May 2020 08:40:27 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id m15sm1557297lji.21.2020.05.06.08.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 08:40:26 -0700 (PDT)
Subject: Re: [PATCH] phy: tegra: Use PTR_ERR_OR_ZERO() to simplify code
To:     Vidya Sagar <vidyas@nvidia.com>,
        Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
References: <20200505150058.17674-1-aishwaryarj100@gmail.com>
 <be185976-3d12-f49d-6131-39f5075e0190@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d3397bc6-099e-591a-ff60-5e67da478526@gmail.com>
Date:   Wed, 6 May 2020 18:40:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <be185976-3d12-f49d-6131-39f5075e0190@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.05.2020 14:47, Vidya Sagar пишет:
> Thanks for pushing this change.
> I'm fine with this change as it is attempting to change only the last
> occurrence of the (IS_ERR(...)) + PTR_ERR combination.
> But, this code was initially written with PTR_ERR_OR_ZERO() itself but
> later changed to use (IS_ERR(...)) + PTR_ERR based on the review comment
> from Dmitry Osipenko ( https://lkml.org/lkml/2019/6/20/1457 )
> 
> Adding Dmitry as well to review the change.
> 
> I'm fine with this change.
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> 
> On 05-May-20 8:30 PM, Aishwarya Ramakrishnan wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> PTR_ERR_OR_ZERO contains if(IS_ERR(...)) + PTR_ERR.
>>
>> Generated by: scripts/coccinelle/api/ptr_ret.cocci
>>
>> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
>> ---
>>   drivers/phy/tegra/phy-tegra194-p2u.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c
>> b/drivers/phy/tegra/phy-tegra194-p2u.c
>> index 7042bed9feaa..42394d27f4cb 100644
>> --- a/drivers/phy/tegra/phy-tegra194-p2u.c
>> +++ b/drivers/phy/tegra/phy-tegra194-p2u.c
>> @@ -92,10 +92,7 @@ static int tegra_p2u_probe(struct platform_device
>> *pdev)
>>          phy_set_drvdata(generic_phy, phy);
>>
>>          phy_provider = devm_of_phy_provider_register(dev,
>> of_phy_simple_xlate);
>> -       if (IS_ERR(phy_provider))
>> -               return PTR_ERR(phy_provider);
>> -
>> -       return 0;
>> +       return PTR_ERR_OR_ZERO(phy_provider);
>>   }

Quite some people think that such a change doesn't bring any benefits,
it doesn't help readability of the code, it even makes harder to read
the code for a human being.

IIRC, there were some requests in the past to remove that cocci rule to
stop such auto-generated patches to re-occur over and over again.

The PTR_ERR_OR_ZERO is good to use in a cases where it's not returned
directly, like this:

phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
err = PTR_ERR_OR_ZERO(phy_provider);
if (err)
	return err;

return 0;
