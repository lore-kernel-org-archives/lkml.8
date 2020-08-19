Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B866C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308C220772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHSBIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 21:08:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbgHSBIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:08:05 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 55D2713F051FD3159F59;
        Wed, 19 Aug 2020 09:08:01 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 09:07:59 +0800
Subject: Re: [PATCH 1/3] libnvdimm: Fix memory leaks in of_pmem.c
To:     Markus Elfring <Markus.Elfring@web.de>, <linux-nvdimm@lists.01.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <5ca9f6e3-38d7-fc65-5010-22c992ecf851@web.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fdbd9d2d-2e5d-8190-5d7c-eec5c4cdadbb@huawei.com>
Date:   Wed, 19 Aug 2020 09:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5ca9f6e3-38d7-fc65-5010-22c992ecf851@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 3:00 AM, Markus Elfring wrote:
>> The memory priv->bus_desc.provider_name allocated by kstrdup() should be
>> freed.
> 
> * Would an imperative wording be preferred for the change description?
> 
> * I propose to add the tag “Fixes” to the commit message.
Thanks for your suggestion, I will add it in v2.

Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")


> 
> Regards,
> Markus
> 
> 

