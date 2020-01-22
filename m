Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2E7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5866E2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgAVJv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:51:28 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbgAVJvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:51:22 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 77878927E199B807C7BC;
        Wed, 22 Jan 2020 09:51:19 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 22 Jan 2020 09:51:20 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Jan
 2020 09:51:19 +0000
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20200122151056.7d09abf0@canb.auug.org.au>
From:   John Garry <john.garry@huawei.com>
Message-ID: <52ff5728-8530-2be8-6dfa-739db5897a61@huawei.com>
Date:   Wed, 22 Jan 2020 09:51:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200122151056.7d09abf0@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2020 04:10, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scsi-mkp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: "irq_create_affinity_masks" [drivers/scsi/hisi_sas/hisi_sas_v2_hw.ko] undefined!
> ERROR: "__irq_set_affinity" [drivers/scsi/hisi_sas/hisi_sas_v2_hw.ko] undefined!
> 

That's sloppy of me - I never build tested for this driver as a module.

And so these symbols are not exported.

> Caused by commit
> 

Hi Martin,

>    3869a618eb88 ("scsi: hisi_sas: Use reply map for v2 hw")
> 

Could you please drop this patch from your branch/revert it? Sorry for 
the hassle.

I should have really talked with Thomas G about whether I should even 
reference the first symbol at all. I'll do that now.

> I have reverted that commit for today.
> 

Thanks,
John


