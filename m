Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B359AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8351C20825
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPn/z1Lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgGPOBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgGPOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:01:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:01:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so7220460wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cBgidtm3K2UC7bZZD55ufcqNRxLA7lDeHaLH7hy/Zr8=;
        b=BPn/z1Lg4Ha3YThdEhMABfg1GUZMLmrkbn22btW3YQXptrhrx2hxb6Q/uSuFdMTzhm
         pMfcXaPSnKoNCfaJg/0W2zZ5D46xvftkaMQ3RslriCnOiUWvf9G8u9VQaeZN2DCboxPU
         xAGk8J2dVTTdOI2ZEKlmdD79jH9qen6wcLfFGtJDVYCE55JHtrZnCfcfRjSeDlkP/i4O
         Pk7/81psmTfylLNQVbzi/R3250fofHM3xPxtq7Q3K3hxRB3JtaThKcgp7loQWMbSFEUR
         BMspmu4NGwWXSWAglvfwUs5AAnFJDLwYdwjfecHnoin3JHBoUCwFGbFgDj//M2iPjZ8E
         EfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cBgidtm3K2UC7bZZD55ufcqNRxLA7lDeHaLH7hy/Zr8=;
        b=UUxdopukrJddnONKicXuR/H0L6wLUjzwkfa/+/HNHeV8ha5ef4dlN/nkekNx/t4IMw
         hZ3Z0CFRmlpWRLp7zqkmDkzyKdsEB/cPzITlbiNN9HGdLQAU+Lws/IntL2tskkUW/Gcq
         cQBFozD9+P517uBOJ8+9WBTd+zhFpv5X7MKNQXEbm/bkd+xlt+55uZbi1TJC7XCWYmDH
         wNq6uYxYlDlpY0H6sCJMg2wk/nYWzkYxGSUMDrNHCVxCaMjpn3bua6x77UtneNoKi0DP
         TXiMVRPpwSOW6NiDd5n05rGkLIeFJSdfsVk4PUOZ1K2GvfUUIlBX2eupo9vPm5Lrafhb
         y8lw==
X-Gm-Message-State: AOAM532PlAULraMFOleuCzzJylFNFyhI6cssR/3gP3OfjCwrQq5b8NW1
        fJAi9OUeoHhc8AhZz0Xry1+VAg==
X-Google-Smtp-Source: ABdhPJxWuTEqJ0U0mmug3AZEYrGs0qIUBJq6BWHdQAoQMxFMyqmaghCWr1vGT05W3k5rLX9Hq4gauA==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr5240273wro.413.1594908093264;
        Thu, 16 Jul 2020 07:01:33 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id b62sm8730073wmh.38.2020.07.16.07.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 07:01:32 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] dt-bindings: timer: Add CLINT bindings
To:     Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20200715071506.10994-1-anup.patel@wdc.com>
 <20200715071506.10994-5-anup.patel@wdc.com> <20200715175052.GA497000@bogus>
 <CAAhSdy04h-PD-=VhjB=5MOf=-RZMrMOcvEtbtUaDc3-kbV47BA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9c12dd2c-7285-5664-973e-3ec066eec0a2@linaro.org>
Date:   Thu, 16 Jul 2020 16:01:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy04h-PD-=VhjB=5MOf=-RZMrMOcvEtbtUaDc3-kbV47BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Anup,


On 16/07/2020 14:32, Anup Patel wrote:
> On Wed, Jul 15, 2020 at 11:20 PM Rob Herring <robh@kernel.org> wrote:

[ ... ]

> Thanks for these steps. I will fix and send v4.

Please take the opportunity to clarify how you want the series to be merged.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
