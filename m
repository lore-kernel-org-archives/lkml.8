Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26864C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC450214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="M+YcKaeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgAaQNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:13:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29552 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729162AbgAaQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:13:40 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VG8Ufu012526;
        Fri, 31 Jan 2020 17:13:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=HUDBBixwA13IQ1SSxhBd1lmaKx9dqoz2nLZDQib/1NY=;
 b=M+YcKaeJ2bnVCl5PayaMJx+tFQAQGf39itcySN6HFpedQJV60UeyQR+C3dnWO5cUftet
 GbGDnNSjoRvGb9p5bocMIOMMVwwq6udnrw3lR1x5yiYRmZ1YDuGEt2eXJNuD+ssGRoYx
 DjnZc2l2lbGzI7hEmfHpDQSH0dYvYPFdkMCxSkvSBI/IvDSKrIvzxHaLm2ARDTIwEYTc
 BYlmU1xUEQVqRMpTLmrVAQC3dHPdMcbckmJMZvJe+QMnLRdD24sLLFwULK9Avg3kl0JA
 6pgph/GNCKKc7UGzCSmm2hWL1nyDuQWkHvTU2pEuyecFki1KCmFXRjOvMEDRpx3H4opv oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrc13pvvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jan 2020 17:13:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC12810002A;
        Fri, 31 Jan 2020 17:13:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A0DEE2D3796;
        Fri, 31 Jan 2020 17:13:26 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 31 Jan
 2020 17:13:25 +0100
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: dwc2: add support for STM32MP15
 SoCs USB OTG HS and FS
To:     Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20200124084131.23749-1-amelie.delaunay@st.com>
 <20200124084131.23749-2-amelie.delaunay@st.com> <87imkr7nou.fsf@kernel.org>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <c29867bd-8056-a82f-2273-101470395e78@st.com>
Date:   Fri, 31 Jan 2020 17:13:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87imkr7nou.fsf@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_04:2020-01-31,2020-01-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/31/20 2:36 PM, Felipe Balbi wrote:
> Hi,
> 
> Amelie Delaunay <amelie.delaunay@st.com> writes:
> 
>> Add the specific compatible string for the DWC2 IP found in the STM32MP15
>> SoCs.
>> STM32MP15 SoCs uses sensing comparators to detect Vbus valid levels and
>> ID pin state. usb33d-supply described the regulator supplying Vbus and ID
>> sensing comparators.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> This doesn't apply. dwc2 bindings is still in .txt format. I have taken
> patch 2, though.
>

Thanks for taking driver patch.

Rob, would you mind to take patch 1 (Yaml binding update) in your tree ?

Regards,
Amelie

