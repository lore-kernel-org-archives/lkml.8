Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FD4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844FB20748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="u7OnbxbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgCaCjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 22:39:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16767 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbgCaCjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 22:39:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585622388; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=F0cnuHPPoBwL4ZXyaNpltI2ZJBgY3zhLpDoVyFkzMWU=;
 b=u7OnbxbRA4BS1CZ5WFRSnJ1FKlw41x2Te+q+9fN99lDJmN4EokmAFec8FG7RIV5xb0CIGxmQ
 QSKpNhKbxWuRVz8ef5fYlNSUq5HTYhHKk2TYxy+Pw9YE3AfU0cR+ns0Keqf0dLawN1NJeJUT
 gH9NdbNsXjxBDOfE6ayq/C9kM/8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e82ad6e.7f8e52e5be68-smtp-out-n03;
 Tue, 31 Mar 2020 02:39:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 864B1C433F2; Tue, 31 Mar 2020 02:39:42 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36F9BC433D2;
        Tue, 31 Mar 2020 02:39:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 31 Mar 2020 10:39:42 +0800
From:   tingwei@codeaurora.org
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: don't clear debug registers in halt
 mode
In-Reply-To: <20200330134218.GB10633@willie-the-truck>
References: <20200328083209.21793-1-tingwei@codeaurora.org>
 <20200330123946.GH1309@C02TD0UTHF1T.local>
 <20200330134218.GB10633@willie-the-truck>
Message-ID: <2f4d076b2b21de3908f0821126d0c61e@codeaurora.org>
X-Sender: tingwei@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-03-30 21:42，Will Deacon 写道：
> On Mon, Mar 30, 2020 at 01:39:46PM +0100, Mark Rutland wrote:
>> On Sat, Mar 28, 2020 at 04:32:09PM +0800, Tingwei Zhang wrote:
>> > If external debugger sets a breakpoint for one Kernel function
>> > when device is in bootloader mode and loads Kernel, this breakpoint
>> > will be wiped out in hw_breakpoint_reset(). To fix this, check
>> > MDSCR_EL1.HDE in hw_breakpoint_reset(). When MDSCR_EL1.HDE is
>> > 0b1, halting debug is enabled. Don't reset debug registers in this
> case.
>> 
>> I don't think this is sufficient, because the kernel can still
>> subsequently mess with breakpoints, and the HW debugger might not be
>> attached at this point in time anyhow.
>> 
>> I reckon this should hang off the existing "nodebumon" command line
>> option, and we shouldn't use HW breakpoints at all when that is 
>> passed.
>> Then you can pass that to prevent the kernel stomping on the external
>> debugger.
>> 
>> Will, thoughts?
> 
> I was going to suggest the same thing, although we will also need to 
> take
> care to reset the registers if "nodebugmon" is toggled at runtime via 
> the
> "debug_enabled" file in debugfs.
> 
> Will

Thanks for the suggestion, Mark and Will. It's a great idea to use
"nodebugmon". When "nodebugmon" is set, Kernel won't change HW 
breakpoints.

For reset the registers after "debug_enabled" is toggled, I'm thinking 
if
we are adding unnecessary complexity here.If we take that approach, we 
will
hook "debug_enabled" interface and use smp_call_function_single() to 
call
hw_breakpoint_reset() on each CPU. Wait for all CPUs' execution done and
change "debug_enabled". External debugger would clear the breakpoints 
when
it detaches the device and restores its breakpoints when attaches the 
device.
Assume debug_enabled is changed to one after external debugger detaches 
the
device. Debugger would already clear the breakpoint registers. If 
debgger is
still attached, there's nothing Kernel can do to stop it 
restores/programs
the breakpoint registers.

What do you think of this?

Thanks,
Tingwei
