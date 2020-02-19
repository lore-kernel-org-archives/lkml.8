Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C50C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7882176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBSO2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:28:14 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbgBSO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:28:14 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 15C509B6D1201F523513;
        Wed, 19 Feb 2020 14:28:12 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Feb 2020 14:28:11 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 19 Feb
 2020 14:28:11 +0000
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Will Deacon" <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <20200218125707.GB20212@willie-the-truck>
 <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
 <20200218133943.GF20212@willie-the-truck>
 <627cbc50-4b36-7f7f-179d-3d27d9e0215a@huawei.com>
 <20200218170803.GA9968@lakrids.cambridge.arm.com>
 <cb004f43-b2a4-ae23-9fd3-0f70bd69701b@huawei.com>
 <20200218181331.GB9968@lakrids.cambridge.arm.com>
 <DB7PR04MB46188F06D6CEA1430712E648E6100@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <b6781341-3d28-bda8-621b-aeca413dc8ae@huawei.com>
 <DB7PR04MB46184AA7765C2393E2BE241CE6100@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <476e386b-c032-71bb-d8f8-1701292636b4@huawei.com>
Date:   Wed, 19 Feb 2020 14:28:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB46184AA7765C2393E2BE241CE6100@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> i.MX8MM and i.MX8MN, they use the same driver(DDRC_ID) and cortex-a53
>> integrated.
>>>
>>> If we want to monitor VPU, their *master id* is different from SoCs.
>>> On i.MX8MM, event is imx8_ddr0/axid-read,axi_id=0x08/ On i.MX8MN,
>>> event is imx8_ddr0/axid-read,axi_id=0x12/
>>>

So it seems that this master id and the axi_id are the same, which is 
some filtering key. Indeed, the actual event number is the same between 
SoC implementations.

And metric groups do support filtering, AFAIU.

>>> I try to write a JSON file to use these events, for now, I only can
>>> locate the file at the directory:
>>> tools/perf/pmu-events/arch/arm64/arm/cortex-a53/
>>>
>>> Perf tool loads all events when CPUID matched, which is now unreasonable,
>> we want related events are loaded for specific SoC.
>>
>> so we could have a folder like .../arch/arm64/nxp/system for these JSONs. The
>> perf tool can be updated to handle CPU and system events in separate folders.
>>
>>>
>>> All events will also be loaded if we use DDRC_ID to match in the future, this
>> seems to not be a good ideal.
>>
>> The important part is knowing which events are supported per implementation.
>> Is there any method in the driver of knowing the specific implementation, like
>> any DT compat string? Least preferred option would be DT machine ID.
> 
> I think, NO, master id could be different even they use the same DT compatible string.

Are you sure? Checking the dts files for your SoCs, I see this:

~/kernel-dev6/arch/arm64$ git grep  "fsl,imx8m-ddr-pmu"
boot/dts/freescale/imx8mm.dtsi:                 compatible = 
"fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
boot/dts/freescale/imx8mn.dtsi:                 compatible = 
"fsl,imx8mn-ddr-pmu", "fsl,imx8m-ddr-pmu";
boot/dts/freescale/imx8mq.dtsi:                 compatible = 
"fsl,imx8mq-ddr-pmu", "fsl,imx8m-ddr-pmu";

So it seems that you could use "fsl,imx8mm-ddr-pmu" vs 
"fsl,imx8mn-ddr-pmu" to differentiate, right?

John

