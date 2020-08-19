Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC5520882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgHSNfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:35:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728625AbgHSNet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:34:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B2FF87F951F8EE11FFAA;
        Wed, 19 Aug 2020 21:34:44 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 21:34:39 +0800
Subject: Re: [PATCH v2 1/4] libnvdimm: Fix memory leaks in of_pmem.c
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-2-thunder.leizhen@huawei.com>
 <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <57fac381-20e5-ce89-7b69-1f2c576e709e@huawei.com>
Date:   Wed, 19 Aug 2020 21:34:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 8:28 PM, Markus Elfring wrote:
>> The memory priv->bus_desc.provider_name allocated by kstrdup() is not
>> freed correctly.
> 
> How do you think about to choose an imperative wording for
> a corresponding change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151

OK, thanks. I think I known what "imperative wording" means now.
I will rewrite the descriptions.

> 
> Regards,
> Markus
> 
> 

