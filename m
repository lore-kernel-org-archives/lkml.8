Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C20C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92764206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgBKJuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:50:20 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:39003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgBKJuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:50:20 -0500
Received: from [192.168.178.45] ([109.104.50.251]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhUDj-1jetne2AAF-00eh1y; Tue, 11 Feb 2020 10:49:53 +0100
Subject: Re: [PATCH] usb: xhci: Enable LPM for VIA LABS VL805
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200120142422.3907-1-nsaenzjulienne@suse.de>
 <20200210185921.GA1058087@kroah.com>
 <1478f170-f0ec-96df-79cf-f7c44bebc290@linux.intel.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <19e1d141-2033-782f-e5a3-dcba6bdc0a8a@i2se.com>
Date:   Tue, 11 Feb 2020 10:49:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1478f170-f0ec-96df-79cf-f7c44bebc290@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:vFNXZBCZU7VbCH3VCVaG6cEIdOYsjm5lxPWe5ExHl9RFzxLd0EH
 hiihmd+vybwokNlPF11GZzswTL6jZo8A2sIz1QCS/Nd21A0h3YRm9GiN+Loyv8FWDd3nn9c
 asppO8H75BuwYsyLH36u0DTC8ZFAUQND6NIyaHS4QfuvJsOOWkbu+jVUMGjsgo3ebnb0baH
 Hn6WPfvDYMsGic6akve9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6KhvdXrvbRE=:fuOzy7NeVahmzRZT33W+Mo
 HuPkJEzfBuFUkJYKA0oWpIUe7LU9EXijU7/UTHFiqhjzJgA73HGg7v2UW++fuvuBCnGItPfN2
 MGjKOCq+WWI7QwNvJn53F/F0MPKU1nMSoNhKIBkRZ8uMOVPYXbDh0LJ95KrrVeaVE6bxpQkEd
 hCuTk61Cc/5B4mWchwn8oxAkJ8RKgDV6g0e+XcZ+DBEnJDsHWEjRBF6Eca8s5i8XrN2M5B/6P
 aS6fPwlV6+gia2Kj4rX4yPuW9dmn04w4O9h1Vh3xVsc4e4oVTwdY53NciHNfuV5A9Mm9TyK2k
 T4Jic4ujObzvZXjNNls5lWaHwrFMyif89JSTZhvuwxRgoFxvYJRNZAFhtVvkBGihIyhKRKGlq
 /Wqv3UlLKN2lizViYYyGSwCXPrKnpDG/hWwVDhpl6cnQqM06AXjaoNCAaoew6ddTDSN8kXnOG
 Ss1N+UIx6LzTf4A5ruddyrFEgsey26z6i+J5MvVMwO33zChm/F8D/LSm8Y0eVbgRFj6tEJrOq
 iVE6GfW47OzkhuDI1a9G7LDI79YlCjpFGAy3wfUI3WOCv0EwoYEo6EjNr41cB8dVdZ4CxY1wr
 Lk+Y6xDKy8QOfgP7feoFEbt2sd8d+EqKIMC9IkHaXwHFMiRmhU7skY1a/5lFmsA5gkVogpHrv
 b6jKlBlSp7yomgmyQpv/v+gaX4WZEGjyU0ASFoHuGbDE5Gz2Ah8Grb1+ej1UONRKL7NLAWlTC
 H/YZNNMRUmVFOa+AJR1zWfWLvKg9bnaaNpP81tkZ+5ToiUN2iOlgo1sZ1g3m+KUwmo14PsB9M
 Ob+qPQKBJoP/A7yMsRkHHgQ3M4sRmQ8pWw3pSeaEtecT9XPWTZgpIoOf8iAewQh+DX3SGF7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 11.02.20 10:34, Mathias Nyman wrote:
> On 10.2.2020 20.59, Greg Kroah-Hartman wrote:
>> On Mon, Jan 20, 2020 at 03:24:22PM +0100, Nicolas Saenz Julienne wrote:
>>> This PCIe controller chip is used on the Raspberry Pi 4 and multiple
>>> adapter cards. There is no publicly available documentation for the
>>> chip, yet both the downstream RPi4 kernel and the controller cards
>>> support/advertise LPM support.
>>>
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>> ---
>>>  drivers/usb/host/xhci-pci.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>> index 4917c5b033fa..c1976e98992b 100644
>>> --- a/drivers/usb/host/xhci-pci.c
>>> +++ b/drivers/usb/host/xhci-pci.c
>>> @@ -241,6 +241,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>>  			pdev->device == 0x3432)
>>>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>>>  
>>> +	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
>>> +		xhci->quirks |= XHCI_LPM_SUPPORT;
>>> +
>>>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>>>  			pdev->device == 0x1042)
>>>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>> Mathias, is this in your review queue?
>>
> Ah yes, before adding link power management support for this controller we
> should check that it has sane (or any) exit latency values set in its
> HCSPARAMS3 capability register.
>
> Nicolas, if you have this controller could you show the capability registers:
>
> cat /sys/kernel/debug/usb/xhci/*/reg-cap
sorry for the naive question, but do you need the dump with or without
this patch applied?
>
> -Mathias
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
