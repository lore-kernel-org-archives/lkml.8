Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A512C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4972C204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGPKAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:00:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7874 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgGPKAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:00:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 65910E0921DE2CE7D799;
        Thu, 16 Jul 2020 18:00:09 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.238) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Jul 2020
 18:00:01 +0800
Subject: Re: [PATCH] net: neterion: vxge: reduce stack usage in
 VXGE_COMPLETE_VPATH_TX
To:     Joe Perches <joe@perches.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <linux-next@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <jdmason@kudzu.us>, <christophe.jaillet@wanadoo.fr>,
        <john.wanghui@huawei.com>
References: <20200716173247.78912-1-cuibixuan@huawei.com>
 <687734b1623965b154752252968adeca35740c88.camel@perches.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <bf277e52-df6f-1249-9af1-6eea4aa663af@huawei.com>
Date:   Thu, 16 Jul 2020 17:59:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <687734b1623965b154752252968adeca35740c88.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/16 17:46, Joe Perches wrote:
> I doubt this is a good idea.
> Check the callers interrupt status.
yes, it's not good idea to alloc memory in interrupt handler,
I will think more while fix warning. :)
Thanks.

