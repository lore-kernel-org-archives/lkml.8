Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A39EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD2D246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgB1Jwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:52:38 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2477 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbgB1Jwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:52:38 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id C9D972383FDC35D57229;
        Fri, 28 Feb 2020 09:52:35 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Feb 2020 09:52:35 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 09:52:35 +0000
To:     <okaya@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   John Garry <john.garry@huawei.com>
Subject: About commit "io: change inX() to have their own IO barrier
 overrides"
Message-ID: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
Date:   Fri, 28 Feb 2020 09:52:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinan,

About the commit in the $subject 87fe2d543f81, would there be any 
specific reason why the logic pio versions of these functions did not 
get the same treatment or should not? I'm talking about lib/logic_pio.c 
here - commit 031e3601869c ("lib: Add generic PIO mapping method") 
introduced this.

In fact, logic pio will override these for arm64 with the vanilla 
defconfig these days.

It seems that your change was made just after that logic pio stuff went 
into the kernel.

Thanks,
John
