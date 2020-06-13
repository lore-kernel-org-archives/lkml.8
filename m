Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F23C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E5F207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWo3LR9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFMNtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:49:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD2C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:49:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so5672300pfg.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=L7g8naTnxszWRQuAzpiNffO3FSZZpQddLb2rinFpYx4=;
        b=wWo3LR9e8M2W/hC+feEbflle68gR2qDsYFrdPYrOmJLriMm2KoppPgHzQhypHT6vah
         79BbJmlRDZEyMT0m/gznLb7kouUAKDh1M4pXLJCev7BAA/4g5sSnTmQWdPDxNiq3+cL2
         /Js3n7BY0zb8cfKRJ0o4rOJkLAjCd8rFeRE8dd02UL0s2VxsBYIJasPLfWrcg5/uujRH
         hMtxXWuHdru+zwaI8/LD2W+wvG/LMu/rK40FFqkuD6mYiZt3st7rKatRxKjZhWrsKojC
         fthUafzmoTMw55kDznVJ2VhLaiBO2bIvYR404Ou7ebgnh8yXpWhfjrIe5TSXqChRxI33
         WeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L7g8naTnxszWRQuAzpiNffO3FSZZpQddLb2rinFpYx4=;
        b=ufl+uIrDcE6S/z/rFbEYacmlWjwSm8EtAh5mxM/5MVkcvDQdvllMB6HYyeAHPeNThB
         gpG+1oGigHqoovGXTYLSsm4cmlxK/hHN20rwyqlmcVmJd1stf0bEnTZsfMI1TpictHq1
         RKL/VyUojarycmFrFiGcTF/N7Xnit8+9/aHVYFGXZ5CC8jWuvlRgDoy3g9BLwwOiFZqe
         47T+Wsh3II6Cjb4Gxk+4I3RDPmKatDhhZ0SbhjzvCob7W943DY2JjuzZsSXCmSmncRQt
         lCagxaIqbaQ/MupmlZz2nwXy0BAEcVwSvGebBTQrGJzrTAjBV8y8lCPH6y7bWKiUCp6w
         sDkw==
X-Gm-Message-State: AOAM533E3/d/XU+gjTHyiZzwEx1J8IeEKJinubOV97PvIYsCDO7o/pHT
        br9hkTFPqXVx43HpNvkJ8u0z7w==
X-Google-Smtp-Source: ABdhPJy1e+sUnbMI01OT7N/zMiAHavpzUEkLgxhZvIxLCaH+AxVJLzGJdr/oYqDUf2eF2C7DlnWeQA==
X-Received: by 2002:a62:fc86:: with SMTP id e128mr16753896pfh.133.1592056188970;
        Sat, 13 Jun 2020 06:49:48 -0700 (PDT)
Received: from [10.175.1.142] ([45.135.186.20])
        by smtp.gmail.com with ESMTPSA id u25sm8947525pfm.115.2020.06.13.06.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 06:49:48 -0700 (PDT)
Subject: Re: [RFC PATCH] PCI: Remove End-End TLP as PASID dependency
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@kernel.org>
References: <20200611174140.GA1597601@bjorn-Precision-5520>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <c981ed09-5fe2-b0ca-b023-ba7e8882832a@linaro.org>
Date:   Sat, 13 Jun 2020 21:49:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611174140.GA1597601@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/6/12 上午1:41, Bjorn Helgaas wrote:
> [+cc Sinan]
>
> On Wed, Jun 10, 2020 at 12:18:14PM +0800, Zhangfei Gao wrote:
>> Some platform devices appear as PCI and have PCI cfg space,
>> but are actually on the AMBA bus.
>> They can support PASID via smmu stall feature, but does not
>> support tlp since they are not real pci devices.
>> So remove tlp as a PASID dependency.
> When you iterate on this, pay attention to things like:
>
>    - Wrap paragraphs to 75 columns or so, so they fill the whole line
>      but don't overflow when "git show" adds 4 spaces.
>
>    - Leave a blank line between paragraphs.
>
>    - Capitalize consistently: "SMMU", "PCI", "TLP".
>
>    - Provide references to relevant spec sections, e.g., for the SMMU
>      stall feature.
OK, Thanks Bjorn
>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/pci/ats.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index 390e92f..8e31278 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -344,9 +344,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>>   	if (WARN_ON(pdev->pasid_enabled))
>>   		return -EBUSY;
>>   
>> -	if (!pdev->eetlp_prefix_path)
>> -		return -EINVAL;
> No.  This would mean we might enable PASID on actual PCIe devices when
> it is not safe to do so, as Jean-Philippe pointed out.
>
> You cannot break actual PCIe devices just to make your non-PCIe device
> work.
>
> These devices do not support PASID as defined in the PCIe spec.  They
> might support something *like* PASID, and you might be able to make
> parts of the PCI core work with them, but you're going to have to deal
> with the parts that don't follow the PCIe spec on your own.  That
> might be quirks, it might be some sort of AMBA adaptation shim, I
> don't know.  But it's not the responsibility of the PCI core to adapt
> to them.
Understand now.
Will continue use quirk for this.

Thanks
