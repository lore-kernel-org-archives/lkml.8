Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B510AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D29620656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pI712vEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgFOLGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFOLGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:06:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E134C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 04:06:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d128so14377923wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bkSrH01Y9/k1sqHTBOMyZUGjP61F3NctXnv7Wc5jLaA=;
        b=pI712vEnq3B3TlnbyFkdvI5qsIsT62Zhg790hq2UMhXw2u3m5JeC13EbTaU3S9eGN0
         1f7rR9B2mlCYXbokxg0sZgojsN2AB+p0uy4yUAh5B4irpWKhzbdZQNxafSYtU3MT1df8
         2/OnToMBAI8l9wcM6Nv2vi0uGTyFWUf1tN1HK6kvv+lcNZwkb/HlCfZcwfcWwWdfdkKa
         uAd3ZEJCq15xALYZ94eDPZjqzPOS3GgAI8GFLnG7KmbSP3BDkq5mAV93zF0HBqxNNh5U
         k3G/tv87zN5SteF9hTrSng4vPbbwepYFLH16sa96Ak9vK3J633J7IEPV958dxk6jCd27
         /Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bkSrH01Y9/k1sqHTBOMyZUGjP61F3NctXnv7Wc5jLaA=;
        b=HBkmeKZzDJsFw2EeQnWCQxTObDXKr1JX6oJLawtaOKN+wFHQjFXTlJXrE9Ls1Z6Nod
         kPPGGs/xBcLm+ZZl6PgJYGf03cezEV4XU5XJRZStPZSm9+7Niqd/Y5wpLtADJY3XSc1J
         2vcc8ez1jVIQm0LuPAz37u3jePN0Ci0cE9x8aX+cuynq63cOJmdWByo+QKB9aTNux+xB
         8YhJqnAX76cHBXd4A1z//VcOup0/NLzUhlYBcyCR0QGVMx1MvdZbtuGEv9pUbwpSH5ID
         3nR7zS7RMlHqDD4YZQkmIbwLiMhsDa80XtcxOFirSygixxyHmr98+6TFl/28JRTJeytT
         jaGw==
X-Gm-Message-State: AOAM530UDh+1Cfxta2Po1N+cOueSxOxuOZUt7VdKYE/zErg+OJI0+xcb
        p5w5qDjLfE+5DoxGLFutjPmKSF/feqM=
X-Google-Smtp-Source: ABdhPJyieyVjnMOv5YdDlns8avn2+fz2WmpkAFDaFceRhnpAnkevW5sSSQ+ykrMI6aCIM9/a0Lz9nQ==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr12143548wme.142.1592219172670;
        Mon, 15 Jun 2020 04:06:12 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x66sm22527394wmb.40.2020.06.15.04.06.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 04:06:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmem: add ONIE NVMEM cells support
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Taras Chornyi <taras.chornyi@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
 <20200529230451.21337-3-vadym.kochan@plvision.eu>
 <8a8653c5-b112-4042-cbdf-8498e38d14ee@linaro.org>
 <20200601090300.GA21928@plvision.eu>
 <0d664272-4ef9-fe2c-02f4-60e9ecb41e20@linaro.org>
 <20200601102749.GA25323@plvision.eu> <20200605105351.GA1118@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9f73d7ea-1f1f-9820-a9d1-55baa984873e@linaro.org>
Date:   Mon, 15 Jun 2020 12:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200605105351.GA1118@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2020 11:53, Vadym Kochan wrote:
>> One of the example is atmel eeprom (at24), but there might be different
>> devices.
>>
>> But can you please explain what is the technical/conceptual issue with
>> this approach ?
>>
>> Thanks,
> I just I'd like to clarify if there is a way it can be acceptable. The
> problem is that there is TLV format which  might be used on any nvmem
> device which contains for example mac address which needs to be exposed
> as nvmem cell. If to populate cells via nvmem_config then anyway I need
> to parse these cells from the "target" nvmem device.



As a first step this need to be part of the provider logic to parse this 
before nvmem provider is registered. If there are more users for such 
parsing, we can think of adding some level of parsing to nvmem core itself.

Hope this answers your query.

Thanks,
srini
