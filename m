Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA100C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B799120658
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jX1f32F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGIFWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:22:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39619 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgGIFWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:22:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594272130; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0yQ0v6FztJJmC7OWCTASn/q9sJkJzVa6D1EfGhFboOQ=;
 b=jX1f32F+HP8oDAO0SJ4OIh/0IqG+4och61UJtdxtzPxqeoWrhUW3DGXZuEWbF51nuKC6kD2e
 Qd4pBI8FOjNvQuQl2yxDyHMI40GHQEbpLTEmcX5XrzZ+oO5+rVzrBQ7WWb4K7jIdNYFCcQlI
 LCblg2uz0LG1JUv00IXwJpHeYfg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f06a971c746eb6f00a0d8e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 05:21:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F492C433CB; Thu,  9 Jul 2020 05:21:52 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97895C433CA;
        Thu,  9 Jul 2020 05:21:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Jul 2020 10:51:50 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>
Subject: Re: [PATCH] arm64: Add missing sentinel to erratum_1463225
In-Reply-To: <20200709051345.14544-1-f.fainelli@gmail.com>
References: <20200709051345.14544-1-f.fainelli@gmail.com>
Message-ID: <c922696adf78e8243f6aab8619278170@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 2020-07-09 10:43, Florian Fainelli wrote:
> When the erratum_1463225 array was introduced a sentinel at the end was
> missing thus causing a KASAN: global-out-of-bounds in
> is_affected_midr_range_list on arm64 error.
> 
> Link:
> https://lore.kernel.org/linux-arm-kernel/CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com/
> Fixes: a9e821b89daa ("arm64: Add KRYO4XX gold CPU cores to erratum
> list 1463225 and 1418040")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c 
> b/arch/arm64/kernel/cpu_errata.c
> index 8e302dc093d0..79728bfb5351 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -782,6 +782,7 @@ static const struct midr_range erratum_1463225[] = 
> {
>  	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 1),
>  	/* Kryo4xx Gold (rcpe to rfpf) => (r0p0 to r3p1) */
>  	MIDR_RANGE(MIDR_QCOM_KRYO_4XX_GOLD, 0xc, 0xe, 0xf, 0xf),
> +	{},
>  };
>  #endif

My bad missing this, thanks for the fix.

Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
