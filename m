Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA84C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D253B20578
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIDE6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:58:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbgIDE6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 00:58:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 633B7737A644A25F3F1A;
        Fri,  4 Sep 2020 12:57:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Sep 2020
 12:57:50 +0800
Subject: Re: [PATCH 0/2] add support for Hisilicon SD5203 vector interrupt
 controller
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200903120504.2308-1-thunder.leizhen@huawei.com>
 <ac9458877cd414a8265d267569b0e8ea@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0c883e25-629c-54d7-e755-006c864bab27@huawei.com>
Date:   Fri, 4 Sep 2020 12:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ac9458877cd414a8265d267569b0e8ea@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/4 0:46, Marc Zyngier wrote:
> On 2020-09-03 13:05, Zhen Lei wrote:
>> The interrupt controller of SD5203 SoC is VIC(vector interrupt controller), it's
>> based on Synopsys DesignWare APB interrupt controller (dw_apb_ictl) IP, but it
>> can not directly use dw_apb_ictl driver. The main reason is that VIC is used as
>> primary interrupt controller and dw_apb_ictl driver worked for secondary
>> interrupt controller.
> 
> What prevents you from improving the existing driver so that it can act
> as a primary interrupt controller? It shouldn't be rocket science, really.
> 
> There are some examples in the tree of drivers that can be used in
> both situations (GIC, VIC

OK, thanks for the tip.

> 
> Thanks,
> 
>         M.

