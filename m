Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA09C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84C020873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgCKGzV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:55:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45747 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgCKGzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:55:21 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jBvGx-0003EL-7E
        for linux-kernel@vger.kernel.org; Wed, 11 Mar 2020 06:55:19 +0000
Received: by mail-pf1-f197.google.com with SMTP id i127so730809pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 23:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TqUEG7fdNypZyQa4Z4aTdLCel+ygQEgWl23w1+5Jc8Y=;
        b=e0dJnx5U6I/xPYY2N3bnoRGNCILbEzJSNNdU3tKPefObKQl7rVLyBeXkxIpLmorJxd
         1QOLQFUMHzfzeTHC3MkoMNcFT44mqtmHt9jj1hmMRaHzhvWqPMvuqhX14ovMw4iwvVlp
         yQmBm9NFyF3o0NLt8PThtyhXqec0vlq7gBWPr2cEuaXnWLTx/LkpCLVoQ5R0/jrasTa+
         PDODI7to4dB7ovx7HYPD56ATHdKqiFU6H8+xcnd9JDBdLNX7zf5rmg2hr3e2KmR3lZ0i
         zguQVxSQJLyT7pyQXmHKP9BWKjTAw0n5A3Y0wgJvaoh2OPcPq0wI2kZwP95F2V4F9dHg
         QRNw==
X-Gm-Message-State: ANhLgQ2S40GD0u6wHnqkxwxWcRbl2RsWwHcN11OwE+1APUEJygDJkfjO
        Dk+fcDqrz9YXsyNsSsXxodT0UljLWg3xyhl6g1IWl8sTpPxsJVjTcOBPWNCiRXhpJ+Uf1vOhHL2
        1pNnZp7YNijuzW0b/fgoOLETT0yRq6zZU4lbb50TuWA==
X-Received: by 2002:a63:348b:: with SMTP id b133mr1510077pga.372.1583909717830;
        Tue, 10 Mar 2020 23:55:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vty78W1f31egS8IeOLoNRAJxRmqtTY6SpHtLBKi35Vn3Gd3pe918ukidBqvv9DkCAgrIYbSqw==
X-Received: by 2002:a63:348b:: with SMTP id b133mr1510058pga.372.1583909717464;
        Tue, 10 Mar 2020 23:55:17 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b70sm10103801pfb.6.2020.03.10.23.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 23:55:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] PCI: Avoid ASMedia XHCI USB PME# from D0 defect
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <DECD6DEE-E67C-43BA-8510-067ADBFBD50E@canonical.com>
Date:   Wed, 11 Mar 2020 14:55:12 +0800
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <013D12C5-676A-48DE-84DE-E448581CC640@canonical.com>
References: <20191219192006.16270-1-kai.heng.feng@canonical.com>
 <DECD6DEE-E67C-43BA-8510-067ADBFBD50E@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 5, 2020, at 01:08, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Hi Bjorn,
> 
>> On Dec 20, 2019, at 03:20, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> The ASMedia USB XHCI Controller claims to support generating PME# while
>> in D0:
>> 
>> 01:00.0 USB controller: ASMedia Technology Inc. Device 2142 (prog-if 30 [XHCI])
>>       Subsystem: SUNIX Co., Ltd. Device 312b
>>       Capabilities: [78] Power Management version 3
>>               Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
>>               Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>> 
>> However PME# only gets asserted when plugging USB 2.0 or USB 1.1
>> devices, but not for USB 3.0 devices.
>> 
>> So remove PCI_PM_CAP_PME_D0 to avoid using PME under D0.
>> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205919
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Would it be possible to merge this patch? Thanks.

Another gentle ping...

> 
> Kai-Heng
> 
>> ---
>> drivers/pci/quirks.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 79379b4c9d7a..24c71555dc77 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5436,3 +5436,14 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>> 			      PCI_CLASS_DISPLAY_VGA, 8,
>> 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
>> +
>> +/*
>> + * Device [1b21:2142]
>> + * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.
>> + */
>> +static void pci_fixup_no_d0_pme(struct pci_dev *dev)
>> +{
>> +	pci_info(dev, "PME# does not work under D0, disabling it\n");
>> +	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
>> -- 
>> 2.17.1
>> 
> 

