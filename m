Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1C0C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224E02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XCS39xlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgG0Jjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:39:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22254 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727847AbgG0Jjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:39:42 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R9bZt4028611;
        Mon, 27 Jul 2020 11:39:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=KNpb5IhGAR9mrGu7U7F+4OMqL2SAQVWh1aDlJk1R/ks=;
 b=XCS39xlpu3dw83UhAQbLqmErci+xzOc3Jf2CMDSwhCvF0qDPr7yzkzoli7SWvLl6RkUL
 6M3autdinKYz7fiizzoQnahnSz44iRuNojqosCxsEo00Q4p1Bj2pH3Mw4C0OsJps4WKH
 cRIvJlgSUJineksA1rYGiPhUeW8SXqhaD2morP0s6tIjhWD7qhInTADRk8W2W4Bc3d38
 QNWiOOP9RN/0KsBNIsU7Q/I97+XkNPYhQ2hLXL0E+ZlZag8d90DoWANZMhLv/pqXUyaP
 UeAahUJ7K3AnocJL6kQLGJOkibFmerv7huBMDLB7jbBas4sekBvppHvwklRZjmURsl0z GQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32gagv0gbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 11:39:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ACEF110002A;
        Mon, 27 Jul 2020 11:39:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A5E22AE6DA;
        Mon, 27 Jul 2020 11:39:24 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 Jul
 2020 11:39:24 +0200
Subject: Re: [PATCH 0/4] Fix DWC2 USB role switch support
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20200724123748.25369-1-amelie.delaunay@st.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <8d59dcfa-dbb6-de26-9154-fc2bd349075f@st.com>
Date:   Mon, 27 Jul 2020 11:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724123748.25369-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_06:2020-07-27,2020-07-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/20 2:37 PM, Amelie DELAUNAY wrote:
> This patchset adds missing documentation for usb-role-switch support in DWC2
> bindings. It also fixes build issue when config is DWC2_HOST only,
> sleeping while atomic issue and missing usb-role-switch unregistration 
> in probe
> error path.
> 
> Amelie Delaunay (4):
>    dt-bindings: usb: dwc2: add optional usb-role-switch property
>    usb: dwc2: fix build issue when config is USB_DWC2_HOST only
>    usb: dwc2: drd: fix sleeping while spinlock atomic context
>    usb: dwc2: fix error path with missing dwc2_drd_exit
> 
>   .../devicetree/bindings/usb/dwc2.yaml         |  4 +++
>   drivers/usb/dwc2/core.h                       |  1 +
>   drivers/usb/dwc2/drd.c                        | 30 +++++++------------
>   drivers/usb/dwc2/platform.c                   |  2 ++
>   4 files changed, 17 insertions(+), 20 deletions(-)
> 
> -- 
> 2.17.1
> 

Patchset dropped.

Regards,
Amelie
