Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6206C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B3D224D3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgGNNpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:45:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48414 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbgGNNpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:45:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 41D0965B92ED3F315B69;
        Tue, 14 Jul 2020 21:45:36 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 21:45:28 +0800
Subject: Re: [PATCH v2] mm/percpu: fix 'defined but not used' warning
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <john.wanghui@huawei.com>, Roman Gushchin <guro@fb.com>
References: <20200714134101.80534-1-cuibixuan@huawei.com>
 <20200714225311.7aeffffd@canb.auug.org.au>
 <7c871406-4f27-64c0-edca-8f5cee1ea605@huawei.com>
Message-ID: <347d8322-e76a-4535-7c74-00fd895ca6e6@huawei.com>
Date:   Tue, 14 Jul 2020 21:45:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7c871406-4f27-64c0-edca-8f5cee1ea605@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/14 21:34, Bixuan Cui wrote:
> mm/percpu-internal.h:145:29: warning: â€˜pcpu_chunk_typeâ€™ defined
> but not used [-Wunused-function]
Please ignore this email, I will resend the v2 patch.

