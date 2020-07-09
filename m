Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529DDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3892073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5xs2zQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGINAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:00:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbgGINAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594299646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSXgeEhLv5Tj53wSYbt5UYfNvPxCwCEac8F+A/0zihk=;
        b=c5xs2zQJHCgFo8YFbAHL1BAz9yfOBag3AhJR8Ds7B9IjgPVbmnwu0ESmzYgKbbM68d9zUE
        elSysEorkQWxeAXxUemkhzr5YCvAUgb8UznEugVHrpvTbbdVDu0iNHRnqmFr0zoElr7nYj
        eMYTYUE3JdDvEsI7pz+OdZcRnYq14fM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-0MF8MjOYNpyVazSs99AWNA-1; Thu, 09 Jul 2020 09:00:44 -0400
X-MC-Unique: 0MF8MjOYNpyVazSs99AWNA-1
Received: by mail-qv1-f72.google.com with SMTP id m18so1294472qvt.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YSXgeEhLv5Tj53wSYbt5UYfNvPxCwCEac8F+A/0zihk=;
        b=Mgo8OGyAlF9w5SUW9KeilZLKU1Zslz73ACfxMtWJPEV092lM4UmDfjlSXvP9V7IZdc
         gQx+yjLGCtmnP3jjL5bkpWEDicGLUUvEks0B+7jh7uocIE7CgXfRAOQHWbgGRxhZHT+T
         cc1K6yRlF/g6s5k70BzOr7OZBlTB/6ecXL7w7L71k6u42BRxLCm1pcC8L/SDFFq+ungm
         zzO2oEW8r7lF/iIdJZPlMOPbjELQpT6ogRh7m0e0jOxnlD1jZO3ntX92E1LwrJFKXmUi
         0ygmk+lbjiFp1n+/CJTHplnPWjfMggEpODiotdgHRItQAYE84jGo07qduLkZyYzaFVOP
         3UXg==
X-Gm-Message-State: AOAM533p6JozRQd0WzXW+WU5dq3N4YOZxMSTMSixzGeVPOHeBMGm/F9n
        mDuoeQOCkZqZTMbiac4j9nMBy3Wjo0E56IVRxHZod5WHWa+Hq0smpnf11XvSbuYVzTaeHA+opbI
        ooOMZtE/Bq9jk6/GuYu2fT/LW
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr63937046qkw.20.1594299643822;
        Thu, 09 Jul 2020 06:00:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmIIe/1yIwX7BG5ThjTMW2ZaJ1OANij7ZtdWK/gj/VJQ69fGc/AlUQ8twBBUU4xG8b7PG2Mg==
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr63937011qkw.20.1594299643609;
        Thu, 09 Jul 2020 06:00:43 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t57sm3684437qtc.91.2020.07.09.06.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:00:42 -0700 (PDT)
Subject: Re: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200709093527.GA32541@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819D07348C347B5BB8F86C085640@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2d7919d5-a320-58f4-5c9d-7ef868ad8676@redhat.com>
Date:   Thu, 9 Jul 2020 06:00:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819D07348C347B5BB8F86C085640@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/20 3:14 AM, Wu, Hao wrote:
>> On Thu, Jul 09, 2020 at 05:10:49PM +0800, Wu, Hao wrote:
>>>> Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
>>>>
>>>> Add PCIe Device ID for Intel FPGA PAC N3000.
>>>>
>>>> Signed-off-by: Wu Hao <hao.wu@intel.com>
>>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> ---
>>>>  drivers/fpga/dfl-pci.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>>>> index 73b5153..824aecf 100644
>>>> --- a/drivers/fpga/dfl-pci.c
>>>> +++ b/drivers/fpga/dfl-pci.c
>>>> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>>>>  #define PCIE_DEVICE_ID_PF_INT_5_X0xBCBD
>>>>  #define PCIE_DEVICE_ID_PF_INT_6_X0xBCC0
>>>>  #define PCIE_DEVICE_ID_PF_DSC_1_X0x09C4
>>>> +#define PCIE_DEVICE_ID_PF_PAC_N3000 0x0B30
>>> Should we drop _PF_ here? and also do you want _INTEL_ here?
>> I think we could keep _PF_, also there is no need to support VF of pac
>> n3000 in product now, but it does exist (ID: 0x0b31).

I was wondering about the vf id, thanks!

>>
>> And add _INTEL_ is good to me.
>>
>> Then how about this one:
>>   #define PCIE_DEVICE_ID_PF_INTEL_PAC_N3000	0x0B30
> I am just considering the alignment with ids defined in include/linux/pci_ids.h
> So drop _PF_ before _INTEL_ would be better? : )

To be consistent, all the id's are intel and all could drop pf.

Tom

>
> Thanks
> Hao
>

