Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A4C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A83420842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGSmQqRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgAJHDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:03:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39820 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgAJHDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:03:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so671370pfs.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 23:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=524ZzQ+ni88Rws2LlNdcnlFyEqdyrbvKeKi49yA8YY4=;
        b=NGSmQqRU5+ICclxQRqDent1NDnfEm2OIeeFdX0tw/ZmF5Ynj0sVDkrXYgo859Seh0M
         J0l0h0MbScEDs2sJRmYMl/Q2HJ9vAiX6odyo6YxZy9mw/XioiCJwEKZ+I1Zo30NGV+ia
         ziky5DZJR/qtVDQrwkd8pjID8fi+W+813nC/nUw8w3rYyGArUeP/iw1vslz/rh0whBTv
         9YIXRZhMWidQzylg7ngeozNKcbUj3M0hEuYMICamx+mNMsw8N5QhTqrpS4gEVk8nz+xx
         PfRK9qHUjXd+VzpCcn5R5QxZgBsCKm7vqH7aWgLY8rvlvHSfalm+nWpsY1TfA2IKaUXg
         yYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=524ZzQ+ni88Rws2LlNdcnlFyEqdyrbvKeKi49yA8YY4=;
        b=KTpp03K+ZwZuK2+9+jvJd9IDIbQmfash30gkV2CaD4RMKu1JzMfzoyaqjWdGoCwG1N
         odMil3V45Ei0ewCCSAvS/sM3Xfq2HZoBWEbrInQNtZZze0ZmBbVru777isQn8b9/JqZi
         WKfZQr5MpjQCLiSqd5Gs4nPa71gbrs8QmcJWFVP0spNDsls9a5y3W69YyBjnnfV+gjfH
         eAp/MerE8lr2+ft3K5He1XzF9jEjAfJTLbWjFRS4LVXgnFHUgumOZog1j8AKM+lQAN6g
         dwefxK0yGDLYa116MNrxAwmboluznaTewjIVZJy87hwnxVaKnBysUY0ytZMTOIK6w3Ej
         k1XQ==
X-Gm-Message-State: APjAAAUO9NWWzRTnvuWrOP2sTmkRhnr1RIrgoPW/8RYvjjT36zKCG/Wz
        ZS/FT80SG3LT0tYYN43/9XXcZA==
X-Google-Smtp-Source: APXvYqxRXSHQMAAqNEXryi+da46roEIsUSSy9JeYNiaSYgUd7HGxHp5FztsZ6Vvs+qp/1RXmy6fNQg==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr2378854pfb.118.1578639818515;
        Thu, 09 Jan 2020 23:03:38 -0800 (PST)
Received: from [10.151.2.174] ([45.135.186.75])
        by smtp.gmail.com with ESMTPSA id a26sm1382558pfo.27.2020.01.09.23.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 23:03:37 -0800 (PST)
Subject: Re: [PATCH v10 0/4] Add uacce module for Accelerator
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, Dave Jiang <dave.jiang@intel.com>
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
 <20200109174952.000051e1@Huawei.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <9b87edca-dd4e-3fe2-5acd-11f7381593ed@linaro.org>
Date:   Fri, 10 Jan 2020 15:03:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109174952.000051e1@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/10 上午1:49, Jonathan Cameron wrote:
> On Mon, 16 Dec 2019 11:08:13 +0800
> Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
>> Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
>> provide Shared Virtual Addressing (SVA) between accelerators and processes.
>> So accelerator can access any data structure of the main cpu.
>> This differs from the data sharing between cpu and io device, which share
>> data content rather than address.
>> Because of unified address, hardware and user space of process can share
>> the same virtual address in the communication.
>>
>> Uacce is intended to be used with Jean Philippe Brucker's SVA
>> patchset[1], which enables IO side page fault and PASID support.
>> We have keep verifying with Jean's sva patchset [2]
>> We also keep verifying with Eric's SMMUv3 Nested Stage patches [3]
> Hi Zhangfei Gao,
>
> Just to check my understanding...
>
> This patch set is not dependent on either 2 or 3?
>
> To use it on our hardware, we need 2, but the interfaces used are already
> upstream, so this could move forwards in parallel.
>
>
Yes,
patch 1, 2 is for uacce.
patch 3, 4 is an example using uacce, which happen to be crypto.

Thanks
