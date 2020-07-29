Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2505BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046CC207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHIjsZuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgG2SID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgG2SID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:08:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08912C061794;
        Wed, 29 Jul 2020 11:08:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so2534824ljc.3;
        Wed, 29 Jul 2020 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rP5EEJynL4vgrWif7lHCElf13y97LueeJ9XmjRFRzS0=;
        b=EHIjsZuIB3TgAX8r22RZWI/8jR1FJnzWSlLGYPXpB+kD8YvVZV8aze0sZ/Mi0CfV/U
         UAbiD9oRa9su9lvZI+vgs9vtebyHkewkpGA9V6w6V0viYqr8TkoPVw91aIqccFNNNsvq
         eReEsCq6wV4/eNP0zks13qdCs0azKEuKAQL3kluP8SaJwaxjuz8XrheyxQnAbrbmBjGF
         oq9mWeTJCWu8Z+0LhNmSfeXFD2E8sN+vChyvX6TQKQO9X3/PO9sFIojBK9yRpkWEqL4b
         buQrjMJySHkHtstvBgAmwD8vjShSs03rdauPB0TXzTWCUnrwSLqgDzrsfDlXuvs9bnyU
         9m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rP5EEJynL4vgrWif7lHCElf13y97LueeJ9XmjRFRzS0=;
        b=ptNfz55lVYC4Eak+ksR7iyxC0mV4IZMmFxGqyHUFPD62eJ/UG8LQmqlJZ1YUCUUIFe
         yEsFNPNfCXohr1wUH9l9roHB+6jq7xBmrDZJi0kLqLSuO8Yx/1I0sUby3ZHwG5ICWKeb
         WeIId+8BZcco8feIydUkLgRveWtV2/MXmgq0K/+A7SggBpJVZuh4vz6z8QOMK6P1iqrq
         vZ6jfXV1Wt9mT8qC0ZvPhmn7MgxuxYs6/Dty76c9MFujFDpWadm+4t/tzlUL4lubHOx6
         ubddUIOltazWd1+sq1SopR9Oq7aONpTM46E0Ujn1hy778JaIrZYafR4k6ARRahD0iyl6
         xcDQ==
X-Gm-Message-State: AOAM533ZrRebqSrN3Xh4+bMuGEDNpxDyFBzUOyjFnPjFgid48Ns8/Acy
        36sXFYmXD7s0YxoB6FnT5nvCINLEdd8=
X-Google-Smtp-Source: ABdhPJxcfwFKEXxoYle9H02FAwEpkRJE3h4+zoXeAqWpIEyYOxLKpX2yOdVWUTis4U5IW3fPT30rgQ==
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr13926210ljj.442.1596046081288;
        Wed, 29 Jul 2020 11:08:01 -0700 (PDT)
Received: from wasted.omprussia.ru ([2a00:1fa0:609:47e:1634:9053:a274:2373])
        by smtp.gmail.com with ESMTPSA id e14sm520837ljj.120.2020.07.29.11.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 11:08:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] usb: xhci: define IDs for various ASMedia host
 controllers
To:     Forest Crossman <cyrozap@gmail.com>, linux-usb@vger.kernel.org
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20200727090629.169701-1-cyrozap@gmail.com>
 <20200728042408.180529-1-cyrozap@gmail.com>
 <20200728042408.180529-2-cyrozap@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <3dbfff9a-e64e-e11f-c032-2bbbb7359c97@gmail.com>
Date:   Wed, 29 Jul 2020 21:08:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728042408.180529-2-cyrozap@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/28/20 7:24 AM, Forest Crossman wrote:

> Not all ASMedia host controllers have a device ID that matches its part
> number. #define some of these IDs to make it clearer at a glance which
> chips require what quirks.
> 
> Signed-off-by: Forest Crossman <cyrozap@gmail.com>
> ---
>  drivers/usb/host/xhci-pci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 9234c82e70e4..baa5af88ca67 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
[...]
> @@ -260,13 +262,13 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		xhci->quirks |= XHCI_LPM_SUPPORT;
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> -			pdev->device == 0x1042)
> +		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)

   You shouldn't have un-indented it, blends with the branch below.
   The 80-column line length limit is history now. :-)

>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> -			pdev->device == 0x1142)
> +		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> -			pdev->device == 0x2142)
> +		pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI)
>  		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&

MBR, Sergei
