Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAD4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CB820825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=notmuch.email header.i=@notmuch.email header.b="vtoz3V1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgESOpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:45:34 -0400
Received: from mx.h4ck.space ([159.69.146.50]:37726 "EHLO mx.h4ck.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgESOpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:45:31 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2020 10:45:31 EDT
Date:   Tue, 19 May 2020 16:38:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=notmuch.email;
        s=mail; t=1589899096;
        bh=Y9XZYNt+/7HUPB/P7WIrgOb1ARcvi6Rd5XCUCLuyNs0=;
        h=Date:From:To:Subject;
        b=vtoz3V1hUuSRbULf8tZ0J8tGKjJrqwfYb70ZRrxExO+2kdpZa+7qRUUSY45v+/0Eg
         cFMXEB46yGiFATylC/1F7x1vS+gS0VJzbce3RfImbkp7rcB2TYzFa50Z5WCt5eGQT7
         yF2KjHu1yQNoGHjGbRVVRagYDr4rjAuzJ00mpylk=
From:   Andreas Rammhold <andi@notmuch.email>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org
Subject: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT instruction
Message-ID: <20200519143815.cpsd2xfx2kl3khsq@wrt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been running into a weird problem with UMIP on a current Ryzen
3900x with kernel 5.6.11 where a process receives a page fault after the
kernel handled the SLDT (or SIDT) instruction (emulation).

The program I am running is run through WINE in 32bit mode and tries to
figure out if it is running in a VMWare machine by comparing the results
of SLDT against well known constants (basically as shown in the
[example] linked below).

In dmesg I see the following log lines:
> [99970.004756] umip: Program.exe[3080] ip:4373fb sp:32f3e0: SIDT instruction cannot be used by applications.
> [99970.004757] umip: Program.exe[3080] ip:4373fb sp:32f3e0: For now, expensive software emulation returns the result.
> [99970.004758] umip: Program.exe[3080] ip:437415 sp:32f3e0: SLDT instruction cannot be used by applications.

Following that the process terminates with a page fault:
> Unhandled exception: page fault on read access to 0xffffffff in 32-bit code (0x0000000000437415).

Assembly at that address:
> 0x0000000000437415: sldt    0xffffffe8(%ebp)

Running the same executable on the exact same kernel (and userland) but
on a Intel i7-8565U doesn't crash at this point. I am guessing the
emulation is supposed to do something different on AMD CPUs?

On the Ryzen the code executes successfully after setting CONFIG_X86_UMIP=n.

I'd love to contriubte a patch but I have no knowledge of the inner
workings of how UMIP actually works.

Is there anything else I can provide to help debugging/fixing this? Very
happy to test patches as well.


[example] https://www.aldeid.com/wiki/X86-assembly/Instructions/sldt
