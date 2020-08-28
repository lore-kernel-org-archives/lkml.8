Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E20EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138712075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4v5ZWL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgH1NvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:51:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55801 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgH1NvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598622660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ga3HPD6MlVFWOFTRVhh6xn4tiwLcCumeV7jIodJt54E=;
        b=g4v5ZWL7TD87BBVvg7ubqEJMiv9BA1XPffv1LacoXCfPnbf6rrSmkGpGRFXsFtVNy/A/xY
        ywOr4NOiCES+nEXb5td11oAOCT5cP9Oqil1hWPcbz3jqzkf/LJFUdkpqDY2PE18L2C8gwR
        oYN0m9/fCwXFEh9iY5oZuCQr4Zj1i9g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-3uviva7sNLymgXLuzFgiqg-1; Fri, 28 Aug 2020 09:50:58 -0400
X-MC-Unique: 3uviva7sNLymgXLuzFgiqg-1
Received: by mail-qt1-f197.google.com with SMTP id b18so740361qte.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ga3HPD6MlVFWOFTRVhh6xn4tiwLcCumeV7jIodJt54E=;
        b=R6O/QZL3FxZo5u2tsrJUFNYpPDIReDRPAThrvG/YLF/eddqRkw0uevdNQ0AZT1BkfD
         ATqbfOLfkSNAE1+Y/L6OTMBZ9iYX/KYeolFUbTTQIy+OyvHdgzUiLduw9R04tlZUiyOA
         18OyVMqsG4RQHCihL7xoKPl2cYmVhwxZAwenIg0MQ3zIqFZbQJTGhZkiNgNFC0lt09rX
         3tmHNBQICI+NYVn1cq1LAt28QJVwmHRUG05K0sgqVgHHDMDlaG5uV3dcXHmDh94obDbL
         LPp4DV5q0CWSIy7oPTm747bhPgjjqm/U6tViS6sCTn8bd85YbAYouv1ABem6YwhYXRAS
         d5Yg==
X-Gm-Message-State: AOAM531bOPXIWx/otDc3n6BBVqTab+Fxl84/AaAClbaBNPqv50EY7Kyl
        DqIshVckqokhibXgS0PUbzGsg4qzjq+7Z5tgfuN/WJcQuTxTCi8zvxigNxssoL28/L+o/v566/U
        H0KZ7EY8bqZRUzhMbYbyu5LaZ
X-Received: by 2002:ac8:22ea:: with SMTP id g39mr1647027qta.146.1598622658225;
        Fri, 28 Aug 2020 06:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCn9gF2PqXG5UIyZOdn+fnMC1KKINLVSEOWhwrulYJZBKJAo7WdtKKn6XP6DG/yfyr0vtMiw==
X-Received: by 2002:ac8:22ea:: with SMTP id g39mr1646999qta.146.1598622657814;
        Fri, 28 Aug 2020 06:50:57 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v28sm1094107qtk.28.2020.08.28.06.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 06:50:57 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support for
 Intel FPGA PAC
To:     Lee Jones <lee.jones@linaro.org>, Xu Yilun <yilun.xu@intel.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
 <20200828100236.GF1826686@dell>
From:   Tom Rix <trix@redhat.com>
Message-ID: <de14ce03-2d42-74d1-3801-2dd2b09a448e@redhat.com>
Date:   Fri, 28 Aug 2020 06:50:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200828100236.GF1826686@dell>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +
>> +static int check_m10bmc_version(struct intel_m10bmc *m10bmc)
>> +{
>> +	unsigned int v;
>> +
>> +	if (m10bmc_raw_read(m10bmc, M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
>> +			    &v))
>> +		return -ENODEV;
> Please break functions out of if statements.
>
> Does m10bmc_raw_read() return 0 on success?
>
> Seems odd for a read function.
>
>> +	if (v != 0xffffffff) {
>> +		dev_err(m10bmc->dev, "bad version M10BMC detected\n");
>> +		return -ENODEV;
>> +	}
> The only acceptable version is -1?

I ran into this in testing.  This is a check if the board is using a very old legacy bmc version. The M10BMC_LEGACY_SYS_BASE is the offset to this old block of mmio regs.  On the old boards, v would have not been f's, on the current boards it is f's. The check is necessary because future calls use the M10BMC_SYS_BASE offset which was not valid on the old boards.

Tom

