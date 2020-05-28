Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFC7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C832078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406577AbgE1Tax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406318AbgE1Taw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:30:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA70C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:30:52 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeOEa-0007Kx-PP; Thu, 28 May 2020 21:30:32 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 426ED100D01; Thu, 28 May 2020 21:30:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jay Lang <jaytlang@mit.edu>
Cc:     jaytlang@mit.edu, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        yu kuai <yukuai3@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ioperm: fix a memory leak bug
In-Reply-To: <20200524162742.253727-1-jaytlang@mit.edu>
References: <20200524162742.253727-1-jaytlang@mit.edu>
Date:   Thu, 28 May 2020 21:30:32 +0200
Message-ID: <87k10voo13.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jay,

Jay Lang <jaytlang@mit.edu> writes:

> In the copy_process() routine called by _do_fork(), failure to allocate
> a PID (or further along in the function) will trigger an invocation to
> exit_thread(). This is done to clean up from an earlier call to
> copy_thread_tls(). Naturally, the child task is passed into exit_thread(),
> however during the process, io_bitmap_exit() nullifies the parent's
> io_bitmap rather than the child's.
>
> As copy_thread_tls() has been called ahead of the failure, the reference
> count on the calling thread's io_bitmap is incremented as we would expect.
> However, io_bitmap_exit() doesn't accept any arguments, and thus assumes
> it should trash the current thread's io_bitmap reference rather than the
> child's. This is pretty sneaky in practice, because in all instances but
> this one, exit_thread() is called with respect to the current task and
> everything works out.
>
> A determined attacker can issue an appropriate ioctl (i.e. KDENABIO) to
> get a bitmap allocated, and force a clone3() syscall to fail by passing
> in a zeroed clone_args structure. The kernel handles the erroneous struct
> and the buggy code path is followed, and even though the parent's reference
> to the io_bitmap is trashed, the child still holds a reference and thus
> the structure will never be freed.

Nice catch! I'm sure I thought about that at some point and then forgot
again.

> Fix this by tweaking io_bitmap_exit() and its subroutines to accept a
> task_struct argument which to operate on.

> This may not be the most elegant solution, but it mitigates the
> trigger described above on an x86_64 kernel.

It's well done and straight forward and comes with a well done change
log. Appreciated!

Thanks,

        tglx
