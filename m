Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23077C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3522086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S2EB4cW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHGSbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgHGSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:31:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685DCC061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 11:31:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so1994480qtn.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=37J7qkTY92lWYAHiK2P2ufque3G/VsvfMWt12OXbwFg=;
        b=S2EB4cW+wNSqkIy28VEhJoHLwrZkwysdckNeOMZOdGnBY6yTLLBEk8bUco+3kGa7Et
         +1tntLFyB49yfNG9+Km7kRHYmw3WiwN4AR9iK8ESzkXIXTKW2QrmL87UFaL/xcoPM83I
         7vmYROEqceEVWG1iCLBKW4xk1nT23kIRcIqok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=37J7qkTY92lWYAHiK2P2ufque3G/VsvfMWt12OXbwFg=;
        b=chwvmHUUFDmbeOd5163W/6O0NGA2QKPvRC+Rwch541bk6d2s1UTa8tAANE74Trp02X
         KtG4Mn5dk/eGQHwUeOBy76G0rW+mYQob4JUaq5C+rZv5VwCwn+icmmnPksAc8mej/Cx+
         t7Jr2u5MZ8nstWHM57h9tN6/ZY9vQHa2xjfOuRBH/P8Ze6WgEjJd5i1qbBb1Db92gq1C
         XPqpxxVlFmQLrrloZMQi8V7B3v5Aj7Vh6Zyya11FWTxQBpn45ue8mNNB/h51RMm7T1Y8
         R6AL9BioJdeOnEGd1DyKMLHZ4Zd4IqOi0fF+7AMUpIr5OVvAPW8rM7liw2qrrAOXb21j
         5dEA==
X-Gm-Message-State: AOAM532fsAWad3/IpqWkhLWto7VavG85AZ30/iYNt4Ek/jlkBLfQrsoi
        gccnd5HweUV+RITm7y8mAu9635FDxw1iP0OTbplUcA+iPspebvl2h6+I2ZfFFZ6w2Mu6H/1ry4r
        9OtkDwXODLVnkEzMqE5zU9Um3LuE863j62eVtLZDFzC8lmiYLerx7OfnySTGg++NE00m21zEw1Z
        Craxu3rmg2OQ==
X-Google-Smtp-Source: ABdhPJzmMbF2ReskD0h3kwWD6Zs3hnqV2cvq+9bDeGMxGiKNZ80EE3N3uUU2+kzN1rtiIVobk/e/UA==
X-Received: by 2002:ac8:50a:: with SMTP id u10mr15457097qtg.175.1596825094120;
        Fri, 07 Aug 2020 11:31:34 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id h55sm8955916qte.16.2020.08.07.11.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 11:31:33 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] MIPS: BCM63xx: refactor board declarations
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200807100411.2904279-1-noltari@gmail.com>
 <20200807100411.2904279-5-noltari@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQgArgUCXnQoOxcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoHaNB/4p5GXw2Xlk4r2J0MsUAZE4Gnfc
 C4DtilufOGVR1K0/WhROYemyCAP+xuBj8bnQDBtZwB5ED37q4/p8DSmCnkEBjM5Cz12EZQzs
 utQgCV1UIgzryoiDZSF2XLslzF9LOSaOiNzpBvwEYNTZ+koEW+AOHEAgS6SbV2Hob8Zc32xF
 oQdKGwbSwcV8hS2YLL37VxKr2h8ZTtuTmhDNqxuKPzZuoAL61/4i8+BTyVZC4gUL/EUu7pG2
 rbwhg/s8TyQWWeBz18Xiw5K148TXT0LeErmTsJSPQFMqZ6AR/nuJDQzhIUiLeq/hvBs1BIQf
 REqNMShEnnMJfHjd8RFnGpdPk+hKuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <6e80d5ad-4dfa-bf2b-1126-3a994ea90273@broadcom.com>
Date:   Fri, 7 Aug 2020 11:31:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807100411.2904279-5-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/2020 3:04 AM, Álvaro Fernández Rojas wrote:
> Current board declarations are a mess. Let's put some order and make them
> follow the same structure. Also board declarations tabs.
> Switch to SPDX license identifier.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

That is a lot of churn, not sure if this is really worth it... in any case:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
