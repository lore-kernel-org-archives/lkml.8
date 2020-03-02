Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEDC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087DA2083E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCBLLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:11:07 -0500
Received: from foss.arm.com ([217.140.110.172]:59520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgCBLLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:11:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 728572F;
        Mon,  2 Mar 2020 03:11:06 -0800 (PST)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458203F6CF;
        Mon,  2 Mar 2020 03:11:05 -0800 (PST)
Date:   Mon, 2 Mar 2020 11:10:57 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpu-topology: Fix the potential data corruption
Message-ID: <20200302111038.GA16218@e107533-lin.cambridge.arm.com>
References: <1582878945-50415-1-git-send-email-prime.zeng@hisilicon.com>
 <20200228104034.GB26973@bogus>
 <678F3D1BB717D949B966B68EAEB446ED341F2AE2@DGGEMM506-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED341F2AE2@DGGEMM506-MBS.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 01:41:47AM +0000, Zengtao (B) wrote:
> > -----Original Message-----
> > From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> > Sent: Friday, February 28, 2020 6:41 PM
> > To: Zengtao (B)
> > Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> > linux-kernel@vger.kernel.org; Sudeep Holla
> > Subject: Re: [PATCH] cpu-topology: Fix the potential data corruption
> >
> > On Fri, Feb 28, 2020 at 04:35:45PM +0800, Zeng Tao wrote:
> > > Currently there are only 10 bytes to store the cpu-topology info.
> > > That is:
> > > snprintf(buffer, 10, "cluster%d",i);
> > > snprintf(buffer, 10, "thread%d",i);
> > > snprintf(buffer, 10, "core%d",i);
> > >
> > > In the boundary test, if the cluster number exceeds 100, there will be a
> >
> > I don't understand you mention of 100 in particular above. I can see
> > issue
> > if there are cluster with more than 2-digit id. Though highly unlikely for
> > now, but I don't have objection to the patch.
> >
>
> The same meaning, more than 2-digit id equals to more than 100, right?

Yes. May be it is obvious but I prefer to word the commit message accordingly.
Mention of 100 specifically makes at-least me think something very specific
to 100 and not applicable for any more than 2-digit number.

> Here 100 is for from tester/user perspective.
> And we found this issue when test with QEMU.

OK.

--
Regards,
Sudeep
