Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0761CC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74B02070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCSJmU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:42:20 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:59068 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgCSJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:42:19 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20613568-1500050 
        for multiple; Thu, 19 Mar 2020 09:42:12 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200317103307.316400146@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org> <20200317103307.316400146@linuxfoundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19 64/89] efi: Make efi_rts_work accessible to efi page fault handler
Message-ID: <158461093093.6873.1396457313254708957@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Thu, 19 Mar 2020 09:42:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg Kroah-Hartman (2020-03-17 10:55:13)
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> 
> commit 9dbbedaa6171247c4c7c40b83f05b200a117c2e0 upstream.
> 
> After the kernel has booted, if any accesses by firmware causes a page
> fault, the efi page fault handler would freeze efi_rts_wq and schedules
> a new process. To do this, the efi page fault handler needs
> efi_rts_work. Hence, make it accessible.
> 
> There will be no race conditions in accessing this structure, because
> all the calls to efi runtime services are already serialized.
> 
> Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
> Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
> Based-on-code-from: Ricardo Neri <ricardo.neri@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Fixes: 3eb420e70d87 (“efi: Use a work queue to invoke EFI Runtime Services”)
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Caspar Zhang <caspar@linux.alibaba.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This requires the fix from

commit ef1491e791308317bb9851a0ad380c4a68b58d54
Author: Waiman Long <longman@redhat.com>
Date:   Wed Nov 14 09:55:40 2018 -0800

    efi: Fix debugobjects warning on 'efi_rts_work'

    The following commit:

      9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault handler")

    converted 'efi_rts_work' from an auto variable to a global variable.
    However, when submitting the work, INIT_WORK_ONSTACK() was still used,
    causing the following complaint from debugobjects:

      ODEBUG: object 00000000ed27b500 is NOT on stack 00000000c7d38760, but annotated.

    Change the macro to just INIT_WORK() to eliminate the warning.

    Signed-off-by: Waiman Long <longman@redhat.com>
    Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
    Acked-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: linux-efi@vger.kernel.org
    Fixes: 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault handler")
    Link: http://lkml.kernel.org/r/20181114175544.12860-2-ard.biesheuvel@linaro.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

