Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB501C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5A320720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fxF9M4+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgGUIy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:54:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19796 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgGUIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:54:57 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06L8rT3k004994;
        Tue, 21 Jul 2020 10:54:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=dWB555vjWWb7KL5jRYHRpdelX9CdrjuI9kFVMIuo3R4=;
 b=fxF9M4+CSWyXKXsgrxhvvH4iNYe3uslzlrhuPkmJ9TB0YkYZXNe5sTk1qGFrgRd5xVCR
 plDjHaMhALH3aSfArR42moZpqn06EzFczL6xfpoUUjOPXYtLi7badf2OIxugPq/2pwzW
 fqb7xCbBMIJwCj/klveRMTwxUqo4Bh0Cme/C5olLOVPU4vEKMguXCu7stlef2GEbvrKF
 rlH/He20nwioxhSq2TBMSP9Q/VWmJxoBb7Zo7owhGFuZXLLtd1uKbcqLDC9BTUp5x6Zr
 EeIT13qL6Sf3j56pbKBNsLzpOi99Je7Y5pUmrjlQPKCwceguJDq3KIB+SI6WfrKX12nL UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsfpct3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:54:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 90E93100038;
        Tue, 21 Jul 2020 10:54:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F4A42A7536;
        Tue, 21 Jul 2020 10:54:43 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 Jul
 2020 10:54:42 +0200
Subject: Re: [PATCH 0/3] Add USB role switch support to DWC2
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20200616140717.28465-1-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <d8069a78-2640-d112-a2fb-d86b99a8e44f@st.com>
Date:   Tue, 21 Jul 2020 10:54:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200616140717.28465-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_02:2020-07-21,2020-07-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 6/16/20 4:07 PM, Amelie Delaunay wrote:
> When using usb-c connector (but it can also be the case with a micro-b
> connector), iddig, avalid, bvalid, vbusvalid input signals may not be
> connected to the DWC2 OTG controller.
> DWC2 OTG controller features an overriding control of the PHY voltage valid
> and ID input signals.
> So, missing signals can be forced using usb role from usb role switch and
> this override feature.
> 
> This series adds support for usb role switch to dwc2, by using overriding
> control of the PHY voltage valid and ID input signals.
> 
> It has been tested on stm32mp157c-dk2 [1], which has a Type-C connector
> managed by a Type-C port controller, and connected to USB OTG controller.
> 
> [1] https://www.st.com/en/evaluation-tools/stm32mp157c-dk2.html
> 
> Amelie Delaunay (3):
>    usb: dwc2: override PHY input signals with usb role switch support
>    usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15
>      SoCs
>    ARM: dts: stm32: enable usb-role-switch on USB OTG on stm32mp15xx-dkx
> 
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi |   2 +-
>   drivers/usb/dwc2/Kconfig               |   1 +
>   drivers/usb/dwc2/Makefile              |   2 +-
>   drivers/usb/dwc2/core.h                |   8 ++
>   drivers/usb/dwc2/drd.c                 | 190 +++++++++++++++++++++++++
>   drivers/usb/dwc2/gadget.c              |   2 +-
>   drivers/usb/dwc2/params.c              |   4 +-
>   drivers/usb/dwc2/platform.c            |  13 ++
>   8 files changed, 218 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/usb/dwc2/drd.c
> 

DT patch applied on stm32-next.

Thanks
Alex
