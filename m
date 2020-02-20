Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7299EC5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 03:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CF521D56
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 03:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBTDVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 22:21:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbgBTDVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 22:21:54 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8EB969452846FC500A28;
        Thu, 20 Feb 2020 11:21:52 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Feb 2020
 11:21:44 +0800
Subject: Re: [PATCH v4 05/20] irqchip/gic-v4.1: Plumb skeletal VSGI irqchip
To:     Marc Zyngier <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Robert Richter <rrichter@marvell.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>,
        "James Morse" <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20200214145736.18550-1-maz@kernel.org>
 <20200214145736.18550-6-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <b1053b00-721a-cfd3-8f2f-04c674490121@huawei.com>
Date:   Thu, 20 Feb 2020 11:21:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200214145736.18550-6-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/14 22:57, Marc Zyngier wrote:
> Since GICv4.1 has the capability to inject 16 SGIs into each VPE,
> and that I'm keen not to invent too many specific interfaces to
> manupulate these interrupts, let's pretend that each of these SGIs
manipulate?

> is an actual Linux interrupt.
> 
> For that matter, let's introduce a minimal irqchip and irqdomain
> setup that will get fleshed up in the following patches.
> 
> Signed-off-by: Marc Zyngier<maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

