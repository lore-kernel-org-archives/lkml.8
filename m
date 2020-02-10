Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFFEC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8011720863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MRuo5P1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBJQoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:44:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51772 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726831AbgBJQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:44:22 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AGiBFt014873;
        Mon, 10 Feb 2020 17:44:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=zcYt6Y+x2k8OY2/GRYD67Vq+aFgoKerUJwHCwYSMUxY=;
 b=MRuo5P1sITtDXkr8HnjEZLFOT8qP9EWImTXRa2Rb/xZDP5na0Ig416XQ5Jef0YDDvoL4
 6bs9jsgbbftU03E2AIMOTwcCgmiq5OyYDBWvTiquc2nqWrtnBo1btOap97eyRqDsQwvA
 E1ZyWHaXlQ0J8Xj9RKGelnylVBl32hol4GlFutYfPHS5f54BZ0HRtmG7cFB2HrB2H6V+
 eJk9TAOxAsKffQnrC/dg4RCETgtUVSH1j5dmvFEhSVVUwUAPUlTbhsnVfjZH7IwXOUGB
 QRWJSUy2QUwYN5F+VxO/E38cVejgx+XbIgpuGjYRRquFAnfcH/E0Z7FjlN4sZ1j+JgMo +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ud9c61f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 17:44:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA47310002A;
        Mon, 10 Feb 2020 17:44:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 973A12AE223;
        Mon, 10 Feb 2020 17:44:12 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Feb
 2020 17:44:11 +0100
Subject: Re: [PATCH 0/3] USB OTG Dual Role on STM32MP15
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200204132606.20222-1-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <3211481b-896f-1b25-b275-f2670fae7234@st.com>
Date:   Mon, 10 Feb 2020 17:44:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204132606.20222-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 2/4/20 2:26 PM, Amelie Delaunay wrote:
> This patchset adds support for USB OTG Dual Role on stm32mp15.
> USB OTG HS is configured in Dual Role mode on stm32mp157c-ev1, role detection
> uses ID pin.
> 
> Amelie Delaunay (3):
>    ARM: dts: stm32: add USB OTG full support on stm32mp151
>    ARM: dts: stm32: add USB OTG pinctrl to stm32mp15
>    ARM: dts: stm32: enable USB OTG Dual Role on stm32mp157c-ev1
> 
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 13 +++++++++++++
>   arch/arm/boot/dts/stm32mp151.dtsi        |  3 ++-
>   arch/arm/boot/dts/stm32mp157c-ed1.dts    |  4 ++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts    |  3 ++-
>   4 files changed, 21 insertions(+), 2 deletions(-)
> 

Series applied on stm32-next.

Thanks
Alex
