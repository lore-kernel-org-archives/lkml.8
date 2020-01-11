Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87928C33CA2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 02:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AADD20721
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 02:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgAKCDz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:03:55 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:51696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727877AbgAKCDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 21:03:55 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 8902B17FB6D3794D71C7;
        Sat, 11 Jan 2020 10:03:52 +0800 (CST)
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.174]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0439.000;
 Sat, 11 Jan 2020 10:03:46 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Thread-Topic: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Thread-Index: AQHVwRzFqRRtqHdXdESmtZr5m5x/BafeywsAgAE0VVCAA0cRAIABfdIQ
Date:   Sat, 11 Jan 2020 02:03:46 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340D6E59@DGGEMM506-MBX.china.huawei.com>
References: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
 <20200107144940.GA47473@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340B8545@dggemm526-mbx.china.huawei.com>
 <20200110111622.GA39451@bogus>
In-Reply-To: <20200110111622.GA39451@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Friday, January 10, 2020 7:16 PM
> To: Zengtao (B)
> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> linux-kernel@vger.kernel.org; Sudeep Holla
> Subject: Re: [PATCH] cpu-topology: Skip the exist but not possible cpu
> nodes
> 
> On Wed, Jan 08, 2020 at 01:57:34AM +0000, Zengtao (B) wrote:
> [...]
> 
> > I have the same concern, I have tried to find out some other return
> values
> > But seems not good enough.
> > Maybe it's better to introduce a new function to replace
> of_cpu_node_to_id
> > Any good suggestion?
> >
> 
> No I don't have any. So please drop the extra logic, add a comment on
> -ENODEV return value and use it as needed.

OK, I will address the review comments and send v2.
Thanks 

Zengtao 
