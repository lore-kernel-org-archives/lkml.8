Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D195C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09FC217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCCC7B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:59:01 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2595 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbgCCC6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:58:54 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id F17EE5C380FB2F4A8F10;
        Tue,  3 Mar 2020 10:58:51 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.227]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0439.000;
 Tue, 3 Mar 2020 10:58:42 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu-topology: Fix the potential data corruption
Thread-Topic: [PATCH] cpu-topology: Fix the potential data corruption
Thread-Index: AQHV7hK2ERrnxNGKY0yF2wIuAuh2Hqgv5MEAgAGAuLCAAz7DgIABi9aQ
Date:   Tue, 3 Mar 2020 02:58:41 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED342092EE@dggemm526-mbx.china.huawei.com>
References: <1582878945-50415-1-git-send-email-prime.zeng@hisilicon.com>
 <20200228104034.GB26973@bogus>
 <678F3D1BB717D949B966B68EAEB446ED341F2AE2@DGGEMM506-MBS.china.huawei.com>
 <20200302111038.GA16218@e107533-lin.cambridge.arm.com>
In-Reply-To: <20200302111038.GA16218@e107533-lin.cambridge.arm.com>
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
> Sent: Monday, March 02, 2020 7:11 PM
> To: Zengtao (B)
> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> linux-kernel@vger.kernel.org; Sudeep Holla
> Subject: Re: [PATCH] cpu-topology: Fix the potential data corruption
> 
> On Sat, Feb 29, 2020 at 01:41:47AM +0000, Zengtao (B) wrote:
> > > -----Original Message-----
> > > From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> > > Sent: Friday, February 28, 2020 6:41 PM
> > > To: Zengtao (B)
> > > Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> > > linux-kernel@vger.kernel.org; Sudeep Holla
> > > Subject: Re: [PATCH] cpu-topology: Fix the potential data corruption
> > >
> > > On Fri, Feb 28, 2020 at 04:35:45PM +0800, Zeng Tao wrote:
> > > > Currently there are only 10 bytes to store the cpu-topology info.
> > > > That is:
> > > > snprintf(buffer, 10, "cluster%d",i);
> > > > snprintf(buffer, 10, "thread%d",i);
> > > > snprintf(buffer, 10, "core%d",i);
> > > >
> > > > In the boundary test, if the cluster number exceeds 100, there will
> be a
> > >
> > > I don't understand you mention of 100 in particular above. I can see
> > > issue
> > > if there are cluster with more than 2-digit id. Though highly unlikely
> for
> > > now, but I don't have objection to the patch.
> > >
> >
> > The same meaning, more than 2-digit id equals to more than 100,
> right?
> 
> Yes. May be it is obvious but I prefer to word the commit message
> accordingly.
> Mention of 100 specifically makes at-least me think something very
> specific
> to 100 and not applicable for any more than 2-digit number.
> 

Do you think I need to update the commit message and resend the patch?
And I don't mind if you can help modify the commit message since both
are fine for me, and it's a very trivial change. 

> > Here 100 is for from tester/user perspective.
> > And we found this issue when test with QEMU.
> 
> OK.
> 
> --
> Regards,
> Sudeep
