Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC21C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48CCA20774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Xiq6/Exw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbgF3JgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:36:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24584 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730613AbgF3JgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:36:14 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U9Ytb1002355;
        Tue, 30 Jun 2020 11:35:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=XvCnsTc0gHyxA4bCQuL6yxD7F1TD1d0nVE+Ilwp4DeE=;
 b=Xiq6/ExwBe2jgYMzd+pcK7nxWvhuZTiZD4+4aj24d34XfntXZzCOg2vU6FyXga20MRKD
 PJOMKuRZSZrEgXKkZziTieNlwWC7FC6WQ7K5ug86Uc/UuIMj1FH5c6MokhYVTyd1RB4Y
 BViFUk/QltOESaJu/VrVtyK11Z3odChqDAl2TRZxDSeOSNsesG5PvoP6T2JMLbtl24n/
 QJhdX61xYpJCFSWNu//POwF8zBpTJo0Zh/4hG69m+nY2ObKs8JX7I7gNJhF2Gsg4aJIA
 dGPTfO8/bP3n6l54ihWE3J1/86/86QAJnpe1rNONw8Ia2/X5tXbXZfJztV2RmEVDgQnS YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31wu89hxgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 11:35:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 314C510002A;
        Tue, 30 Jun 2020 11:35:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 14BEE2ADA10;
        Tue, 30 Jun 2020 11:35:41 +0200 (CEST)
Received: from [10.211.8.105] (10.75.127.49) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 30 Jun
 2020 11:35:39 +0200
Subject: Re: [PATCH v5 4/6] memory: stm32-fmc2-ebi: add STM32 FMC2 EBI
 controller driver
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <arnd@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Marek Vasut <marex@denx.de>, <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1591975362-22009-1-git-send-email-christophe.kerello@st.com>
 <1591975362-22009-5-git-send-email-christophe.kerello@st.com>
 <CAFLxGvzfh1Qa_gM9bZAxaoCbO6xCoNdaPN=Ea20Up_zPVgjugw@mail.gmail.com>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <e30abadc-83c0-f010-be36-fe8d14c4aea9@st.com>
Date:   Tue, 30 Jun 2020 11:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzfh1Qa_gM9bZAxaoCbO6xCoNdaPN=Ea20Up_zPVgjugw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_03:2020-06-30,2020-06-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 6/30/20 11:13 AM, Richard Weinberger wrote:
> On Fri, Jun 12, 2020 at 5:24 PM Christophe Kerello
> <christophe.kerello@st.com> wrote:
>>
>> The driver adds the support for the STMicroelectronics FMC2 EBI controller
>> found on STM32MP SOCs.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
>> +       if (!IS_ERR(rstc)) {
>> +               reset_control_assert(rstc);
>> +               reset_control_deassert(rstc);
> 
> Shouldn't there be a small delay between assert and deassert?
> Other than that the code looks good to me.
> 

Even if I have currently not met any issue, I will add a udelay(2) to be 
safe. It will be part of v6.

Thanks,
Christophe Kerello.
