Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C8AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FA820781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j91ZT750"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHLPNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgHLPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:13:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022C2C061384;
        Wed, 12 Aug 2020 08:13:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so1728842qtp.1;
        Wed, 12 Aug 2020 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jd+0O3rfZzFFL8LU24BOfuyCqms8qaWRv2Co74kbUzc=;
        b=j91ZT750zKdCaCs4PQtHNGQx8b7SYeKNb5qzyJ5ohLQUEL3iCPkSC12yVA98Qd3XZA
         aBwqrwl/PshYusq68OX1wPw/JOQboTCXOpwLBqSalmYjNfcMdx8AyiCi1xDaPGN+f9t9
         4eiF04kqG8gzcHjhsd4cLYBV4lYgIuHLxUVuOQdsKSTdhjh0pTvCCXvTDaohVViR9Ppr
         Hde4WwVtAclxGRzY2jqBNY48bQPAwtYh4Nwglua8IN7T/5V2kWZBvFnRxXRc2MyedgiG
         O1TF8j5YSLdh+NcKTAgGbBv2zN5/7tUZGM6eJzMAve+tX3Q5uc/+58Emc1RQCUkIBXv0
         b+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jd+0O3rfZzFFL8LU24BOfuyCqms8qaWRv2Co74kbUzc=;
        b=Z0ifID5BJZH11zKUAFT3mZ4Iq7nNsQBvmAvefgSdQosFDYsjdpCBFOot1l57w8FW+K
         hTJJtzrU8tmOZACbbXp4amDClhh/ShDa9Zq5WA5nkiNqPsDwZ1y9fY3zAdBnfEhGIrYA
         NWaJUk1g0k6WQUtjyCzGJ6bubFW0JcLWResk6c5xDmweqskewlgk6cppHizaf907bkDc
         TetSoQ/3+Pjsri6ecofmbrGRFPBRN9Sl8U5bwsraLid9q9AW/ShBPfJIN/t/kjkjxfut
         6XY62kBMRwRqjPWjBvRpmW5hjDxpkGhvchHd/LV42KWcslemltDoWDr2U+KMqf3pjo7E
         IJuQ==
X-Gm-Message-State: AOAM533kq9NaC8U3pP+aLuyZnJon9d/HByEO0dm3KlaZY9aVB20rbfp8
        35rLKbbL2HJ9jkdU9mKuqSM=
X-Google-Smtp-Source: ABdhPJwA+sy1dnYb6dWMech9eiLy3w6fKdLRQCmJZxZMNY8ySvEWD9H+y9uw6zP8ha5m9sVYRWMVBw==
X-Received: by 2002:ac8:7606:: with SMTP id t6mr44005qtq.348.1597245205581;
        Wed, 12 Aug 2020 08:13:25 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id k5sm2695377qke.18.2020.08.12.08.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 08:13:25 -0700 (PDT)
Subject: Re: [Q] devicetree overlays
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
 <24f1687c-043a-a15e-0be4-8392e7b5c96b@metux.net>
 <CAGngYiVokqYkEiQTcqAMnvif3qEWkPOb1cAk+4rvwgxBKZ5Ukw@mail.gmail.com>
 <1acc987a-d844-fca7-77eb-cf1d466f35c1@metux.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <fd63b1d4-086c-8bb2-0ba2-19cdf1709e08@gmail.com>
Date:   Wed, 12 Aug 2020 10:13:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1acc987a-d844-fca7-77eb-cf1d466f35c1@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-12 08:27, Enrico Weigelt, metux IT consult wrote:
> On 07.08.20 16:17, Sven Van Asbroeck wrote:
> 
> Hi,
> 
>> I believe you're asking: "how do I associate device tree nodes to
>> devices on a dynamically discoverable bus such as USB or PCI" right ?
>>
>> I believe that already exists. You can describe the _expected_ pci or
>> usb topology in the
>> devicetree. If a device gets detected in a spot on the bus described
>> in the tree, that
>> snippet will be automatically associated with this device.
>>
>> How to for usb:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/usb/usb-device.txt?h=v5.8
>>
>> How to for pci:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/pci.txt?h=v5.8
> 
> Thanks, that looks good.
> 
> But I've still got another problem: how can I use DT along w/ ACPI ?

Some answers from https://elinux.org/Device_tree_plumbers_2016_etherpad

Question: what about device tree on x86

    Answer: there's already support for DT on x86. But, we should not mix DT and ACPI.


A controversial topic is ACPI overlays (putting DT in ACPI or ACPI in DT).

    Don't want to have drivers that get part of their info from ACPI and part from DT. That's nuts.


Question: Can you have ACPI and DT at the same time on x86?

    Answer: No. Some ARM64 systems have support for both ACPI and DT, but the system selects one to use at runtime. They are not used at the same time.
    You can run the DT unit tests on x86.


-Frank

> 
> The scenario goes like this:
> 
> * machine boots and probes normally w/ ACPI
> * device is detected via USB, PCI, DMI, etc -> driver gets active
> * driver loads (or carries) a DT snippet
> * devices on the bus are instantiated via this DT snippet
> 
> (driver could also be some udev vodoo)
> 
> Example a:
> 
> * generic usb i2c dongle w/ some i2c devices attached behind it
> * config (or DT snippet) somewhere in the FS
> 
> Example b:
> 
> * x86 board driver (eg. apu2/3/4), probed via DMI
> * just instantiates a bunch of generic drivers and wires up
>   devices (gpio, leds, keys, ...)
> 
> 
> Do you think we can already do that ?
> Otherwise, what has to be done to achieve that ?	
> 
> 
> --mtx
> 

