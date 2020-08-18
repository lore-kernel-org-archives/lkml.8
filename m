Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75FAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7FE20789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjWjfWhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHRUIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRUIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:08:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2558C061389;
        Tue, 18 Aug 2020 13:08:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so19422595wrh.3;
        Tue, 18 Aug 2020 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P+e1XORCArUjlcDdAd5PUU8mU/r/AXgnqjIeFVw8sX0=;
        b=hjWjfWhzsO5WjVXAZMLwnWx/NcPsyU+rLlisNYNis5RdLQ9BJPhfkNExNd8hQDI5YK
         xKuMya1lhEhb8Kddcy8Q25nIDq1RS8BM4BuF/rc+e1xFQ4f4UdYwkLrCzD5CoB/F3uog
         N4IRGBsAkOnDIiPHsmYYbj0dq88Z5yLs6N8Dt4cBVEXjLasehClXIz7mkeg/VLiOexP7
         9eQGa8GCty5mZlAlEcTiHXe3nkmi6e6kI64n3DyeZXKAjK95QKkQ1v9ORbSClj9vakwo
         DJ5AA7Z/hhtONXdK42+ZqnYs2S4biys9wpXNBDJaa+v1mKp3vurGsd+PqY2hOAum3exU
         LnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+e1XORCArUjlcDdAd5PUU8mU/r/AXgnqjIeFVw8sX0=;
        b=rRPOYy5Q2e1gftIlupgBe5uuR81lP/b0MI5LjLE3QJcZ6wr+h/F80kcH0aLisdn4nO
         Xflb2rmpglZqtdIcqQ/tVWdysUZx0yGF11HYDEIWgilBYycfh3ovfKUxuy9beZ9ehmFI
         CqWogkFkXAXE2kucde+WY23yrO5i9ACUMy1s+gIxG/QUR8TZi3kr70b/RJa//Zor5hVL
         R9sRsQutKBYB6o5hjTdAfN5t4iUbbV8bH/hk3BUi6oucXzBOrnMfpy1V8OIBigDxgq4t
         EMleaEzqc9APR9oY9YXKQf03dlOjrX0cr43W3K7ZcUsjuK8CzYturgUxi2TdkGVEkmE7
         mckw==
X-Gm-Message-State: AOAM531LAJ9so3dA/CmCiF09P77TP8sbrExP8icMPhsEzMKiDGPwrxjW
        AXdkyDYBAxW5tjv4dZEXLlb/KnA9M8U=
X-Google-Smtp-Source: ABdhPJykL/i7OeaWIHcNFUBv29KZ35a6suyplOOvmz9XtIcn+gcy+MyozdD0gATn1PST6BzQjvsuGQ==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr16937864wrg.100.1597781281606;
        Tue, 18 Aug 2020 13:08:01 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id l11sm1306472wme.11.2020.08.18.13.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 13:08:01 -0700 (PDT)
Subject: Re: [PATCH net-next] net: dsa: loop: Return VLAN table size through
 devlink
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200818040354.44736-1-f.fainelli@gmail.com>
 <20200818174300.GI2330298@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <def6ed7c-54a2-a670-624a-9c23c0306cd0@gmail.com>
Date:   Tue, 18 Aug 2020 13:07:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200818174300.GI2330298@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2020 10:43 AM, Andrew Lunn wrote:
> On Mon, Aug 17, 2020 at 09:03:54PM -0700, Florian Fainelli wrote:
>> We return the VLAN table size through devlink as a simple parameter, we
>> do not support altering it at runtime:
>>
>> devlink resource show mdio_bus/fixed-0:1f
>> mdio_bus/fixed-0:1f:
>>    name VTU size 4096 occ 4096 unit entry dpipe_tables none
> 
> Hi Florian
> 
> The occ 4096 looks wrong. It is supposed to show the occupancy, how
> many are in use.
> 
>> +static u64 dsa_loop_devlink_vtu_get(void *priv)
>> +{
>> +	struct dsa_loop_priv *ps = priv;
>> +
>> +	return ARRAY_SIZE(ps->vlans);
>> +}
> 
> So this should probably be looping over all vlan IDs and counting those
> with members?

Yes, I sent an incorrect version, thanks!
-- 
Florian
