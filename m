Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CA0C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035A7224D2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgGNNdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:33:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbgGNNdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:33:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1058AA0EF0DC88216259;
        Tue, 14 Jul 2020 21:33:36 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 21:33:30 +0800
Subject: Re: [PATCH] mm/percpu: mark pcpu_chunk_type() as __maybe_unused
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <john.wanghui@huawei.com>, Roman Gushchin <guro@fb.com>
References: <20200714134101.80534-1-cuibixuan@huawei.com>
 <20200714225311.7aeffffd@canb.auug.org.au>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <ec030764-e2e9-726b-8d7d-13c929eddc51@huawei.com>
Date:   Tue, 14 Jul 2020 21:33:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200714225311.7aeffffd@canb.auug.org.au>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/14 20:53, Stephen Rothwell wrote:
> Hi Bixuan,
> 
> On Tue, 14 Jul 2020 13:41:01 +0000 Bixuan Cui <cuibixuan@huawei.com> wrote:
>> Gcc report the following warning without CONFIG_MEMCG_KMEM:
>>
>> mm/percpu-internal.h:145:29: warning: ‘pcpu_chunk_type’ defined
>> but not used [-Wunused-function]
>>  static enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
>>                              ^~~~~~~~~~~~~~~
>>
>> Mark pcpu_chunk_type() as __maybe_unused to make it clear.
> Given that it is in a header file, it should probably just be "static
> inline" (which will also suppress the warning).  As should
> pcpu_is_memcg_chunk() and pcpu_chunk_list().  Also, without them being
> inline, there will be a new copy for each file that
> mm/percpu-internal.h is included in.
> 
> And that should be considered a fix for "mm: memcg/percpu: account
> percpu memory to memory cgroups".
Thinks，i will fix it.

