Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD7C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EEB20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439994AbgDNMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:18:27 -0400
Received: from foss.arm.com ([217.140.110.172]:54214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439975AbgDNMSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:18:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B2731FB;
        Tue, 14 Apr 2020 05:18:11 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 646C23F6C4;
        Tue, 14 Apr 2020 05:18:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: handle the right RAS SEA(Synchronous External Abort)
 type
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     maz@kernel.org, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, zhengxiang9@huawei.com,
        tanxiaofei@huawei.com, linuxarm@huawei.com
References: <20200411121740.37615-1-gengdongjiu@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <0fa259ab-0e2f-a8b3-783d-24a725b4cc5d@arm.com>
Date:   Tue, 14 Apr 2020 13:18:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200411121740.37615-1-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geng,

On 11/04/2020 13:17, Dongjiu Geng wrote:
> When the RAS Extension is implemented, b0b011000, 0b011100,
> 0b011101, 0b011110, and 0b011111, are not used and reserved
> to the DFSC[5:0] of ESR_ELx, but the code still checks these
> unused bits, so remove them.

They aren't unused: CPUs without the RAS extensions may still generate these.

kvm_handle_guest_abort() wants to know if this is an external abort.
KVM doesn't really care if the CPU has the RAS extensions or not, its the arch code's job
to sort all that out.


> If the handling of guest ras data error fails, it should
> inject data instead of SError to let the guest recover as
> much as possible.

(I don't quite follow your point here).

If KVM injected a synchronous external abort due to a RAS error here, then you wouldn't be
able to support firmware-first RAS with Qemu. I don't think this is what you want.


The handling is (and should be) decoupled.

KVM guests aren't special. Whatever happens for a normal user-space process is what should
happen here. KVM is just doing the plumbing:

When the hypervisor takes an external abort due to the guest, it should plumb the error
into the arch code to be handled. This is what would happen for a normal EL0 process.
This is what do_sea() and kvm_handle_guest_sea() do with apei_claim_sea().

If the RAS code says it handled this error, then we can continue. For user-space, we
return to user-space. For a guest, we return to the guest. (for user-space this piece is
not quite complete in mainline, see:
https://lore.kernel.org/linux-acpi/20200228174817.74278-4-james.morse@arm.com/ )

This first part happens even if the errors are notified by IRQs, or found in a polled buffer.

The RAS code may have 'handled' the memory by unmapping it, and marking the corresponding
page as HWPOISONed. If user-space tries to access this, it will be give an
SIGBUS:MCEERR_AR. If a guest tries to do this, the same things happens. (The signal goes
to Qemu).
(See do_page_fault()s use of the MCEERR si_code's, and kvm_send_hwpoison_signal)

This second part is the same regardless of how the kernel discovered the RAS error in the
first place.


If the RAS code says it did not handle this error, it means it wasn't a RAS error, or your
platform doesn't support RAS. For an external-abort there is very little the hypervisor
can do in this situation. It does what KVM has always done: inject an asynchronous
external abort.
This should only happen if the host has failed to handle the error. KVM's use of
asynchronous abort is the simplest one size fits all.

Are you seeing this happen? If so, what are the circumstances. Did the host handle the
error? (if not: why not!)


Thanks,

James
