Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26950C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9ADA2064C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0loXIBUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgFHMp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbgFHMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:45:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF13C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 05:45:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so17223488wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kzrIHDMd1rJH0AYfztwR/dcAaSAkML42UEE2ly3amJA=;
        b=0loXIBUS7dwSHa3aONVP5pLg2sVnVA9pto08hPlYb4s+0wxBbOCXQvHxjPdJ4Si/bQ
         nQKQOjrwe1mlXB7NZcFCS93xG8qWBUxezAEqJQ7GWl47pd3102vfLxFQCFzgbLXHsAD2
         qRNCmdeiBDeExVvCdDyOkRL4mcT7acS/zeK4j7N90pSTeUKZdZzZCd+G9w5aTzE6Efsd
         tA1mENtIEHRJIle17VXFKdi2+pDV5SroXKXkOcQjkCGNqyhvxwLQSAtXfsm7OLaAVe+t
         WkaGSySy4IZS+4iR+R7UMI3f2lNgRltv0VAQpwvxrfp43w1hb06TxZ2Sdr6E57TNkcML
         SjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kzrIHDMd1rJH0AYfztwR/dcAaSAkML42UEE2ly3amJA=;
        b=I8FmzXooCzDRVvHZj8VSTA0RmwvkSV+6hO2FG8bJkdkj+8RsifwqPqh9CvPbwI8XjN
         MYA2vZEq8iDQZudlLNWHilGa+4DQuxUaUCRQ32CtD9FTODKRxu8l98ZD6dA/0S2874/c
         ChpU3QtszdsL9vchT/vwJ4Jq6yxPeZmWrs5X2k7AcmZ4JMyRU4EAPO1j5EOOcKDjqeRo
         0vhtb2ZaR8ZDYcN7ugt1mRhdLDQLCHC4oxTCpLBmueGsj0qP0kvts02vSjj2GyxxZCxQ
         4K/PvVC2oy9SiIKjx9MuajfQHR6EfSiYbYLwKBMNi+3Q53/IA/WHA2XYbMOdF/Ya7FQP
         Mv0Q==
X-Gm-Message-State: AOAM53185xEDvXluIBIlcM2trNajiUoqHmRhyvDT70wN4d5ySu3L5pJo
        WtPT8CAkM2r3dGCQQ4kwIN0PqlkFHH2E5w==
X-Google-Smtp-Source: ABdhPJzyPn/T0BJF5ZEN9eFOSVxFBb9USHKPP+PjaW+ScH7wgedmbc08GM2FhW1bpBSpZBP7lW0/wg==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr23860485wrm.168.1591620324100;
        Mon, 08 Jun 2020 05:45:24 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:22:5867:d2c6:75f4? ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id j190sm22691969wmb.33.2020.06.08.05.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 05:45:23 -0700 (PDT)
Subject: Re: [PATCH] soc: amlogic: meson-gx-socinfo: Fix S905X3 ID
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200604044808.30995-1-christianshewitt@gmail.com>
 <7d58e4db-2893-3675-eb93-ea14c3534b5b@baylibre.com>
 <ACA41DA3-88A4-4141-AEAD-C056C9834B6B@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <f037849a-0a23-8fdf-f953-28f62c0f9c62@baylibre.com>
Date:   Mon, 8 Jun 2020 14:45:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ACA41DA3-88A4-4141-AEAD-C056C9834B6B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2020 13:32, Christian Hewitt wrote:
> 
>> On 8 Jun 2020, at 12:58 pm, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>>> The current value is taken from Amlogic's 4.9 bsp kernel which appears
>>> to use the wrong ID. For comparison, here's before/after:
>>>
>>> [    0.152237] soc soc0: Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2) Detected
>>> [    0.152463] soc soc0: Amlogic Meson SM1 (S905X3) Revision 2b:c (10:2) Detected
>>
>> For SM1 we have weird values, here are the one we gen on KernelCI:
>> SEI610 (S905D3):
>> Amlogic Meson SM1 (Unknown) Revision 2b:c (50:2)
>>
>> VIM3L (S905D3)
>> Amlogic Meson SM1 (Unknown) Revision 2b:c (4:2)
>>
>> And you report now:
>> Odroid-C4 (S905X4)
>> Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2)
>>
>> And at the time you reported:
>> VIM3L (S905D3)
>> Amlogic Meson SM1 (S905D3) Revision 2b:c (b0:2)
>>
>> So I'm quite lost here….
> 
> In [1] you added the SM1 SoC ID and S905X3 ID { "S905X3", 0x2b, 0x5, 0xf }
> which matches the BSP kernel source.
> 
> In [2] I added a second S905X3 ID { "S905X3", 0x2b, 0xb0, 0xf2 } for VIM3L, but
> this was a mistake (the chip is S905D3) so [3] corrected it to { "S905D3", 0x2b,
> 0xb0, 0xf0 } which matches my VIM3L board. If the VIM3L’s in KernelCI now show
> "2b:c (4:2)” it looks there has been a package change (silicon fixes?) and we
> need to add another S905D3 package ID.
> 
> In the last week I helped three different users install LE on S905X3 Android
> box devices, all of which declare "2b:c (10:2)” as the SoC ID, which matches
> the only S905X3 device I own (Odroid C4). So I assumed the BSP is wrong and
> sent this fix patch.
> 
> If SEI610 is S905X3 (implied by the original SM1 submission from you) KernelCI
> output shows the current ID is wrong (‘Unknown’) so we probably need to fix it
> with { "S905X3", 0x2b, 0x50, 0xf0 } then add new S905D3 (VIM3L) and S905X3 (as
> per this patch) IDs.
> 
> If SEI610 is S905D3 (as stated in this thread) the fix in this patch is still
> correct, but we also need to send a second patch to add two new S905D3 package
> IDs (SEI610 + VIM3L).
> 
> I’ll ping you off-list to discuss.

OK, we have 5 different values :
S905X3	05	0000 0101	(first SEI610 support, early samples)
S905X3	10	0001 0000	(recent S905X3 android boxes, inc Odroid-C4)
S905X3  50	0101 0000	(SEI610 kernelci report, new SEI610 revision)

S905D3  04	0000 0100	(VIM3L in kernelci)
S905D3  b0	1011 0000	(VIM3L)

Seems the early S905X3/S905D3 samples used the low 4 bits to setup the revision.
And the mass-production ones uses the higher 4 bits.

So we can detect all these with the following bits & mask:
	/* Early SM1 Samples */
        { "S905X3", 0x2b, 0x5  0xf5 },
        { "S905D3", 0x2b, 0x4  0xf5 },
	/* Mass production SM1 */
        { "S905X3", 0x2b, 0x10, 0x3f },
        { "S905D3", 0x2b, 0x30  0x3f },

Neil

> 
> Christian
> 
> [1] c9cc9bec36d0 ("soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 ID”)
> [2] 1d7c541b8a5b ("soc: amlogic: meson-gx-socinfo: Add S905X3 ID for VIM3L”)
> [3] fdfc6997bd08 ("soc: amlogic: meson-gx-socinfo: Fix S905D3 ID for VIM3L”)
> 
> 

