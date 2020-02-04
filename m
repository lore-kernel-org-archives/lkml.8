Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506DBC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3245E2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBDRIJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:08:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58057 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBDRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:08:08 -0500
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iz1gF-0004xU-GC
        for linux-kernel@vger.kernel.org; Tue, 04 Feb 2020 17:08:07 +0000
Received: by mail-pj1-f70.google.com with SMTP id c67so2243143pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VK8o/brIxoX1s4YNqEOpFV00pzKNl1VdxAXl7AvMf/M=;
        b=Uac3vF0NHY62EvhU6r0vvOE2eaouKDopVvrDLiuuyaszgRtUKRVcPhGMYBseLCCM+V
         onajrK43zan3KyIuJTy56Sf5uYVS16vyckmdkZL/rbCDRYwZpPRGSxQD/rwnni1I8Ot1
         eGoblATv83Drj+BNE1Oj7Q7paOCE7JbQwfHUNL5DFC8zpbTT5moucC4myxSpu+Vpyqj3
         Izvd/eZtIV0fq8VyaHGc4KWZET9fMuyUeklL64JhPLu0KeQVvWQywx+dko5ccnUYhCVI
         FPCRqiyVcpK2eaZSXkzXGR1gnDwTfrgTjgQMxYpORsbRS/KKiE2zLZw9y9MXheIFqS3p
         4Zaw==
X-Gm-Message-State: APjAAAXB3bBsu69aA8hUSqT5bliKzbmkOVN7gtXSmtQ4Kstb87ez3HA1
        43pD/4MBr4qO43AroKqB3F5Wgj9oT8n2XJ7xcqyD74KeqrPr3aKlAQ0JLQ1sB8ZFcKJk/MTIWgD
        wNkyx8GWcn20Rs5vXDHP6u6K4wb3DsViBiDtjDPSlXg==
X-Received: by 2002:a65:620d:: with SMTP id d13mr33097683pgv.252.1580836085680;
        Tue, 04 Feb 2020 09:08:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyu4JftCXZjXWe/rkUQ0qIvUvwOzDjWRnR5K/gUoHhVSTeuzXeDQPVaHG+xKV0lD+6RnwKmQ==
X-Received: by 2002:a65:620d:: with SMTP id d13mr33097648pgv.252.1580836085315;
        Tue, 04 Feb 2020 09:08:05 -0800 (PST)
Received: from 2001-b011-380f-35a3-4cfd-361b-ac7d-6a8c.dynamic-ip6.hinet.net (2001-b011-380f-35a3-4cfd-361b-ac7d-6a8c.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:4cfd:361b:ac7d:6a8c])
        by smtp.gmail.com with ESMTPSA id z5sm26260221pfq.3.2020.02.04.09.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 09:08:04 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] PCI: Avoid ASMedia XHCI USB PME# from D0 defect
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191219192006.16270-1-kai.heng.feng@canonical.com>
Date:   Wed, 5 Feb 2020 01:08:00 +0800
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DECD6DEE-E67C-43BA-8510-067ADBFBD50E@canonical.com>
References: <20191219192006.16270-1-kai.heng.feng@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> On Dec 20, 2019, at 03:20, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> The ASMedia USB XHCI Controller claims to support generating PME# while
> in D0:
> 
> 01:00.0 USB controller: ASMedia Technology Inc. Device 2142 (prog-if 30 [XHCI])
>        Subsystem: SUNIX Co., Ltd. Device 312b
>        Capabilities: [78] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> 
> However PME# only gets asserted when plugging USB 2.0 or USB 1.1
> devices, but not for USB 3.0 devices.
> 
> So remove PCI_PM_CAP_PME_D0 to avoid using PME under D0.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205919
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Would it be possible to merge this patch? Thanks.

Kai-Heng

> ---
> drivers/pci/quirks.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 79379b4c9d7a..24c71555dc77 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5436,3 +5436,14 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> 			      PCI_CLASS_DISPLAY_VGA, 8,
> 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +/*
> + * Device [1b21:2142]
> + * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.
> + */
> +static void pci_fixup_no_d0_pme(struct pci_dev *dev)
> +{
> +	pci_info(dev, "PME# does not work under D0, disabling it\n");
> +	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
> -- 
> 2.17.1
> 

