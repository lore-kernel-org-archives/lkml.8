Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39A8C55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C7E20776
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgDUM2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:28:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2073 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUM2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:28:45 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B77A8264D657765C6710;
        Tue, 21 Apr 2020 13:28:43 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 21 Apr
 2020 13:28:42 +0100
Subject: Re: [RFC PATCH v2 09/13] perf vendor events: Add JSON metrics for
 imx8mm DDR Perf
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "irogers@google.com" <irogers@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-10-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67959336311C0CF525BB24ADE6D40@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <3486ee3b-7240-d5a7-5a3c-952133a5e9f0@huawei.com>
 <DB8PR04MB679576DAC6EBFFD13F129488E6D40@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <d54e6c6b-0fe6-0cda-e93e-151ce50d0f66@huawei.com>
 <DB8PR04MB6795E2C668C959D4B551F9C3E6D50@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9c82611a-f9ef-7286-8ab7-f7b7ace680ce@huawei.com>
Date:   Tue, 21 Apr 2020 13:28:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB6795E2C668C959D4B551F9C3E6D50@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.25]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2020 03:40, Joakim Zhang wrote:
> For common events, cycles(event=0x00), read-cycles(event=0x2a), write-cycles(event=0x2b), read(event=0x35), write(event=0x38), all these events listed in file (tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json) are compatible for all i.MX8 DDR Perf, only AXI events are various from each SoC. These events tested okay for MX8MM and MX8QM.
> 
> Same situation, metrics listed in file (tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json) is also compatible for all i.MX8 DDR Perf, since metric expression only contains read-cycles(event=0x2a) and write-cycles(event=0x2b).
> 
> Generally speaking, now pmu events and metrics on your branch should support both MX8MM and MX8QM without any change, as long as they export "i.mx8mm" identifier.

Right, but MX8QM should export "i.mx8qm" identifier for upstream eventually.

> 
> As I mentioned before, pmu events tested okay for MX8MM and MX8QM. Metric also tested okay for MX8MM.
> For MX8QM which has two HW PMU(ddr0/ddr1), metric can work, but it would add metric twice which I think if it is possible to improve it in your serials.
> 
> I guess the root cause is that "imx8_ddr.read_cycles" contains two HW PMU events (imx8_ddr0/read-cycles/ and imx8_ddr1/read-cycles/) and metricgroup can't handle it at present.

It should be ok, but I'll check it.

> 
> 8QM:
> root@imx8qmmek:~# ./perf stat -v -a -I 1000 -M imx8mm_ddr_read.all
> Using CPUID 0x00000000410fd030
> metric expr imx8_ddr.read_cycles * 4 * 4 for imx8mm_ddr_read.all
> found event imx8_ddr.read_cycles
> metric expr imx8_ddr.read_cycles * 4 * 4 for imx8mm_ddr_read.all
> found event imx8_ddr.read_cycles
> adding {imx8_ddr.read_cycles}:W,{imx8_ddr.read_cycles}:W
> imx8_ddr.read_cycles -> imx8_ddr0/event=0x2a/
> imx8_ddr.read_cycles -> imx8_ddr1/event=0x2a/
> imx8_ddr.read_cycles -> imx8_ddr0/event=0x2a/
> imx8_ddr.read_cycles -> imx8_ddr1/event=0x2a/
> imx8_ddr.read_cycles: 22748 1000378750 1000378750
> imx8_ddr.read_cycles: 24640 1000376625 1000376625
> imx8_ddr.read_cycles: 22800 1000375125 1000375125
> imx8_ddr.read_cycles: 24616 1000372625 1000372625
> #           time             counts unit events
>       1.000377250              47388      imx8_ddr.read_cycles      #    740.4 MB  imx8qm_ddr_read.all
>       1.000377250              47416      imx8_ddr.read_cycles

john
