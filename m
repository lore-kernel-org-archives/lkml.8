Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCECC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66FA206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgEFNI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:08:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbgEFNI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:08:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 20AA4CDD63EF55DEFD2A;
        Wed,  6 May 2020 21:08:55 +0800 (CST)
Received: from [10.166.215.142] (10.166.215.142) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 6 May 2020
 21:08:51 +0800
Subject: Re: [PATCH -next] staging: kpc2000: fix error return code in
 kp2000_pcie_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <gregkh@linuxfoundation.org>, <simon@nikanor.nu>,
        <jeremy@azazel.net>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20200506125255.90336-1-weiyongjun1@huawei.com>
 <20200506125723.GL1992@kadam>
From:   Wei Yongjun <weiyongjun1@huawei.com>
Message-ID: <4dd9b3d1-37cf-e016-c14b-02f9e529e611@huawei.com>
Date:   Wed, 6 May 2020 21:08:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506125723.GL1992@kadam>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.142]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/6 20:57, Dan Carpenter wrote:
> On Wed, May 06, 2020 at 12:52:55PM +0000, Wei Yongjun wrote:
>> Fix to return a negative error code from the error handling
>> case instead of 0, as done elsewhere in this function. Also
>> removed var 'rv' since we can use 'err' instead.
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Also could you add a Fixes tag?  This goes all the way back to the
> original commit:
> 
> Fixes: 7dc7967fc39a ("staging: kpc2000: add initial set of Daktronics drivers")
> 

Will fix both of your comments in next version, thanks.

Regards,
Wei Yongjun
