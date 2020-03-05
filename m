Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7EAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4944B20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEcRzx34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCERzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:55:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39198 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgCERzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:55:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id j1so6702433wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHBpesZTfJ6mKcWi00bWDILKSsEsVfAhb2bNBmir3Uk=;
        b=yEcRzx34oEY0MIxdeSv4UP8BF0gJMpDCn6WZD+fCY7zu+uqg0wYs1LopL9OtaE2xhz
         Urgl67efLMFYrfCAMDfkHf5Fd9k8bk4XPp7dd6EnEuy6h75rlhUxOARvwB8UhIlSnDd6
         HjzO/rYByVTO2Rqg5uVOFxl7aOcXIaiRgD5WOTnLDR6+anjX7odFjnkMLEfqGsS0+Th+
         ON55fMYa1Zs/QprDipf7F2lqOGCzjhGNoPAoEFWV3f6yzbBrZiYTFOb7IRxweflMITla
         qsUR41WBs257WRFRdkSaOsmM1eobhstWjSe7o25oPZW/hr0Cr+/YlZjAnRwUZlYWx5Pe
         0gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHBpesZTfJ6mKcWi00bWDILKSsEsVfAhb2bNBmir3Uk=;
        b=ugmUOdKRI+g83bVszTKz6WKh/zrsLkPJTxiC+orA3T3PvQqhut7qbhiu3v0XH58Qu9
         m5dkkZrn9+ADuSApHPAXWXZI22oyWXive2alG64tLokUHjbpriv5Y2BSj0o5vVXunwBh
         DfdEFYvBG9EtOMiKLn1LnfNMjUv2Uk0htrJE++fHzIGrSoWLdsV99Nn1NuLNtIiy9kNq
         lu12OekkQVto2LVuVuQY7Bit1mnvaXpB3+w5kqw6bxkAeBT4qWZt8D0enre9A/+vwfH+
         gwMuHk7VBvIrslEKMBB4oQhawPPf8TVBBtvfapURsgt+j+C/ZwlTwrLCAK9BxrvltZuk
         A8YA==
X-Gm-Message-State: ANhLgQ3m+7+SE3z0HfsY6fWPql9eEDXOsXqB45uHZ4g4W0q1Hu0QOhY0
        me/ll+nDQ4k8vEUa6hoYrxFbfg==
X-Google-Smtp-Source: ADFU+vtp3ZeU9yc0Pk2bmRUnySPmTNZKNaB3BjkVR8s8SVb8uArIqVRmBUEcxJLKksj0YY16FGcMFg==
X-Received: by 2002:a05:600c:48c:: with SMTP id d12mr8889884wme.183.1583430914521;
        Thu, 05 Mar 2020 09:55:14 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q4sm719751wro.56.2020.03.05.09.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:55:13 -0800 (PST)
Subject: Re: [PATCH v8 4/7] Documentation: ABI: nvmem: add documentation for
 JZ4780 efuse ABI
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
References: <cover.1582905653.git.hns@goldelico.com>
 <08f3bb4e0fe5499907c4e07fa6751bfb2016f23d.1582905653.git.hns@goldelico.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b7c8567b-5d51-1646-6d0d-8f034839460a@linaro.org>
Date:   Thu, 5 Mar 2020 17:55:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <08f3bb4e0fe5499907c4e07fa6751bfb2016f23d.1582905653.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/2020 16:00, H. Nikolaus Schaller wrote:
> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> 
> This patch brings support for the JZ4780 efuse. Currently it only exposes
> a read only access to the entire 8K bits efuse memory.
> 
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   .../ABI/testing/sysfs-driver-jz4780-efuse        | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Applied thanks,
--srini
