Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C46C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB52620774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbgFWMqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:46:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6825 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729504AbgFWMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:46:24 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FE45BB4E781EB6FDB49;
        Tue, 23 Jun 2020 20:46:22 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.204) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 23 Jun 2020
 20:46:14 +0800
Subject: Re: [PATCH] ARM: imx6: add missing put_device() call in
 imx6q_suspend_init()
To:     Shawn Guo <shawnguo@kernel.org>
CC:     <linux@armlinux.org.uk>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <Anson.Huang@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20200604125449.3917164-1-yukuai3@huawei.com>
 <20200623121143.GF30139@dragon>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <21e5664c-d755-23f2-27ef-31f0526aa09d@huawei.com>
Date:   Tue, 23 Jun 2020 20:46:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200623121143.GF30139@dragon>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.204]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/23 20:11, Shawn Guo wrote:
> On Thu, Jun 04, 2020 at 08:54:49PM +0800, yu kuai wrote:
>> if of_find_device_by_node() succeed, imx6q_suspend_init() doesn't have a
>> corresponding put_device(). Thus add a jump target to fix the exception
>> handling for this function implementation.
>>
>> Signed-off-by: yu kuai <yukuai3@huawei.com>
> 
> Applied, thanks.

Hi, Shawn

How about this patch: https://lkml.org/lkml/2020/6/4/428
The patch fix the similar issure.

Thanks!
Yu Kuai


