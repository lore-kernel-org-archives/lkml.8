Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A0CC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5220C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndBAShkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIFT4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIFT4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:56:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190FC061573;
        Sun,  6 Sep 2020 12:56:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j7so670843plk.11;
        Sun, 06 Sep 2020 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1IXttThf4jyHpYSWfgTpKyb7p67P6B6pcEltUS/FQSw=;
        b=ndBAShkgtmaR2l9T41FfLSCmxUBwDA5Bzi8ffM8TmGdSRjotboIlsWYvt2jqcIq3nW
         WsOpk8vfVtQXuu3464m3LNfvPHk0WwTdBcxguc4KabSRpSKS7cwtmsnUphP0pmU0hm0j
         niMqpdh73W51ys/oGjcnCuN4hU8veqIA0DP5oix5bm4jvEbokSfoObGNEE9R4woYGJ5w
         1tgnGYBeVnGWDS+jfeQXkxNcXMzxBIxi2SfMXHq+NRr582XbVjYXBnrjp0MpgkpL0a2j
         0QyjDZAPb8waTvPrrGgQPRxhP+41MGUI0r+kXVxOXN9NpY/YA4kolpZxwBmLMApEkRZZ
         dREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1IXttThf4jyHpYSWfgTpKyb7p67P6B6pcEltUS/FQSw=;
        b=NjPH0IEz17BQVNzgDeELCyOz8cqsz+QuljzoQjjIi6wWSzrZ91sFyxrlnrUzbdveXZ
         /Xc1iKQIlcz+IHR6sUUXdRDNpH4es/2ZwidA/VquKGZp3vIFsN5vfW9VDIAkii0rURGQ
         CaB7Mcsx9dXB7a8rFIWgccvgSZhIgXDUikXtaVi3KEaVV58T9iaaQr9xwzPrDgcH2fGt
         3Od1V1BXvrYpPpAsPW1/utcDW0L2ZTLQibZ6jopLfEJURJYOXR8hJgJ4VX2M0NpF9zox
         nm0zPdLtBWqB2tQ3GIZjw2CVto4wwFN+8kKNWD1SJfdsHR+8ZBE9bxHoM6dv1dsFKVbi
         D7Lg==
X-Gm-Message-State: AOAM533sIFBhuZcIaxFu97aHs4HSbxn+BQnj4hGlsso5D9riwOGMb3vR
        XqVvZbqPo/UJQ6txfpLSNLw=
X-Google-Smtp-Source: ABdhPJycC1t0Ejn5FeHP5HT9zklQHsEf7BcHDQ8yq8+00RuJH+GXazfojGRIxUWnvrKWq8QuAu4SMQ==
X-Received: by 2002:a17:90a:e2cc:: with SMTP id fr12mr17564131pjb.125.1599422161888;
        Sun, 06 Sep 2020 12:56:01 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o30sm11023817pgc.45.2020.09.06.12.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 12:56:01 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add entry for Broadcom BDC driver
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        swboyd@chromium.org, chunfeng.yun@mediatek.com,
        linux-arm-kernel@lists.infradead.org, alcooperx@gmail.com
References: <20200710034806.15650-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <830cd104-87de-4246-35ff-47a0ed5b05a9@gmail.com>
Date:   Sun, 6 Sep 2020 12:55:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200710034806.15650-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2020 8:48 PM, Florian Fainelli wrote:
> The Broadcom BDC driver did not have a MAINTAINERS entry which made it
> escape review from Al and myself, add an entry so the relevant mailing
> lists and people are copied.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

This patch still does not seem to have been picked up (not seeing it in 
linux-next), can this be applied so we have an accurate maintainer 
information for this driver?

Thanks

> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d4aa7f942de..360d001b81b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3434,6 +3434,14 @@ F:	drivers/bus/brcmstb_gisb.c
>   F:	drivers/pci/controller/pcie-brcmstb.c
>   N:	brcmstb
>   
> +BROADCOM BDC DRIVER
> +M:	Al Cooper <alcooperx@gmail.com>
> +L:	linux-usb@vger.kernel.org
> +L:	bcm-kernel-feedback-list@broadcom.com
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/usb/brcm,bdc.txt
> +F:	drivers/usb/gadget/udc/bdc/
> +
>   BROADCOM BMIPS CPUFREQ DRIVER
>   M:	Markus Mayer <mmayer@broadcom.com>
>   M:	bcm-kernel-feedback-list@broadcom.com
> 

-- 
Florian
