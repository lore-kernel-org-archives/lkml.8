Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B2C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A815620732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgCSIHn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:07:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:46894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgCSIHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:07:42 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id C8ECEBB305E067A6ACAC;
        Thu, 19 Mar 2020 16:07:36 +0800 (CST)
Received: from DGGEML525-MBX.china.huawei.com ([169.254.1.76]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0487.000; Thu, 19 Mar 2020 16:07:31 +0800
From:   "suqiang (C)" <suqiang4@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] UIO: make maximum memory and port regions
 configurable
Thread-Topic: [PATCH V3] UIO: make maximum memory and port regions
 configurable
Thread-Index: AQHV/cGGkHQ9eQPLUkm9Vsy6iEpzl6hPA+wAgACHsTA=
Date:   Thu, 19 Mar 2020 08:07:30 +0000
Message-ID: <7AF579E0012A4E4FA1B0EC683F4B7F591F96D26E@dggeml525-mbx.china.huawei.com>
References: <20200319073923.51812-1-suqiang4@huawei.com>
 <20200319074826.GA3444175@kroah.com>
In-Reply-To: <20200319074826.GA3444175@kroah.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.227]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>What?  No, I did not review this, do not add a tag like that for a patch that I have not explicitly given it for.
A: Sorry, I misunderstood the means of the message.

>And how is the kbuild bot reporting problems that this patch fixes?
>Where is that report?
A: It's a stupid mistake beacause of my wrong git operation. Just ignore it please.

>Also, I want this to be dynamic, not static, please do that instead, no one rebuilds their kernels for something like this.
A: Yes, I got it. I will finish a dynamic implement and send a new patch. I had already sent the PACTH V3 before I read your previous email reply. Sorry for that.

thanks,
Qiang Su
