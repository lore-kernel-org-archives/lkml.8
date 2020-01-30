Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF95DC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8902920661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgA3RlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:41:24 -0500
Received: from foss.arm.com ([217.140.110.172]:55938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgA3RlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:41:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 220A431B;
        Thu, 30 Jan 2020 09:41:23 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC6AA3F67D;
        Thu, 30 Jan 2020 09:41:21 -0800 (PST)
Date:   Thu, 30 Jan 2020 17:41:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jeremy.linton@arm.com,
        arnd@arndb.de, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, guohanjun@huawei.com,
        gregkh@linuxfoundation.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 1/2] ACPI/PPTT: Add acpi_pptt_get_package_info() API
Message-ID: <20200130174116.GA57159@bogus>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-2-git-send-email-john.garry@huawei.com>
 <20200128123415.GB36168@bogus>
 <20200130112338.GA54532@bogus>
 <bfa7770b-d323-1f2a-98c8-44c2142c9124@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa7770b-d323-1f2a-98c8-44c2142c9124@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 04:12:20PM +0000, John Garry wrote:
> On 30/01/2020 11:23, Sudeep Holla wrote:
> > > I personally would not prefer to add the support when I know it is getting
> > > deprecated. I am not sure on kernel community policy on the same.
> > >
> > OK, the details on the proposal to deprecate can be now found in UEFI
> > bugzilla [1]
> >
>
> Wouldn't it be a better approach to propose deprecating the field when there
> is a readily available alternative, i.e. not a spec from a different body in
> beta stage?
>

Understandable and valid concerns. It would be helpful if you raise it in
the UEFI bugzilla. Your concerns will get lost if you just raise here.

> To me, this new SMC support will take an appreciable amount of time to be
> implemented in FW by SiPs when actually released. And if it requires an ATF
> upgrade - which I guess it does - then that's a big job.
>

Again I do understand, please raise it with the SMCCC specification contact
as listed in the link I shared.

--
Regards,
Sudeep
