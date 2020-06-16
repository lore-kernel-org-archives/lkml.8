Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2C72067B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KdHZt9Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgFPRbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgFPRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:31:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277BC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:31:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s135so8852303pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JFUWo+MiY48XJWPPKzfAjnu7zovw2GjrlHd1LDatkUI=;
        b=KdHZt9Na9H2BvVy4TnqAAM6MCsluX1/DOyZOojU/LueEC1VqedufyiYouMxUonuloa
         qCxaZeN2wznLC5bjslm2E85yu/5eg6LRBqJFk98+T6gpYG6Va5hU2sK5Txf+yUeCZiOx
         knmvHOxbRkTaU53TifRPzsiJwHHmw4aWT2y2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JFUWo+MiY48XJWPPKzfAjnu7zovw2GjrlHd1LDatkUI=;
        b=rkGtACNjKHj1BZ4qFg3dTTMtO32bMF3MbqRpxdusihp0unq/8pRCDW1PaWXReETyiB
         kwY1U4lLORg6ESU25hk/Rx+HLpHJZMf6iAZELw17Ub9zkaPbHZIOwaMTScXceWtKwaKh
         KuJ303Hi//CJYCiPXxCn8AFeAdOS7eB61x4bHafg08Fz+q9zVQ15t5I2be/1v2ozysLB
         D7RegIMZE+6PHDqS05YP7Lighd6FAF+Jyt9hRaxP5a6K2GSatt0CDZT3PB2BURkq3trb
         usHJpO8ABabetxiiQ8ebMwfq4ru8RC3ikbBthdbzGPnxXr5YYH5+roV3KerhDCb1+Vat
         p7yQ==
X-Gm-Message-State: AOAM533bh9QgRC3zeTSUKIyDE+GFbiPAAjm+n5bgvB+TxECrv6dya02J
        DaEXUe1LepzendVYJVGNF4/9+g==
X-Google-Smtp-Source: ABdhPJzT7jGgfpqMJ9IgTO3dypfg2xkVIHIazHYWCSMbgrj0Tdr5MxSlXhaWEouSjhLb0Sfk2BKE4Q==
X-Received: by 2002:a63:7a56:: with SMTP id j22mr2326669pgn.293.1592328678209;
        Tue, 16 Jun 2020 10:31:18 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c2sm17615493pfi.71.2020.06.16.10.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:31:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] spi: bcm63xx-spi: allow building for BMIPS
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616070223.3401282-1-noltari@gmail.com>
 <20200616070223.3401282-3-noltari@gmail.com>
 <20200616170724.GT4447@sirena.org.uk>
 <a6edd50d-db3f-8988-157c-ff66e2fd474a@gmail.com>
 <20200616172534.GU4447@sirena.org.uk>
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
Message-ID: <ea904b53-3f6f-da28-39f8-f811f432395a@broadcom.com>
Date:   Tue, 16 Jun 2020 10:31:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616172534.GU4447@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2020 10:25 AM, Mark Brown wrote:
> On Tue, Jun 16, 2020 at 10:15:15AM -0700, Florian Fainelli wrote:
>> On 6/16/2020 10:07 AM, Mark Brown wrote:
> 
>>> Please do not submit new versions of already applied patches, please
>>> submit incremental updates to the existing code.  Modifying existing
>>> commits creates problems for other users building on top of those
>>> commits so it's best practice to only change pubished git commits if
>>> absolutely essential.
> 
>> In Alvaro's defense, you applied the patches despite me requesting that
>> specific changes be made (use the optional reset control API variant).
> 
> I applied only the two patches that you'd acked, not the reset patches
> which had problems.

Indeed, sorry for not reading your commit message properly, I believe I
request that before, cannot the "applied" response just reply with the
patches *applied* and not *all* part of the series?

> 
>> Having a FAQ entry about what your expectations as a subsystem
>> maintainer are (ala netdev-FAQ.rst) could save you time along the way.
> 
> Incremental updates are the default AFAICT?
> 

It really depends if the maintainer is willing to rewrite his tree
history, some people do, some people do not, especially if nothing has
been submitted to Linus yet.
-- 
Florian
