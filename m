Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A9FC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443E2206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2iBL7r3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgEEEKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgEEEK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:10:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA8C061A0F;
        Mon,  4 May 2020 21:10:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so301782plr.3;
        Mon, 04 May 2020 21:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DoqDXH/3ekdVQe0eRy5uE4ovem02TnuS1+gpXK1aVCA=;
        b=E2iBL7r3i7+fGgkaDSkcdr4xgJYIvdXvpfhukXGhunJilBnuw2i0wDcSl40PTZOsBh
         9Cl2lWM6wdwbQ9wCJsGL0yEqO3efdvcGWpX3xo7jwgbqZxP7QOcELhwahRU2WxGcpCGr
         yEjSY+wM77i0QDEaOUedNPwDTD5+oVdAjhEdQOePFpFiffr/SIF8er1WB50+FVWI2TlG
         +fYq7qtVL1YfTt+Mr9ba6EMhz4kYJi8iFxsp+3whfv6sl5Stwx+4qFXdezCkQksQb1O4
         pAfudChDjEXdnlFLKHeXpgIpmrAJURvfp4OtmbKyPrTjxN3OYqDlCF720+XRKQwMCMw8
         KY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DoqDXH/3ekdVQe0eRy5uE4ovem02TnuS1+gpXK1aVCA=;
        b=unfjSEow3w76tmktRZ9SOY6MwvMf18Dt/nDZAI7/pogBPATfz2mUaYrDrGUqpSKT8T
         5gW++tAhyrZ2TdMOMFqe+nPsbuJwrft5QPom3cSzSVwz2+2GLePIfQEazpusxf/ot1u2
         nWYs7mILKdKYQjr04xY/m26Opwb7Sz5BkN2VopUhFNwq9mG8sGqYX1TmL3yLHw6c5pXo
         045nUmcasqpuyCd4H6h0mG2dxuOgJWVGBIUfXxxfEUfebJUy9R+dLmwKO+0RUw/6hYwU
         /h938flPFbtNvag0j+lau1xjHHdsr3eB/sNYUCPoE2iyxbps+Ov0+BtSHGTaG9pBMLVo
         cyQw==
X-Gm-Message-State: AGi0PubouMUO3IQ1DhGM+nRdWh3SCOM6OuQRK2NblGwsXLjHdNJZxlTe
        H/CBkLvWpTvNuQLsl48OB8E=
X-Google-Smtp-Source: APiQypLD5muE/WYp6e4N6pTtzFOfl/tftsP8gdsMUqnOE9ga8bx2CfE1LL2e8qTPkMdTAfvfhbYUnQ==
X-Received: by 2002:a17:90a:dc01:: with SMTP id i1mr597850pjv.166.1588651829190;
        Mon, 04 May 2020 21:10:29 -0700 (PDT)
Received: from [192.168.1.7] ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id w125sm491358pgw.22.2020.05.04.21.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 21:10:28 -0700 (PDT)
Subject: Re: [PATCH] fs: jfs: fix a possible data race in txBegin()
To:     Markus Elfring <Markus.Elfring@web.de>,
        jfs-discussion@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>
References: <5ef374a5-0e2e-5c74-a827-0148c384f6e3@web.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <abbb03ec-7ce3-08b6-7d08-420743067f19@gmail.com>
Date:   Tue, 5 May 2020 12:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5ef374a5-0e2e-5c74-a827-0148c384f6e3@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/5 0:15, Markus Elfring wrote:
>> Thus, a data race can occur for tblk->flag.
>>
>> To fix this data race, the spinlock log->gclock is used in
>> txBegin().
>>
>> This data race is found by our concurrency fuzzer.
> How do you think about a wording variant like the following?
>
>     Change description:
>     A data race can occur for the data structure member “flag”.
>     This data race was found by our concurrency fuzzer.
>
>     Thus use the spin lock “gclock” for the resetting of five
>     data structure members in this function implementation.
>
>
> Would you like to add the tag “Fixes” to the commit message?
>

Thanks, Markus.
I am not sure how to add the tag "Fixes"...
I need to find which previous commit add the code about txBegin()?


Best wishes,
Jia-Ju Bai
