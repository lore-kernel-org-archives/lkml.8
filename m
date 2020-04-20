Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F4AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F933206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDTKvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:51:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2063 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgDTKvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:51:13 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A03ED667683B594D8460;
        Mon, 20 Apr 2020 11:51:11 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.108) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 20 Apr
 2020 11:51:10 +0100
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <3486ee3b-7240-d5a7-5a3c-952133a5e9f0@huawei.com>
Date:   Mon, 20 Apr 2020 11:50:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67959336311C0CF525BB24ADE6D40@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.108]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2020 05:17, Joakim Zhang wrote:
> However, it seems that there are small defects from metric.
> 
> Firstly, could you help change "ScaleUnit": "9.765625e-4MB" into "ScaleUnit": "9.765625e-4KB", this is a mistake.

ok

> 
> Then, you can see that test is okay from 8MM. However, metric would add twice once time from 8QM which has two ddr perf(ddr0/ddr1), it looks incorrect.
> 
> 8MM:
> root@imx8mmevk:~# ./perf stat -v -a -I 1000 -M imx8mm_ddr_write.all
> Using CPUID 0x00000000410fd030
> metric expr imx8_ddr.write_cycles * 4 * 4 for imx8mm_ddr_write.all
> found event imx8_ddr.write_cycles
> adding {imx8_ddr.write_cycles}:W
> imx8_ddr.write_cycles -> imx8_ddr0/event=0x2b/
> imx8_ddr.write_cycles: 13153 1000495125 1000495125
> #           time             counts unit events
>       1.000476625              13153      imx8_ddr.write_cycles     #    205.5 MB  imx8mm_ddr_write.all
> imx8_ddr.write_cycles: 3582 1000681375 1000681375
>       2.001167750               3582      imx8_ddr.write_cycles     #     56.0 MB  imx8mm_ddr_write.all
> 
> 
> 8QM:
> root@imx8qmmek:~# ./perf stat -v -a -I 1000 -M imx8qm_ddr_read.all

Note: for this example, I don't know why you didn't use 
imx8mm_ddr_write.all, as for your 8MM test, so we can compare the same.

> Using CPUID 0x00000000410fd030
> metric expr imx8_ddr.read_cycles * 4 * 4 for imx8qm_ddr_read.all
> found event imx8_ddr.read_cycles
> metric expr imx8_ddr.read_cycles * 4 * 4 for imx8qm_ddr_read.all
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
> imx8_ddr.read_cycles: 32672 1000454375 1000454375
> imx8_ddr.read_cycles: 37888 1000457250 1000457250
> imx8_ddr.read_cycles: 32736 1000460250 1000460250
> imx8_ddr.read_cycles: 38012 1000463000 1000463000
>       2.000812375              70560      imx8_ddr.read_cycles      #   1102.5 MB  imx8qm_ddr_read.all
>       2.000812375              70748      imx8_ddr.read_cycles
> 

I that is just how the aliases work. But how about trying:

./perf stat -v -a -I 1000 -M imx8_ddr0/imx8qm_ddr_read.all/


for just ddr0

I know that the following worked for non-metrics for aliases on a 
specific HW PMU, so I guess should also work for metrics:

./perf stat -e smmuv3_pmcg_200148020/smmuv3_pmcg.l1_tlb/

Thanks,
John
