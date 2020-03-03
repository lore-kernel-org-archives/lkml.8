Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684D2214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgCCKIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:08:09 -0500
Received: from foss.arm.com ([217.140.110.172]:44994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgCCKIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:08:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65490FEC;
        Tue,  3 Mar 2020 02:08:08 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF783F6C4;
        Tue,  3 Mar 2020 02:08:07 -0800 (PST)
Date:   Tue, 3 Mar 2020 10:08:01 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpu-topology: Fix the potential data corruption
Message-ID: <20200303100801.GA56564@bogus>
References: <1582878945-50415-1-git-send-email-prime.zeng@hisilicon.com>
 <20200228104034.GB26973@bogus>
 <678F3D1BB717D949B966B68EAEB446ED341F2AE2@DGGEMM506-MBS.china.huawei.com>
 <20200302111038.GA16218@e107533-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED342092EE@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED342092EE@dggemm526-mbx.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:58:41AM +0000, Zengtao (B) wrote:
[...]

>
> Do you think I need to update the commit message and resend the patch?

Yes

> And I don't mind if you can help modify the commit message since both
> are fine for me, and it's a very trivial change.
>

Sure, something like below:

"Currently there are only 10 bytes to store the cpu-topology 'name'
information. Only 10 bytes copied into cluster/thread/core names. 

If the cluster ID exceeds 2-digit number, it will result in the data
corruption, and ending up in a dead loop in the parsing routines. The
same applies to the thread names with more that 3-digit number.

This issue was found using the boundary tests under virtualised
environment like QEMU.

Let us increase the buffer to fix such potential issues."

With the above commit log, you can add my:
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
