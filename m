Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A497C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FC42072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbgAQBcn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:32:43 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2991 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730070AbgAQBcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:32:43 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 6C97B6AC903F5DAB9BDA;
        Fri, 17 Jan 2020 09:32:41 +0800 (CST)
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.174]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0439.000;
 Fri, 17 Jan 2020 09:32:34 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] cpu-topology: Skip the exist but not possible cpu
 nodes
Thread-Topic: [PATCH v3] cpu-topology: Skip the exist but not possible cpu
 nodes
Thread-Index: AQHVzA+GWMm+RLGKHUGB0ShIe4jJg6fssZOAgAFbuYA=
Date:   Fri, 17 Jan 2020 01:32:33 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340EFACC@DGGEMM506-MBX.china.huawei.com>
References: <1579139255-29262-1-git-send-email-prime.zeng@hisilicon.com>
 <20200116122420.GA40666@bogus>
In-Reply-To: <20200116122420.GA40666@bogus>
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
> Sent: Thursday, January 16, 2020 8:25 PM
> To: Zengtao (B)
> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki; Sudeep Holla;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] cpu-topology: Skip the exist but not possible cpu
> nodes
> 
> Sorry for being pedantic and not mentioning this earlier. Can you
> improve
> the $subject. I prefer:
> 
> cpu-topology: Don't error on more than CONFIG_NR_CPUS CPUs in
> device tree
> 
> On Thu, Jan 16, 2020 at 09:47:35AM +0800, Zeng Tao wrote:
> > When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the
> device
> > tree, all the cpu nodes parsing will fail.
> > And this is not reasonable for a legal device tree configs.
> > In this patch, skip such cpu nodes rather than return an error.
> >
> 
> Also the commit log to be:
> "
> When the kernel is configured with CONFIG_NR_CPUS smaller than the
> number of CPU nodes in the device tree(DT), all the CPU nodes parsing
> done to fetch topology information will fail. This is not reasonable
> as it is legal to have all the physical CPUs in the system in the DT.
> 
> Let us just skip such CPU DT nodes that are not used in the kernel
> rather than returning an error.
> "
> > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> > ---
> > Changelog:
> > v2->v3:
> >  -Fix the Review comments by sudeep, including fix typo, remove
> redundant check
> >  logic, change the warning print level etc.
> > v1->v2:
> >  -Remove redundant -ENODEV assignment in get_cpu_for_node
> >  -Add comment to describe the get_cpu_for_node return values
> >  -Add skip process for cpu threads
> >  -Update the commit log with more detail
> > ---
> >  drivers/base/arch_topology.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/base/arch_topology.c
> b/drivers/base/arch_topology.c
> > index 5fe44b3..d4302a1 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -248,6 +248,16 @@ core_initcall(free_raw_capacity);
> >  #endif
> >
> >  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> > +/*
> > + * This function returns the logic cpu number of the node.
> > + * There are basically three kinds of return values:
> > + * (1) logic cpu number which is > 0.
> > + * (2) -ENODEV when the node is valid one which can be found in the
> device tree
> > + * but there is no possible cpu nodes to match, when the
> CONFIG_NR_CPUS is
> > + * smaller than cpus node numbers in device tree, this will happen.
> It's
> > + * suggested to just ignore this case.
> 
> I prefer (2) to be reword as below:
> "
> -ENODEV when the device tree(DT) node is valid and found in the DT but
> there is no possible logical CPU in the kernel to match. This happens
> when CONFIG_NR_CPUS is configure to be smaller than the number of
> CPU
> nodes in DT. We need to just ignore this case.
> "
> 
> With all these changes you can stick:
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
OK, I will take the above suggestions, thanks for the patience, ^_^

Regards
Zengtao 
> --
> Regards,
> Sudeep
