Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F851C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E903720B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDIHCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:02:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIHCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:02:46 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 0F0463508B4D76666315;
        Thu,  9 Apr 2020 08:02:45 +0100 (IST)
Received: from [127.0.0.1] (10.47.11.47) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 9 Apr 2020
 08:02:44 +0100
Subject: Re: [RFC PATCH] perf/smmuv3: Fix shared interrupt handling
To:     Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "harb@amperecomputing.com" <harb@amperecomputing.com>,
        "tuanphan@os.amperecomputing.com" <tuanphan@os.amperecomputing.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <34dd7c2e-b6db-684f-f0a2-73f2e6951308@huawei.com>
Date:   Thu, 9 Apr 2020 08:02:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.47]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2020 17:49, Robin Murphy wrote:
> IRQF_SHARED is dangerous, since it allows other agents to retarget the
> IRQ's affinity without migrating PMU contexts to match, breaking the way
> in which perf manages mutual exclusion for accessing events. Although
> this means it's not realistically possible to support PMU IRQs being
> shared with other drivers, we *can* handle sharing between multiple PMU
> instances with some explicit affinity bookkeeping and manual interrupt
> multiplexing.

Hi Robin,

Out of curiosity, do we even need to support shared interrupts for any 
implementations today?

D06 board:

john@ubuntu:~$ more /proc/interrupts | grep smmuv3-pmu

  989:  0  0  0  0  ITS-pMSI 133120 Edge  smmuv3-pmu
  990:  0  0  0  0  ITS-pMSI 135168 Edge  smmuv3-pmu
  991:  0  0  0  0  ITS-pMSI 137216 Edge  smmuv3-pmu
  992:  0  0  0  0  ITS-pMSI 139264 Edge  smmuv3-pmu
  993:  0  0  0  0  ITS-pMSI 141312 Edge  smmuv3-pmu
  994:  0  0  0  0  ITS-pMSI 143360 Edge  smmuv3-pmu
  995:  0  0  0  0  ITS-pMSI 145408 Edge  smmuv3-pmu
  996:  0  0  0  0  ITS-pMSI 147456 Edge  smmuv3-pmu

Thanks,
John

