Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C2BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594AA20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvm/hFJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGPUnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgGPUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:43:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB5C061755;
        Thu, 16 Jul 2020 13:43:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q7so9888920ljm.1;
        Thu, 16 Jul 2020 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X1aLmpr1/PmjZwi4WN91F908Ha9QHwqDqsurFVd7fDg=;
        b=Xvm/hFJKgWLTWEUR91X07JCRt32Iwxb1tIAF6Z03k6coGfMaJ2KQ8/0cd7CBabxMLn
         x7MDDhs9Fyhcs69mK3+750VqPQvoRTI6Ox9G6qOgth2LNIAy8Qz5VmRWj9F0zY0wzy7W
         Kw1ZLJXXpKL7s3XgdAIXgZVENHgyZg1Fbvn9Rz/z+/3VmkQAdARFj+ZBqEd3Pyu1u0tj
         GSr9EVAVIu8bx7iuPZofPPAq0K2APuop3kBODBnEAwSEVOA17Lzi6pgf4Yk9UIS40zcv
         thYt/Z2045eOz1wUeeU4IKVXrCZ5EnySxQTTdx1CeSZfErSllH6EOlVotZRqLn+6o4bh
         /svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X1aLmpr1/PmjZwi4WN91F908Ha9QHwqDqsurFVd7fDg=;
        b=KWswmDU20vKv6/9ANCZz3fryarGjXLzyJZf5Z6OM8N6mGjLfGDnmd1qdePpyoTp4mf
         MQlKQw9hlFECf8JsiBt6T3EVYsUYpTEpeOik5l4cn+Pop3sm1xpeHYI12r/8xkdqQ0b9
         eQeBZBE4MnZ0lV7NhYH8npCnxx0BMAj80leCyQPGbnswJokdELsxs0jvdDA1noztN0z7
         y9m6HvZlOzodZGZhyd7TfVEfpBwWIcDiiNUqw7o27Y47A4QRYOBjq51/HP4Vn3Yy0ziG
         OVSOYCLj3QdRNiYD61XoLMvXWj6nnQ9P8ELjWxdrYpo+haRqsG0TXlxPjB2UhXL15IDS
         1BnQ==
X-Gm-Message-State: AOAM532gEHKLpnw6JbEPwRhRXuC+njQ4E17LT8zwZPB5Ncr7qzGrVs7s
        02i97sJZkWBJJTJc2NUwjLGE1tZ5
X-Google-Smtp-Source: ABdhPJyxd1j7WX5boeV16OTfXRfSEGjp4mRExIkmloRQjDdsWh3v9mf1JUtOioAtRTx0anqyq7RQ0A==
X-Received: by 2002:a05:651c:1a6:: with SMTP id c6mr2784612ljn.358.1594932210932;
        Thu, 16 Jul 2020 13:43:30 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-4-184.pppoe.mtu-net.ru. [91.76.4.184])
        by smtp.googlemail.com with ESMTPSA id m20sm1254770ljg.107.2020.07.16.13.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 13:43:30 -0700 (PDT)
Subject: Re: [PATCH v10 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7
 devices
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?Q?Pedro_=c3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200629025456.28124-1-digetx@gmail.com>
 <20200716123814.GB535268@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5aeaedc0-80a6-de59-d69d-196dbd058690@gmail.com>
Date:   Thu, 16 Jul 2020 23:43:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716123814.GB535268@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.07.2020 15:38, Thierry Reding пишет:
> On Mon, Jun 29, 2020 at 05:54:50AM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series introduces upstream kernel support for Acer Iconia Tab A500
>> and ASUS Google Nexus 7 tablet devices. Please review and apply, thanks
>> in advance.

> Applied, thanks.

Hello, Thierry! Thank you! :)
